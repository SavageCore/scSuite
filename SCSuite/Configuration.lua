--[=[ scSuite
by SavageCore
]=]--
SCSuiteConfiguration = SCSuiteConfiguration or class()
--if tweak_data and tweak_data.SCSuiteConfiguration.mission_selector_enable then
function SCSuiteConfiguration:init()

    -- Start edit --
    self.mission_selector_enable = true -- Enables Mission Selection Menu
    self.music_selector_enable = true -- Enables Music Selection Menu
    
    self.mute_bain_enable = true -- Mutes all Bain voice overs in-game except on required levels
    -- All maps listed here disable Mute Bain (Bain talks)
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
        
    self.bank_buster_keybind_enable = true -- Enables opening of all deposit boxes when F9 is pressed
    self.bank_buster_stealth_enable = true -- Enables automatic opening of deposit boxes if vault is opened in stealth
    self.flat_job_bonus_enable = false -- All jobs give +50% XP
    self.drop_in_pause_disable = true -- Disable pause/lock when someone joins your game
    self.cable_tie_override_enable = true -- Enable limit override on amount of cable ties
    self.cable_tie_override_limit = 100 -- Cable ties limit
    self.civilian_follow_override_enable = true -- Enable limit override on amount of civilian followers - Will default to 500
    self.civilian_follow_override_limit = 5 -- Civilian follower limit
    self.version_string_override = true -- Replace Payday 2 Version number on main menu with scSuite version information
    self.instant_drill_override_enable = true -- Enables the keybind F4 to toggle instant drill
    self.drill_jam_override_enable = true -- Enables override so the drill never jams
    self.language = "enGB" --IETF language tag
    self.kill_all_enable = true -- Enables the keybind F5 to kill/delete all AI on map - no pagers
    self.hostage_sell_limit = 1 -- Limit of hostages or body bags you can sell
    
    self.bodies_for_bain_enable = true -- Sell humans - dead or alive
    -- Any level listed here you will be able to sell hostages on
    self.bodies_for_bain_whitelist = {
      
        --"alex_1", -- Rats Day 1
        --"alex_2", -- Rats Day 2
        --"alex_3", -- Rats Day 3
        --"arm_cro", -- Armored Transport: Crossroads
        --"arm_fac", -- Armored Transport: Harbor
        --"arm_for", -- Armored Transport: Train Heist
        --"arm_hcm", -- Armored Transport: Downtown
        --"arm_par", -- Armored Transport: Park
        --"arm_und", -- Armored Transport: Underpass
        "big", -- Big Bank
        "branchbank", -- Bank Heist
        --"election_day_1", -- Election Day Day 1
        --"election_day_2", -- Election Day Day 2
        --"election_day_3_skip1", -- Election Day Day 3 (Not sure the difference)
        --"election_day_3_skip2", -- Election Day Day 3 (Not sure the difference)
        --"election_day_3", -- Election Day Day 3
        --"escape_cafe_day", -- Escape: Cafe (Day)
        --"escape_cafe", -- Escape: Cafe
        --"escape_garage", -- Escape: Garage
        --"escape_overpass_night", -- Escape: Overpass (Night)
        --"escape_overpass", -- Escape: Overpass
        --"escape_park_day", -- Escape: Park (Day)
        --"escape_park", -- Escape: Park
        --"escape_street", -- Escape: Street
        "family", -- Diamond Heist
        --"firestarter_1", -- Firestarter Day 1
        --"firestarter_2", -- Firestarter Day 2
        --"firestarter_3", -- Firestarter Day 3
        --"four_stores", -- Four Stores
        --"framing_frame_1", -- Framing Frame Day 1
        --"framing_frame_2", -- Framing Frame Day 2
        --"framing_frame_3", -- Framing Frame Day 3
        "jewelry_store", -- Jewelry Store
        --"kosugi", -- Shadow Raid
        --"mallcrasher", -- Mallcrasher
        --"nightclub", -- Nightclub
        "roberts", -- GO Bank
        --"safehouse", -- Safehouse
        "ukrainian_job", -- Ukranian Job
        --"watchdogs_1", -- Watchdogs Day 1
        --"watchdogs_2", -- Watchdogs Day 2
        --"welcome_to_the_jungle_1", -- Big Oil Day 1
        --"welcome_to_the_jungle_2", -- Big Oil Day 2          
                
    }
    self.skip_endscreen_enable = true -- Press enter to skip Money/XP counting
    self.sticky_gadget_enable = true -- Gadgets do not turn off on weapon swap
    self.unalerted_pager_chance_enable = true -- Chance to not toggle a pager when killing a guard unalerted (!)
    
    self.force_ready_enable = true -- Spam ready X times to launch level before all have readied
    self.force_ready_threshold = 5
    
    -- Toggle scripts - die push and hold die!
    self.toggle_interact_enable = true -- Enables general interact toggle - lock picking for example - press F again to stop
    self.toggle_mask_enable = true -- Enables mask toggle - press once to put mask on
    self.toggle_equipment_enable = true -- Enables equipment toggle - press once to deploy ECM
    
    self.stealth_joker_enable = true -- Enables Joker (guard domination) in Stealth
    self.unlimited_conversion_enable = true -- Enables unlimited conversions
    
    self.anti_anti_cheat_enable = true -- Enables various Anti Anti-Cheat scripts - such as disabling HoxHud chat spam
   
    self.xray_enable = true -- Enables the keybind F6 to highlight (xray) all enemies, civilians and cameras on the map
    self.pickup_waypoints_enables = false -- Enables Highlighting of Keycards and Crowbars
    
    self.carry_stacker_enable = true -- Enables CarryStacker
    self.carry_stacker_limit = 2 -- Limit for CarryStacker
    
    -- Fixes
    self.fixes_shout_civilians_enable = false -- Enables a fix to stop shouting at tied civs
    -- End edit --
    
    -- !!!!!!! DO NOT TOUCH BELOW !!!!!!! --
    self.version_string = "scSuite v0.1.3 - HoxHud 2.2"
end