-- Status effects duration

---@type _LogLevel
-- Enable logging to see the names of the effects your player gets.
-- The log are write in the `UE4SS.log` file and in the UE4SS GUI Console.
-- Edit `UE4SS-settings.ini` to enable the UE4SS GUI Console (in [Debug] section).
-- If the GUI is blank (bug): in `UE4SS-settings.ini`, set `GraphicsAPI = dx11`.
-- See:
--   https://docs.ue4ss.com/feature-overview/live-view.html
--   https://docs.ue4ss.com/installation-guide.html?highlight=console#how-to-verify-that-ue4ss-is-running-successfully
-- Remove the "--" at the beginning of the next line to enable logging.
--LOG_LEVEL = "DEBUG"

--[[
  Syntax:
    <name> = <new_duration>

    For information: the <name> corresponds to the RowName property in the Table_StatusEffects datatable.
    You can also enable logging to see this name in the `UE4SS.log` file.

  Example:
    SmallHoT = 120 => means that the buff with the name "SmallHoT"
    will now have a duration of 120 seconds.
]]
FilteredByName = {
    -- SmallHoT is the effect "+Trickle Regen" when you use a "Fiber Bandage".
    -- https://grounded.fandom.com/wiki/Status_Effects#Trickle_Regen
    SmallHoT = 60 * 60 * 23 -- 60 * 60 * 23 = 82800 seconds = 23 hours
}

--[[
  Syntax:
    [<original_duration>] = <new_duration>
  Example:
    [50] = 120 => means that any buff that had a duration of 50 seconds
    will now have a duration of 120 seconds.
]]
FilteredByOriginalDuration = {
    [50] = 120,   -- 120 seconds is 2 minutes
    [120] = 600,  -- 600 seconds is 10 minutes
    [240] = 1200, -- 1200 seconds is 20 minutes
    [900] = 3600  -- 3600 seconds is 1 hour
}
-- end -- Status effect duration
