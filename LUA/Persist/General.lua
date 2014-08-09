dofile("LUA/_GLOBALS.lua")

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
-- CrashFixer - http://www.unknowncheats.me/forum/945899-post1.html
if RequiredScript == "lib/managers/group_ai_states/groupaistatebase" then
    for k,v in pairs(GroupAIStateBase) do
        if type(v) == "function" then
            GroupAIStateBase[k] = function(...)
                local ret = {pcall(v, ...)}
                if ret[1] == true and #ret > 1 then
                    table.remove(ret, 1)
                    return unpack(ret)
                end
            end
        end
    end
    
elseif RequiredScript == "lib/units/enemies/cop/actions/lower_body/copactionwalk" then
    CopActionWalk.___nav_point_pos = CopActionWalk._nav_point_pos
    CopActionWalk.___send_nav_point = CopActionWalk._send_nav_point
    
    function CopActionWalk._nav_point_pos(...)
        local _,ret = pcall(CopActionWalk.___nav_point_pos, ...)
        return ret
    end
    
    function CopActionWalk:_send_nav_point(...)
        local _,ret = pcall(self.___send_nav_point, self, ...)
        return ret
    end
    
elseif RequiredScript == "lib/units/enemies/spooc/actions/lower_body/actionspooc" then
    ActionSpooc.__upd_chase_path = ActionSpooc._upd_chase_path

    function ActionSpooc:_upd_chase_path(...)
        pcall(self.__upd_chase_path, self, ...)
    end
end

-- Fix HoxHud on Update 32 - UnitNetworkHandlerV2.lua:0: attempt to index field '_index_to_weapon_list' (a nil value)
-- http://www.unknowncheats.me/forum/1022920-post31.html
if UnitNetworkHandler and UnitNetworkHandler.oldMethods then
    UnitNetworkHandler.set_equipped_weapon = UnitNetworkHandler.oldMethods.set_equipped_weapon
end