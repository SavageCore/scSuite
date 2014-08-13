if tweak_data and tweak_data.SCSuiteConfiguration.carry_stacker_enable then
    --CARRYSTACKER TOGGLE (CUSTOM LIMIT) by Harfatus, Sirgoodsmoke, B1313, and hejoro
    --Carry multiple bags, toggleable, limitable
    _debugEnabled = false
    BagIcon = "pd2_loot"

    _toggleCarry = not _toggleCarry
    if _toggleCarry then
        managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.carry_stacker_toggle_on, tweak_data.system_chat_color)
        if not CarryStackerSetupDone then
            CarryStackerSetupDone = true
            if managers and managers.player and IntimitateInteractionExt and CarryInteractionExt then
                managers.player.carry_limit = tweak_data.SCSuiteConfiguration.carry_stacker_limit
                managers.player.carry_stack = {}
                managers.player.carrystack_lastpress = 0
                managers.player.drop_all_bags = false
                ofuncs = {
                  managers_player_set_carry = managers.player.set_carry,
                  managers_player_drop_carry = managers.player.drop_carry,
                  IntimitateInteractionExt__interact_blocked = IntimitateInteractionExt._interact_blocked,
                  CarryInteractionExt__interact_blocked = CarryInteractionExt._interact_blocked,
                  CarryInteractionExt_can_select = CarryInteractionExt.can_select,
                }
                
                function managers.player:refresh_stack_counter()
                    local count = #self.carry_stack + (self:is_carrying() and 1 or 0)
                    managers.hud:remove_special_equipment("carrystacker")
                    if count > 0 then
                        managers.hud:add_special_equipment({id = "carrystacker", icon = BagIcon, amount = count})
                    end
                end
                
                function managers.player:rotate_stack(dir)
                    if #managers.player.carry_stack < 1 or (#managers.player.carry_stack < 2 and not self:is_carrying()) then
                        return
                    end
                    if self:is_carrying() then
                        table.insert(self.carry_stack, self:get_my_carry_data())
                    end
                    if dir == "up" then
                        table.insert(self.carry_stack, 1, table.remove(self.carry_stack))
                    else
                        table.insert(self.carry_stack, table.remove(self.carry_stack, 1))
                    end
                    local cdata = table.remove(self.carry_stack)
                    if cdata then
                        if self:is_carrying() then self:carry_discard() end
                        ofuncs.managers_player_set_carry(self, cdata.carry_id, cdata.multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier, cdata.zipline_unit)
                    end
                end

                -- pops an item from the stack when the player drops their carried item
                function managers.player:drop_carry(zipline_unit) 
                    ofuncs.managers_player_drop_carry(self, zipline_unit)
                    if #self.carry_stack > 0 then
                        local cdata = table.remove(self.carry_stack)
                        if cdata then
                            self:set_carry(cdata.carry_id, cdata.multiplier or 1, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier, cdata.zipline_unit)
                        end
                    end
                    self:refresh_stack_counter()
                    if self.drop_all_bags then
                        if #self.carry_stack > 0 or self:is_carrying() then
                            self:drop_carry()
                        end
                        self.drop_all_bags = false
                    end
                    --If carrystacker is off, then drop all but one bag if this is run
                    if not _toggleCarry then
                        if #self.carry_stack > 0 then
                            self:drop_carry()
                        end
                    end
                end

                -- saves the current item to the stack if we're already carrying something
                function managers.player:set_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, zipline_unit)
                    if self:is_carrying() and self:get_my_carry_data() then
                        table.insert(self.carry_stack, self:get_my_carry_data())
                    end
                    ofuncs.managers_player_set_carry(self, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, zipline_unit)
                    self:refresh_stack_counter()
                end

                -- new function to discard the currently carried item
                function managers.player:carry_discard()
                    managers.hud:remove_teammate_carry_info( HUDManager.PLAYER_PANEL )
                    managers.hud:temp_hide_carry_bag()
                    self:update_removed_synced_carry_to_peers()
                    if self._current_state == "carry" then
                        managers.player:set_player_state( "standard" )
                    end
                end

                -- overridden to prevent blocking us from picking up a dead body
                function IntimitateInteractionExt:_interact_blocked( player )
                    if _toggleCarry and self.tweak_data == "corpse_dispose" then
                        if managers.player:chk_body_bags_depleted() then
                            return true, nil, "body_bag_limit_reached"
                        end
                        local count = #managers.player.carry_stack + (managers.player:is_carrying() and 1 or 0)
                        if managers.player.carry_limit > 0 and count == managers.player.carry_limit then
                            return true
                        elseif managers.player.carry_limit > 0 and count > managers.player.carry_limit then
                            if not managers.player:is_carrying() then managers.player:carry_stacker() end
                            managers.player:drop_carry()
                            return true
                        end
                        
                        if not managers.player:has_category_upgrade( "player", "corpse_dispose" ) then
                            return true
                        end
                        return not managers.player:can_carry( "person" )
                    end
                    --Run the original function if carrystacker is off or if player isn't disposing of a corpse
                    return ofuncs.IntimitateInteractionExt__interact_blocked(self, player)
                end

                -- overridden to always allow us to pick up a carry item
                function CarryInteractionExt:_interact_blocked( player )
                    if _toggleCarry then
                        local count = #managers.player.carry_stack + (managers.player:is_carrying() and 1 or 0)
                        if managers.player.carry_limit > 0 and count == managers.player.carry_limit then
                            return true
                        elseif managers.player.carry_limit > 0 and count > managers.player.carry_limit then
                            if not managers.player:is_carrying() then managers.player:carry_stacker() end
                            managers.player:drop_carry()
                            return true
                        end
                        return not managers.player:can_carry( self._unit:carry_data():carry_id() )
                    end
                    --Run the original function if carrystacker is off
                    return ofuncs.CarryInteractionExt__interact_blocked(self, player)
                end

                -- overridden to always allow us to select a carry item
                function CarryInteractionExt:can_select( player )
                    local count = #managers.player.carry_stack + (managers.player:is_carrying() and 1 or 0)
                    if _toggleCarry then 
                        if (managers.player.carry_limit > 0 and count < managers.player.carry_limit) or managers.player.carry_limit == 0 then
                            return CarryInteractionExt.super.can_select( self, player )
                        elseif not managers.player:is_carrying() and count >= managers.player.carry_limit then
                            return false
                        end
                    end
                    --Run the original function if carrystacker is off
                    return ofuncs.CarryInteractionExt_can_select(self, player)
                end

                -- custom function. Pushes a carried item to stack and discards it or pops one if we're not carrying anything.
                -- this function is called every time the script gets run.
                function managers.player:carry_stacker()
                    if _debugEnabled then
                        io.stderr:write("current stack size: ".. tostring(#managers.player.carry_stack) .. "\n")
                        if #managers.player.carry_stack > 0 then
                            for _,v in pffairs(managers.player.carry_stack) do
                                io.stderr:write("item: ".. v.carry_id .. "\n")
                            end
                        end
                    end
                    local cdata = self:get_my_carry_data()
                    if self:is_carrying() and cdata then
                        table.insert(self.carry_stack, self:get_my_carry_data())
                        self:carry_discard()
                        -- managers.hud:present_mid_text( { title = "Carry Stack", text = cdata.carry_id .. " Pushed", time = 1 } )
                    elseif #self.carry_stack > 0 then
                        cdata = table.remove(self.carry_stack)
                        self:set_carry(cdata.carry_id, cdata.multiplier, cdata.dye_initiated, cdata.has_dye_pack, cdata.dye_value_multiplier, cdata.zipline_unit)
                        -- managers.hud:present_mid_text( { title = "Carry Stack", text = cdata.carry_id .. " Popped", time = 1 } )
                    -- else
                        -- managers.hud:present_mid_text( { title = "Carry Stack", text = "Empty", time = 1 } )
                    end
                    if (Application:time() - self.carrystack_lastpress) < 0.3 and (self:is_carrying() or #self.carry_stack > 0) then
                        self.drop_all_bags = true
                        self:drop_carry()
                    end
                    self.carrystack_lastpress = Application:time()
                    self:refresh_stack_counter()
                end
            end
        end
    else
        if not managers.player:is_carrying() then managers.player:carry_stacker() end
        managers.player:drop_carry()
        managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.carry_stacker_toggle_off, tweak_data.system_chat_color)
    end
end    