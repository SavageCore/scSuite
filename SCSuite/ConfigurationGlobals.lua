function LocalizationStringManagerCallBack(string_id)
          DynamicallyUpdateConfiguration(tostring(tweak_data.SCSuiteConfiguration.localization_strings[string_id]))
          tweak_data.SCSuiteConfiguration[tweak_data.SCSuiteConfiguration.localization_strings[string_id]] = not tweak_data.SCSuiteConfiguration[tweak_data.SCSuiteConfiguration.localization_strings[string_id]]
end

function DynamicallyUpdateConfiguration(custom_string_name)
          local file = io.open("SCSuite/Configuration.lua", "r")
          local content = file:read("*a")
          local file = io.open("SCSuite/Configuration.lua", "w")
          local custom_string = "self." .. custom_string_name .. " = " .. tostring(tweak_data.SCSuiteConfiguration[custom_string_name])
          local custom_string_output_value = "self." .. custom_string_name .. " = " .. tostring(not tweak_data.SCSuiteConfiguration[custom_string_name])
          local output = string.gsub(content, custom_string, custom_string_output_value)
          file:write(output)
          file:close()
end
  
function LocalizationStringManagerMultiChoiceCallBack(string_id, value)
    local new_value = "multichoice" .. tostring(value)
    DynamicallyUpdateMultiChoiceInConfiguration(tostring(tweak_data.SCSuiteConfiguration.localization_strings[string_id]), tostring(tweak_data.SCSuiteConfiguration.localization_strings[new_value]))
    tweak_data.SCSuiteConfiguration[tweak_data.SCSuiteConfiguration.localization_strings[string_id]] = tostring(tweak_data.SCSuiteConfiguration.localization_strings[new_value])
end

function DynamicallyUpdateMultiChoiceInConfiguration(string_id, value)
    local file_path = "SCSuite/Configuration.lua"
    local file = io.open(file_path, "r")
    local content = file:read("*a")
    local file = io.open(file_path, "w")
    local string_id_search = "self." .. string_id .. " = \"" .. tostring(tweak_data.SCSuiteConfiguration[string_id]) .. "\" "
    local string_id_reconfiguration = "self." .. string_id .. " = \"" .. tostring(value) .. "\" "
    local output = string.gsub(content, string_id_search, string_id_reconfiguration)
    file:write(output)
    file:close()
end

function LocalizationStringManagerSliderCallBack(string_id, value)
    DynamicallyUpdateSlidersInConfiguration(tostring(tweak_data.SCSuiteConfiguration.localization_strings[string_id]), tostring(math.floor(value + 0.5)))
    tweak_data.SCSuiteConfiguration[tweak_data.SCSuiteConfiguration.localization_strings[string_id]] = tostring(math.floor(value + 0.5))
end

function DynamicallyUpdateSlidersInConfiguration(string_id, value)
    local file_path = "SCSuite/Configuration.lua"
    local file = io.open(file_path, "r")
    local content = file:read("*a")
    local file = io.open(file_path, "w")
    local string_id_search = "self." .. string_id .. " = " .. tostring(tweak_data.SCSuiteConfiguration[string_id])
    local string_id_reconfiguration = "self." .. string_id .. " = " .. value
    local output = string.gsub(content, string_id_search, string_id_reconfiguration)
    file:write(output)
    file:close()
end

function LocalizationStringManagerBooleanCallBack(string_id)
    DynamicallyUpdateBooleansInConfiguration(tostring(tweak_data.SCSuiteConfiguration.localization_strings[string_id]))
    tweak_data.SCSuiteConfiguration[tweak_data.SCSuiteConfiguration.localization_strings[string_id]] = not tweak_data.SCSuiteConfiguration[tweak_data.SCSuiteConfiguration.localization_strings[string_id]]
end

function DynamicallyUpdateBooleansInConfiguration(string_id)
    local file_path = "SCSuite/Configuration.lua"
    local file = io.open(file_path, "r")
    local content = file:read("*a")
    local file = io.open(file_path, "w")
    local string_id_search = "self." .. string_id .. " = " .. tostring(tweak_data.SCSuiteConfiguration[string_id])
    local string_id_reconfiguration = "self." .. string_id .. " = " .. tostring(not tweak_data.SCSuiteConfiguration[string_id])
    local output = string.gsub(content, string_id_search, string_id_reconfiguration)
    file:write(output)
    file:close()
end  