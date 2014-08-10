-- Fix HoxHud on Update 32 - UnitNetworkHandlerV2.lua:0: attempt to index field '_index_to_weapon_list' (a nil value)
-- http://www.unknowncheats.me/forum/1022920-post31.html
if UnitNetworkHandler and UnitNetworkHandler.oldMethods then
    UnitNetworkHandler.set_equipped_weapon = UnitNetworkHandler.oldMethods.set_equipped_weapon
end