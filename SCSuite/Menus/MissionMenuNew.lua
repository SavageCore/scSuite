-----------------------------------------
-------- Job Manager (Update 35) --------
-- Acepilot1023978: GUI Implementation --
------ B1313: Base code (functions) -----
-------- SavageCore: Dynamic code -------

local difficultyList = {'normal','hard','veryhard','overkill','deathwish'}

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end    
    
local function translate(id)
    return managers.localization:to_upper_text(id)
end
    
local function set_job(callbackData)
    local difficulty = callbackData['difficulty']
    local job = callbackData['job']
    local level = callbackData['level'] or nil
    local day = callbackData['day'] or nil

    local pro = job:sub(-5) == '_prof'
    local level = pro and job:sub(1, -6) or job
    local local_job = translate('heist_'..level)
    local daystr = day and '_'..tostring(day) or ''

    level = level..daystr
    if not tweak_data.levels[level] then
        level = level:match('[^_]+')..daystr
    end
    
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
    JobMenuNew:close()
end    

local function tchelper(first, rest)
  return first:upper()..rest:lower()
end
-- Add extra characters to the pattern if you need to. _ and ' are
--  found in the middle of identifiers and English words.
-- We must also put %w_' into [%w_'] to make it handle normal stuff
-- and extra stuff the same.
-- This also turns hex numbers into, eg. 0Xa7d4

local function contractor_difficulty(contact,title)
    JobMenuNew:addMenu(contact..'_diff', { title = title } )
end

local function difficulty_selector(k,contact,difficultyList)
    for key, difficulty in pairs(difficultyList) do
        --JobMenuNew:addMenuOption('bain_diff', 'Normal', 'bain_normal')
        local difficultyString = difficulty:gsub("_", " ")
        local difficultyString = difficultyString:gsub("(%a)([%w_']*)", tchelper)
        Console("JobMenuNew:addMenuOption(".. k .."_diff," .. difficultyString .. "," .. k.. "_" ..difficulty..")")
        JobMenuNew:addMenuOption(k..'_diff', difficultyString, k..'_'..difficulty)    
    end
end

local function contractor_selector(k,contact)
    JobMenuNew:addMenuOption('job_menu', contact, k..'_diff')
    JobMenuNew:addGap('job_menu')
end

local function select_mission(k,contact,difficultyList)
    for key, difficulty in pairs(difficultyList) do   
        Console("JobMenuNew:addMenu(".. k .."_"..difficulty..", { title = "..contact.."' - Select Mission' } ")
        JobMenuNew:addMenu(k..'_'..difficulty, { title = contact..' - Select Mission' } )
    end
end
    
-- INGAME CHECK
function inGame()
    if not game_state_machine then return false end
    return string.find(game_state_machine:current_state_name(), "game")
end
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------

JobMenuNew = CustomMenuClass:new({hasLoading = false})
JobMenuNew:addMainMenu('job_menu', { title = "Job Manager\nSelect a Contractor" } )

--------------------
--[[ Fill Menus ]]--
--------------------

--[[ Main Menu ]]--

table_print(tweak_data.narrative:get_jobs_index()) --All maps!
local narrative = tweak_data.narrative:job_data('jewelry_store')
--local local_job = translate(narrative['name_id'])
--local contact_data = managers.job:current_contact_data()
--text = managers.localization:to_upper_text(tweak_data.crime_net.codex)
table_print(tweak_data.narrative.contacts)
table_print(difficultyList)

--contacts.k.name_id
for k, v in pairs(tweak_data.narrative.contacts) do
    if k ~= 'interupt' then 
        contact = translate(tweak_data.narrative.contacts[k].name_id)
        contact = contact:gsub("(%a)([%w_']*)", tchelper)
        contractor_selector(k,contact)
        select_mission(k,contact,difficultyList)
        contractor_difficulty(k,contact..' - Select Difficulty')
        difficulty_selector(k,contact,difficultyList)
    end
end

