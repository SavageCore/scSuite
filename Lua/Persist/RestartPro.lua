if not RestartPro then
    RestartPro = true
    if tweak_data then
        rawset(tweak_data.hoxhud, "debug_allow_restart_any_job", tweak_data.SCSuiteConfiguration.restart_pro_toggle)
    end
end