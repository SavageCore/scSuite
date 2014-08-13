if tweak_data and tweak_data.SCSuiteConfiguration.pickup_waypoints_enable then
    if not managers.hud then return end
    -- KEYCARD & CROWBAR FINDER v0.3
    -- By B1313, Siahi, and hejoro
    _toggleWaypoint = not _toggleWaypoint
    if _toggleWaypoint then
        managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.pickup_finder_enabled, tweak_data.system_chat_color)
    else
        RefreshItemWaypoints()
        managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.pickup_finder_disabled, tweak_data.system_chat_color)
    end
    --speed up waypoint display
    managers.hud.__update_waypoints = managers.hud.__update_waypoints or managers.hud._update_waypoints 
    function HUDManager:_update_waypoints( t, dt ) 
        local result = self:__update_waypoints(t,dt) 
        for id,data in pairs( self._hud.waypoints ) do 
            id = tostring(id) 
            if id:sub(1,5)=='hudz_' then 
                data.move_speed = 0.01 -- remove easing w/o going too deep 
                data.bitmap:set_color( data.bitmap:color():with_alpha( 0.5 ) ) -- opacity 0-1 
            end 
        end 
        return result 
    end  


    function RefreshItemWaypoints()
        --clear all created waypoints
        for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
            id = tostring(id)
            if id:sub(1,5)=='hudz_' then
                managers.hud:remove_waypoint( id ) 
            end
        end
        if _toggleWaypoint then
            --create new waypoints for remaining packages
            for k,v in pairs(managers.interaction._interactive_objects) do
            
            
                --GO Bank stuff
                if managers.job:current_level_id() == 'roberts' then
                    --Count keycards sitting on map
                    local _keycardspawned = -1 --there is always one keycard on the map that spawns out of bounds
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
                    
                    --Commence complicated check
                    if _keycardsoncivs == 1 then
                        if _keycardspawned == 0 then
                            if _briefcases == 0 then
                                if v:interaction().tweak_data == 'open_slash_close_act' then
                                    managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_target', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                                end
                            elseif v:interaction().tweak_data == 'grenade_briefcase' then
                                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_target', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                            end
                        elseif v:interaction().tweak_data == 'pickup_keycard' then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_target', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                        end
                    end
                --End GO Bank stuff
                
                
                elseif v:interaction().tweak_data == 'pickup_keycard' then
                    managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_target', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.yellow, blend_mode = "add" }  )
                end
                if v:interaction().tweak_data == 'gen_pku_crowbar' then
                    managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_target', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
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
        if interacted == 'pickup_keycard' or interacted == 'gen_pku_crowbar' or interacted == 'gage_assignment'
        or (managers.job:current_level_id() == 'roberts' and (interacted == 'open_slash_close_act' or interacted == 'grenade_briefcase')) then
            RefreshItemWaypoints()
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