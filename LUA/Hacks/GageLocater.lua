if tweak_data and tweak_data.SCSuiteConfiguration.gage_locater_enable then
    if not managers.hud then return end
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


    function RefreshGageWaypoints()
        --clear all created waypoints
        for id,_ in pairs( clone( managers.hud._hud.waypoints ) ) do
            id = tostring(id)
            if id:sub(1,5)=='hudz_' then
                managers.hud:remove_waypoint( id ) 
            end
        end
        --create new waypoints for remaining packages
        for k,v in pairs(managers.interaction._interactive_objects) do
            if v:interaction().tweak_data == 'gage_assignment' then
                managers.hud:add_waypoint( 'hudz_'..k, { icon = 'wp_target', distance = true, position = v:position(), no_sync = true, present_timer = 0, state = "present", radius = 800, color = Color.white, blend_mode = "add" }  )
            end
        end
    end
    -- initialize waypoints
    RefreshGageWaypoints()


    --when a package is removed from the game, also refresh waypoints
    managers.interaction._remove_object = managers.interaction._remove_object or managers.interaction.remove_object
    function ObjectInteractionManager:remove_object( obj )
        local do_refresh = obj:interaction().tweak_data == 'gage_assignment'
        local result = self:_remove_object(obj)
        if do_refresh then
            RefreshGageWaypoints()
        end 
        return result
    end
end