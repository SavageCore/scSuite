if tweak_data and tweak_data.SCSuiteConfiguration.confirm_respec_toggle then 

    -------------------------------------------------------------------------------------------------------------
    -- notwa's confirm respec spend skill point dialogs - http://www.unknowncheats.me/forum/1030548-post6.html --
    -------------------------------------------------------------------------------------------------------------
    local function expect_yes(self, params) params.yes_func() end
    if MenuManager then
        MenuManager.show_confirm_skillpoints = expect_yes
        MenuManager.show_confirm_respec_skilltree = expect_yes
    end

end