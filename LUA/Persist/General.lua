-------------------------------------------------------------------------
-- Utility Functions
-------------------------------------------------------------------------
if not _hejinit then
    if tweak_data and tweak_data.SCSuiteConfiguration.version_string_override then
        -- HACK VERSION	by pierredjays
        if not MenuNodeMainGui then return end
        -- MenuNodeMainGui = MenuNodeMainGui or class( MenuNodeGui )
        function MenuNodeMainGui:_setup_item_rows( node )
            MenuNodeMainGui.super._setup_item_rows( self, node )
            if alive( self._version_string ) then
                self._version_string:parent():remove( self._version_string )
                self._version_string = nil
            end
            self._version_string = self.ws:panel():text({
                name = "version_string",
                text = tweak_data.SCSuiteConfiguration.version_string,
                font = tweak_data.menu.pd2_small_font,
                font_size = tweak_data.menu.pd2_small_font_size,
                color = Color('FF4F00'),
                align = SystemInfo:platform() == Idstring("WIN32") and "left",
                vertical = "top",
                alpha = 0.9
            })
        end
    end
    
	--SIMPLEMENU by Harfatus
	--Simple menu class for simple menus, duh.
	if not SimpleMenu then
		SimpleMenu = class()

		function SimpleMenu:init(title, message, options)
			self.dialog_data = { title = title, text = message, button_list = {},
								 id = tostring(math.random(0,0xFFFFFFFF)) }
			self.visible = false
			for _,opt in ipairs(options) do
				local elem = {}
				elem.text = opt.text
				opt.data = opt.data or nil
				opt.callback = opt.callback or nil
				elem.callback_func = callback(self, self, "_do_callback",
											  { data = opt.data,
												callback = opt.callback})
				elem.cancel_button = opt.is_cancel_button or false
				if opt.is_focused_button then
					self.dialog_data.focus_button = #self.dialog_data.button_list+1
				end
				table.insert(self.dialog_data.button_list, elem)
			end
			return self
		end

		function SimpleMenu:_do_callback(info)
			if info.callback then
				if info.data then
					info.callback(info.data)
				else
					info.callback()
				end
			end
			self.visible = false
		end

		function SimpleMenu:show()
			if self.visible then
				return
			end
			self.visible = true
			managers.system_menu:show(self.dialog_data)
		end

		function SimpleMenu:hide()
			if self.visible then
				managers.system_menu:close(self.dialog_data.id)
				self.visible = false
				return
			end
		end
	end
	
	if not managers then return end
	local patched_update_input = function (self, t, dt ) 
		if self._data.no_buttons then 
			return 
		end 

		local dir, move_time 
		local move = self._controller:get_input_axis( "menu_move" ) 

		if( self._controller:get_input_bool( "menu_down" )) then 
			dir = 1 
		elseif( self._controller:get_input_bool( "menu_up" )) then 
			dir = -1 
		end 

		if dir == nil then 
			if move.y > self.MOVE_AXIS_LIMIT then 
				dir = 1 
			elseif move.y < -self.MOVE_AXIS_LIMIT then 
				dir = -1 
			end 
		end 

		if dir ~= nil then 
			if( ( self._move_button_dir == dir ) and self._move_button_time and ( t < self._move_button_time + self.MOVE_AXIS_DELAY ) ) then 
				move_time = self._move_button_time or t 
			else 
				self._panel_script:change_focus_button( dir ) 
				move_time = t 
			end 
		end 

		self._move_button_dir = dir 
		self._move_button_time = move_time 

		local scroll = self._controller:get_input_axis( "menu_scroll" ) 
		-- local sdir 
		if( scroll.y > self.MOVE_AXIS_LIMIT ) then 
			self._panel_script:scroll_up() 
			-- sdir = 1 
		elseif( scroll.y < -self.MOVE_AXIS_LIMIT ) then 
			self._panel_script:scroll_down() 
			-- sdir = -1 
		end 
	end 
	managers.system_menu.DIALOG_CLASS.update_input = patched_update_input 
	managers.system_menu.GENERIC_DIALOG_CLASS.update_input = patched_update_input  

	--TABLE PRINT
	if not print_r then
		function print_r (t, indent)
			local indent=indent or ''
			if type(t) == "table" then
				for key,value in pairs(t) do
					io.write(indent,'[',tostring(key),']') 
					if type(value)=="table" then io.write(':\n') print_r(value,indent..'\t')
					else io.write(' = ',tostring(value),'\n') end
				end
			else io.write(tostring(t),'\n') end
		end
	end
	_hejinit = true
end


	
--Random functions that are used repeatedly
inGame = inGame or function()
	if not game_state_machine then return false end
	return string.find(game_state_machine:current_state_name(), "game")
end

isPlaying = isPlaying or function()
	if not BaseNetworkHandler then
		return false
	end

	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[game_state_machine:last_queued_state_name()]
end 

isServer = isServer or function()
	if not Network then
		return false
	end

	return Network:is_server()
end

isClient = isClient or function()
	if not Network then
		return false
	end

	return Network:is_client()
end

isHost = isHost or function()
	if not Network then
		return false
	end

	return not Network:is_client()
end 

inChat = inChat or function()
	if managers.hud and managers.hud._chat_focus then
		return true
	end
end

isSinglePlayer = isSinglePlayer or function()
	return Global.game_settings.single_player or false
end 

if not showHint then
	function showHint(msg)
		if not managers or not managers.hud then 
			return 
		end
		managers.hud:show_hint({text = msg})
	end
end

show_mid_text = show_mid_text or function(_ARG_0_, _ARG_1_, _ARG_2_)
	if managers and managers.hud then
		managers.hud:present_mid_text({
			text = _ARG_0_,
			title = _ARG_1_,
			time = _ARG_2_
		})
	end

end

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
if tweak_data then
    tweak_data.SCSuiteConfiguration.general_loaded = true
end