--[[ Bain Normal ]]--
JobMenuNew:addInformationOption('bain_normal', '.:: Main ::.')
JobMenuNew:addOption('bain_normal', 'Jewelry Store', { callback = set_job, callbackData = {difficulty = 'normal', job = 'jewelry_store', level = nil, day = nil} } ) --set_job(difficulty, job, level, day)
JobMenuNew:addOption('bain_normal', 'Bank Heist: Cash', { callback = set_job, callbackData = {difficulty = 'normal', job = 'branchbank', level = nil, day = nil} } )
JobMenuNew:addOption('bain_normal', 'Bank Heist: Deposit', { callback = BankDepositNormal } )
JobMenuNew:addOption('bain_normal', 'Diamond Store', { callback = DiamondStoreNormal } )
JobMenuNew:addGap('bain_normal')
JobMenuNew:addGap('bain_normal')
JobMenuNew:addGap('bain_normal')
JobMenuNew:addGap('bain_normal')
JobMenuNew:addGap('bain_normal')
JobMenuNew:addInformationOption('bain_normal', '.:: DLC ::.')
JobMenuNew:addOption('bain_normal', 'Transport: Crossroads', { callback = TransportCrossRoadsNormal } )
JobMenuNew:addOption('bain_normal', 'Transport: Downtown', { callback = TransportDownTownNormal } )
JobMenuNew:addOption('bain_normal', 'Transport: Harbour', { callback = TransportHarbourNormal } )
JobMenuNew:addOption('bain_normal', 'Transport: Underpass', { callback = TransportUnderPassNormal } )
JobMenuNew:addOption('bain_normal', 'Transport: Park', { callback = TransportParkNormal } )
JobMenuNew:addOption('bain_normal', 'Train Heist', { callback = TrainHeistNormal } )
JobMenuNew:addOption('bain_normal', 'GO Bank', { callback = GOBankNormal } )
JobMenuNew:addOption('bain_normal', 'Shadow Raid', { callback = ShadowRaidNormal } )
--[[ Dentist Normal ]]--
JobMenuNew:addOption('dentist_normal', 'The Big Bank', { callback = BigBankNormal } )
--[[ Hector Normal ]]--
JobMenuNew:addOption('hector_normal', 'Watchdogs: Day 1', { callback = WatchdogsDay1Normal } )
JobMenuNew:addOption('hector_normal', 'Watchdogs: Day 2', { callback = WatchdogsDay2Normal } )
JobMenuNew:addGap('hector_normal')
JobMenuNew:addOption('hector_normal', 'Fire Starter: Day 1', { callback = FireStarterDay1Normal } )
JobMenuNew:addOption('hector_normal', 'Fire Starter: Day 2', { callback = FireStarterDay2Normal } )
JobMenuNew:addOption('hector_normal', 'Fire Starter: Day 3', { callback = FireStarterDay3Normal } )
JobMenuNew:addGap('hector_normal')
JobMenuNew:addOption('hector_normal', 'Rats: Day 1', { callback = RatsDay1Normal } )
JobMenuNew:addOption('hector_normal', 'Rats: Day 2', { callback = RatsDay2Normal } )
JobMenuNew:addOption('hector_normal', 'Rats: Day 3', { callback = RatsDay3Normal } )
--[[ Elephant Normal ]]--
JobMenuNew:addOption('elephant_normal', 'Framing Frame: Day 1', { callback = FramingFrameDay1 } )
JobMenuNew:addOption('elephant_normal', 'Framing Frame: Day 2', { callback = FramingFrameDay2 } )
JobMenuNew:addOption('elephant_normal', 'Framing Frame: Day 3', { callback = FramingFrameDay3 } )
JobMenuNew:addGap('elephant_normal')
JobMenuNew:addOption('elephant_normal', 'Election Day: Day 1', { callback = ElectionDayDay1 } )
JobMenuNew:addOption('elephant_normal', 'Election Day: Day 2', { callback = ElectionDayDay2 } )
JobMenuNew:addOption('elephant_normal', 'Election Day: Day 3', { callback = ElectionDayDay3 } )
--[[ Vlad Normal ]]--
JobMenuNew:addOption('vlad_normal', 'Four Stores', { callback = FourStoresNormal } )
JobMenuNew:addOption('vlad_normal', 'Mallcrasher', { callback = MallCrasherNormal } )
JobMenuNew:addOption('vlad_normal', 'Nightclub', { callback = NightclubNormal } )

