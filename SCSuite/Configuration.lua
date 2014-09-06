--[=[ scSuite
by SavageCore
]=]--
SCSuiteConfiguration = SCSuiteConfiguration or class()
require("SCSuite/Localisation.lua")
function SCSuiteConfiguration:init() 
    self.mute_bain_enabled = true
    self.mute_bain_broadcast_toggle = true
    self.mute_bain_blacklist = {
        "alex_1", -- Rats Day 1
        --"alex_2", -- Rats Day 2
        --"alex_3", -- Rats Day 3
        --"arm_cro", -- Armored Transport: Crossroads
        "arm_fac", -- Armored Transport: Harbor
        --"arm_for", -- Armored Transport: Train Heist
        "arm_hcm", -- Armored Transport: Downtown
        --"arm_par", -- Armored Transport: Park
        --"arm_und", -- Armored Transport: Underpass
        "big", -- Big Bank
        --"branchbank", -- Bank Heist
        --"election_day_1", -- Election Day Day 1
        --"election_day_2", -- Election Day Day 2
        --"election_day_3_skip1", -- Election Day Day 3 (Not sure the difference)
        --"election_day_3_skip2", -- Election Day Day 3 (Not sure the difference)
        --"election_day_3", -- Election Day Day 3
        --"escape_cafe_day", -- Escape: Cafe (Day)
        --"escape_cafe", -- Escape: Cafe
        --"escape_garage", -- Escape: Garage
        --"escape_overpass_night", -- Escape: Overpass (Night)
        "escape_overpass", -- Escape: Overpass
        --"escape_park_day", -- Escape: Park (Day)
        --"escape_park", -- Escape: Park
        --"escape_street", -- Escape: Street
        --"family", -- Diamond Heist
        --"firestarter_1", -- Firestarter Day 1
        --"firestarter_2", -- Firestarter Day 2
        --"firestarter_3", -- Firestarter Day 3
        --"four_stores", -- Four Stores
        --"framing_frame_1", -- Framing Frame Day 1
        --"framing_frame_2", -- Framing Frame Day 2
        --"framing_frame_3", -- Framing Frame Day 3
        --"jewelry_store", -- Jewelry Store
        --"kosugi", -- Shadow Raid
        --"mallcrasher", -- Mallcrasher
        --"nightclub", -- Nightclub
        "roberts", -- GO Bank
        --"safehouse", -- Safehouse
        --"ukrainian_job", -- Ukranian Job
        --"watchdogs_1", -- Watchdogs Day 1
        "watchdogs_2", -- Watchdogs Day 2
        --"welcome_to_the_jungle_1", -- Big Oil Day 1
        --"welcome_to_the_jungle_2", -- Big Oil Day 2    
    }
    self.instant_drill_enabled = true
    self.mission_menu_enabled = true
    self.toggle_mask_enabled = true
    self.toggle_equipment_enabled = true
    self.instant_drill_toggle = true
    self.confirm_respec_toggle = true
    self.persistent_gadget_toggle = true
    self.force_ready_toggle = true
    self.force_ready_threshold_value = 3
    self.skip_endscreen_toggle = true
    self.unlock_dlc_toggle = true
end