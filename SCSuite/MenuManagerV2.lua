function MenuCallbackHandler:toggleMuteBain(item)
          LocalizationStringManagerBooleanCallBack("mute_bain_enabled")
end
function MenuCallbackHandler:toggleMissionMenu(item)
          LocalizationStringManagerBooleanCallBack("mission_menu_enabled")
end
function MenuCallbackHandler:toggleMask(item)
          LocalizationStringManagerBooleanCallBack("toggle_mask_enabled")
end
function MenuCallbackHandler:toggleEquipment(item)
          LocalizationStringManagerBooleanCallBack("toggle_equipment_enabled")
end
function MenuCallbackHandler:toggleConfirmRespec(item)
          LocalizationStringManagerBooleanCallBack("confirm_respec_toggle")
end
function MenuCallbackHandler:togglePersistentGadget(item)
          LocalizationStringManagerBooleanCallBack("persistent_gadget_toggle")
end
function MenuCallbackHandler:toggleBroadcastIngredient(item)
          LocalizationStringManagerBooleanCallBack("mute_bain_broadcast_toggle")
end
function MenuCallbackHandler:toggleForceReady(item)
          LocalizationStringManagerBooleanCallBack("force_ready_toggle")
end
function MenuCallbackHandler:sliderForceReadyThreshold(item)
    io.write("Slider value: " .. tostring(math.floor(item:value() + 0.5)) .. "\n")
    LocalizationStringManagerSliderCallBack("force_ready_threshold_value", tostring(item:value()))
end
function MenuCallbackHandler:toggleSkipEndscreen(item)
          LocalizationStringManagerBooleanCallBack("skip_endscreen_toggle")
end

function MenuCallbackHandler:toggleTest2(item)
          io.write("Toggle value: " .. tostring(item:value()) .. "\n")
end

function MenuCallbackHandler:multichoiceTest(item)
    io.write("Multichoice value: " .. tostring(item:value()) .. "\n")
    StealthSuiteMenuCore:LocalizationStringManagerMultiChoiceCallBack("string_id_3", tostring(item:value()))
end

local menu_manager_init_orig = MenuManager.init
function MenuManager:init(is_start_menu)
          menu_manager_init_orig(self, is_start_menu)
          addMainMenu()
end

function addSubmenu(name, title, desc, parent)
          local mainMenuNodes = managers.menu._registered_menus.menu_main and managers.menu._registered_menus.menu_main.logic._data._nodes or
                      managers.menu._registered_menus.menu_pause.logic._data._nodes
                      
          local newNode = deep_clone(mainMenuNodes.video)
          newNode._items = {}
          
          MenuManager:add_back_button(newNode)
          mainMenuNodes[name] = newNode
          
          local button = deep_clone( mainMenuNodes.options._items[1] )
          button._parameters.name = name
          button._parameters.text_id = title
          button._parameters.help_id = desc
          button._parameters.next_node = name

          parent:add_item(button)
          return newNode
end

function addMultichoice(name, title, desc, cbk, value, parent)
          local data = {
                      type = "MenuItemMultiChoice",
                      {
                                  _meta = "option",
                                  text_id = "multichoice0",
                                  value = 0
                      },
                      {
                                  _meta = "option",
                                  text_id = "multichoice1",
                                  value = 1
                      }
          }
          
          local params = {
                      name = name,
                      text_id = title,
                      help_id = desc,
                      callback = cbk,
                      filter = true
          }
          
          local menuItem = parent:create_item(data, params)
          menuItem:set_value( math.clamp(value, data.min, data.max) or data.min )
          parent:add_item(menuItem)
end

function addSlider(name, title, desc, cbk, value, parent, minval, maxval, stepval)
          local data = {
                      type = "CoreMenuItemSlider.ItemSlider",
                      min = minval, --0
                      max = maxval, --1
                      step = stepval, --0.1
                      show_value = true
          }

          local params = {
                      name = name,
                      text_id = title,
                      help_id = desc,
                      callback = cbk,
                      disabled_color = Color(0.25, 1, 1, 1),
          }

          local menuItem = parent:create_item(data, params)
          menuItem:set_value( math.clamp(value, data.min, data.max) or data.min )
          parent:add_item(menuItem)
end

