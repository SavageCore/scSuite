if not StealthFixer then
    local DisableOnDeathwish = false
    if not IntimitateInteractionExt or not GroupAIStateBase or not ElementSpawnEnemyDummy or not CopLogicIntimidated or not Global then
        return
    end
    if DisableOnDeathwish and Global.game_settings.difficulty == "overkill_290" then
        StealthFixer = true
        return
    end
    StealthFixer = { firstCall = true }
    if not managers.interaction or not managers.groupai then
        return
    end

    --Unlimited bodybags
    if tweak_data.SCSuiteConfiguration.unlimited_bodybags_enable then
        old_interact_blocked = old_interact_blocked or IntimitateInteractionExt._interact_blocked
        function IntimitateInteractionExt:_interact_blocked( ... )
            if self.tweak_data == "hostage_convert" then
                return not (managers.player:has_category_upgrade( "player", "convert_enemies" ) and not managers.player:chk_minion_limit_reached() )
            elseif self.tweak_data == "corpse_dispose" and not managers.player.carry_stack then
                if not managers.player:has_category_upgrade( "player", "corpse_dispose" ) or managers.player:is_carrying() then
                    return true
                end
                return not managers.player:can_carry( "person" )
            else
                return old_interact_blocked(self, ...)
            end
        end
        managers.interaction._interact_blocked = IntimitateInteractionExt._interact_blocked
    end
    
    --Joker enabled in stealth
    if tweak_data and tweak_data.SCSuiteConfiguration.stealth_joker_enable then
        GroupAIStateBase.__convert_hostage_to_criminal = GroupAIStateBase.convert_hostage_to_criminal
        managers.groupai:state().__convert_hostage_to_criminal = GroupAIStateBase.__convert_hostage_to_criminal

        function GroupAIStateBase:convert_hostage_to_criminal( unit, peer_unit, ... )
            if not managers.groupai:state():whisper_mode() then
                return self:__convert_hostage_to_criminal(unit, peer_unit, ...)
            end
            local player_unit = peer_unit or managers.player:player_unit()
            if not alive( player_unit ) or not self._criminals[ player_unit:key() ] then
                return
            end
            if not alive( unit ) then
                return
            end
            
            local u_key = unit:key()
            local u_data = self._police[ u_key ]
            
            if not u_data then
                return
            end
            
            local minions = self._criminals[ player_unit:key() ].minions or {}
            self._criminals[ player_unit:key() ].minions = minions
            
            
            local max_minions = 0
            if peer_unit then        -- client
                max_minions = peer_unit:base():upgrade_value( "player", "convert_enemies_max_minions" ) or 0
            else                                                    -- server
                max_minions = managers.player:upgrade_value( "player", "convert_enemies_max_minions", 0 )
            end
            
            
            Application:debug( "GroupAIStateBase:convert_hostage_to_criminal", "Player", player_unit, "Minions: ", table.size( minions ).."/"..max_minions )
            
            if alive(self._converted_police[ u_key ]) or table.size( minions ) >= max_minions then
                local member = managers.network:game():member_from_unit( player_unit )
                if member then
                    if member == Global.local_member then
                        managers.hint:show_hint( "convert_enemy_failed" )
                    else
                        managers.network:session():send_to_peer( member:peer(), "sync_show_hint", "convert_enemy_failed" )
                    end
                end
                
                return
            end
            
            local group = u_data.group
            if group then
                self:_remove_group_member( group, u_key, nil )
            end
            
            -- un-assign from group AI
            self:set_enemy_assigned( nil, u_key )
            
            -- remember the fact that he is converted
            u_data.is_converted = true
            -- switch AI to criminal
            unit:brain():convert_to_criminal( peer_unit )
            -- unit:character_damage():convert_to_criminal()    -- unit:brain():convert_to_criminal already do this
            unit:character_damage():add_listener( "Converted"..tostring(player_unit:key()), {"death"}, callback( self, self, "clbk_minion_dies", player_unit:key() ) )
            -- managers.game_play_central:add_friendly_contour( unit )
            if not unit:contour() then
                debug_pause_unit( unit, "[GroupAIStateBase:convert_hostage_to_criminal]: Unit doesn't have Contour Extension" )
            end
            unit:contour():add( "friendly" )

            u_data.so_access = unit:brain():SO_access()
            
            self._converted_police[ u_key ] = unit
            minions[ u_key ] = unit
            
            
            local convert_enemies_health_multiplier_level = 0
            local passive_convert_enemies_health_multiplier_level = 0
            if alive( peer_unit ) then        -- client
                convert_enemies_health_multiplier_level = peer_unit:base():upgrade_level( "player", "convert_enemies_health_multiplier" ) or 0
                passive_convert_enemies_health_multiplier_level = peer_unit:base():upgrade_level( "player", "passive_convert_enemies_health_multiplier" ) or 0
            else                                                    -- server
                convert_enemies_health_multiplier_level = managers.player:upgrade_level( "player", "convert_enemies_health_multiplier" )
                passive_convert_enemies_health_multiplier_level = managers.player:upgrade_level( "player", "passive_convert_enemies_health_multiplier" )
            end
            
            local owner_peer_id = managers.network:game():member_from_unit( player_unit ):peer():id()
            managers.network:session():send_to_peers( "mark_minion", unit, owner_peer_id, convert_enemies_health_multiplier_level, passive_convert_enemies_health_multiplier_level )
            
            if not peer_unit then    -- server did it!, iam the server
                managers.player:count_up_player_minions()
            end
        end
        managers.groupai:state().convert_hostage_to_criminal = GroupAIStateBase.convert_hostage_to_criminal
    end        
    
    --don't count jokered guards
    if tweak_data.SCSuiteConfiguration.unlimited_conversion_enable then
        GroupAIStateBase.__has_room_for_police_hostage = GroupAIStateBase.has_room_for_police_hostage
        managers.groupai:state().__has_room_for_police_hostage = GroupAIStateBase.has_room_for_police_hostage

        function GroupAIStateBase:has_room_for_police_hostage()
            if not managers.groupai:state():whisper_mode() then
                return self:__has_room_for_police_hostage()
            end
            local global_limit = 1

            for u_key, u_data in pairs( self._player_criminals ) do
                local limit
                if u_data.unit:base().is_local_player then
                    limit = managers.player:upgrade_value( "player", "ene_hostage_lim_1", 1 )
                else
                    limit = u_data.unit:base():upgrade_value( "player", "ene_hostage_lim_1" )
                end
                global_limit = limit and math.max( global_limit, limit ) or global_limit
            end

            return ( self._police_hostage_headcount < global_limit )
        end
        managers.groupai:state().has_room_for_police_hostage = GroupAIStateBase.has_room_for_police_hostage
    end
      
    --No pager for dominated guards
    if tweak_data.SCSuiteConfiguration.no_pager_domination_enable then
        function CopLogicIntimidated._do_tied( data, aggressor_unit )
            local my_data = data.internal_data

            if my_data.surrender_clbk_registered then
                managers.groupai:state():remove_from_surrendered( data.unit )
                my_data.surrender_clbk_registered = nil
            end
            my_data.tied = true
            data.unit:inventory():destroy_all_items()
            data.unit:brain():set_update_enabled_state( false )
            
            if my_data.update_task_key then
                managers.enemy:unqueue_task( my_data.update_task_key )
                my_data.update_task_key = nil
            end
            
            local rsrv_pos = my_data.rsrv_pos
            if rsrv_pos and rsrv_pos.stand then
                managers.navigation:unreserve_pos( rsrv_pos.stand )
                rsrv_pos.stand = nil
            end
            managers.groupai:state():on_enemy_tied( data.unit:key() )
            data.unit:base():set_slot( data.unit, 22 )    --22. Bound Hostages ( civilian and police ) handcuffed players are in slot 4
            
            data.unit:interaction():set_tweak_data( "hostage_convert" )
            data.unit:interaction():set_active( true, true, false )
            
            my_data.is_hostage = true
            managers.groupai:state():on_hostage_state( true, data.key, true )
            
            if aggressor_unit then
                data.unit:character_damage():drop_pickup() -- Steal his things
                data.unit:character_damage():set_pickup( nil )
                    
                if aggressor_unit == managers.player:player_unit() then -- Its me, the server
                    managers.statistics:tied( { name = data.unit:base()._tweak_table } )
                else -- It was one of the clients
                    aggressor_unit:network():send_to_unit( { "statistics_tied", data.unit:base()._tweak_table } )
                end
            end
        end
        
        origCopDamageDie = origCopDamageDie or CopDamage.die
        function CopDamage:die(...)
            origCopDamageDie(self, ...)
            io.stderr:write(self._unit:interaction().tweak_data .."\n")
            if self._unit:interaction().tweak_data == "hostage_convert" then
                self._unit:interaction():set_active(false, true, false)
            end
        end
    end
    
    -- No guard respawns
    
    if tweak_data.SCSuiteConfiguration.no_guard_respawn_enable then
    
        function IsDifficultyHarder(thisDifficulty, otherDifficulty)
            local diffVal = { normal = 1, hard = 2, overkill = 3, overkill_145 = 4, overkill_290 = 5 }
            return diffVal[thisDifficulty] > diffVal[otherDifficulty] and true or false
        end
    
        function fixStealthElementDifficulty(element, target, script)
            local current = Global.game_settings.difficulty
            if current == target or IsDifficultyHarder(target, current) then
                return
            end
            for _,item in ipairs(element:values().on_executed) do
                local elem = script:elements()[item.id]
                if elem:values()["difficulty_"..target] then
                    elem:values()["difficulty_"..current] = true
                elseif elem:values()["difficulty_"..target] == false then
                    elem:values()["difficulty_"..current] = false
                end
            end
        end
        for _, script in pairs(managers.mission:scripts()) do
            for id, element in pairs(script:elements()) do
                local name = element:editor_name()
                if name == "spawnCopPatrol" or name == "spawn_guard" or name == "respawn_guard" or name:find("extra_spawn") then
                    element:set_enabled(false)
                end
                local diff = Global.game_settings.difficulty
                local multiplayer = not Global.game_settings.single_player
                local lvl = Global.game_settings.level_id
                if multiplayer and diff ~= "overkill_290" then --changes only needed for multiplayer and not Deathwish
                    --FF = spawnGuards, BO = logic_link_069, ED1 = setup_spawns, ED2 = delay
                    if name == "spawnGuards" or name == "logic_link_069" or name == "guard_setup" or name == "setup_spawns" or name == "delay" then
                        if lvl:find("framing_frame") or lvl:find("jungle") then
                            fixStealthElementDifficulty(element, "normal", script)
                        elseif lvl == "election_day_1" then
                            fixStealthElementDifficulty(element, "hard", script)
                        elseif lvl == "election_day_2" then
                            fixStealthElementDifficulty(element, "overkill", script)
                        end
                    end
                end
            end
        end
    end
end  