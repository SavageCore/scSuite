if tweak_data and tweak_data.SCSuiteConfiguration.cable_tie_override_enable and tweak_data.SCSuiteConfiguration.cable_tie_override_limit > 2 then
    cable_limit = tweak_data.SCSuiteConfiguration.cable_tie_override_limit - 2
    tweak_data.upgrades.values.cable_tie.quantity = { cable_limit }
end