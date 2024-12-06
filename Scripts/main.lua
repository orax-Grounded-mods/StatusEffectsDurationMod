local string, pairs, print = string, pairs, print

IsFirstInit = true

local info = debug.getinfo(1, "S")
local modsDirectory = info.source:match("@?(.+\\Mods)\\")
dofile(string.format("%s\\StatusEffectsDurationMod\\options.lua", modsDirectory))

local function LogNewDuration(duration, filter)
    print(string.format("Set new duration: %s; filter: %s\n", duration, filter))
end

local function OnFirstInit()
    local function SetCustomTimeElapsed(statusEffect)
        local duration = statusEffect.GetDuration()

        -- test if duration is infinite
        if duration == math.huge then
            return
        end

        if LOGGING then
            print(string.format("effect: %s; duration: %s\n",
                statusEffect.StatusEffectRowHandle.RowName:ToString(), duration))
        end

        for nameKey, customDuration in pairs(FilteredByName) do
            if nameKey == statusEffect.StatusEffectRowHandle.RowName:ToString() then
                LogNewDuration(customDuration, "FilteredByName")
                statusEffect.TimeElapsed = -(customDuration - duration)
                return
            end
        end

        for durationKey, customDuration in pairs(FilteredByOriginalDuration) do
            if durationKey == duration then
                LogNewDuration(customDuration, "FilteredByOriginalDuration")
                statusEffect.TimeElapsed = -(customDuration - duration)
                return
            end
        end

        if __ALL__ ~= nil then
            LogNewDuration(__ALL__, "__ALL__")
            statusEffect.TimeElapsed = -(__ALL__ - duration)
        end
    end

    RegisterHook("/Script/Maine.HealthComponent:OnStatusEffectChanged", function(self, owner, statusEffect)
        SetCustomTimeElapsed(statusEffect:get())
    end)

    -- This hook will not work in multiplayer mode.
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

if not LOGGING then
    LogNewDuration = function(...) end
end

if FindFirstOf('SurvivalPlayerCharacter'):IsValid() then
    Init()
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", Init)
