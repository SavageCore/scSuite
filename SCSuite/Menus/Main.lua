if not SCSuiteMenu then
    function missionmenu()
        SCSuiteMenu:close()
        dofiles("SCSuite/Menus/MissionMenu.lua")
    end
    function missionmenunew()
        SCSuiteMenu:close()
        dofiles("SCSuite/Menus/MissionMenuNew.lua")
    end
    function cheatsmenu()
        SCSuiteMenu:close()
        dofiles("SCSuite/Menus/InGameMenu.lua")
    end    
   
    SCSuiteMenu = CustomMenuClass:new({hasLoading = false})
    
    SCSuiteMenu:addMainMenu('main_menu', { title = 'SCSuite - Main Menu' } )    
    SCSuiteMenu:addOption('main_menu', 'Mission Menu', { callback = missionmenu } )
    SCSuiteMenu:addOption('main_menu', 'Mission Menu New', { callback = missionmenunew } )
    SCSuiteMenu:addOption('main_menu', 'Cheats/Hacks (Ingame)', { callback = cheatsmenu } )
    
    -- Drill Cheats Menu
end   

if SCSuiteMenu:isOpen() then
    SCSuiteMenu:close()
else
    SCSuiteMenu:open()
end 