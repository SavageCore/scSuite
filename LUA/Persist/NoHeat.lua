if tweak_data and tweak_data.SCSuiteConfiguration.flat_job_bonus_enable then    
    --NEVER ANY HEAT by hejoro
    --Stupid lazy way to have no more negative penalties for doing the same job over and over. All jobs now have +50% bonus
    --Change 500 to 0 to remove XP bonus
    if Global.job_manager then
        for k,v in pairs(Global.job_manager.heat) do
            managers.job:set_job_heat(k, 500)
        end
    end
end    