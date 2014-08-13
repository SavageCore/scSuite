--[=[ scSuite
by SavageCore
]=]--
SCSuiteLocalisation = SCSuiteLocalisation or class()
--tweak_data.SCSuiteLocalisation.instant_drill_override_disabled
function SCSuiteLocalisation:init()
    if tweak_data.SCSuiteConfiguration.language == "enGB" then
        -- Instant Drill
        self.instant_drill_override_enabled = "Enabled: Instant Drill Override"
        self.instant_drill_override_disabled = "Disabled: You may not run this script (instant_drill_override_enable)"
        self.instant_drill_override_toggle_on = "INSTANT DRILL (ON)"
        self.instant_drill_override_toggle_off = "INSTANT DRILL (OFF)"
        -- Jam Override
        self.drill_jam_override_enabled = "Enabled: Drill Jam Override"
        self.drill_jam_override_disabled = "Disabled: Drill Jam Override (drill_jam_override_enable)"
        -- Configuration Reloaded
        self.reload_configuration_success = "Configuration Reloaded"
        self.reload_configuration_fail = "Failed: Configuration Reload"
        -- Sell hostages
        self.bodies_for_bain_enabled = "Bain: Bring me hostages or body bags!"
        self.bodies_for_bain_disabled = "Bain: We cannot take organs with this Ebola crisis!"
        -- Mute Bain
        self.mute_bain_enabled = "Enabled: MuteBain"
        self.mute_bain_disabled = "Disabled: MuteBain - required for this level."
        -- KillAllAI
        self.kill_all_notify = "ALL KILLED"
        self.kill_all_disabled = "Disabled: KillAllAI (kill_all_enable)"
        -- XRay
        self.xray_enabled = "Enabled: XRay"
        self.xray_disable = "Disabled: XRay (xray_enable)"        
        --CarryStacker
        self.carry_stacker_enabled = "Enabled: CarryStacker"
        self.carry_stacker_disabled = "Disabled: CarryStacker (carry_stacker_enable)"
        self.carry_stacker_toggle_on = "CarryStacker (ON)"
        self.carry_stacker_toggle_off = "CarryStacker (OFF)"        
        --PickupFinder
        self.pickup_finder_enabled = "Enabled: PickupFinder"
        self.pickup_finder_disabled = "Disabled: PickupFinder (pickup_waypoints_enable)"
        --BigBankComputer
        self.big_bank_computer_enabled = "Enabled: BigBankComputer"
        self.big_bank_computer_disabled = "Disabled: BigBankComputer (big_bank_computer_enable)"
        self.big_bank_computer_toggle_on = "Big Bank Computer Hack (ON)"
        self.big_bank_computer_toggle_off = "Big Bank Computer Hack (OFF)"        
    elseif tweak_data.SCSuiteConfiguration.language == "deDE" then
        -- Instant Drill
        self.instant_drill_override_enabled = "DE Enabled: Instant Drill Override"
        self.instant_drill_override_disabled = "DE Disabled: You may not run this script (instant_drill_override_enable)"
        self.instant_drill_override_toggle_on = "DE INSTANT DRILL (ON)"
        self.instant_drill_override_toggle_off = "DE INSTANT DRILL (OFF)"
        -- Jam Override
        self.drill_jam_override_enabled = "DE Enabled: Drill Jam Override"
        self.drill_jam_override_disabled = "DE Disabled: Drill Jam Override (drill_jam_override_enable)"
        -- Configuration Reloaded
        self.reload_configuration_success = "Konfiguration Reloaded"
        self.reload_configuration_fail = "DE Failed: Configuration Reload"
        -- Sell hostages
        self.bodies_for_bain_enabled = "DE Bain: Bring me hostages or body bags!"
        self.bodies_for_bain_disabled = "DE Bain: We cannot take organs with this Ebola crisis!"
        -- Mute Bain
        self.mute_bain_enabled = "DE Enabled: MuteBain"
        self.mute_bain_disabled = "DE Disabled: MuteBain - required for this level."
        -- KillAllAI
        self.kill_all_notify = "DE ALL KILLED"
        self.kill_all_disabled = "DE Disabled: KillAllAI (kill_all_enable)"     
        -- XRay
        self.xray_enabled = "DE Enabled: XRay"
        self.xray_disable = "DE Disabled: XRay (xray_enable)"    
        --CarryStacker
        self.carry_stacker_enabled = "DE Enabled: CarryStacker"
        self.carry_stacker_disabled = "DE Disabled: CarryStacker (carry_stacker_enable)"
        self.carry_stacker_toggle_on = "DE CarryStacker (ON)"
        self.carry_stacker_toggle_off = "DE CarryStacker (OFF)"    
        --PickupFinder
        self.pickup_finder_enabled = "DE Enabled: PickupFinder"
        self.pickup_finder_disabled = "DE Disabled: PickupFinder (pickup_waypoints_enable)"    
        --BigBankComputer
        self.big_bank_computer_enabled = "DE Enabled: BigBankComputer"
        self.big_bank_computer_disabled = "DE Disabled: BigBankComputer (big_bank_computer_enable)"   
        self.big_bank_computer_toggle_on = "DE Big Bank Computer Hack (ON)"
        self.big_bank_computer_toggle_off = "DE Big Bank Computer Hack (OFF)"           
    end    
end