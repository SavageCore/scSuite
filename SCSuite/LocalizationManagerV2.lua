if not _LocalizationManager_text then _LocalizationManager_text = LocalizationManager.text end
    function LocalizationManager:text(string_id, macros)
        return tweak_data.SCSuiteConfiguration.localization_strings[string_id] or _LocalizationManager_text(self, string_id, macros)
end