function addToggle(name, title, desc, cbk, value, parent)
          local data = {
                      type = "CoreMenuItemToggle.ItemToggle",
                      {
                                  _meta = "option",
                                  icon = "guis/textures/menu_tickbox",
                                  value = true,
                                  x = 24,
                                  y = 0,
                                  w = 24,
                                  h = 24,
                                  s_icon = "guis/textures/menu_tickbox",
                                  s_x = 24,
                                  s_y = 24,
                                  s_w = 24,
                                  s_h = 24
                      },
                      {
                                  _meta = "option",
                                  icon = "guis/textures/menu_tickbox",
                                  value = false,
                                  x = 0,
                                  y = 0,
                                  w = 24,
                                  h = 24,
                                  s_icon = "guis/textures/menu_tickbox",
                                  s_x = 0,
                                  s_y = 24,
                                  s_w = 24,
                                  s_h = 24
                      }
          }

          local params = {
                      name = name,
                      text_id = title,
                      help_id = desc,
                      callback = cbk,
                      disabled_color = Color( 0.25, 1, 1, 1 ),
                      icon_by_text = false
          }

          local menuItem = parent:create_item( data, params )
          menuItem:set_value( value and true or false )
          parent:add_item( menuItem )
end

function addMainMenu()
          local mainMenuNodes = managers.menu._registered_menus.menu_main and managers.menu._registered_menus.menu_main.logic._data._nodes or
                      managers.menu._registered_menus.menu_pause.logic._data._nodes
          
          local menuEntry = deep_clone(mainMenuNodes.video)
          menuEntry._items = {}
          
          MenuManager:add_back_button(menuEntry)
          mainMenuNodes["scsuitemenu"] = menuEntry

          local optionsButton = deep_clone( mainMenuNodes.options._items[1] )
          optionsButton._parameters.name = "scsuitemenu"
          optionsButton._parameters.text_id = "scsuitemenu"
          optionsButton._parameters.help_id = "scsuitemenudesc"
          optionsButton._parameters.next_node = "scsuitemenu"
          mainMenuNodes.options:add_item(optionsButton)
          --table.insert( mainMenuNodes.options._items, optionsButton )
          
          --local cheat_submenu = addSubmenu("cheat_submenu_name", "cheat_submenu_title", "cheat_submenu_desc", menuEntry)
          --addToggle("instant_drill_name", "instant_drill_title", "instant_drill_desc", "toggleInstantDrill", tweak_data.SCSuiteConfiguration.instant_drill_enabled, cheat_submenu)
          addToggle("toggle_mask_name", "toggle_mask_title", "toggle_mask_desc", "toggleMask", tweak_data.SCSuiteConfiguration.toggle_mask_enabled, menuEntry)
          addToggle("toggle_equipment_name", "toggle_equipment_title", "toggle_equipment_desc", "toggleEquipment", tweak_data.SCSuiteConfiguration.toggle_equipment_enabled, menuEntry)
          addToggle("mute_bain_name", "mute_bain_title", "mute_bain_desc", "toggleMuteBain", tweak_data.SCSuiteConfiguration.mute_bain_enabled, menuEntry)
          --addToggle("mission_menu_name", "mission_menu_title", "mission_menu_desc", "toggleMissionMenu", tweak_data.SCSuiteConfiguration.mission_menu_enabled, cheat_submenu)
          addToggle("mission_menu_name", "mission_menu_title", "mission_menu_desc", "toggleMissionMenu", tweak_data.SCSuiteConfiguration.mission_menu_enabled, menuEntry)
          addToggle("confirm_respec_name", "confirm_respec_title", "confirm_respec_desc", "toggleConfirmRespec", tweak_data.SCSuiteConfiguration.confirm_respec_toggle, menuEntry)
          addToggle("persistent_gadget_name", "persistent_gadget_title", "persistent_gadget_desc", "togglePersistentGadget", tweak_data.SCSuiteConfiguration.persistent_gadget_toggle, menuEntry)
          addToggle("mute_bain_broadcast_name", "mute_bain_broadcast_title", "mute_bain_broadcast_desc", "toggleBroadcastIngredient", tweak_data.SCSuiteConfiguration.mute_bain_broadcast_toggle, menuEntry)
          addToggle("force_ready_name", "force_ready_title", "force_ready_desc", "toggleForceReady", tweak_data.SCSuiteConfiguration.force_ready_toggle, menuEntry)
          addSlider("force_ready_threshold_name", "force_ready_threshold_title", "force_ready_threshold_desc", "sliderForceReadyThreshold", tweak_data.SCSuiteConfiguration.force_ready_threshold_value, menuEntry, 0, 10, 1)
          addSlider("skip_endscreen_name", "skip_endscreen_title", "skip_endscreen_desc", "toggleSkipEndscreen", tweak_data.SCSuiteConfiguration.skip_endscreen_toggle, menuEntry, 0, 10, 1)
          --addMultichoice("test_multichoice", "multichoice", "multichoicedesc", "multichoiceTest", 0, menuEntry)
end