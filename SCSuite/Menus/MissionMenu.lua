-- HEAT STRING FUNCTION - by zulu200
local heat_string = function( o )
    if o == 'arm_for' or o == 'branchbank_gold' or o == 'branchbank' or o == 'welcome_to_the_jungle' or o == 'welcome_to_the_jungle_prof' or o == 'ukrainian_job' or o == 'big_prof' or o == 'safehouse' then return "" end
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
-- Yet Another Job Menu
--   original script by harfatus
--   escapes and escape chains by B1313
--   rewritten by so and so
local escape_job = 'ukrainian_job'

if not rawget(_G, 'managers') then return end

local in_game = string.find(game_state_machine:current_state_name(), 'game')
local is_playing = BaseNetworkHandler._gamestate_filter.any_ingame_playing[game_state_machine:last_queued_state_name()]
local in_chat = managers.hud and managers.hud._chat_focus

local function translate(id)
    return managers.localization:to_upper_text(id)
end

local local_easy =      translate("menu_difficulty_easy")
local local_normal =    translate("menu_difficulty_normal")
local local_hard =      translate("menu_difficulty_hard")
local local_veryhard =  translate("menu_difficulty_very_hard")
local local_overkill =  translate("menu_difficulty_overkill")
local local_deathwish = translate("menu_difficulty_apocalypse")
local local_pro =       translate("menu_cn_legend_pro")

local stack = {}
local show_menu
local function back()
    table.remove(stack) -- pop current
    local menu = table.remove(stack)
    if menu then show_menu(menu, true) end
end
show_menu = function(menu)
    show_sorted_dialog(menu.title or '', menu.subtitle or '', menu, #stack > 0 and back or nil)
    table.insert(stack, menu)
end

local function set_job(difficulty, job, level, day)
    -- mostly a copypaste from MenuCallbackHandler:start_job
    if not managers.job:activate_job(job, day or nil) then return end

    Global.game_settings.level_id = level or job
    Global.game_settings.mission = managers.job:current_mission()
    Global.game_settings.world_setting = managers.job:current_world_setting()
    Global.game_settings.difficulty = difficulty
    local matchmake_attributes = MenuCallbackHandler:get_matchmake_attributes()

    if Network:is_server() then
        local job_id_index = tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id())
        local level_id_index = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
        local difficulty_index = tweak_data:difficulty_to_index(Global.game_settings.difficulty)
        managers.network:session():send_to_peers('sync_game_settings', job_id_index, level_id_index, difficulty_index)
        managers.network.matchmake:set_server_attributes(matchmake_attributes)
        managers.menu_component:on_job_updated()
        managers.menu:active_menu().logic:navigate_back(true)
        managers.menu:active_menu().logic:refresh_node('lobby', true)
    else
        managers.network.matchmake:create_lobby(matchmake_attributes)
    end
end

local function MenuItem(text, clbk, ...)
    local args = {...}
    return { text = text, callback = clbk, data = args }
end

local function mission(job, level, day)
    io.write('job:   ', job or '[NO JOB]', '\n')
    io.write('level: ', level or '[default level]', '\n')
    io.write('day:   ', day or '[first day]', '\n')
    if in_game and is_playing then
        managers.job:set_next_interupt_stage(level or job)
        return
    end
    show_menu{
        title = 'Job: '..job..' ' .. heat_string(job),
        subtitle = 'Choose Difficulty',
        --MenuItem(local_easy, set_job, 'easy', job, level, day),
        MenuItem(local_normal, set_job, 'normal', job, level, day),
        MenuItem(local_hard, set_job, 'hard', job, level, day),
        MenuItem(local_veryhard, set_job, 'overkill', job, level, day),
        MenuItem(local_overkill, set_job, 'overkill_145', job, level, day),
        MenuItem(local_deathwish, set_job, 'overkill_290', job, level, day),
    }
end

local function MissionItem(job, day, day_override)
    local pro = job:sub(-5) == '_prof'
    local level = pro and job:sub(1, -6) or job
    local local_job = translate('heist_'..level)
    local daystr = day and '_'..tostring(day) or ''

    level = level..daystr
    if not tweak_data.levels[level] then
        level = level:match('[^_]+')..daystr
    end

    local human = local_job..(pro and ' ('..local_pro..')' or '')..(day and ' {'..tostring(day)..'}' or '')..heat_string(job)
    return MenuItem(human, mission, job, level, day_override or day)
end

