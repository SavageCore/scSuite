if not managers then return end
if not managers.chat then return end
if tweak_data.SCSuiteConfiguration.instant_drill_override_enable then return end
if tweak_data and tweak_data.SCSuiteConfiguration.drill_jam_override_enable then
    --if not tweak_data.SCSuiteLocalisation then Console("not") return end
    if not TimerGui then return end
    if not SCSuiteStatus then return end
    if not isPlaying() then return end
    if isHost() then
        if not instadrill then
            instadrill = true
            -- DISABLE DRILL JAM
            if not _jamValue then _jamValue = TimerGui._set_jamming_values end
            function TimerGui:_set_jamming_values() return end
        end
    end
end        