local TweenService = game:GetService("TweenService")
local CoreGui = gethui() or game:GetService("CoreGui")

local MyRepo = "https://raw.githubusercontent.com/DespiseBlockier/RobloxScripts/refs/heads/main/Jailbreak"
local BagrogiSounds = loadstring(game:HttpGet(MyRepo .. "/BagrogiModules/BagrogiSounds.lua"))()

local BagrogiNotifier = {}
BagrogiNotifier.__index = BagrogiNotifier

local DisplayFrame = nil

local function MakeInstance(Inst, Settings)
	local MadeInst = Instance.new(Inst)

	for Property, Value in Settings do
		MadeInst[Property] = Value
	end

	return MadeInst
end

local function MakeUi()
	local NotifFrame = MakeInstance("Frame", {
		Parent = DisplayFrame,
		BackgroundColor3 = Color3.fromRGB(255, 134, 163),
		Size = UDim2.fromScale(1, 0.1032),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Name = "NotifFrame",
		Visible = false,

		LayoutOrder = os.clock(),
	})
	MakeInstance("UICorner", {
		Parent = NotifFrame,
		CornerRadius = UDim.new(1, 0),
	})
	MakeInstance("TextLabel", {
		Parent = NotifFrame,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextSize = 14,
		Font = Enum.Font.Merriweather,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(0.387, 0.36364),
		Text = "Title",
		Name = "Title",
		Position = UDim2.fromScale(0.25077, 0.18182),
	})
	MakeInstance("TextLabel", {
		Parent = NotifFrame,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Merriweather,
		TextWrapped = true,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextSize = 14,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(0.87926, 0.61364),
		Text = "Message",
		Name = "Message",
		Position = UDim2.fromScale(0.49961, 0.67322),
	})
	MakeInstance("Frame", {
		Parent = NotifFrame,
		BackgroundColor3 = Color3.fromRGB(91, 51, 81),
		Size = UDim2.fromScale(0.88235, 0.02273),
		Position = UDim2.fromScale(0.05882, 0.35),
		Name = "Type",
	})
	MakeInstance("TextButton", {
		Parent = NotifFrame,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Name = "Close",
		Text = "",
	})

	return NotifFrame
end

local function Init()
	local BagrogiDisplayFrame = CoreGui:FindFirstChild("BagrogiDisplayFrame")
	if not BagrogiDisplayFrame then
		BagrogiDisplayFrame = MakeInstance("ScreenGui", {
			Parent = CoreGui,
			IgnoreGuiInset = true,
			Name = "BagrogiDisplayFrame",
		})
		local Frame = MakeInstance("Frame", {
			Parent = BagrogiDisplayFrame,
			Size = UDim2.fromScale(0.20956, 0.49911),
			Position = UDim2.fromScale(0.79044, 0.36767),
			Name = "Frame",
			BackgroundTransparency = 1,
		})
		MakeInstance("UIListLayout", {
			Parent = Frame,
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
	end
	DisplayFrame = BagrogiDisplayFrame.Frame
end

local function New(Data)
	assert(DisplayFrame, "Unable to get the display frame")
	assert(Data["Message"], "Notification contains no message")
	local self = setmetatable({}, BagrogiNotifier)
	self.Gui = MakeUi()
	self.Data = Data
	return self
end

function BagrogiNotifier:Destroy()
	if not self.Gui then
		return
	end

	self.Gui.Message.Text = ""
	self.Gui.Title.Text = ""
	self.Gui.Close.Interactable = false
	
	local HideTween = TweenService:Create(
		self.Gui,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Size = UDim2.fromScale(0, 0) }
	)
	
	HideTween:Play()
	BagrogiSounds.PlaySound("UiPop2")

	HideTween.Completed:Once(function()
		if self.Connection then
			self.Connection:Disconnect()
			self.Connection = nil
		end
		if self.Thread then
			task.cancel(self.Thread)
			self.Thread = nil
		end
		self.Gui:Destroy()
		self.Gui = nil
		table.clear(self)
	end)
end

function BagrogiNotifier:Send(Time)
	local Gui = self.Gui
	local Message = self.Data.Message
	local Title = self.Data.Title or "Untitled Notification"
	local UiTime = Time or 4
	local CurrentSize = Gui.Size

	Gui.Size = UDim2.fromScale(0, 0)
	Gui.Message.Text = Message
	Gui.Title.Text = Title
	Gui.Visible = true

	local AppearTween = TweenService:Create(
		Gui,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Size = CurrentSize }
	)

	AppearTween:Play()
	BagrogiSounds.PlaySound("UiPop")

	self.Connection = Gui.Close.MouseButton1Click:Connect(function()
		self:Destroy()
	end)

	self.Thread = task.spawn(function()
		task.wait(UiTime)
		if self.Gui then
			self:Destroy()
		end
	end)
end

return {
	Init = Init,
	New = New,
}
