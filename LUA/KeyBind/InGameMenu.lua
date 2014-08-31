if not SCSuiteMenu then
    function instantdrill()
        dofile("LUA/Persist/InstantDrill.lua")
    end   
   
    SCSuiteMenu = CustomMenuClass:new({hasLoading = false})
    
    SCSuiteMenu:addMainMenu('main_menu', { title = 'SCSuite - Main Menu' } )
    SCSuiteMenu:addMenu('cheats_menu', { title = 'SCSuite - Cheats Menu' } )
    SCSuiteMenu:addMenu('cheats_drill_menu', { title = 'SCSuite - Cheats Menu - Drill' } )
    
    SCSuiteMenu:addMenuOption('main_menu', 'Cheats Menu', 'cheats_menu')
    SCSuiteMenu:addMenuOption('cheats_menu', 'Drill Related Cheats', 'cheats_drill_menu')
    
    -- Cheats Menu
    SCSuiteMenu:addOption('cheats_drill_menu', 'Instant Drill', { callback = instantdrill } )
    
    -- Drill Cheats Menu
end   

if inGame() and isPlaying() then
    if SCSuiteMenu:isOpen() then
        SCSuiteMenu:close()
    else
        SCSuiteMenu:open()
    end 
end