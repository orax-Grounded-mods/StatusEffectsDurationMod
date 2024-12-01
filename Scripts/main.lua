local utils = require("lua-mods-libs.utils")
local logging = require("lua-mods-libs.logging")

local string, pairs = string, pairs

LOG_LEVEL = "INFO" ---@type _LogLevel
IsFirstInit = true

dofile(string.format("%s\\%s\\options.lua", utils.mod.modsDirectory, utils.mod.name))

local log = __LOGGER or logging.new(LOG_LEVEL, "ERROR")

local function OnFirstInit()
    local function SetCustomTimeElapsed(statusEffect)
        local duration = statusEffect.GetDuration()

        -- test if duration is infinite
        if duration == math.huge then
            return
        end

        log.debug(statusEffect.StatusEffectRowHandle.RowName:ToString(), duration)

        for nameKey, customDuration in pairs(FilteredByName) do
            if nameKey == statusEffect.StatusEffectRowHandle.RowName:ToString() then
                statusEffect.TimeElapsed = -(customDuration - duration)
                return
            end
        end

        for durationKey, customDuration in pairs(FilteredByOriginalDuration) do
            if durationKey == duration then
                statusEffect.TimeElapsed = -(customDuration - duration)
                return
            end
        end
    end

    RegisterHook("/Game/UI/StatusEffects/UI_StatusEffectTimer.UI_StatusEffectTimer_C:Initialize",
        function(self, statusEffectUParam, addedThisFrameUParam)
            local statusEffect = statusEffectUParam:get()
            local addedThisFrame = addedThisFrameUParam:get()

            -- check if the effect has just been added
            if addedThisFrame then
                SetCustomTimeElapsed(statusEffect)
            end
        end)

    RegisterHook("/Game/UI/StatusEffects/UI_StatusEffectTimer.UI_StatusEffectTimer_C:OnTimerReset",
        function(self, statusEffectUParam)
            local statusEffect = statusEffectUParam:get()

            SetCustomTimeElapsed(statusEffect)
        end)
end

local function Init()
    if IsFirstInit == true then
        OnFirstInit()
    end

    IsFirstInit = false
end

if FindFirstOf('SurvivalPlayerCharacter') then
    Init()
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", Init)
