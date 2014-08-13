if tweak_data and tweak_data.SCSuiteConfiguration.pickup_waypoints_enable then
    -----------------------------------
    ---   Waypoints - All in one!   ---
    ---        Update #9.2.1        ---
    -----------------------------------

    --[[	CHANGELOG
    . What's new compared to the previous version?
    - Unreachable Waypoints are removed (Most of them..)
    - Ukrainian Job : Tiara location (should work as Client.. need a feedback!)
    - Ukrainian Job : Power location (to disable Metal detector)
    - Go Bank : Planks are now visible!
    - Election Day 3 : Added Keyboard waypoint
    - Big Oil Day 1 : Added a waypoint for the Airplane key and the safe
    - Train Heist : Added waypoint for the Turret, 3 vault doors locations (Host Only)
    - Framing Frame day 3 Server room
    - Election Day 1 Right Truck
    ]]

    -- INGAME CHECK
    function inGame()
        if not game_state_machine then return false end
        return string.find(game_state_machine:current_state_name(), "game")
    end

    -- IS PLAYING CHECK
    function isPlaying()
        if not BaseNetworkHandler then return false end
        return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
    end

    -- HOST CHECK
    function isHost()
        if not Network then return false end
        return not Network:is_client()
    end

    -- CLIENT CHECK
    function isClient()
        if not Network then return false end
        return Network:is_client()
    end

    -- BEEP
    function beep()
        if managers and managers.menu_component then
            managers.menu_component:post_event("menu_enter")
        end
    end

    if inGame() and isPlaying() then
        _toggleWaypoint = not _toggleWaypoint
        _keyboard_used = _keyboard_used or false
        _engine_used = _engine_used or false
        _intel_used = _intel_used or false
        bo_boxes = bo_boxes or {}
        SecBox1 = SecBox1 --or ""
        SecBox2 = SecBox2 --or ""
        _box1_used = _box1_used or false
        _box2_used = _box2_used or false
        _drill1_used = _drill1_used or false
        _drill2_used = _drill2_used or false
        _drill3_used = _drill3_used or false
        _tiara_used = _tiara_used or false
        _FF3_used = _FF3_used or false
        _gps_used = _gps_used or false
        tabclk = tabclk or {}
        clientBox = clientBox or {}
        clientSucceed = clientSucceed or 0
        cm = managers.controller
        nb = nb or 0
        loopbig = 0
        
        keyboard = Input:keyboard()
        if keyboard:pressed() ~= nil then
            beep()
        end
            
        if _toggleWaypoint then
            managers.chat:_receive_message(1, "Waypoints", "ON", tweak_data.system_chat_color)
        else
            RefreshItemWaypoints()
            managers.chat:_receive_message(1, "Waypoints", "OFF", tweak_data.system_chat_color)
        end

        --speed up waypoint display
        managers.hud.__update_waypoints = managers.hud.__update_waypoints or managers.hud._update_waypoints 
        function HUDManager:_update_waypoints( t, dt ) 
            local result = self:__update_waypoints(t,dt) 
            for id,data in pairs( self._hud.waypoints ) do 
                id = tostring(id) 
                if id:sub(1,5)=='hudz_' or id:sub(1,5)=='hudb_' then 
                    data.move_speed = 0.01
                    data.bitmap:set_color( data.bitmap:color():with_alpha( 0.3 ) ) -- OPACITY : YOU CAN CHANGE THE VALUE (0-1)
                end 
            end 
            return result 
        end  

        function RefreshItemWaypoints()
            local lp = 1
            Color.orange = Color("FF8800")
            --clear all created waypoints
            for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
                id = tostring(id)
                if id:sub(1,5)=='hudz_' or id:sub(1,5)=='hudb_' then
                    managers.hud:remove_waypoint( id ) 
                end
            end
            if _toggleWaypoint then
                --create new waypoints for remaining items
                for k,v in pairs(managers.interaction._interactive_objects) do
                
                    --GO Bank stuff
                    if managers.job:current_level_id() == 'roberts' then
                        --Count keycards sitting on map
                        local _keycardspawned = -1 --always one keycard on the map that spawns out of bounds..
                        for l,w in pairs(managers.interaction._interactive_objects) do
                            if w:interaction().tweak_data == 'pickup_keycard' then _keycardspawned = _keycardspawned + 1 end
                        end
                        
                        --Count keycards on civs
                        local _keycardsoncivs = 0
                        for u_key,u_data in pairs(managers.enemy:all_civilians()) do
                            if alive(u_data.unit) and isHost() and u_data.unit:character_damage():pickup() then _keycardsoncivs = _keycardsoncivs + 1 end
                        end  
                        
                        --Count briefcases
                        local _briefcases = 0
                        for l,w in pairs(managers.interaction._interactive_objects) do
                            if w:interaction().tweak_data == 'grenade_briefcase' then _briefcases = _briefcases + 1 end
                        end
                        if managers.assets:get_asset_unlocked_by_id( "grenade_crate" ) then _briefcases = _briefcases - 1 end
                        
                        --Check
                        if _keycardsoncivs == 1 then
                            if _keycardspawned == 0 then
                                if _briefcases == 0 then
                                    if v:interaction().tweak_data == 'open_slash_close_act' then
                                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_lootdrop', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                                    end
                                elseif v:interaction().tweak_data == 'grenade_briefcase' then
                                    managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_loot', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                                end
                            elseif v:interaction().tweak_data == 'pickup_keycard' then
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_bank_manager_key', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                            end
                        end
                        
                        if v:interaction().tweak_data == 'pickup_keycard' and v:position() ~= Vector3(250, 6750, -64.2354) then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_bank_manager_key', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                        end
                        
                        if v:interaction().tweak_data == 'stash_planks_pickup' then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_planks', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                        elseif v:interaction().tweak_data == 'pickup_boards' then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_planks', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                        end
                        
                    --End GO Bank stuff

                    ----------------------------------------------------------------------------
                    -- YOU CAN COMMENT THE LINES IF YOU DON'T WANT TO HAVE A SPECIFIC WAYPOINT
                    -- USE NOTEPAD++ IF POSSIBLE
                    ----------------------------------------------------------------------------
                    
                    elseif managers.job:current_level_id() == 'framing_frame_1' then
                        if lp == 1 then
                            local unit_list = World:find_units_quick( "all" ) 
                            local count = 0
                            for _,unit in ipairs( unit_list ) do 
                                if unit:carry_data() then --or unit:base() then
                                    if (unit:interaction():active() == true) then
                                        count = count + 1
                                    end
                                end
                            end
                            if count == 9 then
                                managers.chat:_receive_message(1, "Bain", "Guys, I have detected "..count.." paintings in the gallery. That's great. Maximum profits!", tweak_data.system_chat_color)
                            elseif count == 8 then
                                managers.chat:_receive_message(1, "Bain", "Guys, there are "..count.." paintings in the gallery.", tweak_data.system_chat_color)
                            elseif count == 7 then
                                managers.chat:_receive_message(1, "Bain", "Guys, "..count.." paintings are in the gallery. Not much compared with last time!", tweak_data.system_chat_color)
                            elseif count == 6 or count < 6 then
                                managers.chat:_receive_message(1, "Bain", "Guys, only "..count.." paintings detected in the gallery this time.. Better than nothing!", tweak_data.system_chat_color)
                            end
                            lp = 0
                        end
                        -- framing frame day 1 paintings
                        if v:interaction().tweak_data == 'hold_take_painting' and managers.job:current_level_id() ~= "kosugi" then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_loot', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                        end
                    end
                    
                    if v:interaction().tweak_data == 'gage_assignment' then
                        if tostring(v:name()) == "Idstring(@IDe8088e3bdae0ab9e@)" --[[Yellow Package]] then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_christmas_present', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                        elseif tostring(v:name()) == "Idstring(@ID05956ff396f3c58e@)" --[[Blue Package]] then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_christmas_present', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.blue, blend_mode = "add" }  )
                        elseif tostring(v:name()) == "Idstring(@IDc90378ad89058c7d@)" --[[Purple Package]] then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_christmas_present', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.purple, blend_mode = "add" }  )
                        elseif tostring(v:name()) == "Idstring(@ID96504ebd40f8cf98@)" --[[Red Package]] then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_christmas_present', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                        elseif tostring(v:name()) == "Idstring(@IDb3cc2abe1734636c@)" --[[Green Package]] then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_christmas_present', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                        else
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_christmas_present', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.blue, blend_mode = "add" }  )
                        end
                    end
                                        
                    if v:interaction().tweak_data == 'pickup_keycard' then
                        if managers.job:current_level_id() == 'roberts' and v:position() == Vector3(250, 6750, -64.2354) then
                        -- Nothing
                        elseif managers.job:current_level_id() == 'big' and v:position() == Vector3(3000, -3500, 949.99) then
                        -- Nothing
                        elseif managers.job:current_level_id() == 'firestarter_2' and v:position() == Vector3(-1800, -3600, 400) then
                        -- Nothing
                        else
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_bank_manager_key', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                        end
                    end
                    
                    -- big bank keys
                    if (v:interaction().tweak_data == 'invisible_interaction_open' or v:interaction().tweak_data == 'take_keys') and managers.job:current_level_id() == 'big' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_chavez_key', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                    end
                    -- weapons
                    if v:interaction().tweak_data == 'weapon_case' or v:interaction().tweak_data == 'take_weapons' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'ak', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.purple, blend_mode = "add" }  )
                    -- coke
                    elseif v:interaction().tweak_data == 'gen_pku_cocaine' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_vial', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    -- crowbar
                    if v:interaction().tweak_data == 'gen_pku_crowbar' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_crowbar', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- planks
                    elseif v:interaction().tweak_data == 'stash_planks_pickup' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_planks', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'pickup_boards' then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_planks', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                    end
                    -- shadow raid crates location
                    if v:interaction().tweak_data == 'crate_loot_crowbar' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_lootdrop', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- election day 2 crates location
                    elseif v:interaction().tweak_data == 'crate_loot' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_lootdrop', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    -- framing frame day 3 computer location
                    if v:interaction().tweak_data == 'use_computer' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'laptop_objective', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- framing frame day 3 phone location
                    elseif v:interaction().tweak_data == 'pickup_phone' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_phone', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- framing frame day 3 tablet location
                    elseif v:interaction().tweak_data == 'pickup_tablet' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_hack_ipad', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- framing frame day 3 servers location
                    elseif (v:interaction().tweak_data == 'hold_take_server' or v:interaction().tweak_data == 'stash_server_pickup') and managers.job:current_level_id() == "framing_frame_3" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_stash_server', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                
                    -- rats day 1
                    if v:interaction().tweak_data == 'caustic_soda' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_methlab', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'hydrogen_chloride' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_methlab', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'muriatic_acid' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_methlab', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                    end
                    
                    if managers.job:current_level_id() == 'alex_2' and not _intel_used then
                        if isHost() then
                            local values = 
                            {
                                ["103805"] = "Intel Revealer: Safe_01",
                                ["103806"] = "Intel Revealer: Safe_02",
                                ["103807"] = "Intel Revealer: Safe_03",		
                                ["103808"] = "Intel Revealer: Safe_04",
                                ["103809"] = "Intel Revealer: Safe_05",
                                ["103810"] = "Intel Revealer: Safe_06",
                                ["103811"] = "Intel Revealer: Safe_07",	
                                ["103812"] = "Intel Revealer: Safe_08",
                                ["103813"] = "Intel Revealer: Safe_09",
                                ["103814"] = "Intel Revealer: Safe_10",
                                ["103815"] = "Intel Revealer: Safe_11",
                                ["103816"] = "Intel Revealer: Safe_12",
                                ["103817"] = "Intel Revealer: Safe_13",
                                ["103818"] = "Intel Revealer: Safe_14",
                                ["103819"] = "Intel Revealer: Safe_15",
                                ["103820"] = "Intel Revealer: Safe_16"
                            }
                            
                            local bo_safes = {
                                ["103805"] = Vector3(791, 1426, 50),
                                ["103806"] = Vector3(326, 1673, 50),
                                ["103807"] = Vector3(365, 2022, 103.2),	
                                ["103808"] = Vector3(560, 2175, 127.603),
                                ["103809"] = Vector3(2220, 1273, 82.103),
                                ["103810"] = Vector3(2079, 1013, 117.503),
                                ["103811"] = Vector3(2502, 1015, 50),
                                ["103812"] = Vector3(2332, 1100, 50),
                                ["103813"] = Vector3(3162, 2742, 82.1028),
                                ["103814"] = Vector3(2704, 2342, 114.325),
                                ["103815"] = Vector3(3400,2662,117.285),
                                ["103816"] = Vector3(2440, 2747, 50),
                                ["103817"] = Vector3(2474, 3414, 250),
                                ["103818"] = Vector3(3181, 3696, 250),
                                ["103819"] = Vector3(2625, 4003, 250),
                                ["103820"] = Vector3(2755, 3901, 250)
                            }
                            local bo_intel = tostring(managers.mission:script("default")._elements[103759]._values.on_executed[1].id)
                            
                            if _intel_used == false then 
                                managers.hud:add_waypoint( 'hudz_'..bo_intel, { icon = 'interaction_patientfile', distance = true, position = bo_safes[bo_intel], no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                            end
                        elseif isClient() then
                            --managers.chat:_receive_message(1, "*WARNING*", "Intel Revealer is unavailable for you. Host ONLY.",  Color.red)
                            -- 2 safes
                            if (v:interaction().tweak_data == 'drill' or v:interaction().tweak_data == 'take_confidential_folder') then
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_patientfile', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                            end
                        end
                    end
                    
                    -- election day 1, computer location
                    if v:interaction().tweak_data == 'uload_database' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_computer', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- election day 2, machines
                    elseif v:interaction().tweak_data == 'votingmachine2' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_computer', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    
                    -- big bank keyboards location
                    if v:interaction().tweak_data == 'big_computer_hackable' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_keyboard', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    
                    -- firestarter day 2 security boxes location
                    if v:interaction().tweak_data == 'open_slash_close_sec_box' and managers.groupai:state():whisper_mode() and managers.job:current_level_id() == 'firestarter_2' then
                        if isHost() then
                            bo_boxes = {
                                ["105819"] = Vector3(-2710, -2830, 552),	-- Box 001
                                ["105794"] = Vector3(-1840, -3195, 552),	-- Box 002
                                ["105810"] = Vector3(-1540, -2195, 552),	-- Box 003
                                ["105824"] = Vector3(-1005, -3365, 552),	-- Box 004
                                ["105837"] = Vector3(-635, -1705, 552),	-- Box 005
                                ["105851"] = Vector3(-1095, -210, 152),	-- Box 006
                                ["106183"] = Vector3(-1230, 1510, 152),	-- Box 007
                                ["106529"] = Vector3(-1415, -795, 152),	-- Box 008
                                ["106543"] = Vector3(-1160, 395, 152),	-- Box 009
                                ["106556"] = Vector3(-5, 735, 152),	-- Box 010
                                ["106581"] = Vector3(1360, 5, 552),	-- Box 011
                                ["106594"] = Vector3(795, -898, 552),	-- Box 012
                                ["106607"] = Vector3(795, -3240, 552),	-- Box 013
                                ["106620"] = Vector3(1060, -2195, 552),	-- Box 014
                                ["106633"] = Vector3(204, 540, 578),	-- Box 015
                                ["106646"] = Vector3(-1085, -1205, 552),	-- Box 016
                                ["106659"] = Vector3(-2135, 395, 552),	-- Box 017
                                ["106672"] = Vector3(-2405, -840, 552),	-- Box 018
                                ["106685"] = Vector3(-2005, -1640, 552),	-- Box 019
                                ["106698"] = Vector3(-2715, -1595, 552),	-- Box 020
                                                ["106711"] = Vector3(-500, -650, 1300),	-- Box 021
                                                ["106724"] = Vector3(-400, -650, 1300),	-- Box 022
                                                ["106737"] = Vector3(-300, -650, 1300),	-- Box 023		UNAVAILABLE
                                                ["106750"] = Vector3(-200, -650, 1300),	-- Box 024
                                                ["106763"] = Vector3(-100, -650, 1300),	-- Box 025
                                ["106776"] = Vector3(-635, -1205, 152),	-- Box 026
                                ["106789"] = Vector3(-1040, -95, 552),	-- Box 027
                                ["106802"] = Vector3(615, 395, 152),	-- Box 028
                                ["106815"] = Vector3(1890, -1805, 152),	-- Box 029
                                ["106828"] = Vector3(215, -1805, 152)	-- Box 030
                            }
                            
                            SecBox1 = tostring(managers.mission:script("default")._elements[106836]._values.on_executed[1].id)
                            SecBox2 = tostring(managers.mission:script("default")._elements[106836]._values.on_executed[2].id)

                            if _box1_used == false then
                                managers.hud:add_waypoint( 'hudz_'..SecBox1, { icon = 'interaction_wirecutter', distance = true, position = bo_boxes[SecBox1], no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                            end
                            if _box2_used == false then
                                managers.hud:add_waypoint( 'hudz_'..SecBox2, { icon = 'interaction_wirecutter', distance = true, position = bo_boxes[SecBox2], no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.blue, blend_mode = "add" }  )
                            end
                        elseif isClient() then
                            nb = nb + 1
                            if clientBox[nb] ~= 0 then
                                clientBox[nb] = v:position()
                                -- managers.chat:_receive_message(1, "Box_Client"..nb, tostring(clientBox[nb]),  Color.green)
                                managers.hud:add_waypoint( 'hudb_'..k, { icon = 'interaction_wirecutter', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                            end
                        end
                    end
                    if nb == 5 then nb = 0 end
                    
                    -- Big Oil day 1 intel
                    if v:interaction().tweak_data == 'hold_take_blueprints' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_loot', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'take_confidential_folder' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_loot', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'pickup_asset' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_chavez_key', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                    end
                    -- Big Oil day 1 Safe
                    if managers.job:current_level_id() == "welcome_to_the_jungle_1" and v:interaction().tweak_data == 'drill' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_drill', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end

                    -- Big Oil day 2 engine + server
                    if managers.job:current_level_id() == 'welcome_to_the_jungle_2' and v:interaction().tweak_data == 'gen_pku_fusion_reactor' then
                        if isHost() then
                            local values = 
                            {
                                ["103717"] = "Fusion Engine Revealer: Engine_12",
                                ["103716"] = "Fusion Engine Revealer: Engine_11",
                                ["103715"] = "Fusion Engine Revealer: Engine_10",
                                ["103714"] = "Fusion Engine Revealer: Engine_09",
                                ["103711"] = "Fusion Engine Revealer: Engine_08",
                                ["103709"] = "Fusion Engine Revealer: Engine_07",
                                ["103708"] = "Fusion Engine Revealer: Engine_06",
                                ["103707"] = "Fusion Engine Revealer: Engine_05",
                                ["103706"] = "Fusion Engine Revealer: Engine_04",
                                ["103705"] = "Fusion Engine Revealer: Engine_03",
                                ["103704"] = "Fusion Engine Revealer: Engine_02",
                                ["103703"] = "Fusion Engine Revealer: Engine_01"
                            }
                            local engine_id = 
                            {
                                ['103703'] = 'f0e7a7f29fc87c44', --Engine 01
                                ['103704'] = 'db218f98a571c0b1', --Engine 02
                                ['103705'] = 'c717770fadc88e04', --Engine 03
                                ['103706'] = '5fb0a3191c4b8202', --Engine 04
                                ['103707'] = '0b2ecebcf49765b9', --Engine 05
                                ['103708'] = 'b531a6b7026ad84f', --Engine 06
                                ['103709'] = 'e191b6d86e655e23', --Engine 07
                                ['103711'] = '5aabe6e626f00bd4', --Engine 08
                                ['103714'] = '5afbe85d94046cbe', --Engine 09
                                ['103715'] = '9f316997306803b9', --Engine 10
                                ['103716'] = 'b2560b63edcda138', --Engine 11
                                ['103717'] = 'ee644ab092313077'  --Engine 12
                            }
                            local srooms = 
                            {
                                ["101865"] = "Server Room Revealer: 1st floor, Back of the property",
                                ["101866"] = "Server Room Revealer: 1st floor, Front of the property",
                                ["101915"] = "Server Room Revealer: Ground floor"
                            }
                            local keyboard_id = 
                            {
                                ["101865"] = "8efe34cd3f706348",
                                ["101866"] = "8efe34cd3f706348",
                                ["101915"] = "8efe34cd3f706348"
                            }
                            local bo_servers = 
                            {
                                ["101865"] = Vector3(-662, -2142, 475),	-- Room 1
                                ["101866"] = Vector3(-2129, 391, 475), -- Room 2
                                ["101915"] = Vector3(-384, -96, 75) -- Room 3
                            }
                            local bo_keyboard = tostring(managers.mission:script("default")._elements[101916]._values.on_executed[1].id)			
                            local correct_id = tostring(managers.mission:script('default')._elements[103718]._values.on_executed[1].id)
                            
                            if lp == 1 then
                                -- CHAT
                                if _keyboard_used == false then
                                    managers.chat:_receive_message(1, "Server Room", srooms[tostring(managers.mission:script("default")._elements[101916]._values.on_executed[1].id)],  tweak_data.system_chat_color)
                                end
                                if _engine_used == false then
                                    managers.chat:_receive_message(1, "Big Oil", values[tostring(managers.mission:script("default")._elements[103718]._values.on_executed[1].id)],  tweak_data.system_chat_color)
                                end
                                lp = 0
                            end
                            
                            -- WAYPOINT SERVER
                            if _keyboard_used == false then
                                managers.hud:add_waypoint( 'hudz_'..bo_keyboard, { icon = 'interaction_keyboard', distance = true, position = bo_servers[bo_keyboard], no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                            end
                                
                            -- WAYPOINT	ENGINE
                            if v:name():key() == engine_id[correct_id] then
                                managers.hud:add_waypoint( 'hudz_'..correct_id, { icon = 'pd2_loot', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = 'present', radius = 800, color = Color.green, blend_mode = 'add' }  )
                            end						
                        elseif isClient() then
                            if lp == 1 then
                                managers.chat:_receive_message(1, "*WARNING*", "Engine/Server Revealer is unavailable for you. Host ONLY.",  Color.red)
                                lp = 0
                            end
                        end
                    end
                    
                    -- shadow raid server
                    if (v:interaction().tweak_data == 'hold_take_server' or v:interaction().tweak_data == 'stash_server_pickup') and managers.job:current_level_id() == "kosugi" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_stash_server', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                    -- shadow raid paintings
                    elseif v:interaction().tweak_data == 'hold_take_painting' and managers.job:current_level_id() == "kosugi" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_loot', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                    -- shadow raid statue inside crate
                    elseif v:interaction().tweak_data == 'gen_pku_artifact_statue' or v:interaction().tweak_data == 'samurai_armor' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_scrubs', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                    -- shadow raid sewer manhole
                    elseif v:interaction().tweak_data == 'sewer_manhole' and managers.job:current_level_id() == "kosugi" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_open_door', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    -- shadow raid sewer thermite
                    elseif v:interaction().tweak_data == 'apply_thermite_paste' and managers.job:current_level_id() == "kosugi" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_thermite', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    
                    --Train Heist
                    if v:interaction().tweak_data == 'disassemble_turret' and managers.job:current_level_id() == "arm_for" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_sentry', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                    end
                    
                    if managers.job:current_level_id() == "arm_for" then
                        if isHost() then
                            local vault1 = tostring(managers.mission:script("default")._elements[104736]._values.on_executed[1].id)
                            local vault2 = tostring(managers.mission:script("default")._elements[104737]._values.on_executed[1].id)
                            local vault3 = tostring(managers.mission:script("default")._elements[104738]._values.on_executed[1].id)
                            
                            if _drill1_used == false then
                                if vault1 == '104731' then
                                    managers.hud:add_waypoint( 'hudz_'..vault1, { icon = 'wp_target', distance = true, position = Vector3(-2710, -1152, 666), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                                elseif vault1 == '104729' then
                                    managers.hud:add_waypoint( 'hudz_'..vault1, { icon = 'wp_target', distance = true, position = Vector3(-1707, -1157, 667), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                                end
                            end
                            
                            if _drill2_used == false then
                                if vault2 == '104732' then
                                    managers.hud:add_waypoint( 'hudz_'..vault2, { icon = 'wp_target', distance = true, position = Vector3(-192, -1152, 668), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                                elseif vault2 == '104733' then
                                    managers.hud:add_waypoint( 'hudz_'..vault2, { icon = 'wp_target', distance = true, position = Vector3(794, -1161, 668), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                                end
                            end
                            
                            if _drill3_used == false then
                                if vault3 == '104734' then
                                    managers.hud:add_waypoint( 'hudz_'..vault3, { icon = 'wp_target', distance = true, position = Vector3(2291, -1155, 667), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                                elseif vault3 == '104735' then
                                    managers.hud:add_waypoint( 'hudz_'..vault3, { icon = 'wp_target', distance = true, position = Vector3(3308, -1151, 667), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                                end
                            end
                        end
                    end

                    
                    -- Framing Frame day 3 server
                    if managers.job:current_level_id() == 'framing_frame_3' then
                        if isHost() then
                            local servers = 
                            {
                                ["105507"] = "Server Room 1",
                                ["105508"] = "Server Room 2",
                                ["100650"] = "Server Room 3"
                            }
                            local keyboard = 
                            {
                                ["105507"] = "58cb6c4c6221c415",
                                ["105508"] = "58cb6c4c6221c415",
                                ["100650"] = "58cb6c4c6221c415"
                            }
                            local server_vectors = 
                            {
                                ["105507"] = Vector3(-3937.26, 5644.73, 3474.5), -- Office
                                ["105508"] = Vector3(-3169.57, 4563.03, 3074.5), -- Hallway
                                ["100650"] = Vector3(-4920, 3737, 3074.5)    -- Living Room
                            }
                            local svectors = tostring(managers.mission:script("default")._elements[105506]._values.on_executed[1].id)
                                                    
                            -- WAYPOINT SERVER
                            if _FF3_used == false then
                                managers.hud:add_waypoint( 'hudz_'..svectors, { icon = 'interaction_keyboard', distance = true, position = server_vectors[svectors], no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                            end                    
                        else
                        end
                    end
                        

                    -- Election Day 1 Truck
                    if managers.job:current_level_id() == 'election_day_1' then
                        if isHost() then
                            local trucks = 
                            {
                                ["100636"] = "1",
                                ["100633"] = "2",
                                ["100637"] = "3",
                                ["100634"] = "4",
                                ["100639"] = "5",
                                ["100635"] = "6"
                            }
                            local truckid = 
                            {
                                ["100633"] = "3b0947a2434bdc93",
                                ["100634"] = "3b0947a2434bdc93",
                                ["100635"] = "3b0947a2434bdc93",
                                ["100636"] = "3b0947a2434bdc93",
                                ["100637"] = "3b0947a2434bdc93",
                                ["100639"] = "3b0947a2434bdc93"
                            }
                            local truck_vectors = 
                            {
                                ["100636"] = Vector3(150, -3900, 0), -- 1st
                                ["100633"] = Vector3(878.392, -3360.24, 0), --2nd
                                ["100637"] = Vector3(149.999, -2775, 0), --3rd
                                ["100634"] = Vector3(828.07, -2222.45, 0), --4th
                                ["100639"] = Vector3(149.998, -1625, 0), --5th
                                ["100635"] = Vector3(848.961, -1084.9, 0) --6th
                            }
                            local truckv = tostring(managers.mission:script("default")._elements[100631]._values.on_executed[1].id)
                                                                        
                            -- WAYPOINT SERVER
                            if _gps_used == false then
                                managers.hud:add_waypoint( 'hudz_'..truckv, { icon = 'wp_target', distance = true, position = truck_vectors[truckv], no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                            end                    
                        else
                        end
                    end

                    -- election day 3, keyboard
                    if managers.job:current_level_id() == 'election_day_3_skip1' and v:interaction().tweak_data == 'security_station_keyboard' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_keyboard', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    
                    -- Ukrainian Job  Power
                    if v:interaction().tweak_data == 'circuit_breaker' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_powersupply', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                    end
                    
                    -- Ukrainian Job Tiara location
                    if managers.job:current_level_id() == "ukrainian_job" and _tiara_used == false then
                        if isHost() then
                            local unit_list = World:find_units_quick( "all" ) 
                            for _,unit in ipairs( unit_list ) do 
                                if unit:base() and tostring(unit:name()) == "Idstring(@ID077636ce1f33c8d0@)" --[[TIARA]] then
                                    managers.hud:add_waypoint( 'hudz_'.._, { icon = 'pd2_loot', distance = true, position = unit:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                                end
                            end
                        elseif isClient() then
                            -- Not sure..
                            local unit_list = World:find_units_quick( "all" ) 
                            for _,unit in ipairs( unit_list ) do 
                                if unit:base() and tostring(unit:name()) == "Idstring(@ID077636ce1f33c8d0@)" --[[TIARA]] then
                                    managers.hud:add_waypoint( 'hudz_'.._, { icon = 'pd2_loot', distance = true, position = unit:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                                end
                            end
                        end
                    end
                    

                    -- Security Door v3
                    if v:interaction().tweak_data == 'key' and managers.job:current_level_id() ~= "arm_for" then 
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_powerbutton', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                    --DIAMOND STORE KEYPAD
                    elseif managers.job:current_level_id() == "family" and v:interaction().tweak_data == 'numpad_keycard' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_powerbutton', distance = true, position = v:interaction():interact_position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                    end
                    
                    -- money
                    if v:interaction().tweak_data == 'money_wrap_single_bundle' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'cash_register' then
                        if managers.job:current_level_id() == "jewelry_store" or managers.job:current_level_id() == "ukrainian_job" then
                            if v:position() == Vector3(1844, 665, 117.732) then
                            else
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                            end 
                        else
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                        end
                    elseif v:interaction().tweak_data == 'money_small' then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    elseif v:interaction().tweak_data == 'money_wrap' then
                        if managers.job:current_level_id() == "arm_for" then
                            if v:position() == Vector3(71, -1299, -2375.39)
                                or v:position() == Vector3(471, -1233, -2375.39)
                                or v:position() == Vector3(471, -1299, -2375.39)
                                or v:position() == Vector3(371, -1299, -2375.39)
                                or v:position() == Vector3(271, -1299, -2375.39)
                                or v:position() == Vector3(271, -1233, -2375.39)
                                or v:position() == Vector3(171, -1299, -2375.39)
                                or v:position() == Vector3(171, -1233, -2375.39)
                                or v:position() == Vector3(71, -1233, -2375.39)
                                or v:position() == Vector3(371, -1233, -2375.39)
                                
                                or v:position() == Vector3(-2400, -1300, -2375.39)
                                or v:position() == Vector3(-2400, -1200, -2375.39)
                                or v:position() == Vector3(-2300, -1200, -2375.39)
                                or v:position() == Vector3(-2200, -1200, -2375.39)
                                or v:position() == Vector3(-2300, -1300, -2375.39)
                                or v:position() == Vector3(-2100, -1200, -2375.39)
                                or v:position() == Vector3(-2200, -1300, -2375.39)
                                or v:position() == Vector3(-2000, -1200, -2375.39)
                                or v:position() == Vector3(-2000, -1300, -2375.39)
                                or v:position() == Vector3(-2100, -1300, -2375.39)
                                
                                or v:position() == Vector3(2555, -1275, -2375.39)
                                or v:position() == Vector3(2550, -1200, -2375.39)
                                or v:position() == Vector3(2655, -1275, -2375.39)
                                or v:position() == Vector3(2650, -1200, -2375.39)
                                or v:position() == Vector3(2755, -1275, -2375.39)
                                or v:position() == Vector3(2750, -1200, -2375.39)
                                or v:position() == Vector3(2855, -1275, -2375.39)
                                or v:position() == Vector3(2850, -1200, -2375.39)
                                or v:position() == Vector3(2955, -1275, -2375.39)
                                or v:position() == Vector3(2950, -1200, -2375.39)
                            then
                                --
                            else
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                            end
                        elseif managers.job:current_level_id() == "welcome_to_the_jungle_1" then
                            if v:position() == Vector3(9200, -4300, 100) then
                            else
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                            end
                        elseif managers.job:current_level_id() == "family" then
                            if v:position() == Vector3(1400, 200, 1100) then
                            else
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                            end
                        else
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_money_wrap', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.orange, blend_mode = "add" }  )
                        end
                        
                    -- gold
                    elseif v:interaction().tweak_data == 'gold_pile' then
                        if managers.job:current_level_id() == "welcome_to_the_jungle_1" then
                            if v:position() == Vector3(9200, -4400, 100) then
                            else
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_gold', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                            end
                        else
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_gold', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.red, blend_mode = "add" }  )
                        end
                    
                    -- diamonds/jewels
                    elseif v:interaction().tweak_data == 'diamond_pickup' or v:interaction().tweak_data == 'gen_pku_jewelry' then
                        if managers.job:current_level_id() == "ukrainian_job" and v:position().z > 0 then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'interaction_diamond', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.green, blend_mode = "add" }  )
                        end
                    -- ATMS
                    elseif v:interaction().tweak_data == 'requires_ecm_jammer_atm' then 
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_ecm_jammer', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.blue, blend_mode = "add" }  )
                    end
                    --Train Heist
                    if v:interaction().tweak_data == 'take_ammo' and managers.job:current_level_id() == "arm_for" then
                        managers.hud:add_waypoint( 'hudz_'..k, { icon = 'equipment_sentry', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
                    end
                    
                end
            end
        end
        
        -- initialize waypoints
        RefreshItemWaypoints()

        --when a package is removed from the game, also refresh waypoints
        managers.interaction._remove_object = managers.interaction._remove_object or managers.interaction.remove_object
        function ObjectInteractionManager:remove_object( obj )
            local interacted = obj:interaction().tweak_data
            local result = self:_remove_object(obj)
            local position = obj:position()
            local position2 = obj:interaction():interact_position()
            
            
            if interacted == 'gage_assignment' 
            or interacted == 'pickup_keycard' 
            or interacted == 'invisible_interaction_open'
            or (managers.job:current_level_id() == 'big' and (interacted == 'invisible_interaction_open' or interacted == 'take_keys' ))
            or (managers.job:current_level_id() == 'family' and interacted == 'numpad_keycard')
            or interacted == 'key'
            or (managers.job:current_level_id() == 'roberts' and (interacted == 'open_slash_close_act' or interacted == 'grenade_briefcase'))
            or interacted == 'weapon_case' or interacted == 'take_weapons' or interacted == 'gen_pku_cocaine'
            or interacted == 'stash_planks_pickup' or interacted == 'pickup_boards'
            or interacted == 'crate_loot' or interacted == 'crate_loot_crowbar' or interacted == 'crate_loot_close' or interacted == 'gen_pku_crowbar' or interacted == 'votingmachine2'
            or interacted == 'hold_take_server' or interacted == 'stash_server_pickup' or interacted == 'hold_take_painting' 
            or interacted == 'big_computer_hackable' or interacted == 'uload_database' or interacted == 'gen_pku_artifact_statue' 
            or interacted == 'use_computer' or interacted == 'pickup_phone'	or interacted == 'pickup_tablet' 
            or interacted == 'big_computer_server' or interacted == 'sewer_manhole' or interacted == 'pickup_asset' or interacted == 'disassemble_turret'
            or interacted == 'circuit_breaker' or interacted == 'apply_thermite_paste' 
            or (managers.job:current_level_id() == 'alex_1' and (interacted == 'caustic_soda' or interacted == 'hydrogen_chloride' or interacted == 'muriatic_acid'))
            or (managers.job:current_level_id() == 'alex_2' and (interacted == 'take_confidential_folder' or interacted == 'drill'))
            or (managers.job:current_level_id() == 'welcome_to_the_jungle_1' and (interacted == 'drill'))
            then
                RefreshItemWaypoints()
            end 
            
            -- MONEY
            if interacted == 'gen_pku_jewelry' or interacted == 'money_wrap' or interacted == 'diamond_pickup' 
            or interacted == 'money_small' or interacted == 'money_wrap_single_bundle' or interacted == 'cash_register' 
            or interacted == 'gold_pile' or interacted == 'requires_ecm_jammer_atm' 
            then
                RefreshItemWaypoints()
            end 
            -- BIG OIL 2
            if (managers.job:current_level_id() == 'welcome_to_the_jungle_2' and interacted == 'security_station_keyboard') then
                _keyboard_used = true
                RefreshItemWaypoints()
            end
            if (managers.job:current_level_id() == 'welcome_to_the_jungle_2' and interacted == 'gen_pku_fusion_reactor') then
                _engine_used = true
                RefreshItemWaypoints()
            end
            -- RATS 2
            if (managers.job:current_level_id() == 'alex_2' and interacted == 'take_confidential_folder') then
                _intel_used = true
                RefreshItemWaypoints()
            end
            -- TIARA
            if (managers.job:current_level_id() == 'ukrainian_job' and interacted == 'tiara_pickup') then
                _tiara_used = true
                RefreshItemWaypoints()
            end
            -- TRAIN HEIST
            if (managers.job:current_level_id() == 'arm_for' and interacted == 'lance') then
                if position == Vector3(-1750, -1200, 685) or position == Vector3(-2650, -1100, 685) then
                _drill1_used = true -- GREEN
                
                elseif position == Vector3(-150, -1100, 685) or position == Vector3(750, -1200, 685) then
                _drill2_used = true -- ORANGE
                
                elseif position == Vector3(3250, -1200, 685) or position == Vector3(2350, -1100, 685) then
                _drill3_used = true -- RED

                end
                RefreshItemWaypoints()
            end
            
            -- FRAMING FRAME DAY 3 SERVER ROOM
            if (managers.job:current_level_id() == 'framing_frame_3' and interacted == 'security_station_keyboard') then
                _FF3_used = true
                RefreshItemWaypoints()
            end
            -- ELECTION DAY 1 TRUCK
            if (managers.job:current_level_id() == 'election_day_1' and interacted == 'hold_place_gps_tracker') then
                _gps_used = true
                RefreshItemWaypoints()
            end
            
            -- FIRESTARTER 2
            if (managers.job:current_level_id() == 'firestarter_2') then
                if isHost() then
                    if interacted == 'hospital_security_cable' then
                        tabclk[1] = os.clock()
                    elseif interacted == 'open_slash_close_sec_box' then
                        tabclk[2] = os.clock()
                    end

                    if (tabclk[1] ~= nil and tabclk[2] ~= nil) or (tabclk[1] == nil and tabclk[2] ~= nil) then
                        if tabclk[1] == nil then tabclk[1] = 0 end -- to prevent a nil value if you want to cut the first cable
                        local test = tabclk[2] - tabclk[1]
                        
                        if test < 0.5 and test > 0 or test < 0 and test > -0.5 then
                            -- CLOSING THE BOX
                        else
                            -- CUTTING THE CABLE OR OPENING THE BOX
                            if interacted == 'hospital_security_cable' 
                                and position == bo_boxes[SecBox1] 
                                    then 
                                        _box1_used = true
                                        RefreshItemWaypoints()
                            elseif interacted == 'hospital_security_cable' 
                                and position == bo_boxes[SecBox2] 
                                    then
                                        _box2_used = true
                                        RefreshItemWaypoints()
                            end
                        end
                    end
                    if not managers.groupai:state():whisper_mode() then
                        _box1_used = true
                        _box2_used = true
                        RefreshItemWaypoints()
                    end
                elseif isClient() then
                    if not managers.groupai:state():whisper_mode() then
                        _box1_used = true
                        _box2_used = true
                        RefreshItemWaypoints()
                    end
                    if interacted == 'hospital_security_cable' then
                        local vecX = position2.x
                        local vecY = position2.y
                        -- local vecZ = position2.z
                        
                        for k, v in pairs(clientBox) do
                            if clientBox[k] ~= 0 then
                                if 
                                    (vecX < clientBox[k].x + 50 and vecX > clientBox[k].x - 50)
                                and
                                    (vecY < clientBox[k].y + 50 and vecY > clientBox[k].y - 50)
                                then
                                    clientBox[k] = 0
                                    clientSucceed = clientSucceed + 1
                                    RefreshItemWaypoints()
                                end
                            end
                            if clientSucceed == 2 then
                                clientBox[1] = 0
                                clientBox[2] = 0
                                clientBox[3] = 0
                                clientBox[4] = 0
                                clientBox[5] = 0
                                RefreshItemWaypoints()
                            end
                        end
                    end
                end
            end
            
            return result
        end

        --if map is GO bank and keycard or briefcase are spawned, also refresh waypoints
        managers.interaction._add_object = managers.interaction._add_object or managers.interaction.add_object
        function ObjectInteractionManager:add_object( obj )
            local spawned = obj:interaction().tweak_data
            local result = self:_add_object(obj)
            if managers.job:current_level_id() == 'roberts' and (spawned == 'pickup_keycard' or spawned == 'grenade_briefcase') then
                RefreshItemWaypoints()
            elseif (spawned == 'pickup_keycard' or spawned == 'grenade_briefcase') then
                RefreshItemWaypoints()
            end
            return result
        end
    end
end    