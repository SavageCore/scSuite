if not CustomMenuClass then
    CustomMenuClass = class()
	
	--[[ ## Default Values for Menu ## ]]--
	
	_mouseId = "mod_menu_mouse"
	_pauseThreadName = "mod_menu_pause_thread"
	
	--[[ ## Menu Settings ## ]]--
	_panelGaps = 30 --[[ Gaps Between Things like the Menu and Navigation Bar ]]--
	_baseLayer = 100 --[[ So Everything is Drawn Over Everything Else ]]--
	_hasBackgroundBlur = true --[[ The Blur that Appears behind the Menu to Blur out the Background ]]--
	_hasLoading = true --[[ Creates a loading circle when menu opens and fades in menu, fades out menu when closing ]]--
	_hasTitle = true
	_hasNavigation = true
	_hasBorder = true
	_indentColumns = 10 --[[ Distance from edge of Main Menu Panel to the Columns for Options ]]--
	_pauseGame = false

	--[[ ## Actual Menu Settings ## ]]--
	_title = "Mod Menu"
	_titleFont = "fonts/font_large_mf"
	_titleFontSize = 48
	_titleColor = Color.white
	_optionFont = "fonts/font_medium_mf"
	_optionFontSize = 24
	_optionColor = Color.white
	_helpFont = "fonts/font_medium_mf"
	_helpFontSize = 24
	_helpColor = Color.white
	_buttonHighlightColor = Color.white
	_buttonRectHighlightColor = Color(0.3019608, 0.7764706, 1)
	_isMainMenu = false
	_maxRows = 10 --[[ 10 Seems to be a Good Default with Current Default Menu Sizes ]]--
	_maxColumns = 2
	_defaultToggleBoolean = false
	_defaultPostToggleBoolean = true
	_defaultRecieveToggleBoolean = false
	_hasHelp = true
	_closeMenu = false
	
	--[[ ## Main Menu Rectangle ## ]]--
	_mainMenuRectWidth = 750
	_mainMenuRectHeight = 400
	_mainMenuRectColor = Color.black
	_mainMenuRectAlpha = 0.75
	_mainMenuRectAlign = "left"
	_mainMenuRectHAlign = "top"
	_mainMenuRectVertical = "top"
	_mainMenuBorderWidth = 5
	_mainMenuBorderColor = Color.white
	_mainMenuBorderAlpha = 1
	
	--[[ ## Menu Title Rectangle ## ]]--
	_titleMenuRectWidth = 750
	_titleMenuRectHeight = 100
	_titleMenuRectColor = Color.black
	_titleMenuRectAlpha = 0.75
	_titleMenuRectAlign = "left"
	_titleMenuRectHAlign = "top"
	_titleMenuRectVertical = "top"
	_titleMenuBorderWidth = 5
	_titleMenuBorderColor = Color.white
	_titleMenuBorderAlpha = 1
	
	--[[ ## Menu Navigation Rectangle ## ]]--
	_navigationMenuRectWidth = 750
	_navigationMenuRectHeight = 100
	_navigationMenuRectColor = Color.black
	_navigationMenuRectAlpha = 0.75
	_navigationMenuRectAlign = "left"
	_navigationMenuRectHAlign = "top"
	_navigationMenuRectVertical = "top"
	_navigationMenuBorderWidth = 5
	_navigationMenuBorderColor = Color.white
	_navigationMenuBorderAlpha = 1
	
	--[[ ## End of Default Values for Menu ## ]]--
	
	--[[ ## Initialization: Declare all 'self.' variables here ## ]]--
	function CustomMenuClass:init(params)
		if not params then
			params = {}
		end
		
		--[[ ## Setup Menu Settings ## ]]--
		self.menus = { }
		self.panelGaps = getValue(params.panelGaps, _panelGaps)
		self.baseLayer = getValue(params.baseLayer, _baseLayer)
		self.hasBackgroundBlur = getValue(params.hasBackgroundBlur, _hasBackgroundBlur)
		self.hasLoading = getValue(params.hasLoading, _hasLoading)
		self.hasTitle = getValue(params.hasTitle, _hasTitle)
		self.hasNavigation = getValue(params.hasNavigation, _hasNavigation)
		self.hasBorder = getValue(params.hasBorder, _hasBorder)
		self.indentColumns = getValue(params.indentColumns, _indentColumns)
		self.pauseGame = getValue(params.pauseGame, _pauseGame)
		self.mouseActive = false
		
		--[[ ## Setup Workspace ## ]]--
		--[[ Get Resolution Settings ]]--
		self.resolution = RenderSettings.resolution
		--[[ Create Workspace using Resolution Settings to Cover the Whole Screen ]]--
		self.workspace = Overlay:gui():create_scaled_screen_workspace(self.resolution.x, self.resolution.y, 0, 0, self.resolution.x, self.resolution.y)
		--[[ Create a Panel the Size of the Workspace to Make Hiding all Components of the Menu Easily ]]--
		self.panelWorkspace = self.workspace:panel({ name = "workspace_panel" })
		--[[ Create a Panel to Contain the Menu ]]--
		self.panelMenu = self.panelWorkspace:panel({ name = "menu_panel" })
		
		--[[ ## Setup Blur ## ]]--
		if self.hasBackgroundBlur then
			local optionalParams = {
				renderTemplate = "VertexColorTexturedBlur3D",
				layer = self.baseLayer,
				blendMode = "normal",
				alpha = 1
			}
			self.menuBlur = drawBitmap(self.panelWorkspace, "menu_blur", 0, 0, self.panelWorkspace:w(), self.panelWorkspace:h(), "guis/textures/test_blur_df", optionalParams)
		end
		
		--[[ ## Setup Menu Main ## ]]--
		self.panelMainMenu = self.panelMenu:panel({ name = "mainmenu_panel" })
		
		self.mainMenuRectWidth = getValue(params.mainMenuRectWidth, _mainMenuRectWidth)
		self.mainMenuRectHeight = getValue(params.mainMenuRectHeight, _mainMenuRectHeight)
		self.mainMenuRectX = getValue(params.mainMenuRectX, ((self.resolution.x / 2) - (self.mainMenuRectWidth / 2)))
		self.mainMenuRectY = getValue(params.mainMenuRectY, ((self.resolution.y / 2) - (self.mainMenuRectHeight / 2)))
		self.mainMenuRectColor = getValue(params.mainMenuRectColor, _mainMenuRectColor)
		self.mainMenuRectAlpha = getValue(params.mainMenuRectAlpha, _mainMenuRectAlpha)
		self.mainMenuRectLayer = getValue(params.mainMenuRectLayer, (self.baseLayer + 1))
		self.mainMenuRectAlign = getValue(params.mainMenuRectAlign, _mainMenuRectAlign)
		self.mainMenuRectHAlign = getValue(params.mainMenuRectHAlign, _mainMenuRectHAlign)
		self.mainMenuRectVertical = getValue(params.mainMenuRectVertical, _mainMenuRectVertical)
		self.mainMenuBorderWidth = getValue(params.mainMenuBorderWidth, _mainMenuBorderWidth)
		self.mainMenuBorderColor = getValue(params.mainMenuBorderColor, _mainMenuBorderColor)
		self.mainMenuBorderAlpha = getValue(params.mainMenuBorderAlpha, _mainMenuBorderAlpha)
		self.mainMenuBorderLayer = getValue(params.mainMenuBorderLayer, (self.mainMenuRectLayer + 1))
		
		positionPanel(self.panelMainMenu, self.mainMenuRectX, self.mainMenuRectY)
		sizePanel(self.panelMainMenu, self.mainMenuRectWidth, self.mainMenuRectHeight)
		
		local optionalParams = {
			rectAlpha = self.mainMenuRectAlpha,
			rectLayer = self.mainMenuRectLayer,
			rectAlign = self.mainMenuRectAlign,
			rectHAlign = self.mainMenuRectHAlign,
			rectVertical = self.mainMenuRectVertical,
			borderAlpha = self.mainMenuBorderAlpha,
			borderLayer = self.mainMenuBorderLayer
		}
		if self.hasBorder then
			drawRectBorder(self.panelMainMenu, "main_menu_panel", 0, 0, self.mainMenuRectWidth, self.mainMenuRectHeight, self.mainMenuRectColor, self.mainMenuBorderWidth, self.mainMenuBorderColor, optionalParams)
		else
			self.mainMenuBorderWidth = 0
			drawRect(self.panelMainMenu, "main_menu_panel", 0, 0, self.mainMenuRectWidth, self.mainMenuRectHeight, self.mainMenuRectColor, optionalParams)
		end
		
		--[[ ## Setup Menu Title ## ]]--
		if self.hasTitle then
			self.panelTitleMenu = self.panelMenu:panel({ name = "title_panel" })
			
			self.titleMenuRectWidth = getValue(params.titleMenuRectWidth, _titleMenuRectWidth)
			self.titleMenuRectHeight = getValue(params.titleMenuRectHeight, _titleMenuRectHeight)
			self.titleMenuRectX = getValue(params.titleMenuRectX, (self.mainMenuRectX + (self.mainMenuRectWidth / 2) - (self.titleMenuRectWidth / 2)))
			self.titleMenuRectY = getValue(params.titleMenuRectY, (self.mainMenuRectY - self.panelGaps - self.titleMenuRectHeight))
			self.titleMenuRectColor = getValue(params.titleMenuRectColor, _titleMenuRectColor)
			self.titleMenuRectAlpha = getValue(params.titleMenuRectAlpha, _titleMenuRectAlpha)
			self.titleMenuRectLayer = getValue(params.titleMenuRectLayer, (self.baseLayer + 1))
			self.titleMenuRectAlign = getValue(params.titleMenuRectAlign, _titleMenuRectAlign)
			self.titleMenuRectHAlign = getValue(params.titleMenuRectHAlign, _titleMenuRectHAlign)
			self.titleMenuRectVertical = getValue(params.titleMenuRectVertical, _titleMenuRectVertical)
			self.titleMenuBorderWidth = getValue(params.titleMenuBorderWidth, _titleMenuBorderWidth)
			self.titleMenuBorderColor = getValue(params.titleMenuBorderColor, _titleMenuBorderColor)
			self.titleMenuBorderAlpha = getValue(params.titleMenuBorderAlpha, _titleMenuBorderAlpha)
			self.titleMenuBorderLayer = getValue(params.titleMenuBorderLayer, (self.titleMenuRectLayer + 1))
			
			positionPanel(self.panelTitleMenu, self.titleMenuRectX, self.titleMenuRectY)
			sizePanel(self.panelTitleMenu, self.titleMenuRectWidth, self.titleMenuRectHeight)
			
			local optionalParams = {
				rectAlpha = self.titleMenuRectAlpha,
				rectLayer = self.titleMenuRectLayer,
				rectAlign = self.titleMenuRectAlign,
				rectHAlign = self.titleMenuRectHAlign,
				rectVertical = self.titleMenuRectVertical,
				borderAlpha = self.titleMenuBorderAlpha,
				borderLayer = self.titleMenuBorderLayer
			}
			if self.hasBorder then
				drawRectBorder(self.panelTitleMenu, "title_menu_panel", 0, 0, self.titleMenuRectWidth, self.titleMenuRectHeight, self.titleMenuRectColor, self.titleMenuBorderWidth, self.titleMenuBorderColor, optionalParams)
			else
				self.titleMenuBorderWidth = 0
				drawRect(self.panelTitleMenu, "title_menu_panel", 0, 0, self.titleMenuRectWidth, self.titleMenuRectHeight, self.titleMenuRectColor, optionalParams)
			end
		end
		
		--[[ ## Setup Menu Navigation ## ]]--
		if self.hasNavigation then
			self.panelNavigationMenu = self.panelMenu:panel({ name = "navigation_panel" })
			
			self.navigationMenuRectWidth = getValue(params.navigationMenuRectWidth, _navigationMenuRectWidth)
			self.navigationMenuRectHeight = getValue(params.navigationMenuRectHeight, _navigationMenuRectHeight)
			self.navigationMenuRectX = getValue(params.navigationMenuRectX, (self.mainMenuRectX + (self.mainMenuRectWidth / 2) - (self.navigationMenuRectWidth / 2)))
			self.navigationMenuRectY = getValue(params.navigationMenuRectY, (self.mainMenuRectY + self.panelGaps + self.mainMenuRectHeight))
			self.navigationMenuRectColor = getValue(params.navigationMenuRectColor, _navigationMenuRectColor)
			self.navigationMenuRectAlpha = getValue(params.navigationMenuRectAlpha, _navigationMenuRectAlpha)
			self.navigationMenuRectLayer = getValue(params.navigationMenuRectLayer, (self.baseLayer + 1))
			self.navigationMenuRectAlign = getValue(params.navigationMenuRectAlign, _navigationMenuRectAlign)
			self.navigationMenuRectHAlign = getValue(params.navigationMenuRectHAlign, _navigationMenuRectHAlign)
			self.navigationMenuRectVertical = getValue(params.navigationMenuRectVertical, _navigationMenuRectVertical)
			self.navigationMenuBorderWidth = getValue(params.navigationMenuBorderWidth, _navigationMenuBorderWidth)
			self.navigationMenuBorderColor = getValue(params.navigationMenuBorderColor, _navigationMenuBorderColor)
			self.navigationMenuBorderAlpha = getValue(params.navigationMenuBorderAlpha, _navigationMenuBorderAlpha)
			self.navigationMenuBorderLayer = getValue(params.navigationMenuBorderLayer, (self.navigationMenuRectLayer + 1))
			
			positionPanel(self.panelNavigationMenu, self.navigationMenuRectX, self.navigationMenuRectY)
			sizePanel(self.panelNavigationMenu, self.navigationMenuRectWidth, self.navigationMenuRectHeight)
			
			local optionalParams = {
				rectAlpha = self.navigationMenuRectAlpha,
				rectLayer = self.navigationMenuRectLayer,
				rectAlign = self.navigationMenuRectAlign,
				rectHAlign = self.navigationMenuRectHAlign,
				rectVertical = self.navigationMenuRectVertical,
				borderAlpha = self.navigationMenuBorderAlpha,
				borderLayer = self.navigationMenuBorderLayer
			}
			if self.hasBorder then
				drawRectBorder(self.panelNavigationMenu, "navigation_menu_panel", 0, 0, self.navigationMenuRectWidth, self.navigationMenuRectHeight, self.navigationMenuRectColor, self.navigationMenuBorderWidth, self.navigationMenuBorderColor, optionalParams)
			else
				self.navigationMenuBorderWidth = 0
				drawRect(self.panelNavigationMenu, "navigation_menu_panel", 0, 0, self.navigationMenuRectWidth, self.navigationMenuRectHeight, self.navigationMenuRectColor, optionalParams)
			end
		end

		--[[ ## Make all Required Panels Invisible ## ]]--
		self.panelWorkspace:hide()
		self.panelMenu:hide()
		if self.hasBackgroundBlur then
			self.menuBlur:hide()
		end
		
		self.menuLoaded = false
        self.visible = false
        return self
    end
	
	--[[ ## Menu Functions ## ]]--
	--[[ Opens Menu ]]--
	function CustomMenuClass:open()
		if not self:isVisible() and not self:isMenuLoaded() then
			self.visible = true
			self.panelWorkspace:show()
			self:openMainMenu()
			if self.hasLoading then
				self:doLoadingAnimation()
			else
				if self.hasBackgroundBlur then
					self.menuBlur:show()
				end
				self.panelMenu:show()
				self:_open()
			end
		end
	end
	
	function CustomMenuClass:_open()
		self:activateMouse()
		self:menuPause(true)
		self.menuLoaded = true
	end
	
	--[[ Closes Menu ]]--
	function CustomMenuClass:close()
		if self:isVisible() and self:isMenuLoaded() then
			self.visible = false
			self:menuPause(false)
			self:deactivateMouse()
			if self.hasLoading then
				self:setupMenuFadeOut(self)
			else
				self:_close()
			end
		end
	end
	
	function CustomMenuClass:_close()
		self:clearMainMenuComponents()
		self.panelWorkspace:hide()
		self.panelWorkspace:set_alpha(1)
		if self.hasBackgroundBlur then
			self.menuBlur:hide()
		end
		self.panelMenu:hide()
		self.menuLoaded = false
	end
	
	--[[ Starts a Thread which Makes Sure the Game Stays Paused Whilst the Menu is Open ]]--
	function CustomMenuClass:startPauseThread()
		addThread({
			name = _pauseThreadName,
			func = (function() if not isGamePaused() then pauseGame(true) end end),
			sleep = 0.5,
			loopCount = -1
		})
	end
	
	function CustomMenuClass:stopPauseThread()
		stopThread(_pauseThreadName)
	end

	function CustomMenuClass:menuPause(enabled)
		if managers then
			if managers.player and managers.player:player_unit() then
					managers.player:player_unit():base():set_controller_enabled(not enabled)
				end
			if managers.menu and managers.menu:active_menu() then
				managers.menu:active_menu().logic:accept_input(not enabled)
				managers.menu:active_menu().renderer._logic:accept_input(not enabled)
			end
		end
		if self.pauseGame then
			if enabled then
				self:startPauseThread()
			else
				self:stopPauseThread()
				pauseGame(false)
			end
		end
	end
	
	--[[ Checks if Menu is visible ]]--
	function CustomMenuClass:isVisible()
		return self.visible
	end
	
	--[[ Checks if Menu is Loaded ]]--
	function CustomMenuClass:isMenuLoaded()
		return self.menuLoaded
	end
	
	--[[ Checks if Menu is Visible and Loaded ]]--
	function CustomMenuClass:isOpen()
		if self:isVisible() and self:isMenuLoaded() then
			return true
		end
		return false
	end
	
	function CustomMenuClass:getMenu(name)
		for n in pairs(self.menus) do
			if n == name then
				return self.menus[n]
			end
		end
		return nil
	end
	
	function CustomMenuClass:getMainMenu()
		for name,data in pairs(self.menus) do
			if data.isMainMenu then
				return name
			end
		end
		return nil
	end
	
	function CustomMenuClass:hasMainMenu()
		return (self:getMainMenu() ~= nil)
	end
	
	--[[ Opens the Main Menu, if none is Declared it Will Open the First Menu when Looping through the Menus List ]]--
	function CustomMenuClass:openMainMenu(page)
		if self:hasMainMenu() then
			self:openMenu(self:getMainMenu(), page)
		else
			for name in pairs(self.menus) do
				self.menus[name].isMainMenu = true
				self:openMenu(name, page)
				break
			end
		end
	end
	
	--[[ Returns an Array Containing all the Options of the Specified Menu ]]--
	function CustomMenuClass:getMenuOptions(menu)
		local m = self:getMenu(menu)
		if not m then
			return nil
		end
		local options = {}
		--[[ Loop Through All Pages and Merge All the Options into one Table ]]--
		for i=1,#m.pages do
			for j=1,#m.pages[i] do
				table.insert(options, m.pages[i][j])
			end
		end
		return options
	end
	
	function CustomMenuClass:getMenuOption(menu, name)
		local m = self:getMenu(menu)
		if not m or not name then
			return nil
		end
		for i=1,#m.pages do
			for j=1,#m.pages[i] do
				if m.pages[i][j].name then
					if m.pages[i][j].name == name then
						return m.pages[i][j]
					end
				end
			end
		end
	end
	
	--[[ Returns the Menu Option using the Menu Name, the Page the Option is On and it's Index in that Pages Array ]]--
	--Wouldn't Suggest using this due to my Crappy Indexing of Menu Options, it's more for my Convenience and I was Intending on People Needing to Edit Values that Deep
	--This is more here for my Convenience and for the People that need this Function for Whatever Reason
	function CustomMenuClass:getMenuOptionViaIndices(menu, page, index)
		local m = self:getMenu(menu)
		if not m or not page or not index then
			return nil
		end
		return m.pages[page][index]
	end
	
	--[[ Refreshes the Currently Open Menu, Can be Used to Update the Menu Text Whilst Menu is Open ]]--
	function CustomMenuClass:refreshMenu()
		if not self.currentMenu or not self.currentPage then
			return
		end
		self:openMenu(self.currentMenu, self.currentPage)
	end
	
	function CustomMenuClass:openMenu(name, page)
		if not name or not self.menus[name] then
			return
		end
		local p = getValue(page, 1)
		if p > #self.menus[name].pages then
			p = #self.menus[name].pages
		end
		if p == 0 then
			return
		end
		if self.currentMenu and self.currentPage then
			if self.currentMenu ~= name then
				self.previousMenu = self.currentMenu
				self.previousPage = self.currentPage
			end
		end
		self.currentMenu = name
		self.currentPage = p
		--[[ Set Title Text ]]--
		if self.hasTitle then
			if not self.menuTitleText then
				self.menuTitleText = self.panelTitleMenu:text({
					name = "menu_title_text",
					text = "Mod Menu",
					valign = "center",
					align = "center",
					vertical = "center",
					layer = self.baseLayer + 1,
					color = self.menus[name].titleColor,
					font = self.menus[name].titleFont,
					font_size = self.menus[name].titleFontSize
				})
			end
			self.menuTitleText:set_text(self.menus[name].title)
		end
		--[[ Clear Previous Menu Elements ]]--
		self:clearMainMenuComponents()
		--[[ Setup Help Text ]]--
		local helpTextHeight = 0
		if self.menus[name].hasHelp then
			helpTextHeight = self.menus[name].optionFontSize + self.indentColumns + 4
			local helpPanel = self.panelMainMenuDisplay:panel({ name = "help_panel" })
			sizePanel(helpPanel, self.panelMainMenuDisplay:w() - (self.mainMenuBorderWidth * 2) - (self.indentColumns * 2), helpTextHeight)
			positionPanel(helpPanel, self.mainMenuBorderWidth + self.indentColumns, self.mainMenuBorderWidth + self.indentColumns)
			helpPanel:text({
				name = "help_text",
				text = "",
				valign = "left",
				align = "left",
				vertical = "top",
				layer = self.baseLayer + 4,
				color = self.menus[name].helpColor,
				font = self.menus[name].helpFont,
				font_size = self.menus[name].helpFontSize,
				x = 0,
				y = 0
			})
		end
		--[[ Build Columns and Add Options ]]--
		local requiredNumberOfColumns = roundUp(#self.menus[name].pages[p] / self.menus[name].maxRows)
		local width = ((self.panelMainMenuDisplay:w() - (self.mainMenuBorderWidth * 2) - (self.indentColumns * (requiredNumberOfColumns + 1))) / requiredNumberOfColumns)
		local height = (self.panelMainMenuDisplay:h() - helpTextHeight - (self.mainMenuBorderWidth * 2) - (self.indentColumns * 2))
		local y = self.mainMenuBorderWidth + self.indentColumns + helpTextHeight
		for i=1,requiredNumberOfColumns do
			local column = self.panelMainMenuDisplay:panel({ name = "column_panel_" .. tostring(i) })
			local x = self.mainMenuBorderWidth + self.indentColumns + ((self.indentColumns + width) * (i - 1))
			sizePanel(column, width, height)
			positionPanel(column, x, y)
			local columnButtonsCount = #self.menus[name].pages[p] - ((i-1) * self.menus[name].maxRows)
			if columnButtonsCount > self.menus[name].maxRows then
				columnButtonsCount = self.menus[name].maxRows
			end
			local buttonRectHeight = self.menus[name].optionFontSize + 4
			for j=1,columnButtonsCount do
				local option = self.menus[name].pages[p][(((i - 1) * self.menus[name].maxRows) + j)]
				if option.type ~= 2 then --[[ If the Option is a Gap don't Draw Anything on the Screen ]]--
					local buttonRectY = 0
					if self.menus[name].maxRows > 1 then
						buttonRectY = (((column:h() - (buttonRectHeight * self.menus[name].maxRows)) / (self.menus[name].maxRows - 1)) * (j - 1)) + (buttonRectHeight * (j - 1))
					end
					local buttonText = column:text({
						name = "column_panel_" .. tostring(i) .. "_button_text_" .. tostring(j),
						text = option.text,
						valign = "left",
						align = "left",
						vertical = "top",
						layer = self.baseLayer + 4,
						color = option.textColor,
						font = self.menus[name].optionFont,
						font_size = self.menus[name].optionFontSize,
						x = 6,
						y = buttonRectY + 2
					})
					if option.type ~= 3 then --[[ If the Option is Information don't add a Button Highlight Rectangle or add it to the Active Buttons List ]]--
						local buttonRect = drawRect(column, "column_panel_" .. tostring(i) .. "_button_rect_" .. tostring(j), 0, buttonRectY, column:w(), buttonRectHeight, option.rectHighlightColor, { rectLayer = self.baseLayer + 3 })
						buttonRect:set_visible(false)
						local buttonParams = { 
							text = "column_panel_" .. tostring(i) .. "_button_text_" .. tostring(j),
							column = "column_panel_" .. tostring(i),
							rect = "column_panel_" .. tostring(i) .. "_button_rect_" .. tostring(j),
							help = option.help,
							normalColor = option.textColor,
							highlightColor = option.textHighlightColor,
							clbk = option.callback,
							clbkData = option.callbackData,
							type = option.type,
							page = p,
							index = (((i - 1) * self.menus[name].maxRows) + j),
							closeMenu = option.closeMenu
						}
						if option.type == 4 then --[[ If it's a Toggle Option draw the Toggle Box Icon too ]]--
							local bitPos = 0
							if option.toggle then
								bitPos = 24
							end
							column:bitmap({
								name = "column_panel_" .. tostring(i) .. "_toggle_icon_" .. tostring(j),
								layer = self.baseLayer + 4,
								x = column:w() - 24 - ((buttonRectHeight / 2) - 12),
								y = buttonRectY + (buttonRectHeight / 2) - 12,
								texture_rect = {
									bitPos,
									bitPos,
									24,
									24
								},
								texture = "guis/textures/menu_tickbox",
								color = option.textColor
							})
							buttonParams.bitmap = "column_panel_" .. tostring(i) .. "_toggle_icon_" .. tostring(j)
						end
						table.insert(self.activeButtons, buttonParams)
					end
				end
			end
		end
		--[[ Populate Navigation Bar ]]--
		if self.hasNavigation then
			--[[ Close Menu Button ]]--
			local buttonRectWidth = 140
			local buttonRectHeight = self.menus[name].optionFontSize + 4
			local buttonRectX = (self.panelNavigationDisplay:w() / 2) - (buttonRectWidth / 2)
			local buttonRectY = (self.panelNavigationDisplay:h() / 2) - (buttonRectHeight / 2)
			drawRect(self.panelNavigationDisplay, "close_menu_button_rect", buttonRectX, buttonRectY, buttonRectWidth, buttonRectHeight, self.menus[name].buttonRectHighlightColor, { rectLayer = self.baseLayer + 3 }):set_visible(false)
			self.panelNavigationDisplay:text({name = "close_menu_button_text", text = "Close Menu", valign = "center", align = "center", vertical = "center", layer = self.baseLayer + 4, color = self.menus[name].optionColor, font = self.menus[name].optionFont, font_size = self.menus[name].optionFontSize})
			table.insert(self.activeButtons, { 
				text = "close_menu_button_text", 
				rect = "close_menu_button_rect",
				help = "Closes the Menu",
				normalColor = self.menus[name].optionColor,
				highlightColor = self.menus[name].buttonHighlightColor,
				clbk = function() self:close() end
			})
			if #self.menus[name].pages > 1 then
				--[[ Previous Page Button ]]--
				buttonRectHeight = self.menus[name].optionFontSize + 4
				buttonRectX = self.mainMenuBorderWidth + self.indentColumns
				buttonRectY = self.mainMenuBorderWidth + self.indentColumns
				drawRect(self.panelNavigationDisplay, "previous_page_button_rect", buttonRectX, buttonRectY, buttonRectWidth, buttonRectHeight, self.menus[name].buttonRectHighlightColor, { rectLayer = self.baseLayer + 3 }):set_visible(false)
				self.panelNavigationDisplay:text({name = "previous_page_button_text", text = "Previous Page", x = buttonRectX+6, y = buttonRectY+2, layer = self.baseLayer + 4, color = self.menus[name].optionColor, font = self.menus[name].optionFont, font_size = self.menus[name].optionFontSize})
				table.insert(self.activeButtons, {
					text = "previous_page_button_text", 
					rect = "previous_page_button_rect",
					help = "Opens the Previous Page of the Current Open Menu",
					normalColor = self.menus[name].optionColor,
					highlightColor = self.menus[name].buttonHighlightColor,
					clbk = function() if #self.menus[name].pages > 1 then local p = 0 if self.currentPage == 1 then p = #self.menus[name].pages else p = self.currentPage - 1 end self:openMenu(name, p) end end
				})
				--[[ Next Page Button ]]--
				buttonRectHeight = self.menus[name].optionFontSize + 4
				buttonRectX = self.panelNavigationDisplay:w() - self.mainMenuBorderWidth - self.indentColumns - buttonRectWidth
				buttonRectY = self.mainMenuBorderWidth + self.indentColumns
				drawRect(self.panelNavigationDisplay, "next_page_button_rect", buttonRectX, buttonRectY, buttonRectWidth, buttonRectHeight, self.menus[name].buttonRectHighlightColor, { rectLayer = self.baseLayer + 3 }):set_visible(false)
				self.panelNavigationDisplay:text({name = "next_page_button_text", text = "Next Page", x = -6-self.mainMenuBorderWidth-self.indentColumns, y = buttonRectY+2, layer = self.baseLayer + 4, color = self.menus[name].optionColor, font = self.menus[name].optionFont, font_size = self.menus[name].optionFontSize, align = "right"})
				table.insert(self.activeButtons, {
					text = "next_page_button_text", 
					rect = "next_page_button_rect",
					help = "Opens the Next Page of the Current Open Menu",
					normalColor = self.menus[name].optionColor,
					highlightColor = self.menus[name].buttonHighlightColor,
					clbk = function() if #self.menus[name].pages > 1 then local p = 0 if self.currentPage == #self.menus[name].pages then p = 1 else p = self.currentPage + 1 end self:openMenu(name, p) end end
				})
			end
			--[[ Previous Menu Button ]]--
			buttonRectHeight = self.menus[name].optionFontSize + 4
			buttonRectX = self.mainMenuBorderWidth + self.indentColumns
			if #self.menus[name].pages < 2 then
				buttonRectY = (self.panelNavigationDisplay:h() / 2) - (buttonRectHeight / 2)
			else
				buttonRectY = self.panelNavigationDisplay:h() - self.mainMenuBorderWidth - self.indentColumns - buttonRectHeight
			end
			drawRect(self.panelNavigationDisplay, "previous_menu_button_rect", buttonRectX, buttonRectY, buttonRectWidth, buttonRectHeight, self.menus[name].buttonRectHighlightColor, { rectLayer = self.baseLayer + 3 }):set_visible(false)
			self.panelNavigationDisplay:text({name = "previous_menu_button_text", text = "Previous Menu", x = buttonRectX+6, y = buttonRectY+2, layer = self.baseLayer + 4, color = self.menus[name].optionColor, font = self.menus[name].optionFont, font_size = self.menus[name].optionFontSize})
			table.insert(self.activeButtons, {
				text = "previous_menu_button_text", 
				rect = "previous_menu_button_rect",
				help = "Opens the Previously Opened Menu",
				normalColor = self.menus[name].optionColor,
				highlightColor = self.menus[name].buttonHighlightColor,
				clbk = function() self:openMenu(self.previousMenu, self.previousPage) end
			})
			--[[ Main Menu Button ]]--
			buttonRectHeight = self.menus[name].optionFontSize + 4
			buttonRectX = self.panelNavigationDisplay:w() - self.mainMenuBorderWidth - self.indentColumns - buttonRectWidth
			if #self.menus[name].pages < 2 then
				buttonRectY = (self.panelNavigationDisplay:h() / 2) - (buttonRectHeight / 2)
			else
				buttonRectY = self.panelNavigationDisplay:h() - self.mainMenuBorderWidth - self.indentColumns - buttonRectHeight
			end
			drawRect(self.panelNavigationDisplay, "main_menu_button_rect", buttonRectX, buttonRectY, buttonRectWidth, buttonRectHeight, self.menus[name].buttonRectHighlightColor, { rectLayer = self.baseLayer + 3 }):set_visible(false)
			self.panelNavigationDisplay:text({name = "main_menu_button_text", text = "Main Menu", x = -6-self.mainMenuBorderWidth-self.indentColumns, y = buttonRectY+2, layer = self.baseLayer + 4, color = self.menus[name].optionColor, font = self.menus[name].optionFont, font_size = self.menus[name].optionFontSize, align = "right"})
			table.insert(self.activeButtons, {
				text = "main_menu_button_text", 
				rect = "main_menu_button_rect",
				help = "Opens the Main Menu",
				normalColor = self.menus[name].optionColor,
				highlightColor = self.menus[name].buttonHighlightColor,
				clbk = function() if self:getMainMenu() ~= self.currentMenu then self:openMainMenu() end end
			})
		end
	end
	
	function CustomMenuClass:clearMainMenuComponents()
		if self.panelMainMenuDisplay ~= nil then
			self.panelMainMenu:remove(self.panelMainMenu:child("mainmenu_display_panel"))
		end
		self.panelMainMenuDisplay = nil
		self.panelMainMenuDisplay = self.panelMainMenu:panel({ name = "mainmenu_display_panel" })
		positionPanel(self.panelMainMenuDisplay, 0, 0)
		sizePanel(self.panelMainMenuDisplay, self.mainMenuRectWidth, self.mainMenuRectHeight)
		
		if self.panelNavigationDisplay ~= nil then
			self.panelNavigationMenu:remove(self.panelNavigationMenu:child("navigation_display_panel"))
		end
		self.panelNavigationDisplay = nil
		self.panelNavigationDisplay = self.panelNavigationMenu:panel({ name = "navigation_display_panel" })
		positionPanel(self.panelNavigationDisplay, 0, 0)
		sizePanel(self.panelNavigationDisplay, self.navigationMenuRectWidth, self.navigationMenuRectHeight)
		
		self.activeButtons = {}
	end
	
	--[[ Calls the Function of a Clicked Menu Option ]]--
	function CustomMenuClass:_callback(clbk, clbkData)
		if clbk then
			if clbkData then
				clbk(clbkData)
			else
				clbk()
			end
		end
	end
	
	--[[ ## Add Menu Functions ## ]]--
	function CustomMenuClass:addMenu(name, optionalParams)
		if not name then
			return
		end
		if not optionalParams then
			optionalParams = {}
		end
		self.menus[name] = { }
		self.menus[name].title = getValue(optionalParams.title, _title)
		self.menus[name].isMainMenu = getValue(optionalParams.isMainMenu, _isMainMenu)
		self.menus[name].maxRows = getValue(optionalParams.maxRows, _maxRows)
		self.menus[name].maxColumns = getValue(optionalParams.maxColumns, _maxColumns)
		self.menus[name].maxOptionsPerPage = self.menus[name].maxRows * self.menus[name].maxColumns
		self.menus[name].pages = { }
		self.menus[name].titleFont = getValue(optionalParams.titleFont, _titleFont)
		self.menus[name].titleFontSize = getValue(optionalParams.titleFontSize, _titleFontSize)
		self.menus[name].titleColor = getValue(optionalParams.titleColor, _titleColor)
		self.menus[name].optionFont = getValue(optionalParams.optionFont, _optionFont)
		self.menus[name].optionFontSize = getValue(optionalParams.optionFontSize, _optionFontSize)
		self.menus[name].optionColor = getValue(optionalParams.optionColor, _optionColor)
		self.menus[name].helpFont = getValue(optionalParams.helpFont, _helpFont)
		self.menus[name].helpFontSize = getValue(optionalParams.helpFontSize, _helpFontSize)
		self.menus[name].helpColor = getValue(optionalParams.helpColor, _helpColor)
		self.menus[name].buttonHighlightColor = getValue(optionalParams.buttonHighlightColor, _buttonHighlightColor)
		self.menus[name].buttonRectHighlightColor = getValue(optionalParams.buttonRectHighlightColor, _buttonRectHighlightColor)
		self.menus[name].hasHelp = getValue(optionalParams.hasHelp, _hasHelp)
	end
	
	function CustomMenuClass:addMainMenu(name, optionalParams)
		if not name then
			return
		end
		if not optionalParams then
			optionalParams = {}
		end
		if not self:hasMainMenu() then
			optionalParams.isMainMenu = true
		else
			optionalParams.isMainMenu = false
		end
		self:addMenu(name, optionalParams)
	end
	
	--[[ ## Add Option Functions ## ]]--
	function CustomMenuClass:addOption(menu, text, optionalParams)
		if not menu or not self.menus[menu] then
			return
		end
		if not optionalParams then
			optionalParams = {}
		end
		local option = { }
		option.type = 1
		option.text = getValue(text, "")
		self:_addOption(menu, option, optionalParams)
	end
	
	function CustomMenuClass:addMenuOption(menu, text, menuToOpen, optionalParams)
		if not menu or not self.menus[menu] or not menuToOpen then
			return
		end
		if not optionalParams then
			optionalParams = {}
		end
		local option = { }
		option.type = 1
		option.text = getValue(text, "")
		optionalParams.callback = function() self:openMenu(menuToOpen, getValue(optionalParams.page, 1)) end
		optionalParams.callbackData = nil
		self:_addOption(menu, option, optionalParams)
	end
	
	function CustomMenuClass:addGap(menu)
		if not menu or not self.menus[menu] then
			return
		end
		local option = { }
		option.type = 2
		self:_addOption(menu, option)
	end
	
	function CustomMenuClass:addInformationOption(menu, text, optionalParams)
		if not menu or not self.menus[menu] then
			return
		end
		if not optionalParams then
			optionalParams = {}
		end
		local option = { }
		option.type = 3
		option.text = getValue(text, "")
		self:_addOption(menu, option, optionalParams)
	end
	
	function CustomMenuClass:addToggleOption(menu, text, optionalParams)
		if not menu or not self.menus[menu] then
			return
		end
		local option = { }
		option.type = 4
		option.text = getValue(text, "")
		self:_addOption(menu, option, optionalParams)
	end
	
	function CustomMenuClass:_addOption(menu, option, optionalParams)
		if not menu or not self.menus[menu] then
			return
		end
		if not optionalParams then
			optionalParams = {}
		end
		
		option.name = getValue(optionalParams.name, nil)
		option.help = getValue(optionalParams.help, nil)
		option.textColor = getValue(optionalParams.textColor, self.menus[menu].optionColor)
		option.textHighlightColor = getValue(optionalParams.textHighlightColor, self.menus[menu].buttonHighlightColor)
		option.rectHighlightColor = getValue(optionalParams.rectHighlightColor, self.menus[menu].buttonRectHighlightColor)
		option.callback = getValue(optionalParams.callback, nil)
		option.callbackData = getValue(optionalParams.callbackData, nil)
		option.toggle = getValue(optionalParams.toggle, _defaultToggleBoolean) --[[ Sets the Toggle Option to Either On (TRUE) or Off (FALSE) ]]--
		option.postToggle = getValue(optionalParams.postToggle, _defaultPostToggleBoolean) --[[ If True When the Toggle Option is Clicked it will pass the Boolean Value of Whether it's On or Off to the Function it Calls (Overwrites callbackData) ]]--
		option.recieveToggle = getValue(optionalParams.recieveToggle, _defaultRecieveToggleBoolean) --[[ If True When the Toggle Option is Clicked it will Set the Toggle Value to the Boolean Returned from the Function it Calls ]]--
		option.closeMenu = getValue(optionalParams.closeMenu, _closeMenu) --[[ If True Closes the Menu when the Option is Clicked ]]--
		
		local pageCount = #self.menus[menu].pages
		if pageCount > 0 then
			if #self.menus[menu].pages[pageCount] >= self.menus[menu].maxOptionsPerPage then
				table.insert(self.menus[menu].pages, { option })
			else
				table.insert(self.menus[menu].pages[pageCount], option)
			end
		else
			table.insert(self.menus[menu].pages, { option })
		end
	end

	--[[ ## Creates a Loading Animation Before Menu Fades In ## ]]--
	function CustomMenuClass:doLoadingAnimation()
		self.loadingCircleProgress = 0
		if not self.loadingCircle then
			self.loadingCircle = CircleBitmapGuiObject:new(self.panelWorkspace, {
				name = "loading_menu_circle",
				use_bg = true,
				x = (self.panelWorkspace:w() / 2) - 96,
				y = (self.panelWorkspace:h() / 2) - 96,
				radius = 96,
				sides = 96,
				current = 0,
				total = 96,
				color = Color.white:with_alpha(1),
				blend_mode = "normal",
				layer = self.baseLayer
			})
		end
		if not self.loadingText then
			self.loadingText = self.panelWorkspace:text({
				name = "loading_menu_text",
				text = "Loading Menu",
				valign = "center",
				align = "center",
				vertical = "center",
				layer = self.baseLayer,
				color = Color.white,
				font = tweak_data.hud_present.text_font,
				font_size = tweak_data.hud_present.text_size
			})
		end
		self.loadingText:show()
		self.loadingCircle:set_current(0)
		addThread({
			func = (function() self:updateLoadingAnimation() end),
			sleep = 0.01,
			loopCount = 60,
			afterFunc = (function() self:setupMenuFadeIn() end)
		})
		self.loadingCircle:set_visible(true)
	end
	
	function CustomMenuClass:updateLoadingAnimation()
		if self.loadingCircleProgress < 1 then
			self.loadingCircleProgress = self.loadingCircleProgress + 0.02
			self.loadingCircle:set_current(self.loadingCircleProgress)
		end
	end
	
	--[[ ## Functions to Create a Fade In Effect for the Menu ## ]]--
	function CustomMenuClass:setupMenuFadeIn()
		self.loadingText:hide()
		self.loadingCircle:set_visible(false)
		self.panelWorkspace:set_alpha(0)
		if self.hasBackgroundBlur then
			self.menuBlur:show()
		end
		self.panelMenu:show()
		addThread({
			func = (function() self:updateFadeInAnimation() end),
			sleep = 0.01,
			loopCount = 50,
			afterFunc = (function() self:_open() end)
		})
	end
	
	function CustomMenuClass:updateFadeInAnimation()
		if self.panelWorkspace:alpha() < 1 then
			self.panelWorkspace:set_alpha(self.panelWorkspace:alpha() + 0.02)
		end
	end
	
	--[[ ## Functions to Create a Fade Out Effect for the Menu ## ]]--
	function CustomMenuClass:setupMenuFadeOut()
		addThread({
			func = (function() self:updateFadeOutAnimation() end),
			sleep = 0.01,
			loopCount = 100,
			afterFunc = (function() self:_close() end)
		})
	end
	
	function CustomMenuClass:updateFadeOutAnimation()
		if self.panelWorkspace:alpha() > 0 then
			self.panelWorkspace:set_alpha(self.panelWorkspace:alpha() - 0.02)
		end
	end
	
	--[[ ## Mouse Functions ## ]]--
	--[[ Activates Mouse Input ]]--
	function CustomMenuClass:activateMouse()
		if not self.mouseActive then
			managers.mouse_pointer._ws:set_screen(self.resolution.x, self.resolution.y, 0, 0, self.resolution.x, self.resolution.y) --Adjust Mouse Workspace to Current Screen Resolution Because otherwise if your not using 720p Resolution the Mouse is Fucked up for Some Reason
			local data = {
				mouse_move = callback(self, self, "mouse_moved"),
				mouse_press = callback(self, self, "mouse_pressed"),
				mouse_release = callback(self, self, "mouse_released"),
				mouse_click = callback(self, self, "mouse_clicked"),
				mouse_double_click = callback(self, self, "mouse_double_click"),
				id = _mouseId
			}
			managers.mouse_pointer:use_mouse(data)
			self.mouseActive = true
		end
	end
	
	--[[ Deactivates Mouse Input ]]--
	function CustomMenuClass:deactivateMouse()
		if self.mouseActive then
			managers.gui_data:layout_fullscreen_workspace(managers.mouse_pointer._ws) --Set Mouse Workspace back to how PayDay wants it
			managers.mouse_pointer:remove_mouse(_mouseId)
			self.mouseActive = false
		end
	end
	
	--[[ Mouse Input Functions ]]--
	function CustomMenuClass:mouse_moved(o, x, y, mouse_ws)
		if self:isOpen() then
			if self.activeButtons ~= nil then
				local buttonGotHighlighted = nil
				for _,data in ipairs(self.activeButtons) do
					if data then
						if data.column then --[[ Basically if There isn't a Column Declared in the Data then it's a Navigation Button ]]--
							if self.panelMainMenuDisplay:child(data.column):child(data.rect):inside(x, y) then
								self.panelMainMenuDisplay:child(data.column):child(data.rect):set_visible(true)
								self.panelMainMenuDisplay:child(data.column):child(data.text):set_color(data.highlightColor)
								buttonGotHighlighted = data
							else
								self.panelMainMenuDisplay:child(data.column):child(data.rect):set_visible(false)
								self.panelMainMenuDisplay:child(data.column):child(data.text):set_color(data.normalColor)
							end
						else
							if self.panelNavigationDisplay:child(data.rect):inside(x, y) then
								self.panelNavigationDisplay:child(data.rect):set_visible(true)
								self.panelNavigationDisplay:child(data.text):set_color(data.highlightColor)
								buttonGotHighlighted = data
							else
								self.panelNavigationDisplay:child(data.rect):set_visible(false)
								self.panelNavigationDisplay:child(data.text):set_color(data.normalColor)
							end
						end
					end
				end
				if self.menus[self.currentMenu].hasHelp then
					if buttonGotHighlighted then
						if buttonGotHighlighted.help then
							self.panelMainMenuDisplay:child("help_panel"):child("help_text"):set_text(buttonGotHighlighted.help)
						end
					else
						self.panelMainMenuDisplay:child("help_panel"):child("help_text"):set_text("")
					end
				end
			end
		end
	end
	
	function CustomMenuClass:mouse_pressed(o, button, x, y)
		if self:isOpen() then
		end
	end
	
	function CustomMenuClass:mouse_released(o, button, x, y)
		if self:isOpen() then
		end
	end
	
	function CustomMenuClass:mouse_clicked(o, button, x, y)
		if self:isOpen() then
			if self.activeButtons ~= nil then
				local needCloseMenu = false
				for _,data in ipairs(self.activeButtons) do
					if data then
						if data.column then --[[ Basically if There isn't a Column Declared in the Data then it's a Navigation Button ]]--
							--[[ Using PCALL Because Basically the Game Crashed with Access Violation Error when the Button Clicked ran self:openMenu(menuToOpen, Page) ]]--
							--[[ This Actually seems to be Something to do with Accessing the Panels Children, if you pass it as a Variable then it will Error in the Situation Above
								 but if you Call the Children of the Panel using their Names it Doesn't Error. So I Dunno what that's all About, Potentially an Error with Payday 2 Coding ]]--
							pcall(function()
								if self.panelMainMenuDisplay:child(data.column):child(data.rect):inside(x, y) then
									if data.closeMenu then needCloseMenu = true end
									if data.type == 4 then
										local option = self:getMenuOptionViaIndices(self.currentMenu, data.page, data.index)
										option.toggle = not option.toggle
										if option.postToggle then
											data.clbkData = option.toggle
										end
										if option.recieveToggle then
											if data.clbk then
												local answer = nil
												if data.clbkData then
													answer = data.clbk(data.clbkData)
												else
													answer = data.clbk()
												end
												if type(answer) == "boolean" then
													option.toggle = answer
												end
											end
										else
											self:_callback(data.clbk, data.clbkData)
										end
										local bitPos = 0
										if option.toggle then
											bitPos = 24
										end
										if self:isVisible() then
											self.panelMainMenuDisplay:child(data.column):child(data.bitmap):set_texture_rect(bitPos, bitPos, 24, 24)
										end
									else
										self:_callback(data.clbk, data.clbkData)
									end
								end
							end)
						else
							pcall(function()
								if self.panelNavigationDisplay:child(data.rect):inside(x, y) then
									self:_callback(data.clbk, data.clbkData)
								end
							end)
						end
					end
				end
				if needCloseMenu then
					self:close()
				end
			end
		end
	end
	
	function CustomMenuClass:mouse_double_click(o, button, x, y)
		if self:isOpen() then
		end
	end
	
	--[[ ## Drawing Functions Default Values ## ]]--
	_alpha = 1
	_layer = 1
	_align = "left"
	_halign = "top"
	_vertical = "top"
	_blendmode = "normal"
	_render_template = "VertexColorTextured3D"
	
	--[[ ## Drawing Functions ## ]]--
	function drawRect(panel, rectName, rectX, rectY, rectWidth, rectHeight, rectColor, optionalParams)
		--[[
		Draws a Rectangle on the Screen
		-- Compulsory Arguments
			panel, rectName, rectX, rectY, rectWidth, rectHeight, rectColor
		-- Optional Arguments
			rectAlpha, rectLayer, rectAlign, rectHAlign, rectVertical
		]]--
		if not optionalParams then
			optionalParams = {}
		end
		local rect = panel:rect({
			name =  rectName,
			x = rectX,
			y = rectY,
			w = rectWidth,
			h = rectHeight,
			color = rectColor:with_alpha((getValue(optionalParams.rectAlpha, _alpha))),
			layer = getValue(optionalParams.rectLayer, _layer),
			align = getValue(optionalParams.rectAlign, _align),
			halign = getValue(optionalParams.rectHAlign, _halign),
			vertical = getValue(optionalParams.rectVertical, _vertical)
		})
		return rect
	end
	
	function drawRectBorder(panel, rectName, rectX, rectY, rectWidth, rectHeight, rectColor, borderWidth, borderColor, optionalParams)
		--[[
		Draws a Rectangle with a Border on the Screen
		-- Compulsory Arguments
			panel, rectName, rectX, rectY, rectWidth, rectHeight, rectColor, borderWidth, borderColor
		-- Optional Arguments
			rectAlpha, rectLayer, rectAlign, rectHAlign, rectVertical, borderAlpha, borderLayer
		]]--
		if not optionalParams then
			optionalParams = {}
		end
		--[[ ## Draw the Main Box ## ]]--
		local rect = drawRect(panel, rectName, rectX, rectY, rectWidth, rectHeight, rectColor, optionalParams)
		--[[ ## Setup Optional Parameters for Borders ## ]]--
		optionalParams.rectAlpha = getValue(optionalParams.borderAlpha, _alpha)
		optionalParams.rectLayer = getValue(optionalParams.borderLayer, _layer)
		--[[ ## Draw the Borders ## ]]--
		local top = drawRect(panel, rectName .. "_border_top", rectX + borderWidth, rectY, rectWidth - borderWidth, borderWidth, borderColor, optionalParams)
		local bottom = drawRect(panel, rectName .. "_border_bottom", rectX, rectY + rectHeight - borderWidth, rectWidth - borderWidth, borderWidth, borderColor, optionalParams)
		local left = drawRect(panel, rectName .. "_border_left", rectX, rectY, borderWidth, rectHeight - borderWidth, borderColor, optionalParams)
		local right = drawRect(panel, rectName .. "_border_right", rectX + rectWidth - borderWidth, rectY + borderWidth, borderWidth, rectHeight - borderWidth, borderColor, optionalParams)
		local borderRect = { mainRect = rect, borderTop = top, borderBottom = bottom, borderLeft = left, borderRight = right }
		return borderRect
	end
	
	--[[ Not sure about all the optional parameters for this function ]]--
	function drawBitmap(panel, bitName, bitX, bitY, bitWidth, bitHeight, bitTexture, optionalParams)
		--[[
		Draws a Bitmap on the Screen
		-- Compulsory Arguments
			panel, bitName, bitX, bitY, bitWidth, bitHeight, bitTexture
		-- Optional Arguments
			renderTemplate, layer, blendMode, alpha
		]]--
		if not optionalParams then
			optionalParams = {}
		end
		local bitmap = panel:bitmap({
			name = bitName,
			x = bitX,
			y = bitY,
			w = bitWidth,
			h = bitHeight,
			texture = bitTexture,
			render_template = getValue(optionalParams.renderTemplate, _render_template),
			layer = getValue(optionalParams.layer, _layer),
			blendmode = getValue(optionalParams.blendMode, _blendmode),
			alpha = getValue(optionalParams.alpha, _alpha)
		})
		return bitmap
	end
end