instantdrill = instantdrill or function()
    dofiles("LUA/Hacks/InstantDrill.lua")
    showHint("Instant Drill",3)
end
carrystacker = carrystacker or function()
    dofiles("LUA/Hacks/CarryStacker.lua")
    showHint("Carry Stacker",3)
end
nukemap = nukemap or function()
    dofiles("LUA/Hacks/KillAllAI.lua")
    showHint("Nuke Map",3)
end
xray = xray or function()
    dofiles("LUA/Hacks/XRay.lua")
    showHint("X-Ray",3)
end
bigbankcomputer = bigbankcomputer or function()
    dofiles("LUA/Hacks/BigBankComputer.lua")
    showHint("Big Bank Computer Hack",3)
end
pickup = pickup or function()
    dofiles("LUA/Hacks/PickupFinder.lua")
    showHint("Pick-Up Waypoints",3)
end
bankbuster = bankbuster or function()
    dofiles("LUA/KeyBind/BankBuster.lua")
    showHint("Bank Buster",3)
end

-- Menu Call

MainMenuReturn = MainMenuReturn or function()
    dofiles("SCSuite/Menus/Main.lua")
end

ReloadConfiguration = ReloadConfiguration or function()
    dofiles("SCSuite/ReloadConfiguration.lua")
end

-- Menu stuff
if inGame() and isPlaying() then
    cheatmenuopts = {
    { text = "---Cheat Menu---", callback = nil },
        {},
         { text = "Instant Drill", callback = instantdrill },
         { text = "Carry Stacker", callback = carrystacker },
         { text = "Nuke Map", callback = nukemap },
         { text = "X-Ray Map", callback = xray },
         { text = "Big Bank Computer Hack", callback = bigbankcomputer },
         { text = "Pick-Up Waypoints", callback = pickup },
         { text = "Bank Buster", callback = bankbuster },
        {},
         { text = "----------------", callback = nil },
         { text = "Main Menu", callback = MainMenuReturn },
         { text = "Reload Settings", callback = ReloadConfiguration },
         { text = "Cancel", is_cancel_button = true},    
    }
    rootmenu = SimpleMenu:new("Cheat Menu", "scSuite Cheats", cheatmenuopts)
    rootmenu:show()
else 
    cheatmenuopts = {
    { text = "---Cheat Menu---", callback = nil },
        {},
         { text = "Run in-game", callback = nil },
        {},
         { text = "----------------", callback = nil },
         { text = "Main Menu", callback = MainMenuReturn },
         { text = "Reload Settings", callback = ReloadConfiguration },
         { text = "Cancel", is_cancel_button = true},    
    }
    rootmenu = SimpleMenu:new("Cheat Menu", "scSuite Cheats", cheatmenuopts)
    rootmenu:show()
end    