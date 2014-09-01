if tweak_data and tweak_data.SCSuiteConfiguration.persistent_gadget_toggle then 

    ---------------------------------------------------------------------------------------------------------------------------
    -- LazyOzzy's Persistent Gadget State - http://www.unknowncheats.me/forum/payday-2/122014-persistent-weapon-gadgets.html --
    ---------------------------------------------------------------------------------------------------------------------------
    local NewRaycastWeaponBase_on_equip_original = NewRaycastWeaponBase.on_equip
    local NewRaycastWeaponBase_toggle_gadget_original = NewRaycastWeaponBase.toggle_gadget

    function NewRaycastWeaponBase:on_equip()
        self:set_gadget_on(self._stored_gadget_on or 0, false)
        return NewRaycastWeaponBase_on_equip_original(self)
    end

    function NewRaycastWeaponBase:toggle_gadget()
        local result = NewRaycastWeaponBase_toggle_gadget_original(self)
        if result then self._stored_gadget_on = self._gadget_on end
        return result
    end

end