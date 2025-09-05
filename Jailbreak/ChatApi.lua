local TextService = game:GetService("TextService")

local UI = {}
local CoreUi = gethui() or game:GetService("CoreGui")
getgenv().ScreenUi = getgenv().ScreenUi or nil
local ScreenUi = getgenv().ScreenUi

local MAX_WIDTH_SCALE = 0.8
local HORIZONTAL_PADDING = 10
local VERTICAL_PADDING = 6
local STACK_PADDING = 6

local function MakeUi(GPxstaApi)
	if ScreenUi then
		ScreenUi:Destroy()
	end
	
	UI["1"] = Instance.new("ScreenGui", CoreUi)
	UI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	UI["1"]["ResetOnSpawn"] = false

	UI["2"] = Instance.new("Frame", UI["1"])
	UI["2"]["BorderSizePixel"] = 2
	UI["2"]["BackgroundColor3"] = Color3.fromRGB(255, 29, 245)
	UI["2"]["AnchorPoint"] = Vector2.new(0, 1)
	UI["2"]["Size"] = UDim2.new(0.32829, 0, 0.26748, 0)
	UI["2"]["Position"] = UDim2.new(0, 0, 1, 0)
	UI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)

	UI["3"] = Instance.new("ScrollingFrame", UI["2"])
	UI["3"]["Active"] = true
	UI["3"]["BorderSizePixel"] = 2
	UI["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["3"]["Name"] = [[TextMsgs]]
	UI["3"]["Size"] = UDim2.new(0.83738, 0, 0.71023, 0)
	UI["3"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0)
	UI["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)

	UI["4"] = Instance.new("UIListLayout", UI["3"])
	UI["4"]["SortOrder"] = Enum.SortOrder.LayoutOrder

	UI["5"] = Instance.new("TextButton", UI["2"])
	UI["5"]["TextWrapped"] = true
	UI["5"]["TextSize"] = 14
	UI["5"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
	UI["5"]["TextScaled"] = true
	UI["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	UI["5"]["Size"] = UDim2.new(0.16262, 0, 0.28977, 0)
	UI["5"]["Name"] = [[SendMessage]]
	UI["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	UI["5"]["Text"] = [[Send]]
	UI["5"]["Position"] = UDim2.new(0.83495, 0, 0.71023, 0)

	UI["6"] = Instance.new("TextBox", UI["2"])
	UI["6"]["CursorPosition"] = -1
	UI["6"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
	UI["6"]["TextWrapped"] = true
	UI["6"]["TextSize"] = 14
	UI["6"]["Name"] = [[TypeMsgs]]
	UI["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Merriweather.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	UI["6"]["ClearTextOnFocus"] = false
	UI["6"]["Size"] = UDim2.new(0.83738, 0, 0.28977, 0)
	UI["6"]["Position"] = UDim2.new(0, 0, 0.71023, 0)
	UI["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	UI["6"]["Text"] = [[]]

	UI["7"] = Instance.new("TextButton", UI["2"])
	UI["7"]["TextWrapped"] = true
	UI["7"]["TextSize"] = 14
	UI["7"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
	UI["7"]["TextScaled"] = true
	UI["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	UI["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
	UI["7"]["Size"] = UDim2.new(0.06068, 0, 0.14205, 0)
	UI["7"]["Name"] = [[DeleteUi]]
	UI["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	UI["7"]["Text"] = [[X]]
	UI["7"]["Position"] = UDim2.new(0.96845, 0, 0.0625, 0)

	UI["8"] = Instance.new("TextLabel", UI["2"])
	UI["8"]["TextWrapped"] = true
	UI["8"]["TextScaled"] = true
	UI["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["8"]["TextSize"] = 14
	UI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	UI["8"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
	UI["8"]["Size"] = UDim2.new(0.16019, 0, 0.32955, 0)
	UI["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	UI["8"]["Text"] = [[Bagrogi Chat (Credits to @pxsta72)]]
	UI["8"]["Name"] = [[Credits]]
	UI["8"]["Position"] = UDim2.new(1.02913, 0, 0.67045, 0)

	UI["9"] = Instance.new("LocalScript", UI["2"])


	UI["a"] = Instance.new("TextButton", UI["2"])
	UI["a"]["TextWrapped"] = true
	UI["a"]["TextSize"] = 14
	UI["a"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
	UI["a"]["TextScaled"] = true
	UI["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	UI["a"]["AnchorPoint"] = Vector2.new(0, 1)
	UI["a"]["Size"] = UDim2.new(0.15291, 0, 0.14205, 0)
	UI["a"]["Name"] = [[ShowUi]]
	UI["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	UI["a"]["Text"] = [[Show]]
	UI["a"]["Visible"] = false
	UI["a"]["Position"] = UDim2.new(0, 0, -0.06818, 0)

	UI["b"] = Instance.new("TextButton", UI["2"])
	UI["b"]["TextWrapped"] = true
	UI["b"]["TextSize"] = 14
	UI["b"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
	UI["b"]["TextScaled"] = true
	UI["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	UI["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	UI["b"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
	UI["b"]["Size"] = UDim2.new(0.06068, 0, 0.14205, 0)
	UI["b"]["Name"] = [[HideUi]]
	UI["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	UI["b"]["Text"] = [[-]]
	UI["b"]["Position"] = UDim2.new(0.96845, 0, 0.20455, 0)
	
	ScreenUi = UI["1"]
	
	local MainFrame = ScreenUi.Frame
	local TextMsgsFrame = MainFrame.TextMsgs
	local HideUiButton = MainFrame.HideUi
	local ShowUiButton = MainFrame.ShowUi
	local DeleteUiButton = MainFrame.DeleteUi
	local TypeMsgFrame = MainFrame.TypeMsgs
	local SendMessageButton = MainFrame.SendMessage
	
	TypeMsgFrame.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local txt = TypeMsgFrame.Text
			if txt and txt:match("%S") then
				GPxstaApi.sendMessage(txt)
				TypeMsgFrame.Text = ""
			end
		end
	end)

	SendMessageButton.MouseButton1Click:Connect(function()
		local txt = TypeMsgFrame.Text
		if txt and txt:match("%S") then
			GPxstaApi.sendMessage(txt)
			TypeMsgFrame.Text = ""
		end
	end)

	HideUiButton.MouseButton1Click:Connect(function()
		MainFrame.AnchorPoint = Vector2.new(0,0) 
		ShowUiButton.Visible = true
		ShowUiButton.Active = true
		DeleteUiButton.Visible = false
		DeleteUiButton.Active = false
	end)

	ShowUiButton.MouseButton1Click:Connect(function()
		MainFrame.AnchorPoint = Vector2.new(0,1) 
		ShowUiButton.Visible = false
		ShowUiButton.Active = false
		DeleteUiButton.Visible = true
		DeleteUiButton.Active = true
	end)

	DeleteUiButton.MouseButton1Click:Connect(function()
		MainFrame.Parent:Destroy()
	end)
end

local function updateCanvas()
	task.defer(function()
		local contentY = ScreenUi.Frame.TextMsgs.UIListLayout.AbsoluteContentSize.Y
		ScreenUi.Frame.TextMsgs.CanvasSize = UDim2.new(0, 0, 0, contentY + STACK_PADDING)
		ScreenUi.Frame.TextMsgs.CanvasPosition = Vector2.new(0, math.max(0, contentY - ScreenUi.Frame.TextMsgs.AbsoluteSize.Y))
	end)
end

local function AddMessage(Data, Message)
	if not ScreenUi then return end
	if not Message or Message == "" then return end

	local MaxPixels = math.floor(ScreenUi.Frame.TextMsgs.AbsoluteSize.X * MAX_WIDTH_SCALE)
	local Font = Enum.Font.Merriweather
	local TextSize = 18

	local bounds = TextService:GetTextSize(Message, TextSize, Font, Vector2.new(MaxPixels, math.huge))

	local NewLabel = Instance.new("TextLabel")
	NewLabel.Name = "ChatMessage"
	NewLabel.BackgroundTransparency = 1
	NewLabel.Text = Message
	NewLabel.TextWrapped = true
	NewLabel.RichText = false
	NewLabel.TextSize = TextSize
	NewLabel.Font = Font
	NewLabel.Size = UDim2.new(0, math.clamp(bounds.X + HORIZONTAL_PADDING, 20, MaxPixels), 0, bounds.Y + VERTICAL_PADDING)
	NewLabel.AnchorPoint = Vector2.new(0, 0)
	NewLabel.TextXAlignment = Enum.TextXAlignment.Left
	NewLabel.TextYAlignment = Enum.TextYAlignment.Top
	NewLabel.LayoutOrder = Data.time
	NewLabel.Parent = ScreenUi.Frame.TextMsgs

	updateCanvas()
end

return {
	MakeUi = MakeUi;
	AddMessage = AddMessage
}
