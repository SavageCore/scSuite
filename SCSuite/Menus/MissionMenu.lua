-- Requires GUI Drawn Menu by stumpy3toes

-----------------------------------------
----- Job Manager v1.03a (Update 37) ----
-- Acepilot1023978: GUI Implementation --
------ B1313: Base code (functions) -----
----- MS HACK: Update 37 (level ID) -----
-- kel007: Update 37 (open/close menu) --
-----------------------------------------

if not JobMenu then
-- ESCAPE CHAIN (Current Difficulty)
EscapeCafeChain = function()
managers.job:set_next_interupt_stage( "escape_cafe" )
show_mid_text( "Escape Chain:", "Set to: Cafe", 3,5 )
end

EscapeCafeDayChain = function()
managers.job:set_next_interupt_stage( "escape_cafe_day" )
show_mid_text( "Escape Chain:", "Set to: Cafe (Day)", 3,5 )
end

EscapeParkChain = function()
managers.job:set_next_interupt_stage( "escape_park" )
show_mid_text( "Escape Chain:", "Set to: Park", 3,5 )
end

EscapeParkDayChain = function()
managers.job:set_next_interupt_stage( "escape_park_day" )
show_mid_text( "Escape Chain:", "Set to: Park (Day)", 3,5 )
end

EscapeOverPassChain = function()
managers.job:set_next_interupt_stage( "escape_overpass" )
show_mid_text( "Escape Chain:", "Set to: Overpass", 3,5 )
end

EscapeOverPassNightChain = function()
managers.job:set_next_interupt_stage( "escape_overpass_night" )
show_mid_text( "Escape Chain:", "Set to: Overpass (Night)", 3,5 )
end

EscapeStreetChain = function()
managers.job:set_next_interupt_stage( "escape_street" )
show_mid_text( "Escape Chain:", "Set to: Street", 3,5 )
end

EscapeGarageChain = function()
managers.job:set_next_interupt_stage( "escape_garage" )
show_mid_text( "Escape Chain:", "Set to: Garage", 3,5 )
end

