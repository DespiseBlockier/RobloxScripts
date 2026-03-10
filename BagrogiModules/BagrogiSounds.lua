local Workspace = game:GetService("Workspace")

local Repo = "https://github.com/DespiseBlockier/RobloxScripts/raw/refs/heads/main/Sounds/"
BagrogiSoundsFolder = BagrogiSoundsFolder or "Bagrogi/Default/Sounds/"
local FileLocation = BagrogiSoundsFolder or nil

local function FolderCheck(Path)
	if not isfolder(Path) then
		makefolder(Path)
	end
end

local function PlaySound(SoundName)
	if FileLocation == nil then
		warn("[PlaySound] No file location provided for sounds. Please set BagrogiSoundsFolder to a valid path.")
		return false
	end
	FolderCheck(FileLocation)

	local FilePath = FileLocation .. SoundName .. ".mp3"
	if not isfile(FilePath) then
		local Success, Result = pcall(function()
			return game:HttpGet(Repo .. SoundName .. ".txt")
		end)

		if not Success then
			warn("[PlaySound] Failed to fetch: " .. tostring(Result))
			return false
		end

		writefile(FilePath, Result)
	end

	local AssetId = getcustomasset(FilePath)
	local Sound = Instance.new("Sound")
	Sound.Name = SoundName
	Sound.Parent = Workspace
	Sound.SoundId = AssetId
	Sound.Volume = 0.35
	Sound.PlayOnRemove = true
	Sound:Destroy()

	return true
end

return { PlaySound = PlaySound }
