local Players = game:GetService("Players")

local Colors = {
	"shamrock",
	"camo",
	"green"
}

local BodyParts = {
	"Head",
	"LeftArm",
	"LeftLeg",
	"Torso",
	"RightArm",
	"RightLeg"
}

local function IsGreen(HumanoidDescription)
	if HumanoidDescription then
		for _, BodyPart in pairs(BodyParts) do
			local BrickColor = tostring(BrickColor.new(HumanoidDescription[BodyPart.. "Color"]))
			for _, Color in pairs(Colors) do
				if BrickColor:lower():match(Color) then
					return true
				end
			end
		end
	end
end

local function IsGreenBean(Player: Player)
	assert(Player, "No Player Found")
	local HumanoidDescription = Players:GetHumanoidDescriptionFromUserId(Player.UserId)
	assert(HumanoidDescription, "Cant Fetch Humanoid Description")
	if HumanoidDescription then
		local IsGreen = IsGreen(HumanoidDescription)
		local HasMediHood = HumanoidDescription.HatAccessory:match("617605556") and true or false
		return IsGreen, HasMediHood
	end
end

local function GetGreenBeanPlayers()
	local Plrs = {}
	for _, Player in Players:GetPlayers() do
		local IsGreen, HasMediHood = IsGreenBean(Player)
		if IsGreen and HasMediHood then
			table.insert(Plrs, Player)
		end
	end
	return Plrs
end

return {GetGreenBeanPlayers = GetGreenBeanPlayers}
