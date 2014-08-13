missionselector = missionselector or function()
    dofiles("SCSuite/Menus/MissionSelector.lua")
    showHint("Mission Selector",3)
end

cheatmenu = cheatmenu or function()
    dofiles("SCSuite/Menus/Cheats.lua")
    showHint("Cheat Menu",3)
end

-- Menu Call

MainMenuReturn = MainMenuReturn or function()
    dofiles("SCSuite/Menus/Main.lua")
end

-- Menu stuff

if inGame() and isPlaying() then
rootopts = {
{ text = "---Main Menu---", callback = nil },
    {},
     { text = "F2 - Escape Selection", callback = missionselector },
     { text = "F3 - Cheat Menu", callback = cheatmenu }, 
    {},
     { text = "----------------", callback = nil },
     { text = "Reload Settings", callback = ReloadConfiguration },
     { text = "Cancel", is_cancel_button = true},
    }
else
rootopts = {
{ text = "---Main Menu---", callback = nil },
    {},
     { text = "F2 - Mission Selector", callback = missionselector },
    {},
     { text = "----------------", callback = nil },
     { text = "Reload Settings", callback = ReloadConfiguration },
     { text = "Cancel", is_cancel_button = true},
}
end

rootmenu = SimpleMenu:new("Main Menu", "scSuite Main Menu - Please enjoy!", rootopts)
rootmenu:show()