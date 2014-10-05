if not SCSuiteMenuHacks then
    function instantdrill()
        dofile("LUA/Persist/InstantDrill.lua")
    end
    function carrystacker()
        dofile("LUA/KeyBind/CarryStacker.lua")
    end   
   
    SCSuiteMenuHacks = CustomMenuClass:new({hasLoading = false})
    
    SCSuiteMenuHacks:addMainMenu('cheats_menu', { title = 'SCSuite - Cheats Menu' } )
    SCSuiteMenuHacks:addMenu('cheats_drill_menu', { title = 'SCSuite - Cheats Menu - Drill' } )
    
    SCSuiteMenuHacks:addMenuOption('cheats_menu', 'Drill Related Cheats', 'cheats_drill_menu')
    
    -- Cheats Menu
    SCSuiteMenuHacks:addOption('cheats_drill_menu', 'Instant Drill', { callback = instantdrill } )
    SCSuiteMenuHacks:addOption('cheats_menu', 'Carry Stacker', { callback = carrystacker } )
    
    -- Drill Cheats Menu
end   

if inGame() and isPlaying() then
    if SCSuiteMenuHacks:isOpen() then
        SCSuiteMenuHacks:close()
    else
        SCSuiteMenuHacks:open()
    end 
end