--[[ Bain Hard ]]--
JobMenuNew:addInformationOption('bain_hard', '.:: Main ::.')
JobMenuNew:addOption('bain_hard', 'Jewelry Store', { callback = JewelryStoreHard } )
JobMenuNew:addOption('bain_hard', 'Bank Heist: Cash', { callback = BankCashHard } )
JobMenuNew:addOption('bain_hard', 'Bank Heist: Deposit', { callback = BankDepositHard } )
JobMenuNew:addOption('bain_hard', 'Diamond Store', { callback = DiamondStoreHard } )
JobMenuNew:addGap('bain_hard')
JobMenuNew:addOption('bain_hard', 'Bank Heist: Gold (Pro)', { callback = BankGoldPROHard } )
JobMenuNew:addOption('bain_hard', 'Bank Heist (Pro)', { callback = BankPROHard } )
JobMenuNew:addGap('bain_hard')
JobMenuNew:addGap('bain_hard')
JobMenuNew:addInformationOption('bain_hard', '.:: DLC ::.')
JobMenuNew:addOption('bain_hard', 'Transport: Crossroads', { callback = TransportCrossRoadsHard } )
JobMenuNew:addOption('bain_hard', 'Transport: Downtown', { callback = TransportDownTownHard } )
JobMenuNew:addOption('bain_hard', 'Transport: Harbour', { callback = TransportHarbourHard } )
JobMenuNew:addOption('bain_hard', 'Transport: Underpass', { callback = TransportUnderPassHard } )
JobMenuNew:addOption('bain_hard', 'Transport: Park', { callback = TransportParkHard } )
JobMenuNew:addOption('bain_hard', 'Train Heist', { callback = TrainHeistHard } )
JobMenuNew:addOption('bain_hard', 'GO Bank', { callback = GOBankHard } )
JobMenuNew:addOption('bain_hard', 'Shadow Raid', { callback = ShadowRaidHard } )
--[[ Dentist Hard ]]--
JobMenuNew:addOption('dentist_hard', 'The Big Bank', { callback = BigBankHard } )
--[[ Hector Hard ]]--
JobMenuNew:addOption('hector_hard', 'Watchdogs: Day 1', { callback = WatchdogsDay1Hard } )
JobMenuNew:addOption('hector_hard', 'Watchdogs: Day 2', { callback = WatchdogsDay2Hard } )
JobMenuNew:addGap('hector_hard')
JobMenuNew:addOption('hector_hard', 'Fire Starter: Day 1', { callback = FireStarterDay1Hard } )
JobMenuNew:addOption('hector_hard', 'Fire Starter: Day 2', { callback = FireStarterDay2Hard } )
JobMenuNew:addOption('hector_hard', 'Fire Starter: Day 3', { callback = FireStarterDay3Hard } )
JobMenuNew:addGap('hector_hard')
JobMenuNew:addOption('hector_hard', 'Rats: Day 1', { callback = RatsDay1Hard } )
JobMenuNew:addOption('hector_hard', 'Rats: Day 2', { callback = RatsDay2Hard } )
JobMenuNew:addOption('hector_hard', 'Rats: Day 3', { callback = RatsDay3Hard } )
JobMenuNew:addOption('hector_hard', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1Hard } )
JobMenuNew:addOption('hector_hard', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2Hard } )
JobMenuNew:addGap('hector_hard')
JobMenuNew:addOption('hector_hard', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1Hard } )
JobMenuNew:addOption('hector_hard', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2Hard } )
JobMenuNew:addOption('hector_hard', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3Hard } )
JobMenuNew:addGap('hector_hard')
JobMenuNew:addOption('hector_hard', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1Hard } )
JobMenuNew:addOption('hector_hard', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2Hard } )
JobMenuNew:addOption('hector_hard', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3Hard } )
--[[ Elephant Hard ]]--
JobMenuNew:addOption('elephant_hard', 'Framing Frame: Day 1', { callback = FramingFrameDay1Hard } )
JobMenuNew:addOption('elephant_hard', 'Framing Frame: Day 2', { callback = FramingFrameDay2Hard } )
JobMenuNew:addOption('elephant_hard', 'Framing Frame: Day 3', { callback = FramingFrameDay3Hard } )
JobMenuNew:addGap('elephant_hard')
JobMenuNew:addOption('elephant_hard', 'Election Day: Day 1', { callback = ElectionDayDay1Hard } )
JobMenuNew:addOption('elephant_hard', 'Election Day: Day 2', { callback = ElectionDayDay2Hard } )
JobMenuNew:addOption('elephant_hard', 'Election Day: Day 3', { callback = ElectionDayDay3Hard } )
JobMenuNew:addGap('elephant_hard')
JobMenuNew:addGap('elephant_hard')
JobMenuNew:addGap('elephant_hard')
JobMenuNew:addOption('elephant_hard', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1Hard } )
JobMenuNew:addOption('elephant_hard', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2Hard } )
JobMenuNew:addOption('elephant_hard', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3Hard } )
JobMenuNew:addGap('elephant_hard')
JobMenuNew:addOption('elephant_hard', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1Hard } )
JobMenuNew:addOption('elephant_hard', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2Hard } )
JobMenuNew:addOption('elephant_hard', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3Hard } )
--[[ Vlad Hard ]]--
JobMenuNew:addOption('vlad_hard', 'Four Stores', { callback = FourStoresHard } )
JobMenuNew:addOption('vlad_hard', 'Mallcrasher', { callback = MallCrasherHard } )
JobMenuNew:addOption('vlad_hard', 'Nightclub', { callback = NightclubHard } )
JobMenuNew:addOption('vlad_hard', 'Ukrainian Job (Pro)', { callback = UkrainianJobPROHard } )

