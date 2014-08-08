if tweak_data and tweak_data.SCSuiteConfiguration.mission_selector_enable then    
    -----------------------------------------
    ----- SOUNDTRACK MENU -------------------
    ----- BY PIERREDJAYS & POCO -- v2.0 -----
    -----------------------------------------

    local _music 
    local music = { 
        play = function(num) 
            _music.stop() 
            Global.music_manager.source:set_switch( "music_randomizer", "track_"..num ) 
            -- if inGame() and isPlaying() then
                -- _music.set(Global.music_manager.current_event)
            -- else
            _music.set('control') 
            -- end
        end, 
        set = function(mode) 
            _music.stop() 
            Global.music_manager.source:post_event("music_heist_"..mode) 
        end, 
        stop = function() 
            Global.music_manager.source:stop()
        end 
    } 
    _music = music 

    local musicmenu = {} 
    musicmenu[#musicmenu+1] = { text = "Calling All Units (1)", callback = music.play, data='08'} 
    musicmenu[#musicmenu+1] = { text = "Time Window (2)", callback = music.play, data='01'} 
    musicmenu[#musicmenu+1] = { text = "Tick Tock (3)", callback = music.play, data='05'} 
    musicmenu[#musicmenu+1] = { text = "Black Yellow Moebius (4)", callback = music.play, data='02'} 
    musicmenu[#musicmenu+1] = { text = "Razormind (5)", callback = music.play, data='07'} 
    musicmenu[#musicmenu+1] = { text = "The Mark (6)", callback = music.play, data='03'} 
    musicmenu[#musicmenu+1] = { text = "Full Force Forward (7)", callback = music.play, data='04'} 
    musicmenu[#musicmenu+1] = { text = "Fuse Box (8)", callback = music.play, data='06'} 
    musicmenu[#musicmenu+1] = { text = "Armed to the Teeth (9)", callback = music.play, data='09'} 
    musicmenu[#musicmenu+1] = { text = "Sirens in the Distance (10)", callback = music.play, data='10'} 
    musicmenu[#musicmenu+1] = { text = "Wanted Dead Or Alive (11)", callback = music.play, data='11'} 
    musicmenu[#musicmenu+1] = { text = "Death Wish (12)", callback = music.play, data='12'} 
    musicmenu[#musicmenu+1] = { text = "Shadows and Trickery (13)", callback = music.play, data='13'} 
    musicmenu[#musicmenu+1] = { text = "Ode To Greed (14)", callback = music.play, data='14'}
    musicmenu[#musicmenu+1] = { text = "", is_cancel_button = true } 
    musicmenu[#musicmenu+1] = { text = "Music Stealth", callback = music.set, data = 'setup' } 
    musicmenu[#musicmenu+1] = { text = "Music Control", callback = music.set, data = 'control' } 
    musicmenu[#musicmenu+1] = { text = "Music Anticipation", callback = music.set, data = 'anticipation' } 
    musicmenu[#musicmenu+1] = { text = "Music Assault", callback = music.set, data = 'assault' } 
    musicmenu[#musicmenu+1] = { text = "", is_cancel_button = true } 
    musicmenu[#musicmenu+1] = { text = "Stop Music", callback = music.stop } 
    musicmenu[#musicmenu+1] = { text = "", is_cancel_button = true } 
    if is_french then
        musicmenu[#musicmenu+1] = { text = "RETOUR", is_cancel_button = true }
    else
        musicmenu[#musicmenu+1] = { text = "EXIT", is_cancel_button = true }
    end

    if not musicmixermenu then
    musicmixermenu = musicmixermenu or SimpleMenu:new("SOUNDTRACK MENU", "By PierreDjays", musicmenu)
    end
    musicmixermenu:show()
end    