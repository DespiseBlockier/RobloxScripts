--// Adonis bypass edited by DespiseBlockier (sorry, don't know who made the original one, I just kinda skidded it)

--//  variables
local getinfo = getinfo or debug.getinfo
getgenv().AdonisBypass = getgenv().AdonisBypass or false
getgenv().AdonisDebug = getgenv().AdonisDebug or false
local AlreadyHooked = getgenv().AdonisBypass
local Hooked = {}

if AlreadyHooked then
    if getgenv().AdonisDebug then
        warn("Adonis bypass already hooked, skipping")
    end
    return
else
    getgenv().AdonisBypass = true
end

local Detected, Kill

setthreadidentity(2)

for _, Table in getgc(true) do
    if typeof(Table) == "table" then
        local DetectFunc = rawget(Table, "Detected")
        local KillFunc = rawget(Table, "Kill")

        -- Hook the "Detected" function if found
        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc
            local Old
            Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if getgenv().AdonisDebug then
                        warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                    end
                end

                return true
            end)
            table.insert(Hooked, Detected)
        end

        if rawget(Table, "Variables") and rawget(Table, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old
            Old = hookfunction(Kill, function(Info)
                if getgenv().AdonisDebug then
                    warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                end
            end)
            table.insert(Hooked, Kill)
        end
    end
end

local Old
Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if getgenv().AdonisDebug then
            warn(`Adonis AntiCheat sanity check detected and broken`)
        end

        return coroutine.yield(coroutine.running())
    end

    return Old(...)
end))

setthreadidentity(7)