--[[ Bain Very Hard ]]--
JobMenuNew:addInformationOption('bain_veryhard', '.:: Main ::.')
JobMenuNew:addOption('bain_veryhard', 'Jewelry Store', { callback = JewelryStoreVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Bank Heist: Cash', { callback = BankCashVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Bank Heist: Deposit', { callback = BankDepositVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Diamond Store', { callback = DiamondStoreVeryHard } )
JobMenuNew:addGap('bain_veryhard')
JobMenuNew:addOption('bain_veryhard', 'Bank Heist: Gold (Pro)', { callback = BankGoldPROVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Bank Heist (Pro)', { callback = BankPROVeryHard } )
JobMenuNew:addGap('bain_veryhard')
JobMenuNew:addGap('bain_veryhard')
JobMenuNew:addInformationOption('bain_veryhard', '.:: DLC ::.')
JobMenuNew:addOption('bain_veryhard', 'Transport: Crossroads', { callback = TransportCrossRoadsVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Transport: Downtown', { callback = TransportDownTownVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Transport: Harbour', { callback = TransportHarbourVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Transport: Underpass', { callback = TransportUnderPassVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Transport: Park', { callback = TransportParkVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Train Heist', { callback = TrainHeistVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'GO Bank', { callback = GOBankVeryHard } )
JobMenuNew:addOption('bain_veryhard', 'Shadow Raid', { callback = ShadowRaidVeryHard } )
--[[ Dentist Very Hard ]]--
JobMenuNew:addOption('dentist_veryhard', 'The Big Bank', { callback = BigBankVeryHard } )
--[[ Hector Very Hard ]]--
JobMenuNew:addOption('hector_veryhard', 'Watchdogs: Day 1', { callback = WatchdogsDay1VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Watchdogs: Day 2', { callback = WatchdogsDay2VeryHard } )
JobMenuNew:addGap('hector_veryhard')
JobMenuNew:addOption('hector_veryhard', 'Fire Starter: Day 1', { callback = FireStarterDay1VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Fire Starter: Day 2', { callback = FireStarterDay2VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Fire Starter: Day 3', { callback = FireStarterDay3VeryHard } )
JobMenuNew:addGap('hector_veryhard')
JobMenuNew:addOption('hector_veryhard', 'Rats: Day 1', { callback = RatsDay1VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Rats: Day 2', { callback = RatsDay2VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Rats: Day 3', { callback = RatsDay3VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2VeryHard } )
JobMenuNew:addGap('hector_veryhard')
JobMenuNew:addOption('hector_veryhard', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3VeryHard } )
JobMenuNew:addGap('hector_veryhard')
JobMenuNew:addOption('hector_veryhard', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2VeryHard } )
JobMenuNew:addOption('hector_veryhard', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3VeryHard } )
--[[ Elephant Very Hard ]]--
JobMenuNew:addOption('elephant_veryhard', 'Framing Frame: Day 1', { callback = FramingFrameDay1VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Framing Frame: Day 2', { callback = FramingFrameDay2VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Framing Frame: Day 3', { callback = FramingFrameDay3VeryHard } )
JobMenuNew:addGap('elephant_veryhard')
JobMenuNew:addOption('elephant_veryhard', 'Election Day: Day 1', { callback = ElectionDayDay1VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Election Day: Day 2', { callback = ElectionDayDay2VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Election Day: Day 3', { callback = ElectionDayDay3VeryHard } )
JobMenuNew:addGap('elephant_veryhard')
JobMenuNew:addGap('elephant_veryhard')
JobMenuNew:addGap('elephant_veryhard')
JobMenuNew:addOption('elephant_veryhard', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3VeryHard } )
JobMenuNew:addGap('elephant_veryhard')
JobMenuNew:addOption('elephant_veryhard', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2VeryHard } )
JobMenuNew:addOption('elephant_veryhard', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3VeryHard } )
--[[ Vlad Very Hard ]]--
JobMenuNew:addOption('vlad_veryhard', 'Four Stores', { callback = FourStoresVeryHard } )
JobMenuNew:addOption('vlad_veryhard', 'Mallcrasher', { callback = MallCrasherVeryHard } )
JobMenuNew:addOption('vlad_veryhard', 'Nightclub', { callback = NightclubVeryHard } )
JobMenuNew:addOption('vlad_veryhard', 'Ukrainian Job (Pro)', { callback = UkrainianJobPROVeryHard } )

--[[ Bain Overkill ]]--
JobMenuNew:addInformationOption('bain_overkill', '.:: Main ::.')
JobMenuNew:addOption('bain_overkill', 'Jewelry Store', { callback = JewelryStoreOverKill } )
JobMenuNew:addOption('bain_overkill', 'Bank Heist: Cash', { callback = BankCashOverKill } )
JobMenuNew:addOption('bain_overkill', 'Bank Heist: Deposit', { callback = BankDepositOverKill } )
JobMenuNew:addOption('bain_overkill', 'Diamond Store', { callback = DiamondStoreOverKill } )
JobMenuNew:addGap('bain_overkill')
JobMenuNew:addOption('bain_overkill', 'Bank Heist: Gold (Pro)', { callback = BankGoldPROOverKill } )
JobMenuNew:addOption('bain_overkill', 'Bank Heist (Pro)', { callback = BankPROOverKill } )
JobMenuNew:addGap('bain_overkill')
JobMenuNew:addGap('bain_overkill')
JobMenuNew:addInformationOption('bain_overkill', '.:: DLC ::.')
JobMenuNew:addOption('bain_overkill', 'Transport: Crossroads', { callback = TransportCrossRoadsOverKill } )
JobMenuNew:addOption('bain_overkill', 'Transport: Downtown', { callback = TransportDownTownOverKill } )
JobMenuNew:addOption('bain_overkill', 'Transport: Harbour', { callback = TransportHarbourOverKill } )
JobMenuNew:addOption('bain_overkill', 'Transport: Underpass', { callback = TransportUnderPassOverKill } )
JobMenuNew:addOption('bain_overkill', 'Transport: Park', { callback = TransportParkOverKill } )
JobMenuNew:addOption('bain_overkill', 'Train Heist', { callback = TrainHeistOverKill } )
JobMenuNew:addOption('bain_overkill', 'GO Bank', { callback = GOBankOverKill } )
JobMenuNew:addOption('bain_overkill', 'Shadow Raid', { callback = ShadowRaidOverKill } )
--[[ Dentist Overkill ]]--
JobMenuNew:addOption('dentist_overkill', 'The Big Bank', { callback = BigBankOverKill } )
--[[ Hector Overkill ]]--
JobMenuNew:addOption('hector_overkill', 'Watchdogs: Day 1', { callback = WatchdogsDay1OverKill } )
JobMenuNew:addOption('hector_overkill', 'Watchdogs: Day 2', { callback = WatchdogsDay2OverKill } )
JobMenuNew:addGap('hector_overkill')
JobMenuNew:addOption('hector_overkill', 'Fire Starter: Day 1', { callback = FireStarterDay1OverKill } )
JobMenuNew:addOption('hector_overkill', 'Fire Starter: Day 2', { callback = FireStarterDay2OverKill } )
JobMenuNew:addOption('hector_overkill', 'Fire Starter: Day 3', { callback = FireStarterDay3OverKill } )
JobMenuNew:addGap('hector_overkill')
JobMenuNew:addOption('hector_overkill', 'Rats: Day 1', { callback = RatsDay1OverKill } )
JobMenuNew:addOption('hector_overkill', 'Rats: Day 2', { callback = RatsDay2OverKill } )
JobMenuNew:addOption('hector_overkill', 'Rats: Day 3', { callback = RatsDay3OverKill } )
JobMenuNew:addOption('hector_overkill', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1OverKill } )
JobMenuNew:addOption('hector_overkill', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2OverKill } )
JobMenuNew:addGap('hector_overkill')
JobMenuNew:addOption('hector_overkill', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1OverKill } )
JobMenuNew:addOption('hector_overkill', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2OverKill } )
JobMenuNew:addOption('hector_overkill', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3OverKill } )
JobMenuNew:addGap('hector_overkill')
JobMenuNew:addOption('hector_overkill', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1OverKill } )
JobMenuNew:addOption('hector_overkill', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2OverKill } )
JobMenuNew:addOption('hector_overkill', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3OverKill } )
--[[ Elephant Overkill ]]--
JobMenuNew:addOption('elephant_overkill', 'Framing Frame: Day 1', { callback = FramingFrameDay1OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Framing Frame: Day 2', { callback = FramingFrameDay2OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Framing Frame: Day 3', { callback = FramingFrameDay3OverKill } )
JobMenuNew:addGap('elephant_overkill')
JobMenuNew:addOption('elephant_overkill', 'Election Day: Day 1', { callback = ElectionDayDay1OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Election Day: Day 2', { callback = ElectionDayDay2OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Election Day: Day 3', { callback = ElectionDayDay3OverKill } )
JobMenuNew:addGap('elephant_overkill')
JobMenuNew:addGap('elephant_overkill')
JobMenuNew:addGap('elephant_overkill')
JobMenuNew:addOption('elephant_overkill', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3OverKill } )
JobMenuNew:addGap('elephant_overkill')
JobMenuNew:addOption('elephant_overkill', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2OverKill } )
JobMenuNew:addOption('elephant_overkill', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3OverKill } )
--[[ Vlad Overkill ]]--
JobMenuNew:addOption('vlad_overkill', 'Four Stores', { callback = FourStoresOverKill } )
JobMenuNew:addOption('vlad_overkill', 'Mallcrasher', { callback = MallCrasherOverKill } )
JobMenuNew:addOption('vlad_overkill', 'Nightclub', { callback = NightclubOverKill } )
JobMenuNew:addOption('vlad_overkill', 'Ukrainian Job (Pro)', { callback = UkrainianJobPROOverKill } )

