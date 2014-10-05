if tweak_data and tweak_data.SCSuiteConfiguration.pager_chance_toggle then
    -- Chance of pager not going off on an unalerted guard kill CREDIT LazyOzzy
    if CopBrain then
        if not _CopBrain_clbk_alarm_pager then _CopBrain_clbk_alarm_pager = CopBrain.clbk_alarm_pager end
        function CopBrain:clbk_alarm_pager( ignore_this, data )
            -- Create a random number
            local rand = math.rand(1)
            -- 50% / 25% / 12.5% / 0% incrementing chances of no pager in a table
            local chance_table = { 0.5, 0.25, 0.125, 0 }
            -- Initalise table index as 1 if not defined
            self._cTableIndex = self._cTableIndex or 1
            -- Clamp the index so that it's never out of bounds
            self._cTableIndex = math.clamp(self._cTableIndex, 1, #chance_table)
            -- Establish the chance only if the guard is unalerted, by fetching the table value using the current index
            local chance = self._unit:movement():cool() and chance_table[self._cTableIndex] or 0
            -- If the random number is less than our current chance
            if self._alarm_pager_data.nr_calls_made == 0 and rand < chance then
                -- Increment the index
                self._cTableIndex = self._cTableIndex + 1
                -- Prevent the pager from going off
                self:end_alarm_pager()
                -- Enable bodybag interaction
                self:_chk_enable_bodybag_interaction()
                return
            end

            -- Otherwise run the original function
            _CopBrain_clbk_alarm_pager(self, ignore_this, data )
        end
    end
end    