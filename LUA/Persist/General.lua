ChatMessage = ChatMessage or function(_ARG_0_, _ARG_1_)
	if not managers or not managers.chat or not _ARG_0_ then
		return
	end

	_ARG_1_ = _ARG_1_ or managers.network.account:username()
	managers.chat:receive_message_by_name(1, _ARG_1_, _ARG_0_)
end

SystemMessage = SystemMessage or function(_ARG_0_)
	if not managers or not managers.chat or not _ARG_0_ then
		return
	end

	managers.chat:_receive_message(1, managers.localization:to_upper_text("menu_system_message"), _ARG_0_, tweak_data.system_chat_color)
end

SendMessage = SendMessage or function(_ARG_0_, _ARG_1_)
	if not managers or not managers.chat or not _ARG_0_ then
		return
	end

	_ARG_1_ = _ARG_1_ or managers.network.account:username()
	managers.chat:send_message(1, _ARG_1_, _ARG_0_)
end 

--REMOVE HOXHUD BLACK SCREEN MESSAGE
if HoxHudTweakData and HUDManager then
    function HUDManager:set_blackscreen_mid_text( ... )
        self._hud_blackscreen:set_mid_text(tweak_data.SCSuiteConfiguration.version_string)
    end    
end