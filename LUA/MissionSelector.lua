if tweak_data and tweak_data.SCSuiteConfiguration.mission_selector_enable then
    -- MISSION SELECTOR v0.9 (Stealth Suite) by B1313 (kimimaro edit - all credit to B1313)
    -- SHOW MENU FUNCTION
        show_menu = show_menu or function(menu)
                menu:show()
        end

    FramingFrameDay2CompleterNon_on = not FramingFrameDay2CompleterNon_on

    -- HEAT STRING FUNCTION - by zulu200
    local heat_string = function( o )
        local i_perc    = 100 * (managers.job:heat_to_experience_multiplier( managers.job:_get_job_heat( o ) ) - 1)
        local s_perc    = string.format("%.0f", math.abs(i_perc))
        local s_format     = string.format("  (%s%%%is%%%% H",((i_perc > 0) and "+" or "- "),6-string.len(s_perc))

        local i_perc_s  = 0
        local s_perc_s
        if managers.job:get_ghost_bonus( o ) > 0 then
            i_perc_s    = 100 * managers.job:get_ghost_bonus( o )
            s_perc_s    = string.format("%.0f", math.abs(i_perc_s))
            if i_perc ~= 0 then
                s_format = s_format.."  + "..s_perc_s.."%% S)"
            else
                s_format = "  (+ "..s_perc_s.."%% S)"
            end
        else
                s_format = s_format..")"
        end
        return (i_perc ~= 0 or i_perc_s ~= 0) and (string.format(s_format,s_perc) or string.format(s_format,s_perc_s)) or ""
    end

    -- REWORKED MenuCallbackHandler:start_job(job_data)
    -- Had to change a couple of things to spawn specific days of the jobs
    -- cuse the original function just started jobs from the beginning
    start_job = function(job_data)
        if job_data.current_stage then
            if not managers.job:activate_job(job_data.job_id, job_data.current_stage) then
                return
            end
        else
            if not managers.job:activate_job(job_data.job_id) then
                return
            end
        end
        if job_data.level_id then
            Global.game_settings.level_id = job_data.level_id
        else
            Global.game_settings.level_id = managers.job:current_level_id()
        end
        Global.game_settings.mission = managers.job:current_mission()
        Global.game_settings.world_setting = managers.job:current_world_setting()
        Global.game_settings.difficulty = job_data.difficulty
        local matchmake_attributes = MenuCallbackHandler:get_matchmake_attributes()
        matchmake_attributes.numbers[3] = 2 -- 1 PUBLIC / 2 FRIENDS ONLY / 3 PRIVATE
        matchmake_attributes.numbers[6] = 1 -- ALLOW DROP-IN
        matchmake_attributes.numbers[7] = 0 -- MINIMUM REPUTATION REQUIRED
        if Network:is_server() then
            local job_id_index = tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id())
            local level_id_index = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
            local difficulty_index = tweak_data:difficulty_to_index(Global.game_settings.difficulty)
            managers.network:session():send_to_peers("sync_game_settings", job_id_index, level_id_index, difficulty_index)
            managers.network.matchmake:set_server_attributes(matchmake_attributes)
            managers.menu_component:on_job_updated()
            managers.menu:active_menu().logic:navigate_back(true)
            managers.menu:active_menu().logic:refresh_node("lobby", true)
        else
            managers.network.matchmake:create_lobby(matchmake_attributes)
        end

    end

    -- AUTO-COMPLETE FRAMING FRAME DAY 2
    AutoFramingFrameDay2Completer = function()
    if managers.job:current_level_id() == "framing_frame_2" then
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
        managers.loot:secure( "money", managers.money:get_bag_value( "money" ), true )
            if managers.platform:presence() == "Playing" then 
                local num_winners = managers.network:game():amount_of_alive_players() 
                managers.network:session():send_to_peers( "mission_ended", true, num_winners ) 
                game_state_machine:change_state_by_name( "victoryscreen", { num_winners = num_winners, personal_win = true } ) 
            end
        FramingFrameDay2CompleterNon_on = true
    else
        FramingFrameDay2CompleterNon_on = false
    end
    end
        
    -- ESCAPE CHAIN (Current Difficulty)
    EscapeCafeChain = function()
    managers.job:set_next_interupt_stage( "escape_cafe" )
    show_mid_text( "ON", "Escape Chain: Escape: Cafe", 3,5 )
    end

    EscapeCafeDayChain = function()
    managers.job:set_next_interupt_stage( "escape_cafe_day" )
    show_mid_text( "ON", "Escape Chain: Escape: Cafe (Day)", 3,5 )
    end

    EscapeParkChain = function()
    managers.job:set_next_interupt_stage( "escape_park" )
    show_mid_text( "ON", "Escape Chain: Escape: Park", 3,5 )
    end

    EscapeParkDayChain = function()
    managers.job:set_next_interupt_stage( "escape_park_day" )
    show_mid_text( "ON", "Escape Chain: Escape: Park (Day)", 3,5 )
    end

    EscapeOverPassChain = function()
    managers.job:set_next_interupt_stage( "escape_overpass" )
    show_mid_text( "ON", "Escape Chain: Escape: Overpass", 3,5 )
    end

    EscapeOverPassNightChain = function()
    managers.job:set_next_interupt_stage( "escape_overpass_night" )
    show_mid_text( "ON", "Escape Chain: Escape: Overpass (Night)", 3,5 )
    end

    EscapeStreetChain = function()
    managers.job:set_next_interupt_stage( "escape_street" )
    show_mid_text( "ON", "Escape Chain: Escape: Street", 3,5 )
    end

    EscapeGarageChain = function()
    managers.job:set_next_interupt_stage( "escape_garage" )
    show_mid_text( "ON", "Escape Chain: Escape: Garage", 3,5 )
    end

    -- ESCAPES (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- ESCAPE: GARAGE (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeGarageDeathWish = function()
            local job_data = { 
                job_id = "ukrainian_job",
                level_id = "escape_garage",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeGarageDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_garage" )
    end

    EscapeGarageOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_garage",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeGarageOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_garage" )
    end

    EscapeGarageVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_garage",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeGarageVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_garage" )
    end

    EscapeGarageHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_garage",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeGarageHard2 = function()
    managers.job:set_next_interupt_stage( "escape_garage" )
    end

    EscapeGarageNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_garage",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeGarageNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_garage" )
    end    

    -- ESCAPE: STREET (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeStreetDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_street",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeStreetDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_street" )
    end

    EscapeStreetOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_street",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeStreetOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_street" )
    end

    EscapeStreetVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_street",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeStreetVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_street" )
    end

    EscapeStreetHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_street",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeStreetHard2 = function()
    managers.job:set_next_interupt_stage( "escape_street" )
    end

    EscapeStreetNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_street",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeStreetNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_street" )
    end
        
    -- ESCAPE: OVERPASS (NIGHT) (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeOverPassNightDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass_night",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeOverPassNightDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass_night" )
    end

    EscapeOverPassNightOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass_night",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeOverPassNightOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass_night" )
    end

    EscapeOverPassNightVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass_night",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeOverPassNightVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass_night" )
    end

    EscapeOverPassNightHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass_night",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeOverPassNightHard2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass_night" )
    end

    EscapeOverPassNightNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass_night",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeOverPassNightNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass_night" )
    end
        
    -- ESCAPE: OVERPASS (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeOverPassDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeOverPassDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass" )
    end

    EscapeOverPassOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeOverPassOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass" )
    end

    EscapeOverPassVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeOverPassVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass" )
    end

    EscapeOverPassHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeOverPassHard2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass" )
    end

    EscapeOverPassNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                level_id = "escape_overpass",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeOverPassNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_overpass" )
    end    
        
    -- ESCAPE: PARK (DAY) (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeParkDayDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeParkDayDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_park_day" )
    end

    EscapeParkDayOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeParkDayOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_park_day" )
    end

    EscapeParkDayVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeParkDayVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_park_day" )
    end

    EscapeParkDayHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeParkDayHard2 = function()
    managers.job:set_next_interupt_stage( "escape_park_day" )
    end

    EscapeParkDayNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeParkDayNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_park_day" )
    end    
        
    -- ESCAPE: PARK (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeParkDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeParkDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_park" )
    end

    EscapeParkOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeParkOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_park" )
    end

    EscapeParkVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeParkVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_park" )
    end

    EscapeParkHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeParkHard2 = function()
    managers.job:set_next_interupt_stage( "escape_park" )
    end

    EscapeParkNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeParkNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_park" )
    end    

    -- ESCAPE: CAFE (DAY) (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeCafeDayDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeCafeDayDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe_day" )
    end

    EscapeCafeDayOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeCafeDayOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe_day" )
    end

    EscapeCafeDayVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeCafeDayVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe_day" )
    end

    EscapeCafeDayHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeCafeDayHard2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe_day" )
    end

    EscapeCafeDayNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeCafeDayNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe_day" )
    end
        
    -- ESCAPE: CAFE (Normal, Hard, Very Hard, OverKill, and DeathWish)
    EscapeCafeDeathWish = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end
    EscapeCafeDeathWish2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe" )
    end

    EscapeCafeOverKill = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end
    EscapeCafeOverKill2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe" )
    end

    EscapeCafeVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "overkill"
            }
            start_job(job_data)
        end
    EscapeCafeVeryHard2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe" )
    end

    EscapeCafeHard = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "hard"
            }
            start_job(job_data)
        end
    EscapeCafeHard2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe" )
    end

    EscapeCafeNormal = function()
            local job_data = {
                job_id = "ukrainian_job",
                difficulty = "normal"
            }
            start_job(job_data)
        end
    EscapeCafeNormal2 = function()
    managers.job:set_next_interupt_stage( "escape_cafe" )
    end
        
    -- VLAD (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- UKRAINIAN JOB PRO JOB (Hard, Very Hard, OverKill, and DeathWish)
    UkrainianJobPRODeathWish = function()
            local job_data = {
                job_id = "ukrainian_job_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    UkrainianJobPROOverKill = function()
            local job_data = {
                job_id = "ukrainian_job_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    UkrainianJobPROVeryHard = function()
            local job_data = {
                job_id = "ukrainian_job_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    UkrainianJobPROHard = function()
            local job_data = {
                job_id = "ukrainian_job_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- NIGHTCLUB (Normal, Hard, Very Hard, OverKill, and DeathWish)
    NightclubDeathWish = function()
            local job_data = {
                job_id = "nightclub",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    NightclubOverKill = function()
            local job_data = {
                job_id = "nightclub",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    NightclubVeryHard = function()
            local job_data = {
                job_id = "nightclub",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    NightclubHard = function()
            local job_data = {
                job_id = "nightclub",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    NightclubNormal = function()
            local job_data = { 
                job_id = "nightclub",
                difficulty = "normal"
            }
            start_job(job_data)
            Global.game_settings.permission = 2
            Global.game_settings.reputation_permission = 0
            Global.game_settings.drop_in_allowed = 1
        end

    -- MALLCRASHER (Normal, Hard, Very Hard, OverKill, and DeathWish)
    MallCrasherDeathWish = function()
            local job_data = { 
                job_id = "mallcrasher", 
                difficulty = "overkill_290" 
            }
            start_job(job_data)
        end

    MallCrasherOverKill = function()
            local job_data = {
                job_id = "mallcrasher",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    MallCrasherVeryHard = function()
            local job_data = {
                job_id = "mallcrasher",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    MallCrasherHard = function()
            local job_data = {
                job_id = "mallcrasher",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    MallCrasherNormal = function()
            local job_data = {
                job_id = "mallcrasher",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- FOUR STORES (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FourStoresDeathWish = function()
            local job_data = {
                job_id = "four_stores",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    FourStoresOverKill = function()
            local job_data = {
                job_id = "four_stores",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    FourStoresVeryHard = function()
            local job_data = {
                job_id = "four_stores",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    FourStoresHard = function()
            local job_data = {
                job_id = "four_stores",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    FourStoresNormal = function()
            local job_data = {
                job_id = "four_stores",
                difficulty = "normal"
            }
            start_job(job_data)
        end


    -- THE ELEPHANT (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- ELECTION DAY PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
    ElectionDayPRODay3DeathWish = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_3",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayPRODay3OverKill = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_3",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayPRODay3VeryHard = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_3",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayPRODay3Hard = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_3",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- ELECTION DAY PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
    ElectionDayPRODay2DeathWish = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_2",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayPRODay2OverKill = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_2",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayPRODay2VeryHard = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_2",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayPRODay2Hard = function()
            local job_data = { 
                job_id = "election_day_prof",
                level_id = "election_day_2",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- ELECTION DAY PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
    ElectionDayPRODay1DeathWish = function()
            local job_data = {
                job_id = "election_day_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    ElectionDayPRODay1OverKill = function()
            local job_data = {
                job_id = "election_day_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    ElectionDayPRODay1VeryHard = function()
            local job_data = {
                job_id = "election_day_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    ElectionDayPRODay1Hard = function()
            local job_data = {
                job_id = "election_day_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- BIG OIL PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
    BigOilPRODay2DeathWish = function()
            local job_data = { 
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    BigOilPRODay2OverKill = function()
            local job_data = { 
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    BigOilPRODay2VeryHard = function()
            local job_data = { 
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    BigOilPRODay2Hard = function()
            local job_data = { 
                job_id = "welcome_to_the_jungle_prof",
                level_id = "welcome_to_the_jungle_2",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- BIG OIL PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
    BigOilPRODay1DeathWish = function()
            local job_data = {
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    BigOilPRODay1OverKill = function()
            local job_data = {
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    BigOilPRODay1VeryHard = function()
            local job_data = {
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    BigOilPRODay1Hard = function()
            local job_data = {
                job_id = "welcome_to_the_jungle_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- FRAMING FRAME PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
    FramingFramePRODay3DeathWish = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "overkill_290", 
                current_stage = 3
            }
            start_job(job_data)
        end

    FramingFramePRODay3OverKill = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "overkill_145",
                current_stage = 3
            }
            start_job(job_data)
        end

    FramingFramePRODay3VeryHard = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "overkill",
                current_stage = 3
            }
            start_job(job_data)
        end

    FramingFramePRODay3Hard = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "hard",
                current_stage = 3
            }
            start_job(job_data)
        end

    -- FRAMING FRAME PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
    FramingFramePRODay2DeathWish = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    FramingFramePRODay2OverKill = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    FramingFramePRODay2VeryHard = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    FramingFramePRODay2Hard = function()
            local job_data = { 
                job_id = "framing_frame_prof",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- FRAMING FRAME PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
    FramingFramePRODay1DeathWish = function()
            local job_data = {
                job_id = "framing_frame_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    FramingFramePRODay1OverKill = function()
            local job_data = {
                job_id = "framing_frame_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    FramingFramePRODay1VeryHard = function()
            local job_data = {
                job_id = "framing_frame_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    FramingFramePRODay1Hard = function()
            local job_data = {
                job_id = "framing_frame_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- ELECTION DAY DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    ElectionDayDay3DeathWish = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_3",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayDay3OverKill = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_3",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayDay3VeryHard = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_3",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayDay3Hard = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_3",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end
        
    ElectionDayDay3Normal = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_3",
                difficulty = "normal",
                current_stage = 2
            }
            start_job(job_data)
        end    
        
    -- ELECTION DAY DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    ElectionDayDay2DeathWish = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_2",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayDay2OverKill = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_2",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayDay2VeryHard = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_2",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    ElectionDayDay2Hard = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_2",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end
        
    ElectionDayDay2Normal = function()
            local job_data = { 
                job_id = "election_day",
                level_id = "election_day_2",
                difficulty = "normal",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- ELECTION DAY DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    ElectionDayDay1DeathWish = function()
            local job_data = {
                job_id = "election_day",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    ElectionDayDay1OverKill = function()
            local job_data = {
                job_id = "election_day",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    ElectionDayDay1VeryHard = function()
            local job_data = {
                job_id = "election_day",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    ElectionDayDay1Hard = function()
            local job_data = {
                job_id = "election_day",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    ElectionDayDay1Normal = function()
            local job_data = {
                job_id = "election_day",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- FRAMING FRAME DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FramingFrameDay3DeathWish = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "overkill_290",
                current_stage = 3
            }
            start_job(job_data)
        end

    FramingFrameDay3OverKill = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "overkill_145",
                current_stage = 3
            }
            start_job(job_data)
        end

    FramingFrameDay3VeryHard = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "overkill",
                current_stage = 3
            }
            start_job(job_data)
        end

    FramingFrameDay3Hard = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "hard",
                current_stage = 3
            }
            start_job(job_data)
        end
        
    FramingFrameDay3Normal = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "normal",
                current_stage = 3
            }
            start_job(job_data)
        end

    -- FRAMING FRAME DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FramingFrameDay2DeathWish = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    FramingFrameDay2OverKill = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    FramingFrameDay2VeryHard = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    FramingFrameDay2Hard = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end
        
    FramingFrameDay2Normal = function()
            local job_data = { 
                job_id = "framing_frame",
                difficulty = "normal",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- FRAMING FRAME DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FramingFrameDay1DeathWish = function()
            local job_data = {
                job_id = "framing_frame",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    FramingFrameDay1OverKill = function()
            local job_data = {
                job_id = "framing_frame",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    FramingFrameDay1VeryHard = function()
            local job_data = {
                job_id = "framing_frame",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    FramingFrameDay1Hard = function()
            local job_data = {
                job_id = "framing_frame",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    FramingFrameDay1Normal = function()
            local job_data = {
                job_id = "framing_frame",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- HECTOR (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- RATS PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
    RatsPRODay3DeathWish = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "overkill_290",
                current_stage = 3
            }
            start_job(job_data)
        end

    RatsPRODay3OverKill = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "overkill_145",
                current_stage = 3
            }
            start_job(job_data)
        end

    RatsPRODay3VeryHard = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "overkill",
                current_stage = 3
            }
            start_job(job_data)
        end

    RatsPRODay3Hard = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "hard",
                current_stage = 3
            }
            start_job(job_data)
        end

    -- RATS PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
    RatsPRODay2DeathWish = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    RatsPRODay2OverKill = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    RatsPRODay2VeryHard = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    RatsPRODay2Hard = function()
            local job_data = { 
                job_id = "alex_prof",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- RATS PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
    RatsPRODay1DeathWish = function()
            local job_data = {
                job_id = "alex_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    RatsPRODay1OverKill = function()
            local job_data = {
                job_id = "alex_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    RatsPRODay1VeryHard = function()
            local job_data = {
                job_id = "alex_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    RatsPRODay1Hard = function()
            local job_data = {
                job_id = "alex_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- FIRESTARTER PRO JOB DAY 3 (Hard, Very Hard, OverKill, and DeathWish)
    FireStarterPRODay3DeathWish = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "overkill_290",
                current_stage = 3
            }
            start_job(job_data)
        end

    FireStarterPRODay3OverKill = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "overkill_145",
                current_stage = 3
            }
            start_job(job_data)
        end

    FireStarterPRODay3VeryHard = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "overkill",
                current_stage = 3
            }
            start_job(job_data)
        end

    FireStarterPRODay3Hard = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "hard",
                current_stage = 3
            }
            start_job(job_data)
        end

    -- FIRESTARTER PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
    FireStarterPRODay2DeathWish = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    FireStarterPRODay2OverKill = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    FireStarterPRODay2VeryHard = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    FireStarterPRODay2Hard = function()
            local job_data = { 
                job_id = "firestarter_prof",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- FIRESTARTER PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
    FireStarterPRODay1DeathWish = function()
            local job_data = {
                job_id = "firestarter_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    FireStarterPRODay1OverKill = function()
            local job_data = {
                job_id = "firestarter_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    FireStarterPRODay1VeryHard = function()
            local job_data = {
                job_id = "firestarter_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    FireStarterPRODay1Hard = function()
            local job_data = {
                job_id = "firestarter_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- WATCHDOGS PRO JOB DAY 2 (Hard, Very Hard, OverKill, and DeathWish)
    WatchdogsPRODay2DeathWish = function()
            local job_data = { 
                job_id = "watchdogs_prof",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    WatchdogsPRODay2OverKill = function()
            local job_data = { 
                job_id = "watchdogs_prof",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    WatchdogsPRODay2VeryHard = function()
            local job_data = { 
                job_id = "watchdogs_prof",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    WatchdogsPRODay2Hard = function()
            local job_data = { 
                job_id = "watchdogs_prof",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- WATCHDOGS PRO JOB DAY 1 (Hard, Very Hard, OverKill, and DeathWish)
    WatchdogsPRODay1DeathWish = function()
            local job_data = {
                job_id = "watchdogs_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    WatchdogsPRODay1OverKill = function()
            local job_data = {
                job_id = "watchdogs_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    WatchdogsPRODay1VeryHard = function()
            local job_data = {
                job_id = "watchdogs_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    WatchdogsPRODay1Hard = function()
            local job_data = {
                job_id = "watchdogs_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end


    -- RATS DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    RatsDay3DeathWish = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "overkill_290",
                current_stage = 3
            }
            start_job(job_data)
        end

    RatsDay3OverKill = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "overkill_145",
                current_stage = 3
            }
            start_job(job_data)
        end

    RatsDay3VeryHard = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "overkill",
                current_stage = 3
            }
            start_job(job_data)
        end

    RatsDay3Hard = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "hard",
                current_stage = 3
            }
            start_job(job_data)
        end
        
    RatsDay3Normal = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "normal",
                current_stage = 3
            }
            start_job(job_data)
        end

    -- RATS DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    RatsDay2DeathWish = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    RatsDay2OverKill = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    RatsDay2VeryHard = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    RatsDay2Hard = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end
        
    RatsDay2Normal = function()
            local job_data = { 
                job_id = "alex",
                difficulty = "normal",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- RATS DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    RatsDay1DeathWish = function()
            local job_data = {
                job_id = "alex",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    RatsDay1OverKill = function()
            local job_data = {
                job_id = "alex",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    RatsDay1VeryHard = function()
            local job_data = {
                job_id = "alex",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    RatsDay1Hard = function()
            local job_data = {
                job_id = "alex",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    RatsDay1Normal = function()
            local job_data = {
                job_id = "alex",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- FIRESTARTER DAY 3 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FireStarterDay3DeathWish = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "overkill_290",
                current_stage = 3
            }
            start_job(job_data)
        end

    FireStarterDay3OverKill = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "overkill_145",
                current_stage = 3
            }
            start_job(job_data)
        end

    FireStarterDay3VeryHard = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "overkill",
                current_stage = 3
            }
            start_job(job_data)
        end

    FireStarterDay3Hard = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "hard",
                current_stage = 3
            }
            start_job(job_data)
        end
        
    FireStarterDay3Normal = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "normal",
                current_stage = 3
            }
            start_job(job_data)
        end

    -- FIRESTARTER DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FireStarterDay2DeathWish = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    FireStarterDay2OverKill = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    FireStarterDay2VeryHard = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    FireStarterDay2Hard = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end
        
    FireStarterDay2Normal = function()
            local job_data = { 
                job_id = "firestarter",
                difficulty = "normal",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- FIRESTARTER DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    FireStarterDay1DeathWish = function()
            local job_data = {
                job_id = "firestarter",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    FireStarterDay1OverKill = function()
            local job_data = {
                job_id = "firestarter",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    FireStarterDay1VeryHard = function()
            local job_data = {
                job_id = "firestarter",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    FireStarterDay1Hard = function()
            local job_data = {
                job_id = "firestarter",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    FireStarterDay1Normal = function()
            local job_data = {
                job_id = "firestarter",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- WATCHDOGS DAY 2 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    WatchdogsDay2DeathWish = function()
            local job_data = { 
                job_id = "watchdogs",
                difficulty = "overkill_290",
                current_stage = 2
            }
            start_job(job_data)
        end

    WatchdogsDay2OverKill = function()
            local job_data = { 
                job_id = "watchdogs",
                difficulty = "overkill_145",
                current_stage = 2
            }
            start_job(job_data)
        end

    WatchdogsDay2VeryHard = function()
            local job_data = { 
                job_id = "watchdogs",
                difficulty = "overkill",
                current_stage = 2
            }
            start_job(job_data)
        end

    WatchdogsDay2Hard = function()
            local job_data = { 
                job_id = "watchdogs",
                difficulty = "hard",
                current_stage = 2
            }
            start_job(job_data)
        end
        
    WatchdogsDay2Normal = function()
            local job_data = { 
                job_id = "watchdogs",
                difficulty = "normal",
                current_stage = 2
            }
            start_job(job_data)
        end

    -- WATCHDOGS DAY 1 (Normal, Hard, Very Hard, OverKill, and DeathWish)
    WatchdogsDay1DeathWish = function()
            local job_data = {
                job_id = "watchdogs",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    WatchdogsDay1OverKill = function()
            local job_data = {
                job_id = "watchdogs",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    WatchdogsDay1VeryHard = function()
            local job_data = {
                job_id = "watchdogs",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    WatchdogsDay1Hard = function()
            local job_data = {
                job_id = "watchdogs",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    WatchdogsDay1Normal = function()
            local job_data = {
                job_id = "watchdogs",
                difficulty = "normal"
            }
            start_job(job_data)
        end
        
    -- THE DENTIST (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- THE BIG BANK (Normal, Hard, Very Hard, OverKill, and DeathWish)
    BigBankDeathWish = function()
            local job_data = {
                job_id = "big",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    BigBankOverKill = function()
            local job_data = {
                job_id = "big",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    BigBankVeryHard = function()
            local job_data = {
                job_id = "big",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    BigBankHard = function()
            local job_data = {
                job_id = "big",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    BigBankNormal = function()
            local job_data = {
                job_id = "big",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- BAIN DLC (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- SHADOW RAID (Normal, Hard, Very Hard, OverKill, and DeathWish)
    ShadowRaidDeathWish = function()
            local job_data = {
                job_id = "kosugi",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    ShadowRaidOverKill = function()
            local job_data = {
                job_id = "kosugi",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    ShadowRaidVeryHard = function()
            local job_data = {
                job_id = "kosugi",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    ShadowRaidHard = function()
            local job_data = {
                job_id = "kosugi",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    ShadowRaidNormal = function()
            local job_data = {
                job_id = "kosugi",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- GO BANK (Normal, Hard, Very Hard, OverKill, and DeathWish)
    GOBankDeathWish = function()
            local job_data = {
                job_id = "roberts",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    GOBankOverKill = function()
            local job_data = {
                job_id = "roberts",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    GOBankVeryHard = function()
            local job_data = {
                job_id = "roberts",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    GOBankHard = function()
            local job_data = {
                job_id = "roberts",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    GOBankNormal = function()
            local job_data = {
                job_id = "roberts",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- ARMORED TRANSPORT: TRAIN HEIST (Normal, Hard, Very Hard, OverKill, and DeathWish)
    TrainHeistDeathWish = function()
            local job_data = {
                job_id = "arm_for",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    TrainHeistOverKill = function()
            local job_data = {
                job_id = "arm_for",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    TrainHeistVeryHard = function()
            local job_data = {
                job_id = "arm_for",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    TrainHeistHard = function()
            local job_data = {
                job_id = "arm_for",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    TrainHeistNormal = function()
            local job_data = {
                job_id = "arm_for",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- ARMORED TRANSPORT: TRANSPORT PARK (Normal, Hard, Very Hard, OverKill, and DeathWish)
    TransportParkDeathWish = function()
            local job_data = {
                job_id = "arm_par",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    TransportParkOverKill = function()
            local job_data = {
                job_id = "arm_par",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    TransportParkVeryHard = function()
            local job_data = {
                job_id = "arm_par",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    TransportParkHard = function()
            local job_data = {
                job_id = "arm_par",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    TransportParkNormal = function()
            local job_data = {
                job_id = "arm_par",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- ARMORED TRANSPORT: TRANSPORT UNDERPASS (Normal, Hard, Very Hard, OverKill, and DeathWish)
    TransportUnderPassDeathWish = function()
            local job_data = {
                job_id = "arm_und",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    TransportUnderPassOverKill = function()
            local job_data = {
                job_id = "arm_und",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    TransportUnderPassVeryHard = function()
            local job_data = {
                job_id = "arm_und",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    TransportUnderPassHard = function()
            local job_data = {
                job_id = "arm_und",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    TransportUnderPassNormal = function()
            local job_data = {
                job_id = "arm_und",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- ARMORED TRANSPORT: TRANSPORT HARBOUR (Normal, Hard, Very Hard, OverKill, and DeathWish)
    TransportHarbourDeathWish = function()
            local job_data = {
                job_id = "arm_fac",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    TransportHarbourOverKill = function()
            local job_data = {
                job_id = "arm_fac",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    TransportHarbourVeryHard = function()
            local job_data = {
                job_id = "arm_fac",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    TransportHarbourHard = function()
            local job_data = {
                job_id = "arm_fac",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    TransportHarbourNormal = function()
            local job_data = {
                job_id = "arm_fac",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- ARMORED TRANSPORT: TRANSPORT DOWNTOWN (Normal, Hard, Very Hard, OverKill, and DeathWish)
    TransportDownTownDeathWish = function()
            local job_data = {
                job_id = "arm_hcm",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    TransportDownTownOverKill = function()
            local job_data = {
                job_id = "arm_hcm",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    TransportDownTownVeryHard = function()
            local job_data = {
                job_id = "arm_hcm",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    TransportDownTownHard = function()
            local job_data = {
                job_id = "arm_hcm",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    TransportDownTownNormal = function()
            local job_data = {
                job_id = "arm_hcm",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- ARMORED TRANSPORT: TRANSPORT CROSSROADS (Normal, Hard, Very Hard, OverKill, and DeathWish)
    TransportCrossRoadsDeathWish = function()
            local job_data = {
                job_id = "arm_cro",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    TransportCrossRoadsOverKill = function()
            local job_data = {
                job_id = "arm_cro",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    TransportCrossRoadsVeryHard = function()
            local job_data = {
                job_id = "arm_cro",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    TransportCrossRoadsHard = function()
            local job_data = {
                job_id = "arm_cro",
                difficulty = "hard"
            }
            start_job(job_data)
        end
        
    TransportCrossRoadsNormal = function()
            local job_data = {
                job_id = "arm_cro",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- BAIN CLASSIC (Normal, Hard, Very Hard, OverKill, and DeathWish)
    -- BANK HEIST: PRO JOB (Hard, Very Hard, OverKill, and DeathWish)
    BankPRODeathWish = function()
            local job_data = {
                job_id = "branchbank_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    BankPROOverKill = function()
            local job_data = {
                job_id = "branchbank_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    BankPROVeryHard = function()
            local job_data = {
                job_id = "branchbank_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    BankPROHard = function()
            local job_data = {
                job_id = "branchbank_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- BANK HEIST: GOLD PRO JOB (Hard, Very Hard, OverKill, and DeathWish)
    BankGoldPRODeathWish = function()
            local job_data = {
                job_id = "branchbank_gold_prof",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    BankGoldPROOverKill = function()
            local job_data = {
                job_id = "branchbank_gold_prof",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    BankGoldPROVeryHard = function()
            local job_data = {
                job_id = "branchbank_gold_prof",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    BankGoldPROHard = function()
            local job_data = {
                job_id = "branchbank_gold_prof",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    -- DIAMOND STORE (Normal, Hard, Very Hard, OverKill, and DeathWish)
    DiamondStoreDeathWish = function()
            local job_data = {
                job_id = "family",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    DiamondStoreOverKill = function()
            local job_data = {
                job_id = "family",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    DiamondStoreVeryHard = function()
            local job_data = {
                job_id = "family",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    DiamondStoreHard = function()
            local job_data = {
                job_id = "family",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    DiamondStoreNormal = function()
            local job_data = {
                job_id = "family",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- BANK HEIST: DEPOSIT (Normal, Hard, Very Hard, OverKill, and DeathWish)
    BankDepositDeathWish = function()
            local job_data = {
                job_id = "branchbank_deposit",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    BankDepositOverKill = function()
            local job_data = {
                job_id = "branchbank_deposit",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    BankDepositVeryHard = function()
            local job_data = {
                job_id = "branchbank_deposit",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    BankDepositHard = function()
            local job_data = {
                job_id = "branchbank_deposit",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    BankDepositNormal = function()
            local job_data = {
                job_id = "branchbank_deposit",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- BANK HEIST: CASH (Normal, Hard, Very Hard, OverKill, and DeathWish)
    BankCashDeathWish = function()
            local job_data = {
                job_id = "branchbank",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    BankCashOverKill = function()
            local job_data = {
                job_id = "branchbank",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    BankCashVeryHard = function()
            local job_data = {
                job_id = "branchbank",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    BankCashHard = function()
            local job_data = {
                job_id = "branchbank",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    BankCashNormal = function()
            local job_data = {
                job_id = "branchbank",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    -- JEWELRY STORE (Normal, Hard, Very Hard, OverKill, and DeathWish)
    JewelryStoreDeathWish = function()
            local job_data = {
                job_id = "jewelry_store",
                difficulty = "overkill_290"
            }
            start_job(job_data)
        end

    JewelryStoreOverKill = function()
            local job_data = {
                job_id = "jewelry_store",
                difficulty = "overkill_145"
            }
            start_job(job_data)
        end

    JewelryStoreVeryHard = function()
            local job_data = {
                job_id = "jewelry_store",
                difficulty = "overkill"
            }
            start_job(job_data)
        end

    JewelryStoreHard = function()
            local job_data = {
                job_id = "jewelry_store",
                difficulty = "hard"
            }
            start_job(job_data)
        end

    JewelryStoreNormal = function()
            local job_data = {
                job_id = "jewelry_store",
                difficulty = "normal"
            }
            start_job(job_data)
        end

    EscapeDeathWish = {
    { text = "Escape: Cafe", callback = EscapeCafeDeathWish },
    { text = "Escape: Cafe (Day)", callback = EscapeCafeDayDeathWish },
    { text = "Escape: Park", callback = EscapeParkDeathWish },
    { text = "Escape: Park (Day)", callback = EscapeParkDayDeathWish },
    { text = "Escape: Overpass", callback = EscapeOverPassDeathWish },
    { text = "Escape: Overpass (Night)", callback = EscapeOverPassNightDeathWish },
    { text = "Escape: Street", callback = EscapeStreetDeathWish },
    { text = "Escape: Garage", callback = EscapeGarageDeathWish },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", EscapeDeathWish)

    EscapeOverKill = {
    { text = "Escape: Cafe", callback = EscapeCafeOverKill },
    { text = "Escape: Cafe (Day)", callback = EscapeCafeDayOverKill },
    { text = "Escape: Park", callback = EscapeParkOverKill },
    { text = "Escape: Park (Day)", callback = EscapeParkDayOverKill },
    { text = "Escape: Overpass", callback = EscapeOverPassOverKill },
    { text = "Escape: Overpass (Night)", callback = EscapeOverPassNightOverKill },
    { text = "Escape: Street", callback = EscapeStreetOverKill },
    { text = "Escape: Garage", callback = EscapeGarageOverKill },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", EscapeOverKill)

    EscapeVeryHard = {
    { text = "Escape: Cafe", callback = EscapeCafeVeryHard },
    { text = "Escape: Cafe (Day)", callback = EscapeCafeDayVeryHard },
    { text = "Escape: Park", callback = EscapeParkVeryHard },
    { text = "Escape: Park (Day)", callback = EscapeParkDayVeryHard },
    { text = "Escape: Overpass", callback = EscapeOverPassVeryHard },
    { text = "Escape: Overpass (Night)", callback = EscapeOverPassNightVeryHard },
    { text = "Escape: Street", callback = EscapeStreetVeryHard },
    { text = "Escape: Garage", callback = EscapeGarageVeryHard },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", EscapeVeryHard)

    EscapeHard = {
    { text = "Escape: Cafe", callback = EscapeCafeHard },
    { text = "Escape: Cafe (Day)", callback = EscapeCafeDayHard },
    { text = "Escape: Park", callback = EscapeParkHard },
    { text = "Escape: Park (Day)", callback = EscapeParkDayHard },
    { text = "Escape: Overpass", callback = EscapeOverPassHard },
    { text = "Escape: Overpass (Night)", callback = EscapeOverPassNightHard },
    { text = "Escape: Street", callback = EscapeStreetHard },
    { text = "Escape: Garage", callback = EscapeGarageHard },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", EscapeHard)

    EscapeNormal = {
    { text = "Escape: Cafe", callback = EscapeCafeNormal },
    { text = "Escape: Cafe (Day)", callback = EscapeCafeDayNormal },
    { text = "Escape: Park", callback = EscapeParkNormal },
    { text = "Escape: Park (Day)", callback = EscapeParkDayNormal },
    { text = "Escape: Overpass", callback = EscapeOverPassNormal },
    { text = "Escape: Overpass (Night)", callback = EscapeOverPassNightNormal },
    { text = "Escape: Street", callback = EscapeStreetNormal },
    { text = "Escape: Garage", callback = EscapeGarageNormal },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", EscapeNormal)
        
    VladDeathWish = {
    { text = "Four Stores" .. heat_string("four_stores"), callback = FourStoresDeathWish },
    { text = "Mallcrasher" .. heat_string("mallcrasher"), callback = MallCrasherDeathWish },
    { text = "Nightclub" .. heat_string("nightclub"), callback = NightclubDeathWish },
    { text = "Ukrainian Job (Pro Job)" .. heat_string("ukrainian_job_prof"), callback = UkrainianJobPRODeathWish },
    { text = "Cancel", is_cancel_button = true},
    }
    VladDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", VladDeathWish)

    VladOverKill = {
    { text = "Four Stores" .. heat_string("four_stores"), callback = FourStoresOverKill },
    { text = "Mallcrasher" .. heat_string("mallcrasher"), callback = MallCrasherOverKill },
    { text = "Nightclub" .. heat_string("nightclub"), callback = NightclubOverKill },
    { text = "Ukrainian Job (Pro Job)" .. heat_string("ukrainian_job_prof"), callback = UkrainianJobPROOverKill },
    { text = "Cancel", is_cancel_button = true},
    }
    VladOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", VladOverKill)

    VladVeryHard = {
    { text = "Four Stores" .. heat_string("four_stores"), callback = FourStoresVeryHard },
    { text = "Mallcrasher" .. heat_string("mallcrasher"), callback = MallCrasherVeryHard },
    { text = "Nightclub" .. heat_string("nightclub"), callback = NightclubVeryHard },
    { text = "Ukrainian Job (Pro Job)" .. heat_string("ukrainian_job_prof"), callback = UkrainianJobPROVeryHard },
    { text = "Cancel", is_cancel_button = true},
    }
    VladVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", VladVeryHard)

    VladHard = {
    { text = "Four Stores" .. heat_string("four_stores"), callback = FourStoresHard },
    { text = "Mallcrasher" .. heat_string("mallcrasher"), callback = MallCrasherHard },
    { text = "Nightclub" .. heat_string("nightclub"), callback = NightclubHard },
    { text = "Ukrainian Job (Pro Job)" .. heat_string("ukrainian_job_prof"), callback = UkrainianJobPROHard },
    { text = "Cancel", is_cancel_button = true},
    }
    VladHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", VladHard)

    VladNormal = {
    { text = "Four Stores" .. heat_string("four_stores"), callback = FourStoresNormal },
    { text = "Mallcrasher" .. heat_string("mallcrasher"), callback = MallCrasherNormal },
    { text = "Nightclub" .. heat_string("nightclub"), callback = NightclubNormal },
    { text = "Cancel", is_cancel_button = true},
    }
    VladNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", VladNormal)

    ElephantDeathWish = {
    { text = "Framing Frame Day 1" .. heat_string("framing_frame"), callback = FramingFrameDay1DeathWish },
    { text = "Framing Frame Day 2" .. heat_string("framing_frame"), callback = FramingFrameDay2DeathWish },
    { text = "Framing Frame Day 3" .. heat_string("framing_frame"), callback = FramingFrameDay3DeathWish },
    { text = "Framing Frame (Pro Job) Day 1" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay1DeathWish },
    { text = "Framing Frame (Pro Job) Day 2" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay2DeathWish },
    { text = "Framing Frame (Pro Job) Day 3" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay3DeathWish },
    { text = "Big Oil (Pro Job) Day 1" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay1DeathWish },
    { text = "Big Oil (Pro Job) Day 2" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay2DeathWish },
    { text = "Election Day Day 1" .. heat_string("election_day"), callback = ElectionDayDay1DeathWish },
    { text = "Election Day Day 2" .. heat_string("election_day"), callback = ElectionDayDay2DeathWish },
    { text = "Election Day Day 3" .. heat_string("election_day"), callback = ElectionDayDay3DeathWish },
    { text = "Election Day (Pro Job) Day 1" .. heat_string("election_day_prof"), callback = ElectionDayPRODay1DeathWish },
    { text = "Election Day (Pro Job) Day 2" .. heat_string("election_day_prof"), callback = ElectionDayPRODay2DeathWish },
    { text = "Election Day (Pro Job) Day 3" .. heat_string("election_day_prof"), callback = ElectionDayPRODay3DeathWish },
    { text = "Cancel", is_cancel_button = true},
    }
    ElephantDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", ElephantDeathWish)

    ElephantOverKill = {
    { text = "Framing Frame Day 1" .. heat_string("framing_frame"), callback = FramingFrameDay1OverKill },
    { text = "Framing Frame Day 2" .. heat_string("framing_frame"), callback = FramingFrameDay2OverKill },
    { text = "Framing Frame Day 3" .. heat_string("framing_frame"), callback = FramingFrameDay3OverKill },
    { text = "Framing Frame (Pro Job) Day 1" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay1OverKill },
    { text = "Framing Frame (Pro Job) Day 2" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay2OverKill },
    { text = "Framing Frame (Pro Job) Day 3" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay3OverKill },
    { text = "Big Oil (Pro Job) Day 1" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay1OverKill },
    { text = "Big Oil (Pro Job) Day 2" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay2OverKill },
    { text = "Election Day Day 1" .. heat_string("election_day"), callback = ElectionDayDay1OverKill },
    { text = "Election Day Day 2" .. heat_string("election_day"), callback = ElectionDayDay2OverKill },
    { text = "Election Day Day 3" .. heat_string("election_day"), callback = ElectionDayDay3OverKill },
    { text = "Election Day (Pro Job) Day 1" .. heat_string("election_day_prof"), callback = ElectionDayPRODay1OverKill },
    { text = "Election Day (Pro Job) Day 2" .. heat_string("election_day_prof"), callback = ElectionDayPRODay2OverKill },
    { text = "Election Day (Pro Job) Day 3" .. heat_string("election_day_prof"), callback = ElectionDayPRODay3OverKill },
    { text = "Cancel", is_cancel_button = true},
    }
    ElephantOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", ElephantOverKill)

    ElephantVeryHard = {
    { text = "Framing Frame Day 1" .. heat_string("framing_frame"), callback = FramingFrameDay1VeryHard },
    { text = "Framing Frame Day 2" .. heat_string("framing_frame"), callback = FramingFrameDay2VeryHard },
    { text = "Framing Frame Day 3" .. heat_string("framing_frame"), callback = FramingFrameDay3VeryHard },
    { text = "Framing Frame (Pro Job) Day 1" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay1VeryHard },
    { text = "Framing Frame (Pro Job) Day 2" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay2VeryHard },
    { text = "Framing Frame (Pro Job) Day 3" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay3VeryHard },
    { text = "Big Oil (Pro Job) Day 1" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay1VeryHard },
    { text = "Big Oil (Pro Job) Day 2" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay2VeryHard },
    { text = "Election Day Day 1" .. heat_string("election_day"), callback = ElectionDayDay1VeryHard },
    { text = "Election Day Day 2" .. heat_string("election_day"), callback = ElectionDayDay2VeryHard },
    { text = "Election Day Day 3" .. heat_string("election_day"), callback = ElectionDayDay3VeryHard },
    { text = "Election Day (Pro Job) Day 1" .. heat_string("election_day_prof"), callback = ElectionDayPRODay1VeryHard },
    { text = "Election Day (Pro Job) Day 2" .. heat_string("election_day_prof"), callback = ElectionDayPRODay2VeryHard },
    { text = "Election Day (Pro Job) Day 3" .. heat_string("election_day_prof"), callback = ElectionDayPRODay3VeryHard },
    { text = "Cancel", is_cancel_button = true},
    }
    ElephantVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", ElephantVeryHard)

    ElephantHard = {
    { text = "Framing Frame Day 1" .. heat_string("framing_frame"), callback = FramingFrameDay1Hard },
    { text = "Framing Frame Day 2" .. heat_string("framing_frame"), callback = FramingFrameDay2Hard },
    { text = "Framing Frame Day 3" .. heat_string("framing_frame"), callback = FramingFrameDay3Hard },
    { text = "Framing Frame (Pro Job) Day 1" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay1Hard },
    { text = "Framing Frame (Pro Job) Day 2" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay2Hard },
    { text = "Framing Frame (Pro Job) Day 3" .. heat_string("framing_frame_prof"), callback = FramingFramePRODay3Hard },
    { text = "Big Oil (Pro Job) Day 1" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay1Hard },
    { text = "Big Oil (Pro Job) Day 2" .. heat_string("welcome_to_the_jungle_prof"), callback = BigOilPRODay2Hard },
    { text = "Election Day Day 1" .. heat_string("election_day"), callback = ElectionDayDay1Hard },
    { text = "Election Day Day 2" .. heat_string("election_day"), callback = ElectionDayDay2Hard },
    { text = "Election Day Day 3" .. heat_string("election_day"), callback = ElectionDayDay3Hard },
    { text = "Election Day (Pro Job) Day 1" .. heat_string("election_day_prof"), callback = ElectionDayPRODay1Hard },
    { text = "Election Day (Pro Job) Day 2" .. heat_string("election_day_prof"), callback = ElectionDayPRODay2Hard },
    { text = "Election Day (Pro Job) Day 3" .. heat_string("election_day_prof"), callback = ElectionDayPRODay3Hard },
    { text = "Cancel", is_cancel_button = true},
    }
    ElephantHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", ElephantHard)

    ElephantNormal = {
    { text = "Framing Frame Day 1" .. heat_string("framing_frame"), callback = FramingFrameDay1Normal },
    { text = "Framing Frame Day 2" .. heat_string("framing_frame"), callback = FramingFrameDay2Normal },
    { text = "Framing Frame Day 3" .. heat_string("framing_frame"), callback = FramingFrameDay3Normal },
    { text = "Election Day Day 1" .. heat_string("election_day"), callback = ElectionDayDay1Normal },
    { text = "Election Day Day 2" .. heat_string("election_day"), callback = ElectionDayDay2Normal },
    { text = "Election Day Day 3" .. heat_string("election_day"), callback = ElectionDayDay3Normal },
    { text = "Cancel", is_cancel_button = true},
    }
    ElephantNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", ElephantNormal)

    HectorDeathWish = {
    { text = "Watchdogs Day 1" .. heat_string("watchdogs"), callback = WatchdogsDay1DeathWish },
    { text = "Watchdogs Day 2" .. heat_string("watchdogs"), callback = WatchdogsDay2DeathWish },
    { text = "Fire Starter Day 1" .. heat_string("firestarter"), callback = FireStarterDay1DeathWish },
    { text = "Fire Starter Day 2" .. heat_string("firestarter"), callback = FireStarterDay2DeathWish },
    { text = "Fire Starter Day 3" .. heat_string("firestarter"), callback = FireStarterDay3DeathWish },
    { text = "Rats Day 1" .. heat_string("alex"), callback = RatsDay1DeathWish },
    { text = "Rats Day 2" .. heat_string("alex"), callback = RatsDay2DeathWish },
    { text = "Rats Day 3" .. heat_string("alex"), callback = RatsDay3DeathWish },
    { text = "Watchdogs (Pro Job) Day 1" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay1DeathWish },
    { text = "Watchdogs (Pro Job) Day 2" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay2DeathWish },
    { text = "Fire Starter (Pro Job) Day 1" .. heat_string("firestarter_prof"), callback = FireStarterPRODay1DeathWish },
    { text = "Fire Starter (Pro Job) Day 2" .. heat_string("firestarter_prof"), callback = FireStarterPRODay2DeathWish },
    { text = "Fire Starter (Pro Job) Day 3" .. heat_string("firestarter_prof"), callback = FireStarterPRODay3DeathWish },
    { text = "Rats (Pro Job) Day 1" .. heat_string("alex_prof"), callback = RatsPRODay1DeathWish },
    { text = "Rats (Pro Job) Day 2" .. heat_string("alex_prof"), callback = RatsPRODay2DeathWish },
    { text = "Rats (Pro Job) Day 3" .. heat_string("alex_prof"), callback = RatsPRODay3DeathWish },
    { text = "Cancel", is_cancel_button = true},
    }
    HectorDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", HectorDeathWish)

    HectorOverKill = {
    { text = "Watchdogs Day 1" .. heat_string("watchdogs"), callback = WatchdogsDay1OverKill },
    { text = "Watchdogs Day 2" .. heat_string("watchdogs"), callback = WatchdogsDay2OverKill },
    { text = "Fire Starter Day 1" .. heat_string("firestarter"), callback = FireStarterDay1OverKill },
    { text = "Fire Starter Day 2" .. heat_string("firestarter"), callback = FireStarterDay2OverKill },
    { text = "Fire Starter Day 3" .. heat_string("firestarter"), callback = FireStarterDay3OverKill },
    { text = "Rats Day 1" .. heat_string("alex"), callback = RatsDay1OverKill },
    { text = "Rats Day 2" .. heat_string("alex"), callback = RatsDay2OverKill },
    { text = "Rats Day 3" .. heat_string("alex"), callback = RatsDay3OverKill },
    { text = "Watchdogs (Pro Job) Day 1" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay1OverKill },
    { text = "Watchdogs (Pro Job) Day 2" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay2OverKill },
    { text = "Fire Starter (Pro Job) Day 1" .. heat_string("firestarter_prof"), callback = FireStarterPRODay1OverKill },
    { text = "Fire Starter (Pro Job) Day 2" .. heat_string("firestarter_prof"), callback = FireStarterPRODay2OverKill },
    { text = "Fire Starter (Pro Job) Day 3" .. heat_string("firestarter_prof"), callback = FireStarterPRODay3OverKill },
    { text = "Rats (Pro Job) Day 1" .. heat_string("alex_prof"), callback = RatsPRODay1OverKill },
    { text = "Rats (Pro Job) Day 2" .. heat_string("alex_prof"), callback = RatsPRODay2OverKill },
    { text = "Rats (Pro Job) Day 3" .. heat_string("alex_prof"), callback = RatsPRODay3OverKill },
    { text = "Cancel", is_cancel_button = true},
    }
    HectorOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", HectorOverKill)

    HectorVeryHard = {
    { text = "Watchdogs Day 1" .. heat_string("watchdogs"), callback = WatchdogsDay1VeryHard },
    { text = "Watchdogs Day 2" .. heat_string("watchdogs"), callback = WatchdogsDay2VeryHard },
    { text = "Fire Starter Day 1" .. heat_string("firestarter"), callback = FireStarterDay1VeryHard },
    { text = "Fire Starter Day 2" .. heat_string("firestarter"), callback = FireStarterDay2VeryHard },
    { text = "Fire Starter Day 3" .. heat_string("firestarter"), callback = FireStarterDay3VeryHard },
    { text = "Rats Day 1" .. heat_string("alex"), callback = RatsDay1VeryHard },
    { text = "Rats Day 2" .. heat_string("alex"), callback = RatsDay2VeryHard },
    { text = "Rats Day 3" .. heat_string("alex"), callback = RatsDay3VeryHard },
    { text = "Watchdogs (Pro Job) Day 1" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay1VeryHard },
    { text = "Watchdogs (Pro Job) Day 2" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay2VeryHard },
    { text = "Fire Starter (Pro Job) Day 1" .. heat_string("firestarter_prof"), callback = FireStarterPRODay1VeryHard },
    { text = "Fire Starter (Pro Job) Day 2" .. heat_string("firestarter_prof"), callback = FireStarterPRODay2VeryHard },
    { text = "Fire Starter (Pro Job) Day 3" .. heat_string("firestarter_prof"), callback = FireStarterPRODay3VeryHard },
    { text = "Rats (Pro Job) Day 1" .. heat_string("alex_prof"), callback = RatsPRODay1VeryHard },
    { text = "Rats (Pro Job) Day 2" .. heat_string("alex_prof"), callback = RatsPRODay2VeryHard },
    { text = "Rats (Pro Job) Day 3" .. heat_string("alex_prof"), callback = RatsPRODay3VeryHard },
    { text = "Cancel", is_cancel_button = true},
    }
    HectorVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", HectorVeryHard)

    HectorHard = {
    { text = "Watchdogs Day 1" .. heat_string("watchdogs"), callback = WatchdogsDay1Hard },
    { text = "Watchdogs Day 2" .. heat_string("watchdogs"), callback = WatchdogsDay2Hard },
    { text = "Fire Starter Day 1" .. heat_string("firestarter"), callback = FireStarterDay1Hard },
    { text = "Fire Starter Day 2" .. heat_string("firestarter"), callback = FireStarterDay2Hard },
    { text = "Fire Starter Day 3" .. heat_string("firestarter"), callback = FireStarterDay3Hard },
    { text = "Rats Day 1" .. heat_string("alex"), callback = RatsDay1Hard },
    { text = "Rats Day 2" .. heat_string("alex"), callback = RatsDay2Hard },
    { text = "Rats Day 3" .. heat_string("alex"), callback = RatsDay3Hard },
    { text = "Watchdogs (Pro Job) Day 1" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay1Hard },
    { text = "Watchdogs (Pro Job) Day 2" .. heat_string("watchdogs_prof"), callback = WatchdogsPRODay2Hard },
    { text = "Fire Starter (Pro Job) Day 1" .. heat_string("firestarter_prof"), callback = FireStarterPRODay1Hard },
    { text = "Fire Starter (Pro Job) Day 2" .. heat_string("firestarter_prof"), callback = FireStarterPRODay2Hard },
    { text = "Fire Starter (Pro Job) Day 3" .. heat_string("firestarter_prof"), callback = FireStarterPRODay3Hard },
    { text = "Rats (Pro Job) Day 1" .. heat_string("alex_prof"), callback = RatsPRODay1Hard },
    { text = "Rats (Pro Job) Day 2" .. heat_string("alex_prof"), callback = RatsPRODay2Hard },
    { text = "Rats (Pro Job) Day 3" .. heat_string("alex_prof"), callback = RatsPRODay3Hard },
    { text = "Cancel", is_cancel_button = true},
    }
    HectorHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", HectorHard)

    HectorNormal = {
    { text = "Watchdogs Day 1" .. heat_string("watchdogs"), callback = WatchdogsDay1Normal },
    { text = "Watchdogs Day 2" .. heat_string("watchdogs"), callback = WatchdogsDay2Normal },
    { text = "Fire Starter Day 1" .. heat_string("firestarter"), callback = FireStarterDay1Normal },
    { text = "Fire Starter Day 2" .. heat_string("firestarter"), callback = FireStarterDay2Normal },
    { text = "Fire Starter Day 3" .. heat_string("firestarter"), callback = FireStarterDay3Normal },
    { text = "Rats Day 1" .. heat_string("alex"), callback = RatsDay1Normal },
    { text = "Rats Day 2" .. heat_string("alex"), callback = RatsDay2Normal },
    { text = "Rats Day 3" .. heat_string("alex"), callback = RatsDay3Normal },
    { text = "Cancel", is_cancel_button = true},
    }
    HectorNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", HectorNormal)

    DentistDeathWish = {
    { text = "The Big Bank" .. heat_string("big"), callback = BigBankDeathWish },
    { text = "Cancel", is_cancel_button = true },
    }
    DentistDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", DentistDeathWish)

    DentistOverKill = {
    { text = "The Big Bank" .. heat_string("big"), callback = BigBankOverKill },
    { text = "Cancel", is_cancel_button = true },
    }
    DentistOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", DentistOverKill)

    DentistVeryHard = {
    { text = "The Big Bank" .. heat_string("big"), callback = BigBankVeryHard },
    { text = "Cancel", is_cancel_button = true },
    }
    DentistVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", DentistVeryHard)

    DentistHard = {
    { text = "The Big Bank" .. heat_string("big"), callback = BigBankHard },
    { text = "Cancel", is_cancel_button = true },
    }
    DentistHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", DentistHard)

    DentistNormal = {
    { text = "The Big Bank" .. heat_string("big"), callback = BigBankNormal },
    { text = "Cancel", is_cancel_button = true },
    }
    DentistNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", DentistNormal)

    BainDLCDeathWish = {
    { text = "Transport: Crossroads" .. heat_string("arm_cro"), callback = TransportCrossRoadsDeathWish },
    { text = "Transport: Downtown" .. heat_string("arm_hcm"), callback = TransportDownTownDeathWish },
    { text = "Transport: Harbour" .. heat_string("arm_fac"), callback = TransportHarbourDeathWish },
    { text = "Transport: Underpass" .. heat_string("arm_und"), callback = TransportUnderPassDeathWish },
    { text = "Transport: Park" .. heat_string("arm_par"), callback = TransportParkDeathWish },
    { text = "Train Heist", callback = TrainHeistDeathWish },
    { text = "GO Bank" .. heat_string("roberts"), callback = GOBankDeathWish },
    { text = "Shadow Raid" .. heat_string("kosugi"), callback = ShadowRaidDeathWish },
    { text = "Cancel", is_cancel_button = true },
    }
    BainDLCDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainDLCDeathWish)

    BainDLCOverKill = {
    { text = "Transport: Crossroads" .. heat_string("arm_cro"), callback = TransportCrossRoadsOverKill },
    { text = "Transport: Downtown" .. heat_string("arm_hcm"), callback = TransportDownTownOverKill },
    { text = "Transport: Harbour" .. heat_string("arm_fac"), callback = TransportHarbourOverKill },
    { text = "Transport: Underpass" .. heat_string("arm_und"), callback = TransportUnderPassOverKill },
    { text = "Transport: Park" .. heat_string("arm_par"), callback = TransportParkOverKill },
    { text = "Train Heist", callback = TrainHeistOverKill },
    { text = "GO Bank" .. heat_string("roberts"), callback = GOBankOverKill },
    { text = "Shadow Raid" .. heat_string("kosugi"), callback = ShadowRaidOverKill },
    { text = "Cancel", is_cancel_button = true },
    }
    BainDLCOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainDLCOverKill)

    BainDLCVeryHard = {
    { text = "Transport: Crossroads" .. heat_string("arm_cro"), callback = TransportCrossRoadsVeryHard },
    { text = "Transport: Downtown" .. heat_string("arm_hcm"), callback = TransportDownTownVeryHard },
    { text = "Transport: Harbour" .. heat_string("arm_fac"), callback = TransportHarbourVeryHard },
    { text = "Transport: Underpass" .. heat_string("arm_und"), callback = TransportUnderPassVeryHard },
    { text = "Transport: Park" .. heat_string("arm_par"), callback = TransportParkVeryHard },
    { text = "Train Heist", callback = TrainHeistVeryHard },
    { text = "GO Bank" .. heat_string("roberts"), callback = GOBankVeryHard },
    { text = "Shadow Raid" .. heat_string("kosugi"), callback = ShadowRaidVeryHard },
    { text = "Cancel", is_cancel_button = true },
    }
    BainDLCVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainDLCVeryHard)

    BainDLCHard = {
    { text = "Transport: Crossroads" .. heat_string("arm_cro"), callback = TransportCrossRoadsHard },
    { text = "Transport: Downtown" .. heat_string("arm_hcm"), callback = TransportDownTownHard },
    { text = "Transport: Harbour" .. heat_string("arm_fac"), callback = TransportHarbourHard },
    { text = "Transport: Underpass" .. heat_string("arm_und"), callback = TransportUnderPassHard },
    { text = "Transport: Park" .. heat_string("arm_par"), callback = TransportParkHard },
    { text = "Train Heist", callback = TrainHeistHard },
    { text = "GO Bank" .. heat_string("roberts"), callback = GOBankHard },
    { text = "Shadow Raid" .. heat_string("kosugi"), callback = ShadowRaidHard },
    { text = "Cancel", is_cancel_button = true },
    }
    BainDLCHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainDLCHard)

    BainDLCNormal = {
    { text = "Transport: Crossroads" .. heat_string("arm_cro"), callback = TransportCrossRoadsNormal },
    { text = "Transport: Downtown" .. heat_string("arm_hcm"), callback = TransportDownTownNormal },
    { text = "Transport: Harbour" .. heat_string("arm_fac"), callback = TransportHarbourNormal },
    { text = "Transport: Underpass" .. heat_string("arm_und"), callback = TransportUnderPassNormal },
    { text = "Transport: Park" .. heat_string("arm_par"), callback = TransportParkNormal },
    { text = "Train Heist", callback = TrainHeistNormal },
    { text = "GO Bank" .. heat_string("roberts"), callback = GOBankNormal },
    { text = "Shadow Raid" .. heat_string("kosugi"), callback = ShadowRaidNormal },
    { text = "Cancel", is_cancel_button = true },
    }
    BainDLCNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainDLCNormal)

    BainDeathWish = {
    { text = "Jewelry Store" .. heat_string("jewelry_store"), callback = JewelryStoreDeathWish },
    { text = "Bank Heist: Cash" .. heat_string("branchbank_cash"), callback = BankCashDeathWish },
    { text = "Bank Heist: Deposit" .. heat_string("branchbank_deposit"), callback = BankDepositDeathWish },
    { text = "Diamond Store" .. heat_string("family"), callback = DiamondStoreDeathWish },
    { text = "Bank Heist: Gold (Pro Job)" .. heat_string("branchbank_gold_prof"), callback = BankGoldPRODeathWish },
    { text = "Bank Heist (Pro Job)" .. heat_string("branchbank_prof"), callback = BankPRODeathWish },
    { text = "Cancel", is_cancel_button = true },
    }
    BainDeathWishMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainDeathWish)

    BainOverKill = {
    { text = "Jewelry Store" .. heat_string("jewelry_store"), callback = JewelryStoreOverKill },
    { text = "Bank Heist: Cash" .. heat_string("branchbank_cash"), callback = BankCashOverKill },
    { text = "Bank Heist: Deposit" .. heat_string("branchbank_deposit"), callback = BankDepositOverKill },
    { text = "Diamond Store" .. heat_string("family"), callback = DiamondStoreOverKill },
    { text = "Bank Heist: Gold (Pro Job)" .. heat_string("branchbank_gold_prof"), callback = BankGoldPROOverKill },
    { text = "Bank Heist (Pro Job)" .. heat_string("branchbank_prof"), callback = BankPROOverKill },
    { text = "Cancel", is_cancel_button = true },
    }
    BainOverKillMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainOverKill)

    BainVeryHard = {
    { text = "Jewelry Store" .. heat_string("jewelry_store"), callback = JewelryStoreVeryHard },
    { text = "Bank Heist: Cash" .. heat_string("branchbank_cash"), callback = BankCashVeryHard },
    { text = "Bank Heist: Deposit" .. heat_string("branchbank_deposit"), callback = BankDepositVeryHard },
    { text = "Diamond Store" .. heat_string("family"), callback = DiamondStoreVeryHard },
    { text = "Bank Heist: Gold (Pro Job)" .. heat_string("branchbank_gold_prof"), callback = BankGoldPROVeryHard },
    { text = "Bank Heist (Pro Job)" .. heat_string("branchbank_prof"), callback = BankPROVeryHard },
    { text = "Cancel", is_cancel_button = true },
    }
    BainVeryHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainVeryHard)

    BainHard = {
    { text = "Jewelry Store" .. heat_string("jewelry_store"), callback = JewelryStoreHard },
    { text = "Bank Heist: Cash" .. heat_string("branchbank_cash"), callback = BankCashHard },
    { text = "Bank Heist: Deposit" .. heat_string("branchbank_deposit"), callback = BankDepositHard },
    { text = "Diamond Store" .. heat_string("family"), callback = DiamondStoreHard },
    { text = "Bank Heist: Gold (Pro Job)" .. heat_string("branchbank_gold_prof"), callback = BankGoldPROHard },
    { text = "Bank Heist (Pro Job)" .. heat_string("branchbank_prof"), callback = BankPROHard },
    { text = "Cancel", is_cancel_button = true },
    }
    BainHardMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainHard)

    BainNormal = {
    { text = "Jewelry Store" .. heat_string("jewelry_store"), callback = JewelryStoreNormal },
    { text = "Bank Heist: Cash" .. heat_string("branchbank_cash"), callback = BankCashNormal },
    { text = "Bank Heist: Deposit" .. heat_string("branchbank_deposit"), callback = BankDepositNormal },
    { text = "Diamond Store" .. heat_string("family"), callback = DiamondStoreNormal },
    { text = "Cancel", is_cancel_button = true },
    }
    BainNormalMenu = SimpleMenu:new("Mission Selector", "Choose Heist", BainNormal)

    EscapeDiff = {
    { text = "Normal", callback = show_menu, data = EscapeNormalMenu },
    { text = "Hard", callback = show_menu, data = EscapeHardMenu },
    { text = "Very Hard", callback = show_menu, data = EscapeVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = EscapeOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = EscapeDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", EscapeDiff)

    VladDiff = {
    { text = "Normal", callback = show_menu, data = VladNormalMenu },
    { text = "Hard", callback = show_menu, data = VladHardMenu },
    { text = "Very Hard", callback = show_menu, data = VladVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = VladOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = VladDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    VladDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", VladDiff)

    ElephantDiff = {
    { text = "Normal", callback = show_menu, data = ElephantNormalMenu },
    { text = "Hard", callback = show_menu, data = ElephantHardMenu },
    { text = "Very Hard", callback = show_menu, data = ElephantVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = ElephantOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = ElephantDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    ElephantDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", ElephantDiff)

    HectorDiff = {
    { text = "Normal", callback = show_menu, data = HectorNormalMenu },
    { text = "Hard", callback = show_menu, data = HectorHardMenu },
    { text = "Very Hard", callback = show_menu, data = HectorVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = HectorOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = HectorDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    HectorDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", HectorDiff)

    DentistDiff = {
    { text = "Normal", callback = show_menu, data = DentistNormalMenu },
    { text = "Hard", callback = show_menu, data = DentistHardMenu },
    { text = "Very Hard", callback = show_menu, data = DentistVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = DentistOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = DentistDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    DentistDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", DentistDiff)

    BainDLCDiff = {
    { text = "Normal", callback = show_menu, data = BainDLCNormalMenu },
    { text = "Hard", callback = show_menu, data = BainDLCHardMenu },
    { text = "Very Hard", callback = show_menu, data = BainDLCVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = BainDLCOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = BainDLCDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    BainDLCDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", BainDLCDiff)

    BainDiff = {
    { text = "Normal", callback = show_menu, data = BainNormalMenu },
    { text = "Hard", callback = show_menu, data = BainHardMenu },
    { text = "Very Hard", callback = show_menu, data = BainVeryHardMenu },
    { text = "Overkill", callback = show_menu, data = BainOverKillMenu },
    { text = "Death Wish", callback = show_menu, data = BainDeathWishMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    BainDiffMenu = SimpleMenu:new("Mission Selector", "Choose Difficulty", BainDiff)

    rootopts = {
    { text = "Bain Classic", callback = show_menu, data = BainDiffMenu },
    { text = "Bain DLC", callback = show_menu, data = BainDLCDiffMenu },
    { text = "The Dentist", callback = show_menu, data = DentistDiffMenu },
    { text = "Hector", callback = show_menu, data = HectorDiffMenu },
    { text = "The Elephant", callback = show_menu, data = ElephantDiffMenu },
    { text = "Vlad", callback = show_menu, data = VladDiffMenu },
    { text = "Escapes", callback = show_menu, data = EscapeDiffMenu },
    { text = "Cancel", is_cancel_button = true},
    }
    rootmenu = SimpleMenu:new("Mission Selector", "Choose Contractor", rootopts)

    EscapeChain = {
    { text = "Escape: Cafe", callback = EscapeCafeChain },
    { text = "Escape: Cafe (Day)", callback = EscapeCafeDayChain },
    { text = "Escape: Park", callback = EscapeParkChain },
    { text = "Escape: Park (Day)", callback = EscapeParkDayChain },
    { text = "Escape: Overpass", callback = EscapeOverPassChain },
    { text = "Escape: Overpass (Night)", callback = EscapeOverPassNightChain },
    { text = "Escape: Street", callback = EscapeStreetChain },
    { text = "Escape: Garage", callback = EscapeGarageChain },
    { text = "Cancel", is_cancel_button = true},
    }
    EscapeChainMenu = SimpleMenu:new("Mission Selector", "Choose Escape to Chain", EscapeChain)

    FramingFrameDay2Completer = {
    { text = "Auto-Complete Framing Frame Day 2", callback = AutoFramingFrameDay2Completer },
    { text = "Cancel", is_cancel_button = true},
    }
    FramingFrameDay2CompleterMenu = SimpleMenu:new("Mission Selector", "Choose an Option", FramingFrameDay2Completer)


    -- ESCAPE MENU OR AUTO-COMPLETE FRAMING FRAME DAY 2 MENU OR MISSION CONTRACTOR MENU
    if inGame() and isPlaying() then
        if not inChat() then
            if managers.job:current_level_id() == "framing_frame_2" then
                FramingFrameDay2CompleterMenu:show()
            else
                EscapeChainMenu:show()
            end
        end
    else
        rootmenu:show()
    end
end    