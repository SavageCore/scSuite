if tweak_data and tweak_data.SCSuiteConfiguration.sell_hostage_toggle then
    local DEAD_BODY_COST			=	300			-- Base cost for dead body
    local HOSTAGE_SELL_DISTANCE		=	6 * 100		-- Distance to loot zone, when we can sell a hostage
    local BODYBAGS_STAY_IN_CAR 		= 	false		-- Bodybags visual will stay in car after secure

    if not SellHostage then
        -- GET UNIT TYPE
        if get_unit_type == nil then
            get_unit_type = function(unit)
                return unit:base() and unit:base()._tweak_table
            end
        end

        if get_by_id == nil then
            -- FIND BY ID (Laggy!)
            get_by_id = function(id, mask)
                local all_found = World:find_units_quick( "all", mask )			
                for _,unit in ipairs(all_found) do
                    if unit.id ~= nil and unit:id() == id then
                        return unit
                    end
                end					
                        
                return nil
            end
        end
        
        if inGame == nil then	
            -- INGAME CHECK
            inGame = function()
                if not game_state_machine then return false end
                return string.find(game_state_machine:current_state_name(), "game")
            end
        end
        
        if inGame() then
            -- Get bag value
            if not MoneyManager.def_get_bag_value then MoneyManager.def_get_bag_value = MoneyManager.get_bag_value end	
            function MoneyManager:get_bag_value(carry_id, multiplier)
                if Network:is_client() then
                    return self:def_get_bag_value(carry_id, multiplier)
                end
                
                --\\ Bodybags to sale (2)		
                if carry_id == "person" then --new
                    return DEAD_BODY_COST	-- Bodybags cost
                end
                            
                return self:def_get_bag_value(carry_id, multiplier)
            end
            
            -- Check loot items for trigger zone
            if not ElementAreaTrigger.def_project_instigators then ElementAreaTrigger.def_project_instigators = ElementAreaTrigger.project_instigators end	
            function ElementAreaTrigger:project_instigators()
                if self.def_project_instigators == nil then
                    return {}
                end
                
                local instigators = self:def_project_instigators()

                if Network:is_client() then
                    return instigators
                end
                
                -- new --
                if self.hostages_to_sale == nil then
                    self.hostages_to_sale = {}
                end
                
                -- Check for zones with same position (probably don't have sense)
                if self.h_bAlowed == nil and self._values.instigator == "loot" then
                    local _id = self:id()

                    local pos, rot = self:get_orientation()
                    if managers.loot.h_ea_pos_store == nil then managers.loot.h_ea_pos_store = {} end
                    
                    if pos ~= nil then
                        if managers.loot.h_ea_pos_store[_id] == nil then
                            managers.loot.h_ea_pos_store[_id] = {pos, true}
                            self.h_bAlowed = true
                        end
                        
                        for ea_id, ea_data in pairs(managers.loot.h_ea_pos_store) do
                            if ea_id ~= _id then
                                local ea_pos 	= ea_data[1]
                                local ea_alowed	= ea_data[2]
                                
                                if ea_alowed == true then
                                    local distance = mvector3.distance(ea_pos, pos)
                                    if distance <= 800 then
                                        managers.loot.h_ea_pos_store[_id][2] = false
                                        self.h_bAlowed = false
                                        break
                                    end
                                end
                            end
                        end
                    else
                        self.h_bAlowed = false
                    end
                end
                
                -- Add bodybags and hostages to loot
                if self.h_bAlowed == true and self._values.instigator == "loot" then
                    local all_found = World:find_units_quick( "all", 14 )
                            
                    --\\ Bodybags to sale (1)
                    for _,unit in ipairs(all_found) do
                        if unit:carry_data() and unit:carry_data():carry_id() == "person" then
                            table.insert(instigators, unit)
                        end
                    end
                    
                    --\\ Add hostages to loot list
                    local all_found = World:find_units_quick( "all", managers.slot:get_mask("civilians") )			
                    for _,unit in ipairs(all_found) do
                        if unit.brain ~= nil then
                            local brain = unit:brain()
                            if brain ~= nil then
                                local objective = brain:objective()
                                local objective_type = objective and objective.type				
                                if objective_type == "follow" or objective_type == "surrender" then
                                    table.insert(instigators, unit)			

                                    if self.hostages_to_sale[unit:id()]  == nil then
                                        self.hostages_to_sale[unit:id()] = "fresh"		
                                    end
                                end
                            end
                        end
                    end			
                end
                
                return instigators
            end
            
            -- Is unit inside area check
            if not ElementAreaTrigger.def__is_inside then ElementAreaTrigger.def__is_inside = ElementAreaTrigger._is_inside end		
            function ElementAreaTrigger:_is_inside(pos)
                if self.hostages_to_sale == nil then
                    self.hostages_to_sale = {}
                end
                
                if self._values.instigator == "loot" then
                    -- Find unit by his position
                    local target_unit = nil
                    
                    for unit_id, sale_state in pairs(self.hostages_to_sale) do
                        if sale_state == "fresh" then
                            local unit = get_by_id(unit_id, managers.slot:get_mask("civilians"))
                            
                            if unit ~= nil  then
                                local unit_pos = unit:position()
                                if unit_pos.x == pos.x and unit_pos.y == pos.y and unit_pos.z == pos.z then
                                    target_unit = unit
                                    break
                                end
                            end
                        end
                    end
                    
                    -- Check that hostage near loot car
                    if target_unit ~= nil then
                        local all_shapes = self:get_shapes()
                            
                        for _,shape in ipairs(all_shapes) do
                            if shape ~= nil then
                                local distance = mvector3.distance(shape:position(), pos)
                                if distance <= HOSTAGE_SELL_DISTANCE then	
                                    self.hostages_to_sale[target_unit:id()] = "sold"
                                    return true
                                end
                            end
                        end		
                    end
                    
                end
                
                return self:def__is_inside(pos)
            end

            local civ_types = {
                civilian		=	true,
                civilian_female	=	true,
                bank_manager	=	true,			
            }
            
            -- Carry in trigger callback
            function ElementCarry:on_executed(instigator)		
                if not self._values.enabled or not alive(instigator) then
                    return
                end
            
                local isHostage = (instigator:carry_data() == nil and civ_types[get_unit_type(instigator)] == true)	--new	
                if managers.loot.h_secured_persons == nil then managers.loot.h_secured_persons 	= {} end --new
                
                if self._values.type_filter and self._values.type_filter ~= "none" then
                    if managers.loot.h_saved_filter_type == nil then managers.loot.h_saved_filter_type = self._values.type_filter end --new - protect from double item remove -> crash
                    
                    local carry_ext = instigator:carry_data()
                    if carry_ext ~= nil then --new
                        local carry_id 	= carry_ext:carry_id()
                        local disable_f	= false	--new
                        
                        if carry_id == "person" and managers.loot.h_saved_filter_type == self._values.type_filter then --new
                            disable_f = true
                        end
                        
                        if not disable_f then --new
                            if carry_id ~= self._values.type_filter then
                                return
                            end
                        end
                    end
                end

                if self._values.operation == "remove" then --new
                    if Network:is_server() then
                        if isHostage == true then --new
                            if managers.loot.h_secured_persons[instigator:id()] == "secured" then
                                managers.loot:secure( "money" )
                                managers.loot.h_secured_persons[instigator:id()] = "removed"
                                    
                                if instigator:damage():has_sequence("secured") then
                                    instigator:damage():run_sequence_simple("secured")
                                else
                                    debug_pause("[ElementCarry:on_executed] instigator missing secured sequence", instigator)
                                end
                                    
                                instigator:set_slot(0)
                            end
                        else	
                            local carry_ext = instigator:carry_data() --new
                            if carry_ext == nil or BODYBAGS_STAY_IN_CAR == false or carry_ext:carry_id() ~= "person" then --new
                                instigator:set_slot(0)
                            end
                        end					
                    end
                    
                elseif self._values.operation == "add_to_respawn" then
                    if Network:is_server() then
                        local carry_ext = instigator:carry_data()
                        if carry_ext ~= nil then --new
                            local carry_id = carry_ext:carry_id()
                            local multiplier = carry_ext:multiplier()
                            managers.loot:add_to_respawn(carry_id, multiplier)
                            instigator:set_slot(0)
                        end
                    end

                elseif self._values.operation == "freeze" then
                    if instigator:damage():has_sequence("freeze") then
                        instigator:damage():run_sequence_simple("freeze")
                    else
                        debug_pause("[ElementCarry:on_executed] instigator missing freeze sequence", instigator)
                    end

                elseif self._values.operation == "secure" or self._values.operation == "secure_silent" then
                    if managers.loot.h_secured_persons[instigator:id()] == nil then --new	
                        if isHostage == true and Network:is_server() then --new
                            managers.loot.h_secured_persons[instigator:id()] = "secured"					
                        end
                        
                        if instigator:carry_data() then
                            local carry_ext = instigator:carry_data()
                            carry_ext:disarm()
                        
                            if Network:is_server() then
                                local silent = self._values.operation == "secure_silent"
                                local carry_id = carry_ext:carry_id()
                                local multiplier = carry_ext:multiplier()
                                managers.loot:secure(carry_id, multiplier, silent)
                            end

                            carry_ext:set_value(0)
                            if instigator:damage():has_sequence("secured") then
                                instigator:damage():run_sequence_simple("secured")
                            else
                                debug_pause("[ElementCarry:on_executed] instigator missing secured sequence", instigator)
                            end	
                        else
                            debug_pause("[ElementCarry:on_executed] instigator missing carry_data extension", instigator)
                        end
                    end
                end
                            
                ElementCarry.super.on_executed(self, instigator)
            end
            
            
            if not PlayerManager.def_dye_pack_exploded then PlayerManager.def_dye_pack_exploded = PlayerManager.dye_pack_exploded end			
            function PlayerManager:dye_pack_exploded()
                local carry_data = self:get_my_carry_data()
                if not carry_data then
                    return
                end

                if carry_data.value == nil then --new - duno, but sometimes it nil for bodybag (eg on Election Day 2)
                    return
                end
                
                return self:def_dye_pack_exploded()
            end
        
            SellHostage = true
            return
        end
    end
end    