--[[ Bain Deathwish ]]--
JobMenuNew:addInformationOption('bain_deathwish', '.:: Main ::.')
JobMenuNew:addOption('bain_deathwish', 'Jewelry Store', { callback = JewelryStoreDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Bank Heist: Cash', { callback = BankCashDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Bank Heist: Deposit', { callback = BankDepositDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Diamond Store', { callback = DiamondStoreDeathWish } )
JobMenuNew:addGap('bain_deathwish')
JobMenuNew:addOption('bain_deathwish', 'Bank Heist: Gold (Pro)', { callback = BankGoldPRODeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Bank Heist (Pro)', { callback = BankPRODeathWish } )
JobMenuNew:addGap('bain_deathwish')
JobMenuNew:addGap('bain_deathwish')
JobMenuNew:addInformationOption('bain_deathwish', '.:: DLC ::.')
JobMenuNew:addOption('bain_deathwish', 'Transport: Crossroads', { callback = TransportCrossRoadsDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Transport: Downtown', { callback = TransportDownTownDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Transport: Harbour', { callback = TransportHarbourDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Transport: Underpass', { callback = TransportUnderPassDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Transport: Park', { callback = TransportParkDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Train Heist', { callback = TrainHeistDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'GO Bank', { callback = GOBankDeathWish } )
JobMenuNew:addOption('bain_deathwish', 'Shadow Raid', { callback = ShadowRaidDeathWish } )
--[[ Dentist Deathwish ]]--
JobMenuNew:addOption('dentist_deathwish', 'The Big Bank', { callback = BigBankDeathWish } )
--[[ Hector Deathwish ]]--
JobMenuNew:addOption('hector_deathwish', 'Watchdogs: Day 1', { callback = WatchdogsDay1DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Watchdogs: Day 2', { callback = WatchdogsDay2DeathWish } )
JobMenuNew:addGap('hector_deathwish')
JobMenuNew:addOption('hector_deathwish', 'Fire Starter: Day 1', { callback = FireStarterDay1DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Fire Starter: Day 2', { callback = FireStarterDay2DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Fire Starter: Day 3', { callback = FireStarterDay3DeathWish } )
JobMenuNew:addGap('hector_deathwish')
JobMenuNew:addOption('hector_deathwish', 'Rats: Day 1', { callback = RatsDay1DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Rats: Day 2', { callback = RatsDay2DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Rats: Day 3', { callback = RatsDay3DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Watchdogs: Day 1 (Pro)', { callback = WatchdogsPRODay1DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Watchdogs: Day 2 (Pro)', { callback = WatchdogsPRODay2DeathWish } )
JobMenuNew:addGap('hector_deathwish')
JobMenuNew:addOption('hector_deathwish', 'Fire Starter: Day 1 (Pro)', { callback = FireStarterPRODay1DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Fire Starter: Day 2 (Pro)', { callback = FireStarterPRODay2DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Fire Starter: Day 3 (Pro)', { callback = FireStarterPRODay3DeathWish } )
JobMenuNew:addGap('hector_deathwish')
JobMenuNew:addOption('hector_deathwish', 'Rats: Day 1 (Pro)', { callback = RatsPRODay1DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Rats: Day 2 (Pro)', { callback = RatsPRODay2DeathWish } )
JobMenuNew:addOption('hector_deathwish', 'Rats: Day 3 (Pro)', { callback = RatsPRODay3DeathWish } )
--[[ Elephant Deathwish ]]--
JobMenuNew:addOption('elephant_deathwish', 'Framing Frame: Day 1', { callback = FramingFrameDay1DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Framing Frame: Day 2', { callback = FramingFrameDay2DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Framing Frame: Day 3', { callback = FramingFrameDay3DeathWish } )
JobMenuNew:addGap('elephant_deathwish')
JobMenuNew:addOption('elephant_deathwish', 'Election Day: Day 1', { callback = ElectionDayDay1DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Election Day: Day 2', { callback = ElectionDayDay2DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Election Day: Day 3', { callback = ElectionDayDay3DeathWish } )
JobMenuNew:addGap('elephant_deathwish')
JobMenuNew:addGap('elephant_deathwish')
JobMenuNew:addGap('elephant_deathwish')
JobMenuNew:addOption('elephant_deathwish', 'Framing Frame: Day 1 (Pro)', { callback = FramingFramePRODay1DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Framing Frame: Day 2 (Pro)', { callback = FramingFramePRODay2DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Framing Frame: Day 3 (Pro)', { callback = FramingFramePRODay3DeathWish } )
JobMenuNew:addGap('elephant_deathwish')
JobMenuNew:addOption('elephant_deathwish', 'Election Day: Day 1 (Pro)', { callback = ElectionDayPRODay1DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Election Day: Day 2 (Pro)', { callback = ElectionDayPRODay2DeathWish } )
JobMenuNew:addOption('elephant_deathwish', 'Election Day: Day 3 (Pro)', { callback = ElectionDayPRODay3DeathWish } )
--[[ Vlad Deathwish ]]--
JobMenuNew:addOption('vlad_deathwish', 'Four Stores', { callback = FourStoresDeathWish } )
JobMenuNew:addOption('vlad_deathwish', 'Mallcrasher', { callback = MallCrasherDeathWish } )
JobMenuNew:addOption('vlad_deathwish', 'Nightclub', { callback = NightclubDeathWish } )
JobMenuNew:addOption('vlad_deathwish', 'Ukrainian Job (Pro)', { callback = UkrainianJobPRODeathWish } )

if not inGame() and not inTitlescreen() then
    if JobMenuNew:isOpen() then
        JobMenuNew:close()
    else
        JobMenuNew:open()
    end
end