-- ESCAPES (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- ESCAPE: GARAGE (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeGarageDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_garage"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeGarageOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_garage"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeGarageVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_garage"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeGarageHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_garage"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeGarageNormal = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_garage"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ESCAPE: STREET (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeStreetDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_street"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeStreetOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_street"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeStreetVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_street"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeStreetHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_street"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeStreetNormal = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_street"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ESCAPE: OVERPASS (NIGHT) (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeOverPassNightDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass_night"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassNightOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass_night"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassNightVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass_night"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassNightHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass_night"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassNightNormal = function()
    managers.job:activate_job ( "escape_overpass_night" )
    Global.game_settings.level_id = "escape_overpass_night"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ESCAPE: OVERPASS (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeOverPassDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_overpass"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeOverPassNormal = function()
    managers.job:activate_job ( "escape_overpass" )
    Global.game_settings.level_id = "escape_overpass"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ESCAPE: PARK (DAY) (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeParkDayDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkDayOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkDayVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkDayHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkDayNormal = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ESCAPE: PARK (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeParkDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeParkNormal = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_park"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end 

-- ESCAPE: CAFE (DAY) (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeCafeDayDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeDayOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeDayVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeDayHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeDayNormal = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe_day"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ESCAPE: CAFE (Normal, Hard, Very Hard, OverKill, and DeathWish)
EscapeCafeDeathWish = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeOverKill = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeVeryHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeHard = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

EscapeCafeNormal = function()
    managers.job:activate_job ( "ukrainian_job" )
    Global.game_settings.level_id = "escape_cafe"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end
-- VLAD (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- UKRAINIAN JOB PRO JOB (Hard, Very Hard, OverKill, and DeathWish)
UkrainianJobPRODeathWish = function()
    managers.job:activate_job ( "ukrainian_job_prof" )
    Global.game_settings.level_id = "ukrainian_job"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

UkrainianJobPROOverKill = function()
    managers.job:activate_job ( "ukrainian_job_prof" )
    Global.game_settings.level_id = "ukrainian_job"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

UkrainianJobPROVeryHard = function()
    managers.job:activate_job ( "ukrainian_job_prof" )
    Global.game_settings.level_id = "ukrainian_job"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

UkrainianJobPROHard = function()
    managers.job:activate_job ( "ukrainian_job_prof" )
    Global.game_settings.level_id = "ukrainian_job"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- NIGHTCLUB (Normal, Hard, Very Hard, OverKill, and DeathWish)
NightclubDeathWish = function()
    managers.job:activate_job ( "nightclub" )
    Global.game_settings.level_id = "nightclub"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

NightclubOverKill = function()
    managers.job:activate_job ( "nightclub" )
    Global.game_settings.level_id = "nightclub"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

NightclubVeryHard = function()
    managers.job:activate_job ( "nightclub" )
    Global.game_settings.level_id = "nightclub"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

NightclubHard = function()
    managers.job:activate_job ( "nightclub" )
    Global.game_settings.level_id = "nightclub"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

NightclubNormal = function()
    managers.job:activate_job ( "nightclub" )
    Global.game_settings.level_id = "nightclub"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- MALLCRASHER (Normal, Hard, Very Hard, OverKill, and DeathWish)
MallCrasherDeathWish = function()
    managers.job:activate_job ( "mallcrasher" )
    Global.game_settings.level_id = "mallcrasher"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

MallCrasherOverKill = function()
    managers.job:activate_job ( "mallcrasher" )
    Global.game_settings.level_id = "mallcrasher"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

MallCrasherVeryHard = function()
    managers.job:activate_job ( "mallcrasher" )
    Global.game_settings.level_id = "mallcrasher"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

MallCrasherHard = function()
    managers.job:activate_job ( "mallcrasher" )
    Global.game_settings.level_id = "mallcrasher"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

MallCrasherNormal = function()
    managers.job:activate_job ( "mallcrasher" )
    Global.game_settings.level_id = "mallcrasher"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FOUR STORES (Normal, Hard, Very Hard, OverKill, and DeathWish)
FourStoresDeathWish = function()
    managers.job:activate_job ( "four_stores" )
    Global.game_settings.level_id = "four_stores"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FourStoresOverKill = function()
    managers.job:activate_job ( "four_stores" )
    Global.game_settings.level_id = "four_stores"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FourStoresVeryHard = function()
    managers.job:activate_job ( "four_stores" )
    Global.game_settings.level_id = "four_stores"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FourStoresHard = function()
    managers.job:activate_job ( "four_stores" )
    Global.game_settings.level_id = "four_stores"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FourStoresNormal = function()
    managers.job:activate_job ( "four_stores" )
    Global.game_settings.level_id = "four_stores"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end


-- THE ELEPHANT (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- ELECTION DAY PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
ElectionDayPRODay3DeathWish = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay3OverKill = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay3VeryHard = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay3Hard = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- ELECTION DAY PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
ElectionDayPRODay2DeathWish = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay2OverKill = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay2VeryHard = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay2Hard = function()
    managers.job:activate_job ( "election_day_prof", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- ELECTION DAY PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
ElectionDayPRODay1DeathWish = function()
    managers.job:activate_job ( "election_day_prof" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay1OverKill = function()
    managers.job:activate_job ( "election_day_prof" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay1VeryHard = function()
    managers.job:activate_job ( "election_day_prof" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayPRODay1Hard = function()
    managers.job:activate_job ( "election_day_prof" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- BIG OIL PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
BigOilPRODay2DeathWish = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof", 2 )
    Global.game_settings.level_id = "welcome_to_the_jungle_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BigOilPRODay2OverKill = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof", 2 )
    Global.game_settings.level_id = "welcome_to_the_jungle_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BigOilPRODay2VeryHard = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof", 2 )
    Global.game_settings.level_id = "welcome_to_the_jungle_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BigOilPRODay2Hard = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof", 2 )
    Global.game_settings.level_id = "welcome_to_the_jungle_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- BIG OIL PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
BigOilPRODay1DeathWish = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof" )
    Global.game_settings.level_id = "welcome_to_the_jungle_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BigOilPRODay1OverKill = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof" )
    Global.game_settings.level_id = "welcome_to_the_jungle_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BigOilPRODay1VeryHard = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof" )
    Global.game_settings.level_id = "welcome_to_the_jungle_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BigOilPRODay1Hard = function()
    managers.job:activate_job ( "welcome_to_the_jungle_prof" )
    Global.game_settings.level_id = "welcome_to_the_jungle_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- FRAMING FRAME PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
FramingFramePRODay3DeathWish = function()
    managers.job:activate_job ( "framing_frame_prof", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay3OverKill = function()
    managers.job:activate_job ( "framing_frame_prof", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay3VeryHard = function()
    managers.job:activate_job ( "framing_frame_prof", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay3Hard = function()
    managers.job:activate_job ( "framing_frame_prof", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- FRAMING FRAME PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
FramingFramePRODay2DeathWish = function()
    managers.job:activate_job ( "framing_frame_prof", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay2OverKill = function()
    managers.job:activate_job ( "framing_frame_prof", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay2VeryHard = function()
    managers.job:activate_job ( "framing_frame_prof", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay2Hard = function()
    managers.job:activate_job ( "framing_frame_prof", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- FRAMING FRAME PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
FramingFramePRODay1DeathWish = function()
    managers.job:activate_job ( "framing_frame_prof" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay1OverKill = function()
    managers.job:activate_job ( "framing_frame_prof" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay1VeryHard = function()
    managers.job:activate_job ( "framing_frame_prof" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FramingFramePRODay1Hard = function()
    managers.job:activate_job ( "framing_frame_prof" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- ELECTION DAY DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
ElectionDayDay3DeathWish = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay3OverKill = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay3VeryHard = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay3Hard = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay3Normal = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end    

-- ELECTION DAY DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
ElectionDayDay2DeathWish = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay2OverKill = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay2VeryHard = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay2Hard = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay2Normal = function()
    managers.job:activate_job ( "election_day", 2 )
    Global.game_settings.level_id = "election_day_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ELECTION DAY DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
ElectionDayDay1DeathWish = function()
    managers.job:activate_job ( "election_day" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay1OverKill = function()
    managers.job:activate_job ( "election_day" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay1VeryHard = function()
    managers.job:activate_job ( "election_day" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay1Hard = function()
    managers.job:activate_job ( "election_day" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

ElectionDayDay1Normal = function()
    managers.job:activate_job ( "election_day" )
    Global.game_settings.level_id = "election_day_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FRAMING FRAME DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
FramingFrameDay3DeathWish = function()
    managers.job:activate_job ( "framing_frame", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay3OverKill = function()
    managers.job:activate_job ( "framing_frame", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay3VeryHard = function()
    managers.job:activate_job ( "framing_frame", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay3Hard = function()
    managers.job:activate_job ( "framing_frame", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay3Normal = function()
    managers.job:activate_job ( "framing_frame", 3 )
    Global.game_settings.level_id = "framing_frame_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FRAMING FRAME DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
FramingFrameDay2DeathWish = function()
    managers.job:activate_job ( "framing_frame", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay2OverKill = function()
    managers.job:activate_job ( "framing_frame", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay2VeryHard = function()
    managers.job:activate_job ( "framing_frame", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay2Hard = function()
    managers.job:activate_job ( "framing_frame", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay2Normal = function()
    managers.job:activate_job ( "framing_frame", 2 )
    Global.game_settings.level_id = "framing_frame_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FRAMING FRAME DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
FramingFrameDay1DeathWish = function()
    managers.job:activate_job ( "framing_frame" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay1OverKill = function()
    managers.job:activate_job ( "framing_frame" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay1VeryHard = function()
    managers.job:activate_job ( "framing_frame" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay1Hard = function()
    managers.job:activate_job ( "framing_frame" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FramingFrameDay1Normal = function()
    managers.job:activate_job ( "framing_frame" )
    Global.game_settings.level_id = "framing_frame_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- HECTOR (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- RATS PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
RatsPRODay3DeathWish = function()
    managers.job:activate_job ( "alex_prof", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay3OverKill = function()
    managers.job:activate_job ( "alex_prof", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay3VeryHard = function()
    managers.job:activate_job ( "alex_prof", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay3Hard = function()
    managers.job:activate_job ( "alex_prof", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- RATS PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
RatsPRODay2DeathWish = function()
    managers.job:activate_job ( "alex_prof", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay2OverKill = function()
    managers.job:activate_job ( "alex_prof", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay2VeryHard = function()
    managers.job:activate_job ( "alex_prof", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay2Hard = function()
    managers.job:activate_job ( "alex_prof", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- RATS PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
RatsPRODay1DeathWish = function()
    managers.job:activate_job ( "alex_prof" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay1OverKill = function()
    managers.job:activate_job ( "alex_prof" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay1VeryHard = function()
    managers.job:activate_job ( "alex_prof" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

RatsPRODay1Hard = function()
    managers.job:activate_job ( "alex_prof" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- FIRESTARTER PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
FireStarterPRODay3DeathWish = function()
    managers.job:activate_job ( "firestarter_prof", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay3OverKill = function()
    managers.job:activate_job ( "firestarter_prof", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay3VeryHard = function()
    managers.job:activate_job ( "firestarter_prof", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay3Hard = function()
    managers.job:activate_job ( "firestarter_prof", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- FIRESTARTER PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
FireStarterPRODay2DeathWish = function()
    managers.job:activate_job ( "firestarter_prof", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay2OverKill = function()
    managers.job:activate_job ( "firestarter_prof", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay2VeryHard = function()
    managers.job:activate_job ( "firestarter_prof", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay2Hard = function()
    managers.job:activate_job ( "firestarter_prof", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- FIRESTARTER PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
FireStarterPRODay1DeathWish = function()
    managers.job:activate_job ( "firestarter_prof" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay1OverKill = function()
    managers.job:activate_job ( "firestarter_prof" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay1VeryHard = function()
    managers.job:activate_job ( "firestarter_prof" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterPRODay1Hard = function()
    managers.job:activate_job ( "firestarter_prof" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- WATCHDOGS PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
WatchdogsPRODay2DeathWish = function()
    managers.job:activate_job ( "watchdogs_prof", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsPRODay2OverKill = function()
    managers.job:activate_job ( "watchdogs_prof", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsPRODay2VeryHard = function()
    managers.job:activate_job ( "watchdogs_prof", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsPRODay2Hard = function()
    managers.job:activate_job ( "watchdogs_prof", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- WATCHDOGS PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
WatchdogsPRODay1DeathWish = function()
    managers.job:activate_job ( "watchdogs_prof" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsPRODay1OverKill = function()
    managers.job:activate_job ( "watchdogs_prof" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsPRODay1VeryHard = function()
    managers.job:activate_job ( "watchdogs_prof" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsPRODay1Hard = function()
    managers.job:activate_job ( "watchdogs_prof" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end


-- RATS DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
RatsDay3DeathWish = function()
    managers.job:activate_job ( "alex", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay3OverKill = function()
    managers.job:activate_job ( "alex", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay3VeryHard = function()
    managers.job:activate_job ( "alex", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay3Hard = function()
    managers.job:activate_job ( "alex", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay3Normal = function()
    managers.job:activate_job ( "alex", 3 )
    Global.game_settings.level_id = "alex_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- RATS DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
RatsDay2DeathWish = function()
    managers.job:activate_job ( "alex", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay2OverKill = function()
    managers.job:activate_job ( "alex", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay2VeryHard = function()
    managers.job:activate_job ( "alex", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay2Hard = function()
    managers.job:activate_job ( "alex", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay2Normal = function()
    managers.job:activate_job ( "alex", 2 )
    Global.game_settings.level_id = "alex_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- RATS DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
RatsDay1DeathWish = function()
    managers.job:activate_job ( "alex" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay1OverKill = function()
    managers.job:activate_job ( "alex" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay1VeryHard = function()
    managers.job:activate_job ( "alex" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay1Hard = function()
    managers.job:activate_job ( "alex" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

RatsDay1Normal = function()
    managers.job:activate_job ( "alex" )
    Global.game_settings.level_id = "alex_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FIRESTARTER DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
FireStarterDay3DeathWish = function()
    managers.job:activate_job ( "firestarter", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay3OverKill = function()
    managers.job:activate_job ( "firestarter", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay3VeryHard = function()
    managers.job:activate_job ( "firestarter", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay3Hard = function()
    managers.job:activate_job ( "firestarter", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay3Normal = function()
    managers.job:activate_job ( "firestarter", 3 )
    Global.game_settings.level_id = "firestarter_3"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FIRESTARTER DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
FireStarterDay2DeathWish = function()
    managers.job:activate_job ( "firestarter", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay2OverKill = function()
    managers.job:activate_job ( "firestarter", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay2VeryHard = function()
    managers.job:activate_job ( "firestarter", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay2Hard = function()
    managers.job:activate_job ( "firestarter", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay2Normal = function()
    managers.job:activate_job ( "firestarter", 2 )
    Global.game_settings.level_id = "firestarter_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- FIRESTARTER DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
FireStarterDay1DeathWish = function()
    managers.job:activate_job ( "firestarter" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay1OverKill = function()
    managers.job:activate_job ( "firestarter" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay1VeryHard = function()
    managers.job:activate_job ( "firestarter" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay1Hard = function()
    managers.job:activate_job ( "firestarter" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

FireStarterDay1Normal = function()
    managers.job:activate_job ( "firestarter" )
    Global.game_settings.level_id = "firestarter_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- WATCHDOGS DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
WatchdogsDay2DeathWish = function()
    managers.job:activate_job ( "watchdogs", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay2OverKill = function()
    managers.job:activate_job ( "watchdogs", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay2VeryHard = function()
    managers.job:activate_job ( "watchdogs", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay2Hard = function()
    managers.job:activate_job ( "watchdogs", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay2Normal = function()
    managers.job:activate_job ( "watchdogs", 2 )
    Global.game_settings.level_id = "watchdogs_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- WATCHDOGS DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
WatchdogsDay1DeathWish = function()
    managers.job:activate_job ( "watchdogs" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay1OverKill = function()
    managers.job:activate_job ( "watchdogs" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay1VeryHard = function()
    managers.job:activate_job ( "watchdogs" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay1Hard = function()
    managers.job:activate_job ( "watchdogs" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

WatchdogsDay1Normal = function()
    managers.job:activate_job ( "watchdogs" )
    Global.game_settings.level_id = "watchdogs_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- THE DENTIST (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- THE BIG BANK (Normal, Hard, Very Hard, OverKill, and DeathWish)
BigBankDeathWish = function()
    managers.job:activate_job ( "big" )
    Global.game_settings.level_id = "big"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BigBankOverKill = function()
    managers.job:activate_job ( "big" )
    Global.game_settings.level_id = "big"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BigBankVeryHard = function()
    managers.job:activate_job ( "big" )
    Global.game_settings.level_id = "big"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BigBankHard = function()
    managers.job:activate_job ( "big" )
    Global.game_settings.level_id = "big"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

BigBankNormal = function()
    managers.job:activate_job ( "big" )
    Global.game_settings.level_id = "big"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- HOTLINE MIAMI DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
HotlineMiamiDay2DeathWish = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay2OverKill = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay2VeryHard = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay2Hard = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay2Normal = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- HOTLINE MIAMI DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
HotlineMiamiDay1DeathWish = function()
    managers.job:activate_job ( "mia" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay1OverKill = function()
    managers.job:activate_job ( "mia" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay1VeryHard = function()
    managers.job:activate_job ( "mia" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay1Hard = function()
    managers.job:activate_job ( "mia" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiDay1Normal = function()
    managers.job:activate_job ( "mia" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- HOTLINE MIAMI PRO JOB DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
HotlineMiamiPRODay2DeathWish = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiPRODay2OverKill = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiPRODay2VeryHard = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiPRODay2Hard = function()
    managers.job:activate_job ( "mia", 2 )
    Global.game_settings.level_id = "mia_2"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- HOTLINE MIAMI PRO JOB DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
HotlineMiamiPRODay1DeathWish = function()
    managers.job:activate_job ( "mia_prof" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiPRODay1OverKill = function()
    managers.job:activate_job ( "mia_prof" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiPRODay1VeryHard = function()
    managers.job:activate_job ( "mia_prof" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

HotlineMiamiPRODay1Hard = function()
    managers.job:activate_job ( "mia_prof" )
    Global.game_settings.level_id = "mia_1"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- BAIN DLC (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- SHADOW RAID (Normal, Hard, Very Hard, OverKill, and DeathWish)
ShadowRaidDeathWish = function()
    managers.job:activate_job ( "kosugi" )
    Global.game_settings.level_id = "kosugi"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

ShadowRaidOverKill = function()
    managers.job:activate_job ( "kosugi" )
    Global.game_settings.level_id = "kosugi"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

ShadowRaidVeryHard = function()
    managers.job:activate_job ( "kosugi" )
    Global.game_settings.level_id = "kosugi"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

ShadowRaidHard = function()
    managers.job:activate_job ( "kosugi" )
    Global.game_settings.level_id = "kosugi"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

ShadowRaidNormal = function()
    managers.job:activate_job ( "kosugi" )
    Global.game_settings.level_id = "kosugi"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- GO BANK (Normal, Hard, Very Hard, OverKill, and DeathWish)
GOBankDeathWish = function()
    managers.job:activate_job ( "roberts" )
    Global.game_settings.level_id = "roberts"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

GOBankOverKill = function()
    managers.job:activate_job ( "roberts" )
    Global.game_settings.level_id = "roberts"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

GOBankVeryHard = function()
    managers.job:activate_job ( "roberts" )
    Global.game_settings.level_id = "roberts"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

GOBankHard = function()
    managers.job:activate_job ( "roberts" )
    Global.game_settings.level_id = "roberts"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

GOBankNormal = function()
    managers.job:activate_job ( "roberts" )
    Global.game_settings.level_id = "roberts"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ARMORED TRANSPORT: TRAIN HEIST (Normal, Hard, Very Hard, OverKill, and DeathWish)
TrainHeistDeathWish = function()
    managers.job:activate_job ( "arm_for" )
    Global.game_settings.level_id = "arm_for"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

TrainHeistOverKill = function()
    managers.job:activate_job ( "arm_for" )
    Global.game_settings.level_id = "arm_for"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

TrainHeistVeryHard = function()
    managers.job:activate_job ( "arm_for" )
    Global.game_settings.level_id = "arm_for"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

TrainHeistHard = function()
    managers.job:activate_job ( "arm_for" )
    Global.game_settings.level_id = "arm_for"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

TrainHeistNormal = function()
    managers.job:activate_job ( "arm_for" )
    Global.game_settings.level_id = "arm_for"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ARMORED TRANSPORT: TRANSPORT PARK (Normal, Hard, Very Hard, OverKill, and DeathWish)
TransportParkDeathWish = function()
    managers.job:activate_job ( "arm_par" )
    Global.game_settings.level_id = "arm_par"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

TransportParkOverKill = function()
    managers.job:activate_job ( "arm_par" )
    Global.game_settings.level_id = "arm_par"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

TransportParkVeryHard = function()
    managers.job:activate_job ( "arm_par" )
    Global.game_settings.level_id = "arm_par"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

TransportParkHard = function()
    managers.job:activate_job ( "arm_par" )
    Global.game_settings.level_id = "arm_par"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

TransportParkNormal = function()
    managers.job:activate_job ( "arm_par" )
    Global.game_settings.level_id = "arm_par"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ARMORED TRANSPORT: TRANSPORT UNDERPASS (Normal, Hard, Very Hard, OverKill, and DeathWish)
TransportUnderPassDeathWish = function()
    managers.job:activate_job ( "arm_und" )
    Global.game_settings.level_id = "arm_und"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

TransportUnderPassOverKill = function()
    managers.job:activate_job ( "arm_und" )
    Global.game_settings.level_id = "arm_und"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

TransportUnderPassVeryHard = function()
    managers.job:activate_job ( "arm_und" )
    Global.game_settings.level_id = "arm_und"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

TransportUnderPassHard = function()
    managers.job:activate_job ( "arm_und" )
    Global.game_settings.level_id = "arm_und"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

TransportUnderPassNormal = function()
    managers.job:activate_job ( "arm_und" )
    Global.game_settings.level_id = "arm_und"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ARMORED TRANSPORT: TRANSPORT HARBOUR (Normal, Hard, Very Hard, OverKill, and DeathWish)
TransportHarbourDeathWish = function()
    managers.job:activate_job ( "arm_fac" )
    Global.game_settings.level_id = "arm_fac"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

TransportHarbourOverKill = function()
    managers.job:activate_job ( "arm_fac" )
    Global.game_settings.level_id = "arm_fac"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

TransportHarbourVeryHard = function()
    managers.job:activate_job ( "arm_fac" )
    Global.game_settings.level_id = "arm_fac"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

TransportHarbourHard = function()
    managers.job:activate_job ( "arm_fac" )
    Global.game_settings.level_id = "arm_fac"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

TransportHarbourNormal = function()
    managers.job:activate_job ( "arm_fac" )
    Global.game_settings.level_id = "arm_fac"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ARMORED TRANSPORT: TRANSPORT DOWNTOWN (Normal, Hard, Very Hard, OverKill, and DeathWish)
TransportDownTownDeathWish = function()
    managers.job:activate_job ( "arm_hcm" )
    Global.game_settings.level_id = "arm_hcm"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

TransportDownTownOverKill = function()
    managers.job:activate_job ( "arm_hcm" )
    Global.game_settings.level_id = "arm_hcm"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

TransportDownTownVeryHard = function()
    managers.job:activate_job ( "arm_hcm" )
    Global.game_settings.level_id = "arm_hcm"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

TransportDownTownHard = function()
    managers.job:activate_job ( "arm_hcm" )
    Global.game_settings.level_id = "arm_hcm"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

TransportDownTownNormal = function()
    managers.job:activate_job ( "arm_hcm" )
    Global.game_settings.level_id = "arm_hcm"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- ARMORED TRANSPORT: TRANSPORT CROSSROADS (Normal, Hard, Very Hard, OverKill, and DeathWish)
TransportCrossRoadsDeathWish = function()
    managers.job:activate_job ( "arm_cro" )
    Global.game_settings.level_id = "arm_cro"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

TransportCrossRoadsOverKill = function()
    managers.job:activate_job ( "arm_cro" )
    Global.game_settings.level_id = "arm_cro"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

TransportCrossRoadsVeryHard = function()
    managers.job:activate_job ( "arm_cro" )
    Global.game_settings.level_id = "arm_cro"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

TransportCrossRoadsHard = function()
    managers.job:activate_job ( "arm_cro" )
    Global.game_settings.level_id = "arm_cro"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

TransportCrossRoadsNormal = function()
    managers.job:activate_job ( "arm_cro" )
    Global.game_settings.level_id = "arm_cro"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- BAIN CLASSIC (Normal, Hard, Very Hard, OverKill, and DeathWish)
-- BANK HEIST: PRO JOB (Hard, Very Hard, OverKill, and DeathWish)
BankPRODeathWish = function()
    managers.job:activate_job ( "branchbank_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BankPROOverKill = function()
    managers.job:activate_job ( "branchbank_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BankPROVeryHard = function()
    managers.job:activate_job ( "branchbank_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BankPROHard = function()
    managers.job:activate_job ( "branchbank_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- BANK HEIST: GOLD PRO JOB (Hard, Very Hard, OverKill, and DeathWish)
BankGoldPRODeathWish = function()
    managers.job:activate_job ( "branchbank_gold_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BankGoldPROOverKill = function()
    managers.job:activate_job ( "branchbank_gold_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BankGoldPROVeryHard = function()
    managers.job:activate_job ( "branchbank_gold_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BankGoldPROHard = function()
    managers.job:activate_job ( "branchbank_gold_prof" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

-- DIAMOND STORE (Normal, Hard, Very Hard, OverKill, and DeathWish)
DiamondStoreDeathWish = function()
    managers.job:activate_job ( "family" )
    Global.game_settings.level_id = "family"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

DiamondStoreOverKill = function()
    managers.job:activate_job ( "family" )
    Global.game_settings.level_id = "family"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

DiamondStoreVeryHard = function()
    managers.job:activate_job ( "family" )
    Global.game_settings.level_id = "family"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

DiamondStoreHard = function()
    managers.job:activate_job ( "family" )
    Global.game_settings.level_id = "family"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

DiamondStoreNormal = function()
    managers.job:activate_job ( "family" )
    Global.game_settings.level_id = "family"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- BANK HEIST: DEPOSIT (Normal, Hard, Very Hard, OverKill, and DeathWish)
BankDepositDeathWish = function()
    managers.job:activate_job ( "branchbank_deposit" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BankDepositOverKill = function()
    managers.job:activate_job ( "branchbank_deposit" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BankDepositVeryHard = function()
    managers.job:activate_job ( "branchbank_deposit" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BankDepositHard = function()
    managers.job:activate_job ( "branchbank_deposit" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

BankDepositNormal = function()
    managers.job:activate_job ( "branchbank_deposit" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- BANK HEIST: CASH (Normal, Hard, Very Hard, OverKill, and DeathWish)
BankCashDeathWish = function()
    managers.job:activate_job ( "branchbank" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

BankCashOverKill = function()
    managers.job:activate_job ( "branchbank" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

BankCashVeryHard = function()
    managers.job:activate_job ( "branchbank" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

BankCashHard = function()
    managers.job:activate_job ( "branchbank" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

BankCashNormal = function()
    managers.job:activate_job ( "branchbank" )
    Global.game_settings.level_id = "branchbank"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end

-- JEWELRY STORE (Normal, Hard, Very Hard, OverKill, and DeathWish)
JewelryStoreDeathWish = function()
    managers.job:activate_job ( "jewelry_store" )
    Global.game_settings.level_id = "jewelry_store"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_290"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_290", "public", nil, nil, 1, 1, 1 } } )
end

JewelryStoreOverKill = function()
    managers.job:activate_job ( "jewelry_store" )
    Global.game_settings.level_id = "jewelry_store"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill_145"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill_145", "public", nil, nil, 1, 1, 1 } } )
end

JewelryStoreVeryHard = function()
    managers.job:activate_job ( "jewelry_store" )
    Global.game_settings.level_id = "jewelry_store"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "overkill"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "overkill", "public", nil, nil, 1, 1, 1 } } )
end

JewelryStoreHard = function()
    managers.job:activate_job ( "jewelry_store" )
    Global.game_settings.level_id = "jewelry_store"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "hard"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "hard", "public", nil, nil, 1, 1, 1 } } )
end

JewelryStoreNormal = function()
    managers.job:activate_job ( "jewelry_store" )
    Global.game_settings.level_id = "jewelry_store"
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.difficulty = "normal"
    local level_id = tweak_data.levels:get_index_from_level_id( Global.game_settings.level_id )
    local job_id = tweak_data.narrative:get_index_from_job_id( managers.job:current_job_id() )
    managers.network.matchmake:create_lobby( { numbers = { level_id, "normal", "public", nil, nil, 1, 1, 1 } } )
end
    
-- INGAME CHECK
function inGame()
    if not game_state_machine then return false end
    return string.find(game_state_machine:current_state_name(), "game")
end
-- IS PLAYING CHECK
function isPlaying()
    if not BaseNetworkHandler then return false end
    return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------

JobMenu = CustomMenuClass:new({hasLoading = false})
if not inGame() and not isPlaying() then
    JobMenu:addMainMenu('job_menu', { title = "Job Manager\nSelect a Contractor" } )
else
    JobMenu:addMainMenu('escape_chain', { title = 'Escape Chain' } )
end

-------------------
--[[ Add Menus ]]--
-------------------
--[[ Contractor Difficulty ]]--
JobMenu:addMenu('bain_diff', { title = 'Bain - Select Difficulty' } )
JobMenu:addMenu('dentist_diff', { title = 'Dentist - Select Difficulty' } )
JobMenu:addMenu('hector_diff', { title = 'Hector - Select Difficulty' } )
JobMenu:addMenu('elephant_diff', { title = 'Elephant - Select Difficulty' } )
JobMenu:addMenu('vlad_diff', { title = 'Vlad - Select Difficulty' } )
JobMenu:addMenu('escape_diff', { title = 'Escapes - Select Difficulty' } )
--[[ Normal ]]--
JobMenu:addMenu('bain_normal', { title = 'Bain - Select Mission' } )
JobMenu:addMenu('dentist_normal', { title = 'Dentist - Select Mission' } )
JobMenu:addMenu('hector_normal', { title = 'Hector - Select Mission' } )
JobMenu:addMenu('elephant_normal', { title = 'Elephant - Select Mission' } )
JobMenu:addMenu('vlad_normal', { title = 'Vlad - Select Mission' } )
JobMenu:addMenu('escape_normal', { title = 'Escapes - Select Mission' } )
--[[ Hard ]]--
JobMenu:addMenu('bain_hard', { title = 'Bain - Select Mission' } )
JobMenu:addMenu('dentist_hard', { title = 'Dentist - Select Mission' } )
JobMenu:addMenu('hector_hard', { title = 'Hector - Select Mission' } )
JobMenu:addMenu('elephant_hard', { title = 'Elephant - Select Mission', maxColumns = 3 } )
JobMenu:addMenu('vlad_hard', { title = 'Vlad - Select Mission' } )
JobMenu:addMenu('escape_hard', { title = 'Escapes - Select Mission' } )
--[[ Very Hard ]]--
JobMenu:addMenu('bain_veryhard', { title = 'Bain - Select Mission' } )
JobMenu:addMenu('dentist_veryhard', { title = 'Dentist - Select Mission' } )
JobMenu:addMenu('hector_veryhard', { title = 'Hector - Select Mission' } )
JobMenu:addMenu('elephant_veryhard', { title = 'Elephant - Select Mission', maxColumns = 3 } )
JobMenu:addMenu('vlad_veryhard', { title = 'Vlad - Select Mission' } )
JobMenu:addMenu('escape_veryhard', { title = 'Escapes - Select Mission' } )
--[[ Overkill ]]--
JobMenu:addMenu('bain_overkill', { title = 'Bain - Select Mission' } )
JobMenu:addMenu('dentist_overkill', { title = 'Dentist - Select Mission' } )
JobMenu:addMenu('hector_overkill', { title = 'Hector - Select Mission' } )
JobMenu:addMenu('elephant_overkill', { title = 'Elephant - Select Mission', maxColumns = 3 } )
JobMenu:addMenu('vlad_overkill', { title = 'Vlad - Select Mission' } )
JobMenu:addMenu('escape_overkill', { title = 'Escapes - Select Mission' } )
--[[ Death Wish ]]--
JobMenu:addMenu('bain_deathwish', { title = 'Bain - Select Mission' } )
JobMenu:addMenu('dentist_deathwish', { title = 'Dentist - Select Mission' } )
JobMenu:addMenu('hector_deathwish', { title = 'Hector - Select Mission' } )
JobMenu:addMenu('elephant_deathwish', { title = 'Elephant - Select Mission', maxColumns = 3 } )
JobMenu:addMenu('vlad_deathwish', { title = 'Vlad - Select Mission' } )
JobMenu:addMenu('escape_deathwish', { title = 'Escapes - Select Mission' } )

--------------------
--[[ Fill Menus ]]--
--------------------

--[[ Main Menu ]]--
JobMenu:addGap('job_menu')
JobMenu:addMenuOption('job_menu', 'Bain', 'bain_diff')
JobMenu:addGap('job_menu')
JobMenu:addGap('job_menu')
JobMenu:addMenuOption('job_menu', 'The Dentist', 'dentist_diff')
JobMenu:addGap('job_menu')
JobMenu:addGap('job_menu')
JobMenu:addMenuOption('job_menu', 'Hector', 'hector_diff')
JobMenu:addGap('job_menu')
JobMenu:addGap('job_menu')
JobMenu:addGap('job_menu')
JobMenu:addMenuOption('job_menu', 'The Elephant', 'elephant_diff')
JobMenu:addGap('job_menu')
JobMenu:addGap('job_menu')
JobMenu:addMenuOption('job_menu', 'Vlad', 'vlad_diff')
JobMenu:addGap('job_menu')
JobMenu:addGap('job_menu')
JobMenu:addMenuOption('job_menu', 'Escapes', 'escape_diff')
--[[ Bain Diff ]]--
JobMenu:addMenuOption('bain_diff', 'Normal', 'bain_normal')
JobMenu:addMenuOption('bain_diff', 'Hard', 'bain_hard')
JobMenu:addMenuOption('bain_diff', 'Very Hard', 'bain_veryhard')
JobMenu:addMenuOption('bain_diff', 'Overkill', 'bain_overkill')
JobMenu:addMenuOption('bain_diff', 'Death Wish', 'bain_deathwish')
--[[ Dentist Diff ]]--
JobMenu:addMenuOption('dentist_diff', 'Normal', 'dentist_normal')
JobMenu:addMenuOption('dentist_diff', 'Hard', 'dentist_hard')
JobMenu:addMenuOption('dentist_diff', 'Very Hard', 'dentist_veryhard')
JobMenu:addMenuOption('dentist_diff', 'Overkill', 'dentist_overkill')
JobMenu:addMenuOption('dentist_diff', 'Death Wish', 'dentist_deathwish')
--[[ Hector Diff ]]--
JobMenu:addMenuOption('hector_diff', 'Normal', 'hector_normal')
JobMenu:addMenuOption('hector_diff', 'Hard', 'hector_hard')
JobMenu:addMenuOption('hector_diff', 'Very Hard', 'hector_veryhard')
JobMenu:addMenuOption('hector_diff', 'Overkill', 'hector_overkill')
JobMenu:addMenuOption('hector_diff', 'Death Wish', 'hector_deathwish')
--[[ Elephant Diff ]]--
JobMenu:addMenuOption('elephant_diff', 'Normal', 'elephant_normal')
JobMenu:addMenuOption('elephant_diff', 'Hard', 'elephant_hard')
JobMenu:addMenuOption('elephant_diff', 'Very Hard', 'elephant_veryhard')
JobMenu:addMenuOption('elephant_diff', 'Overkill', 'elephant_overkill')
JobMenu:addMenuOption('elephant_diff', 'Death Wish', 'elephant_deathwish')
--[[ Vlad Diff ]]--
JobMenu:addMenuOption('vlad_diff', 'Normal', 'vlad_normal')
JobMenu:addMenuOption('vlad_diff', 'Hard', 'vlad_hard')
JobMenu:addMenuOption('vlad_diff', 'Very Hard', 'vlad_veryhard')
JobMenu:addMenuOption('vlad_diff', 'Overkill', 'vlad_overkill')
JobMenu:addMenuOption('vlad_diff', 'Death Wish', 'vlad_deathwish')
--[[Escape Diff]]--
JobMenu:addMenuOption('escape_diff', 'Normal', 'escape_normal')
JobMenu:addMenuOption('escape_diff', 'Hard', 'escape_hard')
JobMenu:addMenuOption('escape_diff', 'Very Hard', 'escape_veryhard')
JobMenu:addMenuOption('escape_diff', 'Overkill', 'escape_overkill')
JobMenu:addMenuOption('escape_diff', 'Death Wish', 'escape_deathwish')

--[[ Bain Normal ]]--
JobMenu:addInformationOption('bain_normal', '.:: Main ::.')
JobMenu:addOption('bain_normal', 'Jewelry Store', { callback = JewelryStoreNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Bank Heist: Cash', { callback = BankCashNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Bank Heist: Deposit', { callback = BankDepositNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Diamond Store', { callback = DiamondStoreNormal, closeMenu = true } )
JobMenu:addGap('bain_normal')
JobMenu:addGap('bain_normal')
JobMenu:addGap('bain_normal')
JobMenu:addGap('bain_normal')
JobMenu:addGap('bain_normal')
JobMenu:addInformationOption('bain_normal', '.:: DLC ::.')
JobMenu:addOption('bain_normal', 'Transport: Crossroads', { callback = TransportCrossRoadsNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Transport: Downtown', { callback = TransportDownTownNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Transport: Harbour', { callback = TransportHarbourNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Transport: Underpass', { callback = TransportUnderPassNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Transport: Park', { callback = TransportParkNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Train Heist', { callback = TrainHeistNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'GO Bank', { callback = GOBankNormal, closeMenu = true } )
JobMenu:addOption('bain_normal', 'Shadow Raid', { callback = ShadowRaidNormal, closeMenu = true } )
--[[ Dentist Normal ]]--
JobMenu:addOption('dentist_normal', 'The Big Bank', { callback = BigBankNormal, closeMenu = true } )
JobMenu:addGap('dentist_normal')
JobMenu:addOption('dentist_normal', 'Hotline Miami: Day 1', { callback = HotlineMiamiDay1Normal, closeMenu = true } )
JobMenu:addOption('dentist_normal', 'Hotline Miami: Day 2', { callback = HotlineMiamiDay2Normal, closeMenu = true } )
--[[ Hector Normal ]]--
JobMenu:addOption('hector_normal', 'Watchdogs: Day 1', { callback = WatchdogsDay1Normal, closeMenu = true } )
JobMenu:addOption('hector_normal', 'Watchdogs: Day 2', { callback = WatchdogsDay2Normal, closeMenu = true } )
JobMenu:addGap('hector_normal')
JobMenu:addOption('hector_normal', 'Fire Starter: Day 1', { callback = FireStarterDay1Normal, closeMenu = true } )
JobMenu:addOption('hector_normal', 'Fire Starter: Day 2', { callback = FireStarterDay2Normal, closeMenu = true } )
JobMenu:addOption('hector_normal', 'Fire Starter: Day 3', { callback = FireStarterDay3Normal, closeMenu = true } )
JobMenu:addGap('hector_normal')
JobMenu:addOption('hector_normal', 'Rats: Day 1', { callback = RatsDay1Normal, closeMenu = true } )
JobMenu:addOption('hector_normal', 'Rats: Day 2', { callback = RatsDay2Normal, closeMenu = true } )
JobMenu:addOption('hector_normal', 'Rats: Day 3', { callback = RatsDay3Normal, closeMenu = true } )
--[[ Elephant Normal ]]--
JobMenu:addOption('elephant_normal', 'Framing Frame: Day 1', { callback = FramingFrameDay1Normal, closeMenu = true } )
JobMenu:addOption('elephant_normal', 'Framing Frame: Day 2', { callback = FramingFrameDay2Normal, closeMenu = true } )
JobMenu:addOption('elephant_normal', 'Framing Frame: Day 3', { callback = FramingFrameDay3Normal, closeMenu = true } )
JobMenu:addGap('elephant_normal')
JobMenu:addGap('elephant_normal')
JobMenu:addGap('elephant_normal')
JobMenu:addGap('elephant_normal')
JobMenu:addGap('elephant_normal')
JobMenu:addGap('elephant_normal')
JobMenu:addGap('elephant_normal')
JobMenu:addOption('elephant_normal', 'Election Day: Day 1', { callback = ElectionDayDay1Normal, closeMenu = true } )
JobMenu:addOption('elephant_normal', 'Election Day: Day 2', { callback = ElectionDayDay2Normal, closeMenu = true } )
JobMenu:addOption('elephant_normal', 'Election Day: Day 3', { callback = ElectionDayDay3Normal, closeMenu = true } )
--[[ Vlad Normal ]]--
JobMenu:addOption('vlad_normal', 'Four Stores', { callback = FourStoresNormal, closeMenu = true } )
JobMenu:addOption('vlad_normal', 'Mallcrasher', { callback = MallCrasherNormal, closeMenu = true } )
JobMenu:addOption('vlad_normal', 'Nightclub', { callback = NightclubNormal, closeMenu = true } )
--[[ Escape Normal ]]--
JobMenu:addOption('escape_normal', 'Escape: Cafe', { callback = EscapeCafeNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Cafe (Day)', { callback = EscapeCafeDayNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Park', { callback = EscapeParkNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Park (Day)', { callback = EscapeParkDayNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Overpass', { callback = EscapeOverPassNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Overpass (Night)', { callback = EscapeOverPassNightNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Street', { callback = EscapeStreetNormal, closeMenu = true } )
JobMenu:addOption('escape_normal', 'Escape: Park', { callback = EscapeGarageNormal, closeMenu = true } )


--[[ Bain Hard ]]--
JobMenu:addInformationOption('bain_hard', '.:: Main ::.')
JobMenu:addOption('bain_hard', 'Jewelry Store', { callback = JewelryStoreHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Bank Heist: Cash', { callback = BankCashHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Bank Heist: Deposit', { callback = BankDepositHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Diamond Store', { callback = DiamondStoreHard, closeMenu = true } )
JobMenu:addGap('bain_hard')
JobMenu:addOption('bain_hard', 'Bank Heist: Gold (Pro)', { callback = BankGoldPROHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Bank Heist (Pro)', { callback = BankPROHard, closeMenu = true } )
JobMenu:addGap('bain_hard')
JobMenu:addGap('bain_hard')
JobMenu:addInformationOption('bain_hard', '.:: DLC ::.')
JobMenu:addOption('bain_hard', 'Transport: Crossroads', { callback = TransportCrossRoadsHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Transport: Downtown', { callback = TransportDownTownHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Transport: Harbour', { callback = TransportHarbourHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Transport: Underpass', { callback = TransportUnderPassHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Transport: Park', { callback = TransportParkHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Train Heist', { callback = TrainHeistHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'GO Bank', { callback = GOBankHard, closeMenu = true } )
JobMenu:addOption('bain_hard', 'Shadow Raid', { callback = ShadowRaidHard, closeMenu = true } )
--[[ Dentist Hard ]]--
JobMenu:addOption('dentist_hard', 'The Big Bank', { callback = BigBankHard, closeMenu = true } )
JobMenu:addGap('dentist_hard')
JobMenu:addOption('dentist_hard', 'Hotline Miami: Day 1', { callback = HotlineMiamiDay1Hard, closeMenu = true } )
JobMenu:addOption('dentist_hard', 'Hotline Miami: Day 2', { callback = HotlineMiamiDay2Hard, closeMenu = true } )
JobMenu:addGap('dentist_hard')
JobMenu:addOption('dentist_hard', 'Hotline Miami: Day 1 (Pro)', { callback = HotlineMiamiPRODay1Hard, closeMenu = true } )
JobMenu:addOption('dentist_hard', 'Hotline Miami: Day 2 (Pro)', { callback = HotlineMiamiPRODay2Hard, closeMenu = true } )
--[[ Hector Hard ]]--
JobMenu:addOption('hector_hard', 'Watchdogs: Day 1', { callback = WatchdogsDay1Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Watchdogs: Day 2', { callback = WatchdogsDay2Hard, closeMenu = true } )
JobMenu:addGap('hector_hard')
JobMenu:addOption('hector_hard', 'Fire Starter: Day 1', { callback = FireStarterDay1Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Fire Starter: Day 2', { callback = FireStarterDay2Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Fire Starter: Day 3', { callback = FireStarterDay3Hard, closeMenu = true } )
JobMenu:addGap('hector_hard')
JobMenu:addOption('hector_hard', 'Rats: Day 1', { callback = RatsDay1Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Rats: Day 2', { callback = RatsDay2Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Rats: Day 3', { callback = RatsDay3Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2Hard, closeMenu = true } )
JobMenu:addGap('hector_hard')
JobMenu:addOption('hector_hard', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3Hard, closeMenu = true } )
JobMenu:addGap('hector_hard')
JobMenu:addOption('hector_hard', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2Hard, closeMenu = true } )
JobMenu:addOption('hector_hard', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3Hard, closeMenu = true } )
--[[ Elephant Hard ]]--
JobMenu:addOption('elephant_hard', 'Framing Frame: Day 1', { callback = FramingFrameDay1Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Framing Frame: Day 2', { callback = FramingFrameDay2Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Framing Frame: Day 3', { callback = FramingFrameDay3Hard, closeMenu = true } )
JobMenu:addGap('elephant_hard')
JobMenu:addOption('elephant_hard', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3Hard, closeMenu = true } )
JobMenu:addGap('elephant_hard')
JobMenu:addGap('elephant_hard')
JobMenu:addGap('elephant_hard')
JobMenu:addOption('elephant_hard', 'Election Day: Day 1', { callback = ElectionDayDay1Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Election Day: Day 2', { callback = ElectionDayDay2Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Election Day: Day 3', { callback = ElectionDayDay3Hard, closeMenu = true } )
JobMenu:addGap('elephant_hard')
JobMenu:addOption('elephant_hard', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3Hard, closeMenu = true } )
JobMenu:addGap('elephant_hard')
JobMenu:addGap('elephant_hard')
JobMenu:addGap('elephant_hard')
JobMenu:addOption('elephant_hard', 'Big Oil: Day 1 (Pro)', { callback = BigOilPRODay1Hard, closeMenu = true } )
JobMenu:addOption('elephant_hard', 'Big Oil: Day 2 (Pro)', { callback = BigOilPRODay2Hard, closeMenu = true } )
--[[ Vlad Hard ]]--
JobMenu:addOption('vlad_hard', 'Four Stores', { callback = FourStoresHard, closeMenu = true } )
JobMenu:addOption('vlad_hard', 'Mallcrasher', { callback = MallCrasherHard, closeMenu = true } )
JobMenu:addOption('vlad_hard', 'Nightclub', { callback = NightclubHard, closeMenu = true } )
JobMenu:addOption('vlad_hard', 'Ukrainian Job (Pro)', { callback = UkrainianJobPROHard, closeMenu = true } )
--[[ Escape Hard ]]--
JobMenu:addOption('escape_hard', 'Escape: Cafe', { callback = EscapeCafeHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Cafe (Day)', { callback = EscapeCafeDayHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Park', { callback = EscapeParkHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Park (Day)', { callback = EscapeParkDayHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Overpass', { callback = EscapeOverPassHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Overpass (Night)', { callback = EscapeOverPassNightHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Street', { callback = EscapeStreetHard, closeMenu = true } )
JobMenu:addOption('escape_hard', 'Escape: Park', { callback = EscapeGarageHard, closeMenu = true } )

--[[ Bain Very Hard ]]--
JobMenu:addInformationOption('bain_veryhard', '.:: Main ::.')
JobMenu:addOption('bain_veryhard', 'Jewelry Store', { callback = JewelryStoreVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Bank Heist: Cash', { callback = BankCashVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Bank Heist: Deposit', { callback = BankDepositVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Diamond Store', { callback = DiamondStoreVeryHard, closeMenu = true } )
JobMenu:addGap('bain_veryhard')
JobMenu:addOption('bain_veryhard', 'Bank Heist: Gold (Pro)', { callback = BankGoldPROVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Bank Heist (Pro)', { callback = BankPROVeryHard, closeMenu = true } )
JobMenu:addGap('bain_veryhard')
JobMenu:addGap('bain_veryhard')
JobMenu:addInformationOption('bain_veryhard', '.:: DLC ::.')
JobMenu:addOption('bain_veryhard', 'Transport: Crossroads', { callback = TransportCrossRoadsVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Transport: Downtown', { callback = TransportDownTownVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Transport: Harbour', { callback = TransportHarbourVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Transport: Underpass', { callback = TransportUnderPassVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Transport: Park', { callback = TransportParkVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Train Heist', { callback = TrainHeistVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'GO Bank', { callback = GOBankVeryHard, closeMenu = true } )
JobMenu:addOption('bain_veryhard', 'Shadow Raid', { callback = ShadowRaidVeryHard, closeMenu = true } )
--[[ Dentist Very Hard ]]--
JobMenu:addOption('dentist_veryhard', 'The Big Bank', { callback = BigBankVeryHard, closeMenu = true } )
JobMenu:addGap('dentist_veryhard')
JobMenu:addOption('dentist_veryhard', 'Hotline Miami: Day 1', { callback = HotlineMiamiDay1VeryHard, closeMenu = true } )
JobMenu:addOption('dentist_veryhard', 'Hotline Miami: Day 2', { callback = HotlineMiamiDay2VeryHard, closeMenu = true } )
JobMenu:addGap('dentist_veryhard')
JobMenu:addOption('dentist_veryhard', 'Hotline Miami: Day 1 (Pro)', { callback = HotlineMiamiPRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('dentist_veryhard', 'Hotline Miami: Day 2 (Pro)', { callback = HotlineMiamiPRODay2VeryHard, closeMenu = true } )
--[[ Hector Very Hard ]]--
JobMenu:addOption('hector_veryhard', 'Watchdogs: Day 1', { callback = WatchdogsDay1VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Watchdogs: Day 2', { callback = WatchdogsDay2VeryHard, closeMenu = true } )
JobMenu:addGap('hector_veryhard')
JobMenu:addOption('hector_veryhard', 'Fire Starter: Day 1', { callback = FireStarterDay1VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Fire Starter: Day 2', { callback = FireStarterDay2VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Fire Starter: Day 3', { callback = FireStarterDay3VeryHard, closeMenu = true } )
JobMenu:addGap('hector_veryhard')
JobMenu:addOption('hector_veryhard', 'Rats: Day 1', { callback = RatsDay1VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Rats: Day 2', { callback = RatsDay2VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Rats: Day 3', { callback = RatsDay3VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2VeryHard, closeMenu = true } )
JobMenu:addGap('hector_veryhard')
JobMenu:addOption('hector_veryhard', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3VeryHard, closeMenu = true } )
JobMenu:addGap('hector_veryhard')
JobMenu:addOption('hector_veryhard', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2VeryHard, closeMenu = true } )
JobMenu:addOption('hector_veryhard', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3VeryHard, closeMenu = true } )
--[[ Elephant Very Hard ]]--
JobMenu:addOption('elephant_veryhard', 'Framing Frame: Day 1', { callback = FramingFrameDay1VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Framing Frame: Day 2', { callback = FramingFrameDay2VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Framing Frame: Day 3', { callback = FramingFrameDay3VeryHard, closeMenu = true } )
JobMenu:addGap('elephant_veryhard')
JobMenu:addOption('elephant_veryhard', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3VeryHard, closeMenu = true } )
JobMenu:addGap('elephant_veryhard')
JobMenu:addGap('elephant_veryhard')
JobMenu:addGap('elephant_veryhard')
JobMenu:addOption('elephant_veryhard', 'Election Day: Day 1', { callback = ElectionDayDay1VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Election Day: Day 2', { callback = ElectionDayDay2VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Election Day: Day 3', { callback = ElectionDayDay3VeryHard, closeMenu = true } )
JobMenu:addGap('elephant_veryhard')
JobMenu:addOption('elephant_veryhard', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3VeryHard, closeMenu = true } )
JobMenu:addGap('elephant_veryhard')
JobMenu:addGap('elephant_veryhard')
JobMenu:addGap('elephant_veryhard')
JobMenu:addOption('elephant_veryhard', 'Big Oil: Day 1 (Pro)', { callback = BigOilPRODay1VeryHard, closeMenu = true } )
JobMenu:addOption('elephant_veryhard', 'Big Oil: Day 2 (Pro)', { callback = BigOilPRODay2VeryHard, closeMenu = true } )
--[[ Vlad Very Hard ]]--
JobMenu:addOption('vlad_veryhard', 'Four Stores', { callback = FourStoresVeryHard, closeMenu = true } )
JobMenu:addOption('vlad_veryhard', 'Mallcrasher', { callback = MallCrasherVeryHard, closeMenu = true } )
JobMenu:addOption('vlad_veryhard', 'Nightclub', { callback = NightclubVeryHard, closeMenu = true } )
JobMenu:addOption('vlad_veryhard', 'Ukrainian Job (Pro)', { callback = UkrainianJobPROVeryHard, closeMenu = true } )
--[[ Escape Very Hard ]]--
JobMenu:addOption('escape_veryhard', 'Escape: Cafe', { callback = EscapeCafeVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Cafe (Day)', { callback = EscapeCafeDayVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Park', { callback = EscapeParkVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Park (Day)', { callback = EscapeParkDayVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Overpass', { callback = EscapeOverPassVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Overpass (Night)', { callback = EscapeOverPassNightVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Street', { callback = EscapeStreetVeryHard, closeMenu = true } )
JobMenu:addOption('escape_veryhard', 'Escape: Park', { callback = EscapeGarageVeryHard, closeMenu = true } )


--[[ Bain Overkill ]]--
JobMenu:addInformationOption('bain_overkill', '.:: Main ::.')
JobMenu:addOption('bain_overkill', 'Jewelry Store', { callback = JewelryStoreOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Bank Heist: Cash', { callback = BankCashOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Bank Heist: Deposit', { callback = BankDepositOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Diamond Store', { callback = DiamondStoreOverKill, closeMenu = true } )
JobMenu:addGap('bain_overkill')
JobMenu:addOption('bain_overkill', 'Bank Heist: Gold (Pro)', { callback = BankGoldPROOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Bank Heist (Pro)', { callback = BankPROOverKill, closeMenu = true } )
JobMenu:addGap('bain_overkill')
JobMenu:addGap('bain_overkill')
JobMenu:addInformationOption('bain_overkill', '.:: DLC ::.')
JobMenu:addOption('bain_overkill', 'Transport: Crossroads', { callback = TransportCrossRoadsOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Transport: Downtown', { callback = TransportDownTownOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Transport: Harbour', { callback = TransportHarbourOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Transport: Underpass', { callback = TransportUnderPassOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Transport: Park', { callback = TransportParkOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Train Heist', { callback = TrainHeistOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'GO Bank', { callback = GOBankOverKill, closeMenu = true } )
JobMenu:addOption('bain_overkill', 'Shadow Raid', { callback = ShadowRaidOverKill, closeMenu = true } )
--[[ Dentist Overkill ]]--
JobMenu:addOption('dentist_overkill', 'The Big Bank', { callback = BigBankOverKill, closeMenu = true } )
JobMenu:addGap('dentist_overkill')
JobMenu:addOption('dentist_overkill', 'Hotline Miami: Day 1', { callback = HotlineMiamiDay1OverKill, closeMenu = true } )
JobMenu:addOption('dentist_overkill', 'Hotline Miami: Day 2', { callback = HotlineMiamiDay2OverKill, closeMenu = true } )
JobMenu:addGap('dentist_overkill')
JobMenu:addOption('dentist_overkill', 'Hotline Miami: Day 1 (Pro)', { callback = HotlineMiamiPRODay1OverKill, closeMenu = true } )
JobMenu:addOption('dentist_overkill', 'Hotline Miami: Day 2 (Pro)', { callback = HotlineMiamiPRODay2OverKill, closeMenu = true } )
--[[ Hector Overkill ]]--
JobMenu:addOption('hector_overkill', 'Watchdogs: Day 1', { callback = WatchdogsDay1OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Watchdogs: Day 2', { callback = WatchdogsDay2OverKill, closeMenu = true } )
JobMenu:addGap('hector_overkill')
JobMenu:addOption('hector_overkill', 'Fire Starter: Day 1', { callback = FireStarterDay1OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Fire Starter: Day 2', { callback = FireStarterDay2OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Fire Starter: Day 3', { callback = FireStarterDay3OverKill, closeMenu = true } )
JobMenu:addGap('hector_overkill')
JobMenu:addOption('hector_overkill', 'Rats: Day 1', { callback = RatsDay1OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Rats: Day 2', { callback = RatsDay2OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Rats: Day 3', { callback = RatsDay3OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2OverKill, closeMenu = true } )
JobMenu:addGap('hector_overkill')
JobMenu:addOption('hector_overkill', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3OverKill, closeMenu = true } )
JobMenu:addGap('hector_overkill')
JobMenu:addOption('hector_overkill', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2OverKill, closeMenu = true } )
JobMenu:addOption('hector_overkill', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3OverKill, closeMenu = true } )
--[[ Elephant Overkill ]]--
JobMenu:addOption('elephant_overkill', 'Framing Frame: Day 1', { callback = FramingFrameDay1OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Framing Frame: Day 2', { callback = FramingFrameDay2OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Framing Frame: Day 3', { callback = FramingFrameDay3OverKill, closeMenu = true } )
JobMenu:addGap('elephant_overkill')
JobMenu:addOption('elephant_overkill', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3OverKill, closeMenu = true } )
JobMenu:addGap('elephant_overkill')
JobMenu:addGap('elephant_overkill')
JobMenu:addGap('elephant_overkill')
JobMenu:addOption('elephant_overkill', 'Election Day: Day 1', { callback = ElectionDayDay1OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Election Day: Day 2', { callback = ElectionDayDay2OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Election Day: Day 3', { callback = ElectionDayDay3OverKill, closeMenu = true } )
JobMenu:addGap('elephant_overkill')
JobMenu:addOption('elephant_overkill', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3OverKill, closeMenu = true } )
JobMenu:addGap('elephant_overkill')
JobMenu:addGap('elephant_overkill')
JobMenu:addGap('elephant_overkill')
JobMenu:addOption('elephant_overkill', 'Big Oil: Day 1 (Pro)', { callback = BigOilPRODay1OverKill, closeMenu = true } )
JobMenu:addOption('elephant_overkill', 'Big Oil: Day 2 (Pro)', { callback = BigOilPRODay2OverKill, closeMenu = true } )
--[[ Vlad Overkill ]]--
JobMenu:addOption('vlad_overkill', 'Four Stores', { callback = FourStoresOverKill, closeMenu = true } )
JobMenu:addOption('vlad_overkill', 'Mallcrasher', { callback = MallCrasherOverKill, closeMenu = true } )
JobMenu:addOption('vlad_overkill', 'Nightclub', { callback = NightclubOverKill, closeMenu = true } )
JobMenu:addOption('vlad_overkill', 'Ukrainian Job (Pro)', { callback = UkrainianJobPROOverKill, closeMenu = true } )
--[[ Escape Overkill ]]--
JobMenu:addOption('escape_overkill', 'Escape: Cafe', { callback = EscapeCafeOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Cafe (Day)', { callback = EscapeCafeDayOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Park', { callback = EscapeParkOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Park (Day)', { callback = EscapeParkDayOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Overpass', { callback = EscapeOverPassOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Overpass (Night)', { callback = EscapeOverPassNightOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Street', { callback = EscapeStreetOverKill, closeMenu = true } )
JobMenu:addOption('escape_overkill', 'Escape: Park', { callback = EscapeGarageOverKill, closeMenu = true } )

--[[ Bain Deathwish ]]--
JobMenu:addInformationOption('bain_deathwish', '.:: Main ::.')
JobMenu:addOption('bain_deathwish', 'Jewelry Store', { callback = JewelryStoreDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Bank Heist: Cash', { callback = BankCashDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Bank Heist: Deposit', { callback = BankDepositDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Diamond Store', { callback = DiamondStoreDeathWish, closeMenu = true } )
JobMenu:addGap('bain_deathwish')
JobMenu:addOption('bain_deathwish', 'Bank Heist: Gold (Pro)', { callback = BankGoldPRODeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Bank Heist (Pro)', { callback = BankPRODeathWish, closeMenu = true } )
JobMenu:addGap('bain_deathwish')
JobMenu:addGap('bain_deathwish')
JobMenu:addInformationOption('bain_deathwish', '.:: DLC ::.')
JobMenu:addOption('bain_deathwish', 'Transport: Crossroads', { callback = TransportCrossRoadsDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Transport: Downtown', { callback = TransportDownTownDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Transport: Harbour', { callback = TransportHarbourDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Transport: Underpass', { callback = TransportUnderPassDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Transport: Park', { callback = TransportParkDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Train Heist', { callback = TrainHeistDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'GO Bank', { callback = GOBankDeathWish, closeMenu = true } )
JobMenu:addOption('bain_deathwish', 'Shadow Raid', { callback = ShadowRaidDeathWish, closeMenu = true } )
--[[ Dentist Deathwish ]]--
JobMenu:addOption('dentist_deathwish', 'The Big Bank', { callback = BigBankDeathWish, closeMenu = true } )
JobMenu:addGap('dentist_deathwish')
JobMenu:addOption('dentist_deathwish', 'Hotline Miami: Day 1', { callback = HotlineMiamiDay1DeathWish, closeMenu = true } )
JobMenu:addOption('dentist_deathwish', 'Hotline Miami: Day 2', { callback = HotlineMiamiDay2DeathWish, closeMenu = true } )
JobMenu:addGap('dentist_deathwish')
JobMenu:addOption('dentist_deathwish', 'Hotline Miami: Day 1 (Pro)', { callback = HotlineMiamiPRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('dentist_deathwish', 'Hotline Miami: Day 2 (Pro)', { callback = HotlineMiamiPRODay2DeathWish, closeMenu = true } )
--[[ Hector Deathwish ]]--
JobMenu:addOption('hector_deathwish', 'Watchdogs: Day 1', { callback = WatchdogsDay1DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Watchdogs: Day 2', { callback = WatchdogsDay2DeathWish, closeMenu = true } )
JobMenu:addGap('hector_deathwish')
JobMenu:addOption('hector_deathwish', 'Fire Starter: Day 1', { callback = FireStarterDay1DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Fire Starter: Day 2', { callback = FireStarterDay2DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Fire Starter: Day 3', { callback = FireStarterDay3DeathWish, closeMenu = true } )
JobMenu:addGap('hector_deathwish')
JobMenu:addOption('hector_deathwish', 'Rats: Day 1', { callback = RatsDay1DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Rats: Day 2', { callback = RatsDay2DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Rats: Day 3', { callback = RatsDay3DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2DeathWish, closeMenu = true } )
JobMenu:addGap('hector_deathwish')
JobMenu:addOption('hector_deathwish', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3DeathWish, closeMenu = true } )
JobMenu:addGap('hector_deathwish')
JobMenu:addOption('hector_deathwish', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2DeathWish, closeMenu = true } )
JobMenu:addOption('hector_deathwish', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3DeathWish, closeMenu = true } )
--[[ Elephant Deathwish ]]--
JobMenu:addOption('elephant_deathwish', 'Framing Frame: Day 1', { callback = FramingFrameDay1DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Framing Frame: Day 2', { callback = FramingFrameDay2DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Framing Frame: Day 3', { callback = FramingFrameDay3DeathWish, closeMenu = true } )
JobMenu:addGap('elephant_deathwish')
JobMenu:addOption('elephant_deathwish', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3DeathWish, closeMenu = true } )
JobMenu:addGap('elephant_deathwish')
JobMenu:addGap('elephant_deathwish')
JobMenu:addGap('elephant_deathwish')
JobMenu:addOption('elephant_deathwish', 'Election Day: Day 1', { callback = ElectionDayDay1DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Election Day: Day 2', { callback = ElectionDayDay2DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Election Day: Day 3', { callback = ElectionDayDay3DeathWish, closeMenu = true } )
JobMenu:addGap('elephant_deathwish')
JobMenu:addOption('elephant_deathwish', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3DeathWish, closeMenu = true } )
JobMenu:addGap('elephant_deathwish')
JobMenu:addGap('elephant_deathwish')
JobMenu:addGap('elephant_deathwish')
JobMenu:addOption('elephant_deathwish', 'Big Oil: Day 1 (Pro)', { callback = BigOilPRODay1DeathWish, closeMenu = true } )
JobMenu:addOption('elephant_deathwish', 'Big Oil: Day 2 (Pro)', { callback = BigOilPRODay2DeathWish, closeMenu = true } )
--[[ Vlad Deathwish ]]--
JobMenu:addOption('vlad_deathwish', 'Four Stores', { callback = FourStoresDeathWish, closeMenu = true } )
JobMenu:addOption('vlad_deathwish', 'Mallcrasher', { callback = MallCrasherDeathWish, closeMenu = true } )
JobMenu:addOption('vlad_deathwish', 'Nightclub', { callback = NightclubDeathWish, closeMenu = true } )
JobMenu:addOption('vlad_deathwish', 'Ukrainian Job (Pro)', { callback = UkrainianJobPRODeathWish, closeMenu = true } )
--[[ Escape Deathwish ]]--
JobMenu:addOption('escape_deathwish', 'Escape: Cafe', { callback = EscapeCafeDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Cafe (Day)', { callback = EscapeCafeDayDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Park', { callback = EscapeParkDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Park (Day)', { callback = EscapeParkDayDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Overpass', { callback = EscapeOverPassDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Overpass (Night)', { callback = EscapeOverPassNightDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Street', { callback = EscapeStreetDeathWish, closeMenu = true } )
JobMenu:addOption('escape_deathwish', 'Escape: Park', { callback = EscapeGarageDeathWish, closeMenu = true } )

--[[ Escape Chain ]]--
JobMenu:addOption('escape_chain', 'Escape: Cafe', { callback = EscapeCafeChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Cafe (Day)', { callback = EscapeCafeDayChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Park', { callback = EscapeParkChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Park (Day)', { callback = EscapeParkDayChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Overpass', { callback = EscapeOverPassChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Overpass (Night)', { callback = EscapeOverPassNightChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Street', { callback = EscapeStreetChain, closeMenu = true } )
JobMenu:addOption('escape_chain', 'Escape: Park', { callback = EscapeGarageChain, closeMenu = true } )
end

	if JobMenu:isOpen() then
		JobMenu:close()
	else
		JobMenu:open()
	end