local HttpService = game:GetService("HttpService")

local BagrogiWebhooker = {}
BagrogiWebhooker.__index = BagrogiWebhooker

BagrogiWebhooker.DefaultRetries = 3
BagrogiWebhooker.DefaultTimeout = 10


local Request = http and http.request or http_request or request



local function TryRequest(Url, BodyJson)
	local ReqTable = {
		Url = Url,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			["User-Agent"] = "BagrogiWebhooker/1",
		},
		Body = BodyJson,
	}

	if la_exists then
		local Ok, Res = pcall(function()
			la_send_webhook(Url, BodyJson)
		end)

		if not Ok then
			warn("😭 ", Res)
		end
		return
	end

	if Request then
		local Ok, Res = pcall(Request, ReqTable)
		if not Ok then
			warn("Error making request:", Res)
		end
	else
		warn("No Normal Request Function????")
	end
end

local function SafeDecode(Json)
	local Ok, Data = pcall(HttpService.JSONDecode, HttpService, Json or "")
	if Ok then
		return Data
	end
	return nil
end

local function New(WebhookUrl)
	assert(type(WebhookUrl) == "string" and WebhookUrl:match("^https?://"), "Invalid webhook URL")
	local self = setmetatable({}, BagrogiWebhooker)
	self.Url = WebhookUrl
	self.MaxRetries = BagrogiWebhooker.DefaultRetries
	self.Timeout = BagrogiWebhooker.DefaultTimeout
	return self
end

local function CreateEmbed(Title, Description, Color, Fields, Footer, Timestamp)
	local Embed = {}
	if Title then
		Embed.title = tostring(Title)
	end
	if Description then
		Embed.description = tostring(Description)
	end
	if Color then
		Embed.color = tonumber(Color)
	end
	if Fields then
		Embed.fields = Fields
	end
	if Footer then
		Embed.footer = {}
		if Footer.text then
			Embed.footer.text = tostring(Footer.text)
		end
		if Footer.icon_url then
			Embed.footer.icon_url = tostring(Footer.icon_url)
		end
	end
	if Timestamp then
		Embed.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
	end
	return Embed
end

function BagrogiWebhooker.Send(Self, Content, Opts)
	Opts = Opts or {}
	local Payload = {}

	if Content and Content ~= "" then
		Payload.content = tostring(Content)
	end
	if Opts.username then
		Payload.username = tostring(Opts.username)
	end
	if Opts.avatar_url then
		Payload.avatar_url = tostring(Opts.avatar_url)
	end
	if Opts.tts ~= nil then
		Payload.tts = not not Opts.tts
	end
	if Opts.embeds then
		Payload.embeds = Opts.embeds
	end
	if Opts.allowed_mentions then
		Payload.allowed_mentions = Opts.allowed_mentions
	end

	local BodyJson = HttpService:JSONEncode(Payload)

	local Attempt = 0
	while Attempt < Self.MaxRetries do
		Attempt = Attempt + 1
		local Res = TryRequest(Self.Url, BodyJson) or {}
		local Sc = tonumber(Res.StatusCode) or 0

		if Res.Success and (Sc == 204 or Sc == 200 or Sc == 201) then
			return true, Res
		end

		if Sc == 429 then
			local Body = SafeDecode(Res.Body)
			local RetryAfter = 1
			if Body and Body.retry_after then
				local Raw = tonumber(Body.retry_after) or 0
				if Raw > 10 then
					RetryAfter = Raw / 1000
				else
					RetryAfter = Raw
				end
			end
			task.wait(RetryAfter)
		else
			return false, Res.Body or ("StatusCode: " .. tostring(Sc))
		end
	end

	return false, "Exceeded retries."
end

function BagrogiWebhooker.SendEmbed(Self, Content, EmbedTable, Opts)
	Opts = Opts or {}
	Opts.embeds = { EmbedTable }
	return BagrogiWebhooker.Send(Self, Content, Opts)
end

return {
	New = New,
	CreateEmbed = CreateEmbed,
}
