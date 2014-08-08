if tweak_data and tweak_data.SCSuiteConfiguration.drop_in_pause_disable then
    -- Network Check
    if not NetworkGame then return end

    -- Drop-In Pause Remover
    function NetworkGame:load( game_data )
        if managers.network:session():is_client() then
            Network:set_client( managers.network:session():server_peer():rpc() )
        end
            
        if game_data then
            for k, v in pairs( game_data.members ) do
                self._members[ k ] = NetworkMember:new()
                self._members[ k ]:load( v )
            end
        end
    end

    function NetworkGame:on_drop_in_pause_request_received( peer_id, nickname, state )
        print( "[NetworkGame:on_drop_in_pause_request_received]", peer_id, nickname, state )
        local status_changed = false
        local is_playing = BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
        if state then
            if not managers.network:session():closing() then
                status_changed = true
                self._dropin_pause_info[ peer_id ] = nickname
            end
            
        elseif self._dropin_pause_info[ peer_id ] then
            status_changed = true
            if peer_id == managers.network:session():local_peer():id() then
                self._dropin_pause_info[ peer_id ] = nil
                managers.menu:close_person_joining( peer_id )
            else
                self._dropin_pause_info[ peer_id ] = nil
                managers.menu:close_person_joining( peer_id )
            end
        end

        if status_changed then
            if state then
                if not managers.network:session():closing() then
                    if table.size( self._dropin_pause_info ) == 1 then
                        show_mid_text('', managers.localization:text( "dialog_dropin_title", { USER = string.upper( nickname ) } ) , 3.0 )
                        managers.menu_component:post_event("Play_star_hit")
                    end
                    
                    if Network:is_client() then
                        managers.network:session():send_to_host( "drop_in_pause_confirmation", peer_id )
                    end
                end
                
            elseif not next( self._dropin_pause_info ) then
                print( "DROP-IN UNPAUSE" )
            else
                print( "MAINTAINING DROP-IN UNPAUSE. # dropping peers:", table.size(    self._dropin_pause_info ) )
            end
        end
    end
end    