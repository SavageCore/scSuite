if not HoxHudFix then
    HoxHudFix = true
    
    if UnitNetworkHandler and UnitNetworkHandler.oldMethods then
        UnitNetworkHandler.set_equipped_weapon = UnitNetworkHandler.oldMethods.set_equipped_weapon
    end
end