local function EscapeItem(job)
    local pro = job:sub(-5) == '_prof'
    local level = pro and job:sub(1, -6) or job

    local append = ''
    if not managers.localization:exists('heist_'..level..'_hl') then
        level = level:match('escape_[^_]+')
        append = ' (alt)' -- hackish
    end

    local local_level = translate('heist_'..level..'_hl')
    return MenuItem(local_level..append, mission, escape_job, level, nil)
end

local menu_bain = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    MissionItem('jewelry_store'),
    MissionItem('branchbank_cash'),
    MissionItem('branchbank_deposit'),
    MissionItem('branchbank_gold_prof'),
    MissionItem('branchbank_prof'),
    MissionItem('family'), -- diamond store
    MissionItem('roberts'), -- go bank
    MissionItem('kosugi'), -- shadow raid
}

local menu_arm = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    --MissionItem('arm_bri'), -- ???
    MissionItem('arm_cro'), -- crossroads
    MissionItem('arm_hcm'), -- downtown
    MissionItem('arm_fac'), -- harbor
    MissionItem('arm_und'), -- underpass
    MissionItem('arm_par'), -- park
    MissionItem('arm_for'), -- train heist
}

local menu_hector = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    MissionItem('watchdogs', 1),
    MissionItem('watchdogs', 2),
    MissionItem('firestarter', 1),
    MissionItem('firestarter', 2),
    MissionItem('firestarter', 3),
    MissionItem('alex', 1), -- rats
    MissionItem('alex', 2),
    MissionItem('alex', 3),
    MissionItem('watchdogs_prof', 1),
    MissionItem('watchdogs_prof', 2),
    MissionItem('firestarter_prof', 1),
    MissionItem('firestarter_prof', 2),
    MissionItem('firestarter_prof', 3),
    MissionItem('alex_prof', 1),
    MissionItem('alex_prof', 2),
    MissionItem('alex_prof', 3),
}

local menu_elephant = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    MissionItem('framing_frame', 1),
    MissionItem('framing_frame', 2),
    MissionItem('framing_frame', 3),
    MissionItem('election_day', 1),
    MissionItem('election_day', 2),
    MissionItem('election_day', 3, 2), -- alternative second day
    MissionItem('welcome_to_the_jungle_prof', 1), -- big oil
    MissionItem('welcome_to_the_jungle_prof', 2),
    MissionItem('framing_frame_prof', 1),
    MissionItem('framing_frame_prof', 2),
    MissionItem('framing_frame_prof', 3),
    MissionItem('election_day_prof', 1),
    MissionItem('election_day_prof', 2),
    MissionItem('election_day_prof', 3, 2),
}

local menu_dentist = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    MissionItem('big'), -- big bank
}

local menu_vlad = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    MissionItem('four_stores'),
    MissionItem('mallcrasher'),
    MissionItem('nightclub'),
    MissionItem('ukrainian_job_prof'),
}

local menu_escapes = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    EscapeItem('escape_cafe'),
    EscapeItem('escape_cafe_day'),
    EscapeItem('escape_park'),
    EscapeItem('escape_park_day'),
    EscapeItem('escape_overpass'),
    EscapeItem('escape_overpass_night'),
    EscapeItem('escape_street'),
    EscapeItem('escape_garage'),
}

local menu_extra = {
    title = 'Mission Selector',
    subtitle = 'Choose Map',
    MissionItem('branchbank_gold'),
    MissionItem('branchbank'),
    MissionItem('welcome_to_the_jungle', 1),
    MissionItem('welcome_to_the_jungle', 2),
    MissionItem('ukrainian_job'),
    MissionItem('big_prof'),
    MissionItem('safehouse'),
    --MenuItem('Safehouse (Transport Wrapper)', mission, 'arm_wrapper', 'safehouse'),
}

local menu_main = {
    title = 'Mission Selector',
    subtitle = 'Choose Contractor',
    MenuItem('Bain', show_menu, menu_bain),
    MenuItem('Transport', show_menu, menu_arm),
    MenuItem('Hector', show_menu, menu_hector),
    MenuItem('Elephant', show_menu, menu_elephant),
    MenuItem('Dentist', show_menu, menu_dentist),
    MenuItem('Vlad', show_menu, menu_vlad),
    MenuItem('Escapes', show_menu, menu_escapes),
    MenuItem('Extra', show_menu, menu_extra),
}

if in_chat then return end
if in_game and not is_playing then return end
show_menu(menu_main)