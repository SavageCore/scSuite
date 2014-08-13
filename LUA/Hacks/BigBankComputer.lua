if tweak_data and tweak_data.SCSuiteConfiguration.big_bank_computer_enable then
    -----------------------------------
    ---         Big Bank            ---
    ---   Hacking computer 1st try  ---
    ---         Update #1.0         ---
    -----------------------------------

    if inGame() and isPlaying() then
        _toggleWaypointBB = not _toggleWaypointBB
        _id_101277 = _id_101277 or false
        _bbserv_used = _bbserv_used or false

        if _toggleWaypointBB then
            managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.big_bank_computer_toggle_on, tweak_data.system_chat_color)
            if managers.job:current_level_id() == 'big' and _bbserv_used == false then
                if isHost() then
                    for _, script in pairs(managers.mission:scripts()) do
                        for id, element in pairs(script:elements()) do
                            if id == 101277 then
                                managers.mission:script("default")._elements[id]._values.on_executed[1].id = 104496
                            end
                        end
                    end
                    _id_101277 = true
                end
            end
        else
            RefreshItemWaypoints()
            managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.big_bank_computer_toggle_off, tweak_data.system_chat_color)
            if managers.job:current_level_id() == 'big' and _bbserv_used == false then
                if isHost() then
                    for _, script in pairs(managers.mission:scripts()) do
                        for id, element in pairs(script:elements()) do
                            if id == 101277 then
                                managers.mission:script("default")._elements[id]._values.on_executed[1].id = 104498
                            end
                        end
                    end
                    _id_101277 = false
                end
            end
        end
        
        managers.hud.__update_waypoints = managers.hud.__update_waypoints or managers.hud._update_waypoints 
        function HUDManager:_update_waypoints( t, dt ) 
            local result = self:__update_waypoints(t,dt) 
            for id,data in pairs( self._hud.waypoints ) do 
                id = tostring(id) 
                if id:sub(1,5)=='hudz_' or id:sub(1,5)=='hudb_' then 
                    data.move_speed = 0.01
                    data.bitmap:set_color( data.bitmap:color():with_alpha( 0.5 ) ) 
                end 
            end 
            return result 
        end  
        
        function RefreshItemWaypoints()
            for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
                id = tostring(id)
                if id:sub(1,5)=='hudz_' then
                    managers.hud:remove_waypoint( id ) 
                end
            end
            if _toggleWaypointBB then
                local level = managers.job:current_level_id()
                for k,v in pairs(managers.interaction._interactive_objects) do
                    if managers.job:current_level_id() == 'big' and v:interaction().tweak_data == 'big_computer_server' then
                        if _bbserv_used == false then
                            managers.hud:add_waypoint( 'hudz_'..k, { icon = 'pd2_computer', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 1, color = Color.green, blend_mode = "add" }  )
                        end
                    end
                end
            end
        end
        
        RefreshItemWaypoints()
        managers.interaction._remove_object = managers.interaction._remove_object or managers.interaction.remove_object
        function ObjectInteractionManager:remove_object( obj )
            local interacted = obj:interaction().tweak_data
            local result = self:_remove_object(obj)
            
            if (managers.job:current_level_id() == 'big' and interacted == 'big_computer_server') and _bbserv_used == false then
                if isHost() and _id_101277 == true then
                    for _, script in pairs(managers.mission:scripts()) do
                        for id, element in pairs(script:elements()) do
                            -- Hacking
                            if id == 104532 then
                                element:on_executed()
                                for _, script in pairs(managers.mission:scripts()) do
                                    for id, element in pairs(script:elements()) do
                                        -- Bain message OK
                                        if id == 106458 then
                                            element:on_executed()
                                        end
                                        if id == 101554 then
                                            element:on_executed()
                                        end
                                    end
                                end
                            end
                            -- Lasers off
                            if id == 104569 then
                                local RnGLaser = math.random(100)
                                -- managers.chat:_receive_message(1, "Lasers", tostring(RnGLaser),  Color.blue)
                                show_mid_text("Activated", "Lasers state...", 1.5)
                                if RnGLaser <= tweak_data.SCSuiteConfiguration.big_bank_laser_chance then	-- Change the value (100 = lasers off, 0 = lasers on)
                                    element:on_executed()
                                    show_mid_text("Disabled!", "Lasers state..", 1.5)
                                end
                            end
                        end
                    end
                end
                RefreshItemWaypoints()
                _bbserv_used = true
            end
            return result
        end

        managers.interaction._add_object = managers.interaction._add_object or managers.interaction.add_object
        function ObjectInteractionManager:add_object( obj )
            local spawned = obj:interaction().tweak_data
            local result = self:_add_object(obj)
            return result
        end
    end
end    