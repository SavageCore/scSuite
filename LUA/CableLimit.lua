if tweak_data and tweak_data.SCSuiteConfiguration.cable_tie_override_enable and tweak_data.SCSuiteConfiguration.cable_tie_override_limit > 2 then
    --Console("DEBUG: cable_guy started")
    if managers.skilltree:skill_unlocked(nil, "cable_guy") then
        --Console("DEBUG: cable_guy unlocked")
        if managers.skilltree:skill_completed("cable_guy") then
            tie_quantity = tweak_data.SCSuiteConfiguration.cable_tie_override_limit - 2
            tweak_data.upgrades.values.cable_tie.quantity = { tie_quantity }
            --Console("DEBUG: cable_guy completed")     
            --if managers.skilltree:skill_completed("cable_tie_quantity") then
                --Console("DEBUG: extra_cable_ties completed")
                --tweak_data.upgrades.values.cable_tie.quantity = { 10 }
            --end
        end    
    end
end