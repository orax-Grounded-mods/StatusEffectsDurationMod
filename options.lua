-- Status effects duration options

-- Enable logging to see the names of the effects your player gets.
-- The log are write in the `UE4SS.log` file and in the UE4SS GUI Console.
-- Edit `UE4SS-settings.ini` to enable the UE4SS GUI Console (in [Debug] section).
-- If the GUI is blank (bug): in `UE4SS-settings.ini`, set `GraphicsAPI = dx11`.
-- See:
--   https://docs.ue4ss.com/feature-overview/live-view.html
--   https://docs.ue4ss.com/installation-guide.html?highlight=console#how-to-verify-that-ue4ss-is-running-successfully
-- Remove the "--" at the beginning of the next line to enable logging.
--LOGGING = true -- true or false

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
  SmallHoT = 60 * 60 * 23, -- 60 * 60 * 23 = 82800 seconds = 23 hours
}

--[[
  Syntax:
    [<original_duration>] = <new_duration>
  Example:
    [50] = 120 => means that any buff that had a duration of 50 seconds
    will now have a duration of 120 seconds.

  Notes:
    Remove the "--" (Lua commentary) at the beginning to enable the line.
    Example:
      -- [720] = 720,    (the line is disabled)
      [720] = 720,       (the line is enabled)
]]
FilteredByOriginalDuration = {
  [50] = 1200,  -- 120 seconds is 2 minutes
  [120] = 6000, -- 600 seconds is 10 minutes
  [240] = 1200, -- 1200 seconds is 20 minutes
  -- [720] = 720,
  -- [900] = 900,
  -- [960] = 960,
  -- [1200] = 1200
}

--[[
  __ALL__ is a special value.
  The duration here will be applied to all status effects not found by the filters below.
  Add a "--" (Lua commentary) at the begining of the line to disable it.

  Syntax:
    __ALL__ = <duration>
]]
__ALL__ = 60 * 60 * 23 -- 60 * 60 * 23 = 82800 seconds = 23 hours
