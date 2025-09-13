local BagrogiHeartBeat = {}
local RunService = game:GetService("RunService")

local Listeners = {}

function BagrogiHeartBeat.Connect(Func)
	if type(Func) == "function" then
		table.insert(Listeners, Func)
		return Func
	else
		warn("BagrogiHeartBeat: Attempted to connect a non-function.")
	end
end

function BagrogiHeartBeat.Disconnect(Func)
	for Index, Listener in ipairs(Listeners) do
		if Listener == Func then
			table.remove(Listeners, Index)
			break
		end
	end
end

function BagrogiHeartBeat.DisconnectAll()
	for k in pairs(Listeners) do
		Listeners[k] = nil
	end
end

if getgenv().BagrogiHeartBeat then
    getgenv().BagrogiHeartBeat:Disconnect()
end

local LastTime = tick()
getgenv().BagrogiHeartBeat = RunService.Heartbeat:Connect(function()
	local CurrentTime = tick()
	local DeltaTime = CurrentTime - LastTime
	LastTime = CurrentTime

	for _, Func in ipairs(Listeners) do
		local Success, Err = pcall(Func, DeltaTime)
		if not Success then
			warn("BagrogiHeartBeat: Error in connected function:", Err)
		end
	end
end)

return BagrogiHeartBeat
