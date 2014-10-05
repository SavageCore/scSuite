if not HoxHudOverride then
    if not (tweak_data and tweak_data.hoxhud) then return end
    MenuManager.hh_upd_chk = function(...) end
    HoxHudOverride = true
end  