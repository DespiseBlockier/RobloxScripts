local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local Request = http and http.request or http_request or request

local function Check(WebhookUrl, ExtraData)
	local Hwid = gethwid()
	local Executor, Version = identifyexecutor()

	local logData = {
		embeds = {
			{
				title = "Bagrogi Hub Ran",
				color = 15193302,
				fields = {
					{ name = "Player", value = Player.Name, inline = true },
					{ name = "Executor", value = tostring(Executor), inline = true },
					{ name = "PlaceId", value = tostring(game.PlaceId), inline = true },
					{ name = "User ID", value = tostring(Player.UserId), inline = true },
					{ name = "Version", value = tostring(Version), inline = true },
					{ name = "JobId", value = tostring(game.JobId), inline = true },
					{ name = "Hwid", value = "||" .. tostring(Hwid) .. "||", inline = true },
					{ name = "Extra Info", value = HttpService:JSONEncode(ExtraData or {}), inline = false },
				},
				footer = { text = os.date("%d/%m %H:%M") },
			},
		},
	}

	local JsonData = HttpService:JSONEncode(logData)

	pcall(function()
		Request({
			Url = WebhookUrl,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = JsonData,
		})
	end)
end

return { Check = Check }
