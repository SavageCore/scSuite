if tweak_data and tweak_data.SCSuiteConfiguration.bodies_for_bain_enable then
    if not Console then return end
    if not tweak_data.SCSuitePersistVar.SellHostage_ii then tweak_data.SCSuitePersistVar.SellHostage_ii = 0 end
    Console("tweak_data.SCSuitePersistVar.SellHostage_ii = " .. tweak_data.SCSuitePersistVar.SellHostage_ii)
    SkipLevel = true
    -- Misc functions --
    function inTable(tbl, i)
        for i,v in ipairs(tbl) do
            if managers.job:current_level_id() == v then
                return true 
            end
        end
        return false
    end
    if managers.job:current_level_id() == nil then return end
    if not isPlaying() then return end
    -- END - Misc functions --    
    
    if not WhitelistCheck then 
        if inTable(tweak_data.SCSuiteConfiguration.bodies_for_bain_whitelist, managers.job:current_level_id()) then
            managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.bodies_for_bain_enabled, tweak_data.system_chat_color)    
            SkipLevel = false
            WhitelistCheck = true
        else
            managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.bodies_for_bain_disabled, tweak_data.system_chat_color)
            WhitelistCheck = true
        end
    end
    
    -- START SELL HOSTAGES --
    if not SellHostage and not SkipLevel then
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
            -- get_bag_value
            if not MoneyManager.def_get_bag_value then MoneyManager.def_get_bag_value = MoneyManager.get_bag_value end    
            function MoneyManager:get_bag_value(carry_id, multiplier)
                if Network:is_client() then
                    return self:def_get_bag_value(carry_id, multiplier)
                end
                
                --\\ Bodybags to sale (2)        
                if carry_id == "person" then
                    return 300    --  dead body cost
                end
                
                return self:def_get_bag_value(carry_id, multiplier)
            end
            
            -- project_instigators
            if not ElementAreaTrigger.def_project_instigators then ElementAreaTrigger.def_project_instigators = ElementAreaTrigger.project_instigators end    
            function ElementAreaTrigger:project_instigators()
                local instigators = self:def_project_instigators()
                
                if Network:is_client() then
                    return instigators
                end
                
                if self.hostages_to_sale == nil then
                    self.hostages_to_sale = {}
                end
                                    
                if self._values.instigator == "loot" then
                    local all_found = World:find_units_quick( "all", 14 )
                            
                    --\\ Bodybags to sale (1)
                    for _,unit in ipairs(all_found) do
                        if unit:carry_data() and unit:carry_data():carry_id() == "person" then
                            table.insert(instigators, unit)
                            tweak_data.SCSuitePersistVar.SellHostage_ii = tweak_data.SCSuitePersistVar.SellHostage_ii + 1
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
            
            -- _is_inside
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
                                if distance <= 500 then     -- 5m (?)            
                                    self.hostages_to_sale[target_unit:id()] = "sold"
                                    managers.loot:secure( "money", managers.money:get_bag_value( "money" ) )    -- award for alive hostage
                                    tweak_data.SCSuitePersistVar.SellHostage_ii = tweak_data.SCSuitePersistVar.SellHostage_ii + 1
                                    return true
                                end
                            end
                        end        
                    end
                    
                end
                
                return self:def__is_inside(pos)
            end

            SellHostage = true
            return
        end
    end
    -- END SELL HOSTAGES --
end