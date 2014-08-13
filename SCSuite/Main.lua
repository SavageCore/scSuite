if tweak_data and not tweak_data.SCSuiteConfiguration then
    dofile("SCSuite/Configuration.lua")
    tweak_data.SCSuiteConfiguration = SCSuiteConfiguration:new()
    dofile("SCSuite/PersistVar.lua")
    tweak_data.SCSuitePersistVar = SCSuitePersistVar:new()
    dofile("SCSuite/Localisation.lua")
    tweak_data.SCSuiteLocalisation = SCSuiteLocalisation:new()
end