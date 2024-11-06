local Data = _G.Data or {}

--// Use When Developing
local Banner = Data.Banner or _G.Banner or "11220387429"
local BlackScreen = Data.Dev or false
local HubName = Data.Name or "1halla Hub"
local HubInvite = Data.Invite or "Free"
local HubInfo = Data.Info or "Beta Version "
--[[
            UI Design by 1halla 
            Code by Rem
        
            Do not use without permission 
            Dn not Share this Ui
            Do not Modified the Source file 
            Do not Remove or Claim the Credit 
        
            also thank to 
            - Signal Module 
            - Fusion Framework [Sleithnick] [Minimize by REM]
            - Rem Hub Owner [He/She] is very cute!
        ]]
local function DesFormat(str)
	local str = tostring(str)
	local space = "    "
	-- name = name:gsub("%^a", "")
	return space .. str:gsub("\n", "\n" .. space)
end

-- Settings
local LIBRARY_NAME = "vahallalib"
-- Configs
local Children = "Children"
local OnCreate = "OnCreate"
-- 85, 255, 127
local ThemeList = {
	["Default"] = {
		Banner = "11220387429",
		MainColor = Color3.fromRGB(85, 255, 127),
		AccentColor = Color3.fromRGB(85, 255, 127),
		FontColor = Color3.fromRGB(255, 255, 255),
		Gradient = true,
		BackgroundColor = Color3.fromRGB(40, 40, 40),
		LeftBarColor = Color3.fromRGB(30, 30, 30),
		TopbarColor = Color3.fromRGB(20, 20, 20),
		ContainerBackground = Color3.fromRGB(100, 100, 100),
		TabContainerColor = Color3.fromRGB(30, 30, 30),
		SectionFrameColor = Color3.fromRGB(85, 255, 127),

		SliderBackgroundColor = Color3.fromRGB(30, 30, 30),
		DropdownBackgroundColor = Color3.fromRGB(60, 60, 60),
		-- Toggle
		ToggleBackgroundColor_Off = Color3.fromRGB(255, 83, 120),
		ToggleBackgroundColor_On = Color3.fromRGB(85, 255, 127),
		ToggleDotColor_Off = Color3.fromRGB(255, 255, 255),
		ToggleDotColor_On = Color3.fromRGB(30, 30, 30),

		-- Button
		ButtonTextColor = Color3.fromRGB(0, 0, 0),
	},
	["Hutao"] = {
		Banner = "11499908803",
		MainColor = Color3.fromRGB(255, 182, 80),
		AccentColor = Color3.fromRGB(255, 182, 80),
		FontColor = Color3.fromRGB(255, 255, 255),
		Gradient = true,
		BackgroundColor = Color3.fromRGB(40, 40, 40),
		LeftBarColor = Color3.fromRGB(30, 30, 30),
		TopbarColor = Color3.fromRGB(20, 20, 20),
		ContainerBackground = Color3.fromRGB(100, 100, 100),
		TabContainerColor = Color3.fromRGB(30, 30, 30),
		SectionFrameColor = Color3.fromRGB(255, 182, 80),

		SliderBackgroundColor = Color3.fromRGB(30, 30, 30),
		DropdownBackgroundColor = Color3.fromRGB(60, 60, 60),
		-- Toggle
		ToggleBackgroundColor_Off = Color3.fromRGB(255, 83, 120),
		ToggleBackgroundColor_On = Color3.fromRGB(255, 182, 80),
		ToggleDotColor_Off = Color3.fromRGB(255, 255, 255),
		ToggleDotColor_On = Color3.fromRGB(30, 30, 30),

		-- Button
		ButtonTextColor = Color3.fromRGB(0, 0, 0),
	},
}
-- Easy custom Theme
if _G.customTheme then
	for i, v in pairs(_G.customTheme) do
		ThemeList[i] = v
	end
end
local White = Color3.fromRGB(255, 255, 255)

local CurrentTheme = _G.Theme or ThemeList.Default
local function GetTheme(props)
	return CurrentTheme[props] or ThemeList["Default"][props]
end

local NoGradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0, CurrentTheme.MainColor),
	ColorSequenceKeypoint.new(1, CurrentTheme.MainColor),
})
local WithGradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0, CurrentTheme.MainColor),
	ColorSequenceKeypoint.new(1, CurrentTheme.AccentColor),
})
-- Variable
local themesobj = {}
local themesgradient = {}
local function AddtoThemeGradient(obj)
	table.insert(themesgradient, obj)
end
local function AddtoTheme(obj, props, link)
	table.insert(themesobj, {
		Instance = obj,
		Property = props,
		Link = link,
	})
end
local function GetThemeNameByThemeObject(obj)
	for i, v in pairs(ThemeList) do
		if v == obj then
			return tostring(i)
		end
	end
	return "Default"
end

local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local HttpService = game:GetService("HttpService")

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
-- Function
local Tween
local New
local TweenAll
local Create
local MakeDragable
local MakeClickArea
local ripple
local MakeDynamicScrolling
local MakeDynamicSize
local flagify

do
	function flagify(str)
		return str:gsub("%s+", "_"):lower()
	end

	function MakeDynamicScrolling(uilist, frame, add)
		local a = add or 0
		local Change = function()
			local ContentSize = uilist.AbsoluteContentSize.Y
			frame.CanvasSize = UDim2.fromOffset(0, ContentSize + a)
		end
		Change()
		uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(Change)
	end
	function MakeDynamicSize(uilist, frame)
		local ChangeSize = function()
			local ContentSize = uilist.AbsoluteContentSize.Y

			frame.Size = UDim2.new(1, 0, 0, ContentSize + 10)
		end
		ChangeSize()
		uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ChangeSize)
	end

	function MakeDragable(obj)
		local gui = obj
		local dragging
		local dragInput
		local dragStart
		local startPos
		local function update(input)
			local delta = input.Position - dragStart
			local EndPos =
				UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			local TW = game:GetService("TweenService")
				:Create(gui, TweenInfo.new(0.1, Enum.EasingStyle.Quad), { Position = EndPos })
			TW:Play()
			wait(1)
		end

		gui.InputBegan:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		gui.InputChanged:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch
			then
				dragInput = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end
	function Tween(obj, t, easingstyle, easingdirection, goal, cb)
		local callback = typeof(cb) == "function" and cb or function() end
		local style = typeof(easingstyle) == "EnumItem" and easingstyle or Enum.EasingStyle[easingstyle]
		local direction = typeof(easingdirection) == "EnumItem" and easingdirection
			or Enum.EasingDirection[easingdirection]

		local tween = TweenService:Create(obj, TweenInfo.new(t, style, direction), goal)
		tween:Play()
		tween.Completed:Connect(function()
			callback()
		end)
		return tween
	end
	function TweenAll(objs, t, easingstyle, easingdirection, cb)
		for i, v in pairs(objs) do
			Tween(i, t, easingstyle, easingdirection, {}, cb)
		end
	end
	function Create(classname, props, children)
		local children = typeof(children) == "table" and children or {}
		local properties = typeof(props) == "table" and props or {}
		local main = Instance.new(classname)
		for i, v in pairs(properties) do
			if i ~= "Time" then
				main[i] = v
			end
		end
		local LifeTime = properties["Time"] or nil
		if LifeTime then
			game.Debris:AddItem(main, LifeTime)
		end
		for _, v in pairs(children) do
			if typeof(v) == "function" then
				local ins = pcall(v)
				if typeof(ins) == "Instance" then
					ins.Parent = main
				end
			elseif typeof(v) == "Instance" then
				v.Parent = main
			end
		end

		return main
	end
	function New(classname)
		return function(props)
			local toCreate = {}
			local toChildren = {}

			for i, v in pairs(props) do
				if i ~= Children and i ~= OnCreate then
					toCreate[i] = v
				else
					if i ~= OnCreate then
						for a, b in pairs(v) do
							toChildren[a] = b
						end
					end
				end
			end
			local NewInstance = Create(classname, toCreate, toChildren)
			if typeof(props[OnCreate]) == "function" then
				props[OnCreate](NewInstance)
			end
			return NewInstance
		end
	end

	function ripple(obj)
		task.spawn(function()
			local Circle = Instance.new("ImageLabel")
			Circle.Name = "Circle"
			Circle.Parent = obj
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.ZIndex = 100
			Circle.Image = "rbxassetid://6082206725"
			Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Circle.ImageTransparency = 0.4
			local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
			local Size = 0
			if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.X * 1.5
			elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.Y * 1.5
			end
			TweenService:Create(Circle, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
				Size = UDim2.new(0, Size, 0, Size),
				Position = UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
				ImageTransparency = 1,
			}):Play()

			TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {

				ImageTransparency = 1,
			}):Play()

			wait(0.3)
			Circle:Destroy()
		end)

		do
			local Circle = Instance.new("ImageLabel")
			Circle.Name = "Circle"
			Circle.Parent = obj
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.ZIndex = 100
			Circle.Image = "rbxassetid://266543268"
			Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Circle.ImageTransparency = 0.8
			local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
			local Size = 0
			if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.X * 1.5
			elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.Y * 1.5
			end
			TweenService:Create(Circle, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
				Size = UDim2.new(0, Size, 0, Size),
				Position = UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
				ImageTransparency = 1,
			}):Play()

			TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {

				ImageTransparency = 1,
			}):Play()

			wait(0.3)
			Circle:Destroy()
		end
	end
	function MakeClickArea(obj, callback, nohoverfx)
		local NewClickArea = New("TextButton")({
			Parent = obj,
			ZIndex = 99,
			ClipsDescendants = true,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Text = "",
			AutoButtonColor = false,
			[Children] = {
				New("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 3),
				}),
			},
		})
		if not nohoverfx then
			NewClickArea.MouseEnter:Connect(function()
				Tween(NewClickArea, 0.1, "Linear", "In", {
					BackgroundTransparency = 0.9,
				})
			end)
			NewClickArea.MouseLeave:Connect(function()
				Tween(NewClickArea, 0.1, "Linear", "In", {
					BackgroundTransparency = 1,
				})
			end)
		end

		NewClickArea.MouseButton1Click:Connect(function()
			task.spawn(ripple, NewClickArea)
			-- ripple(NewClickArea)
			callback()
		end)

		return {
			Instance = NewClickArea,
		}
	end
end
do
	if BlackScreen then
		if not game.CoreGui:FindFirstChild("Nigga") then
			game:GetService("RunService"):Set3dRenderingEnabled(false)

			local Nigga = New("ScreenGui")({
				Name = "Nigga",
				Parent = game.CoreGui,
				IgnoreGuiInset = true,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

				[Children] = {
					New("Frame")({
						Name = "Frame",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(100, 100, 100),
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromScale(1, 1),
					}),
				},
			})
			for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
				if v:IsA("ScreenGui") and v.Enabled == true then
					v:SetAttribute("Visible", true)
					v.Enabled = false
				end
			end
		end
	else
		for i, v in pairs(game.CoreGui:GetChildren()) do
			if v.Name == "Nigga" then
				v:Destroy()
			end
		end
		for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
			if v:IsA("ScreenGui") and v:GetAttribute("Visible") ~= nil then
				v:SetAttribute("Visible", nil)
				v.Enabled = true
			end
		end

		game:GetService("RunService"):Set3dRenderingEnabled(true)
	end
end
-- Signal
local function GetSignal()
	-- I did not include debug traceback to make it as light-weight as possible
	local Signal = {}
	Signal.__index = Signal
	Signal.ClassName = "Signal"

	-- Constructor
	function Signal.new()
		return setmetatable({
			_bindable = Instance.new("BindableEvent"),

			_args = nil,
			_argCount = nil, -- To stay true to _args, even when some indexes are nil
		}, Signal)
	end

	function Signal:Fire(...)
		-- I use this method of arguments because when passing it in a bindable event, it creates a deep copy which makes it slower
		self._args = { ... }
		self._argCount = select("#", ...)

		self._bindable:Fire()
	end

	function Signal:fire(...)
		return self:Fire(...)
	end

	function Signal:Connect(handler)
		if not (type(handler) == "function") then
			error(("connect(%s)"):format(typeof(handler)), 2)
		end

		return self._bindable.Event:Connect(function()
			handler(unpack(self._args, 1, self._argCount))
		end)
	end

	function Signal:connect(...)
		return self:Connect(...)
	end

	function Signal:Wait()
		self._bindableEvent.Event:Wait()
		assert(self._argData, "Missing argument data, likely due to :TweenSize/Position corrupting.")
		return unpack(self._args, 1, self._argCount)
	end

	function Signal:wait()
		return self:Wait()
	end

	function Signal:Destroy()
		if self._bindable then
			self._bindable:Destroy()
			self._bindable = nil
		end

		self._args = nil
		self._argCount = nil

		setmetatable(self, nil)
	end

	function Signal:destroy()
		return self:Destroy()
	end

	return Signal
end

local Signal = GetSignal()
local ChangeBanner = Signal.new()
local library = {}
local configs = {
	Name = "1halla hub",
	SaveConfig = {},
	flags = {},
	SeperatePlayer = true,
	MainPathName = "OneHalla_Hub",
}
library.__index = library
function library.new()
	return setmetatable(configs, library)
end

local SavedInfo = {}
local librarySetting = {}

-- File System
local SaveFilePath
local SaveLibrarySettingPath
local function Path(...)
	local args = { ... }
	local str = ""
	for i, v in pairs(args) do
		str = str .. v .. "/"
	end

	return str:sub(1, -2)
end
local function toJson(data)
	return HttpService:JSONDecode(data)
end
local function fromJson(data)
	return HttpService:JSONEncode(data)
end

local function SaveData()
	writefile(SaveFilePath, HttpService:JSONEncode(SavedInfo))
end
local function SaveLibraryData()
	writefile(SaveLibrarySettingPath, HttpService:JSONEncode(librarySetting))
	-- warn("Data Saved")
end

local function CheckMainPath()
	local MainPathName = configs.MainPathName
	if not isfolder(MainPathName) then
		makefolder(MainPathName)
	end
	return MainPathName
end

--// library settings
do
	local MainPathName = CheckMainPath()
	local LibrarySettingFile = Path(MainPathName, "Settings") .. ".json"
	SaveLibrarySettingPath = LibrarySettingFile

	if not isfile(LibrarySettingFile) then
		local Template = fromJson({
			Created = os.date(),
			Mode = "Window",
		})
		writefile(LibrarySettingFile, Template)
		warn("Created Library Setting File : ", LibrarySettingFile)
	end

	librarySetting = HttpService:JSONDecode(readfile(LibrarySettingFile))
end

function library:LoadAutoSave(input)
	local SaveName = (input == "Auto" and tostring(game.GameId)) or tostring(input)

	local MainPathName = CheckMainPath()

	local LocalPlayerFormat = string.format("%s-%d", game.Players.LocalPlayer.Name, game.Players.LocalPlayer.UserId)
	local LocalPlayerPath = Path(MainPathName, LocalPlayerFormat)
	if not isfolder(LocalPlayerPath) then
		makefolder(LocalPlayerPath)
	end

	local SaveFile = Path(LocalPlayerPath, SaveName) .. ".json"
	SaveFilePath = SaveFile
	local Template = fromJson({
		Created = os.date(),
	})
	local function InitTemplate()
		writefile(SaveFile, Template)
		warn("Created File : ", SaveFile)
	end
	if not isfile(SaveFile) then
		InitTemplate()
	end

	local status, Data = xpcall(function()
		return HttpService:JSONDecode(readfile(SaveFilePath))
	end, function()
		InitTemplate()
		return Template
	end)
	repeat
		wait()
	until Data ~= nil
	SavedInfo = Data
end

local ThemeChanged = Signal.new()
local function SetTheme()
	NoGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, CurrentTheme.MainColor),
		ColorSequenceKeypoint.new(1, CurrentTheme.MainColor),
	})

	WithGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, CurrentTheme.MainColor),
		ColorSequenceKeypoint.new(1, CurrentTheme.AccentColor),
	})

	for i, v in pairs(themesgradient) do
		v.Color = CurrentTheme.Gradient and WithGradient or NoGradient
	end
	for i, v in pairs(themesobj) do
		if v.Instance ~= nil and v["Property"] and CurrentTheme[v.Link] ~= nil then
			pcall(function()
				Tween(v.Instance, 0.1, "Linear", "In", {
					[v.Property] = CurrentTheme[v.Link] or ThemeList.Default[v.Link],
				})
			end)
		end
	end
	local ThemeName = GetThemeNameByThemeObject(CurrentTheme)
	librarySetting["Theme"] = ThemeName
	SaveLibraryData()
	ThemeChanged:Fire()
end

function library:Clear()
	for i, v in pairs(game.CoreGui:GetChildren()) do
		if v.Name == LIBRARY_NAME then
			v:Destroy()
		end
	end
end
local ModeIndex = 1

--// Dynamic Element
local Tab_Container
local Background
local WindowTypeToggler
local AllTabs = {}

local Connections = {}
local function CleanConnection()
	for i, v in pairs(Connections) do
		v:Disconnect()
	end
end
local SideSignal = Signal.new()
local LeftRightList = {}
local function ChangeLeftRightHeight(Mode)
	local function Apply(Side)
		Side.Size = UDim2.new(1, -5, 1, 0)
	end
	local function ApplyDynamic(Side)
		local UIListLayout = Side:FindFirstChild("UIListLayout")
		--UIListLayout.Padding = UDim2.new(0,)
		local Dynamic = function()
			local ContentSize = UIListLayout.AbsoluteContentSize.Y
			Side.Size = UDim2.new(1, -5, 0, ContentSize + 20)
		end

		if UIListLayout then
			Dynamic()
			table.insert(Connections, UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(Dynamic))
		end
	end
	for i, v in pairs(LeftRightList) do
		if Mode == "Full" then
			Apply(v.Left)
			Apply(v.Right)
		elseif Mode == "Dynamic" then
			ApplyDynamic(v.Left)
			ApplyDynamic(v.Right)
		end
	end
end

local NotificationUI = New("ScreenGui")({
	Name = "Notification",
	Parent = game.CoreGui,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	[Children] = {
		New("Frame")({
			Name = "Holder",
			AnchorPoint = Vector2.new(1, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(1, 1),
			Size = UDim2.fromScale(0.3, 1),

			[Children] = {
				New("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingTop = UDim.new(0, 5),
				}),

				New("UIListLayout")({
					Name = "UIListLayout",
					Padding = UDim.new(0, 10),
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Bottom,
				}),
			},
		}),
	},
})
local function NewNotificationCard(type, title, info, lifetime)
	local t = string.lower(type)
	local style = {
		["default"] = {
			Color = GetTheme("MainColor"),
			Icon = "11207357159",
		},
		["success"] = {
			Color = Color3.fromRGB(255, 182, 80),
			Icon = "11207704092",
		},
		["error"] = {
			Color = Color3.fromRGB(255, 85, 127),
			Icon = "11207702613",
		},
		["info"] = {
			Color = Color3.fromRGB(85, 170, 255),
			Icon = "11207703333",
		},
		["warning"] = {
			Color = Color3.fromRGB(255, 170, 0),
			Icon = "11207704598",
		},
	}
	local color = style[t] and style[t].Color or style["default"].Color
	local icon = style[t] and style[t].Icon or style["default"].Icon

	local Card = New("Frame")({
		Parent = NotificationUI.Holder,
		Name = "Template",
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		Size = UDim2.new(0, 0, 0, 0),
		AnchorPoint = Vector2.new(1, 1),
		ClipsDescendants = true,

		[Children] = {
			New("Frame")({
				Name = "Line",
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundColor3 = color,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 1),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 2),
			}),

			New("TextLabel")({
				Name = "Info",
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = title,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				TextTransparency = 1,
				Position = UDim2.fromScale(0.9, 0.367),
				Size = UDim2.new(0.9, -30, 0.633, -2),
			}),

			New("ImageLabel")({
				Name = "Icon",
				Image = "http://www.roblox.com/asset/?id=" .. tostring(icon),
				ImageColor3 = color,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0, 0.5),
				ImageTransparency = 1,
				Size = UDim2.fromOffset(30, 30),
			}),

			New("ImageLabel")({
				Name = "Close",
				Image = "http://www.roblox.com/asset/?id=11207370821",
				ImageColor3 = Color3.fromRGB(91, 91, 91),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,

				Position = UDim2.fromScale(1, 0.5),

				Size = UDim2.fromOffset(25, 25),
			}),

			New("TextLabel")({
				Name = "Title",
				FontFace = Font.new(
					"rbxasset://fonts/families/GothamSSm.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				),
				TextTransparency = 1,

				Text = info,
				TextColor3 = color,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.9, 0),
				Size = UDim2.new(0.9, -30, 0.433, -2),
			}),
		},
	})

	function Get(n)
		return Card:WaitForChild(n)
	end
	local Line, Close, Icon, Title, Info = Get("Line"), Get("Close"), Get("Icon"), Get("Title"), Get("Info")

	local function CloseNotif()
		Title.Visible = false
		Info.Visible = false
		Close.Visible = false
		Icon.Visible = false
		Tween(Card, 0.2, "Quad", "Out", {
			Size = UDim2.new(0, 0, 0, 30),
		}, function()
			Tween(Card, 0.1, "Quad", "Out", {
				Size = UDim2.new(0, 0, 0, 0),
			}, function()
				Card:Destroy()
			end)
		end)
	end

	local function Open()
		Tween(Card, 0.3, "Quad", "In", {
			Size = UDim2.new(1, 0, 0, 40),
		}, function()
			Tween(Line, 0.2, "Quad", "In", {
				BackgroundTransparency = 0,
			}, function()
				Tween(Line, lifetime, "Linear", "In", {
					Size = UDim2.new(0, 0, 0, 2),
				}, function()
					CloseNotif()
				end)
			end)

			Tween(Info, 0.2, "Quad", "In", {
				TextTransparency = 0,
			})
			Tween(Title, 0.2, "Quad", "In", {
				TextTransparency = 0,
			})
			Tween(Icon, 0.2, "Quad", "In", {
				ImageTransparency = 0,
				Position = UDim2.fromScale(0, 0),
			})
		end)
	end

	Open()

	MakeClickArea(Close, function()
		CloseNotif()
	end)
end
function library:SendNotification(_info)
	local info = _info or {}
	local _type = info.type or info.Type or info.Status or "Default"
	local title = info.title or info.Title or info.Name or "Notification"
	local info = info.info or info.Info or info.Text or ". . ."
	local lifetime = info.time or info.lifetime or info.delay or info.duration or 5

	NewNotificationCard(_type, info, title, lifetime)
end

local ToggleUI
local RowMode = Signal.new()
local AllMode = {
	[1] = {
		Name = "Window",
		Icon = "rbxassetid://10965528897",
		Callback = function()
			ToggleUI.Visible = true
			Tween(Background, 0.2, "Quad", "In", {
				Size = UDim2.new(0, 600, 0, 550),
			}, function()
				CleanConnection()
				-- Tab_Container.UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				RowMode:Fire("Horizontal")
				for i, v in pairs(AllTabs) do
					v.Size = UDim2.new(0.5, -5, 1, 0)
				end
			end)

			-- Background.Size = UDim2.new(0,533,0,288)
		end,
	},
	[2] = {
		Name = "Mini", -- Phone
		Icon = "rbxassetid://10965554659",
		Callback = function()
			ToggleUI.Visible = false
			Tween(Background, 0.2, "Quad", "In", {
				Size = UDim2.new(0, 400, 0, 450),
			}, function()
				CleanConnection()
				-- Tab_Container.UIListLayout.FillDirection = Enum.FillDirection.Vertical
				RowMode:Fire("Vertical")

				ChangeLeftRightHeight("Dynamic")
			end)
		end,
	},
	[3] = {
		Name = "Single", -- Full
		Icon = "rbxassetid://10965542161",
		Callback = function()
			ToggleUI.Visible = true
			Tween(Background, 0.2, "Quad", "In", {
				Size = UDim2.new(0, 500, 0, 400),
			}, function()
				CleanConnection()
				RowMode:Fire("Vertical")
				--					Tab_Container.UIListLayout.FillDirection = Enum.FillDirection.Vertical

				ChangeLeftRightHeight("Dynamic")
			end)
		end,
	},
}

local function SelectMode(ModeName)
	for i, v in pairs(AllMode) do
		if v.Name == ModeName then
			CurrentMode = v.Name
			ModeIndex = i
			WindowTypeToggler.Image = v.Icon
			v.Callback()

			librarySetting["Mode"] = v.Name
			SaveLibraryData()
		end
	end
end

local function TogglerWindow()
	ModeIndex = ModeIndex + 1
	if ModeIndex > #AllMode then
		ModeIndex = 1
	end
	SelectMode(AllMode[ModeIndex].Name)
end
local ScreenGui

local CurrentMode = librarySetting["Mode"] or "Window"
function library:LoadingScreen()
	local Loading = New("ScreenGui")({
		Name = LIBRARY_NAME,
		Parent = game.CoreGui,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		[Children] = {
			New("Frame")({
				Name = "Holder",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(352, 136),
				[OnCreate] = function(ins)
					MakeDragable(ins)
				end,
				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 100),
					}),

					New("ImageLabel")({
						Name = "Logo",
						Image = "http://www.roblox.com/asset/?id=11219897278",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0, 0.5),
						Size = UDim2.fromOffset(100, 100),
					}),

					New("TextLabel")({
						Name = "Title",
						FontFace = Font.new(
							"rbxasset://fonts/families/GothamSSm.json",
							Enum.FontWeight.Bold,
							Enum.FontStyle.Normal
						),
						Text = "1halla hub",
						TextColor3 = Color3.fromRGB(80, 255, 176),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
						TextTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0.304, 0.0636),
						Size = UDim2.fromOffset(228, 25),
					}),

					New("UIStroke")({
						Name = "UIStroke",
						Color = Color3.fromRGB(81, 255, 180),
						Thickness = 2,
					}),

					New("TextLabel")({
						Name = "Credit",
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
						Text = "สคริปฟรีตึงๆ by 1halla#0001",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextTransparency = 1,
						TextSize = 14,

						TextWrapped = true,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0.452, 0.243),
						Size = UDim2.fromOffset(150, 20),
					}),

					New("TextButton")({
						Name = "Execute",
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
						Text = " LOAD ",
						AutoButtonColor = false,
						TextColor3 = Color3.fromRGB(30, 30, 30),
						TextScaled = false,
						TextSize = 20,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						TextWrapped = true,
						BackgroundColor3 = Color3.fromRGB(80, 255, 176),
						Position = UDim2.fromScale(0.284, 0.674),
						Size = UDim2.fromOffset(242, 33),

						[Children] = {
							New("UICorner")({
								Name = "UICorner",
								CornerRadius = UDim.new(0, 3),
							}),
						},
					}),

					New("TextButton")({
						Name = "Discord",
						AutoButtonColor = false,
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
						Text = "copy discord invite",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = false,
						TextSize = 20,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						TextWrapped = true,
						BackgroundColor3 = Color3.fromRGB(60, 60, 60),
						Position = UDim2.fromScale(0.284, 0.372),
						Size = UDim2.fromOffset(242, 33),

						[Children] = {
							New("UICorner")({
								Name = "UICorner",
								CornerRadius = UDim.new(0, 3),
							}),
						},
					}),
				},
			}),
		},
	})
	local Holder = Loading:WaitForChild("Holder")
	local function Get(n)
		return Holder:WaitForChild(n)
	end
	local Discord, Execute, Title, Credit, Logo =
		Get("Discord"), Get("Execute"), Get("Title"), Get("Credit"), Get("Logo")
	local UIStroke = Get("UIStroke")
	local UICorner = Get("UICorner")
	local Opened = false
	local function Open()
		task.spawn(function()
			while not Opened do
				Tween(UIStroke, 0.4, "Linear", "In", {
					Color = Color3.fromRGB(81, 255, 180),
				})
				wait(1)
				Tween(UIStroke, 0.4, "Linear", "In", {
					Color = White,
				})
				wait(1)
			end
		end)
		Title.Visible = false
		Credit.Visible = false
		Discord.Visible = false
		Execute.Visible = false

		Holder.Size = UDim2.fromOffset(120, 120)
		Logo.Size = UDim2.fromScale(1, 1)

		local A
		A = MakeClickArea(Logo, function()
			A.Instance:Destroy()
			Opened = true

			Tween(UICorner, 0.4, "Linear", "In", {
				CornerRadius = UDim.new(0, 3),
			})
			wait(0.4)
			Tween(Logo, 0.3, "Quad", "In", {
				ImageTransparency = 1,
				-- Size = UDim2.fromOffset(100, 100),
			}, function()
				Tween(UIStroke, 0.4, "Linear", "In", {
					Color = Color3.fromRGB(81, 255, 180),
				})
				Tween(Holder, 0.3, "Quad", "In", {
					Size = UDim2.fromOffset(352, 136),
				})
				wait(0.3)
				Logo.Size =
					UDim2.fromOffset(100, 100), Tween(Logo, 0.15, "Quad", "In", {
						ImageTransparency = 0,

						-- Size = UDim2.fromOffset(100, 100),
					})
				wait(0.2)
				Title.Visible = true
				Credit.Visible = true
				Discord.Visible = true
				Execute.Visible = true

				Tween(Title, 0.2, "Linear", "In", {
					TextTransparency = 0,
				})
				wait(0.1)
				Tween(Credit, 0.2, "Linear", "In", {
					TextTransparency = 0.5,
				})
				wait(0.1)
				Tween(Discord, 0.2, "Linear", "In", {
					TextTransparency = 0,
					BackgroundTransparency = 0,
				})
				wait(0.1)
				Tween(Execute, 0.2, "Linear", "In", {
					TextTransparency = 0,
					BackgroundTransparency = 0,
				})
			end)
		end)
	end
	local function Close()
		Tween(Title, 0.2, "Linear", "In", {
			TextTransparency = 1,
		})
		wait(0.1)
		Tween(Credit, 0.2, "Linear", "In", {
			TextTransparency = 1,
		})
		wait(0.1)
		Tween(Discord, 0.2, "Linear", "In", {
			TextTransparency = 1,
			BackgroundTransparency = 1,
		})
		wait(0.1)
		Tween(Execute, 0.2, "Linear", "In", {
			TextTransparency = 1,
			BackgroundTransparency = 1,
		})
		wait(0.1)
		Tween(Logo, 0.2, "Linear", "In", {
			ImageTransparency = 1,
		})
		wait(0.1)
		Tween(UIStroke, 0.2, "Linear", "In", {
			Transparency = 1,
		})

		wait(0.3)

		Tween(Holder, 0.3, "Quad", "In", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 0, 0, 0),
		}, function()
			Loading:Destroy()
		end)
		wait(0.3)
	end
	Open()
	MakeClickArea(Execute, function()
		library:SendNotification({
			Title = "Loading",
			Type = "Info",
			Text = "รอซักครู่",
		})
		Close()
		library:Init()
		library:SendNotification({
			Title = "คำเตือน",
			Type = "warning",
			Text = "เข้าดิสคอร์ดเพื่อรับสคริปเพิ่มเติม",
		})
	end)
	MakeClickArea(Discord, function()
		setclipboard("https://discord.gg/CAdzMB87Fj")
		library:SendNotification({
			Title = "Discord",
			Type = "Success",
			Text = "Invite Copied",
		})
		library:SendNotification({
			Title = "Discord",
			Type = "Info",
			Text = "คัดลอกลิ้งค์ Discord เรียบร้อย",
		})
	end)
end
function library:Init()
	local ThemeCach = librarySetting["Theme"] or "Default"
	if ThemeList[ThemeCach] == nil then
		ThemeCach = "Default"
	end

	CurrentTheme = ThemeList[ThemeCach]

	SetTheme()
	wait(0.2)
	ScreenGui.Enabled = true
	SelectMode(CurrentMode)
end
function library:NewWindow(options)
	local flags = self.flags
	ScreenGui = New("ScreenGui")({
		Name = LIBRARY_NAME,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = game.CoreGui,
		Enabled = false,
	})

	Background = New("Frame")({
		Name = "Background",
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = ScreenGui,
		Position = UDim2.new(0.5, 0, 0.147, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(0, 533, 0, 288),

		[Children] = {
			New("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 0),
			}),
		},
	})
	AddtoTheme(Background, "BackgroundColor3", "BackgroundColor")

	local ShadowScreenGui = New("ScreenGui")({
		Name = LIBRARY_NAME,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = game.CoreGui,
		Enabled = false,
	})
	local Shadow = New("ImageLabel")({
		Name = "Background",
		Image = "rbxassetid://1316045217",
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		Parent = ScreenGui,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(0, 533, 0, 288),
		ZIndex = -50,
		Position = Background.Position,
		ImageTransparency = 0.401,
		ImageColor3 = Color3.fromRGB(0, 0, 0),
	})
	local ShadowSize = 40
	local function UpdatetoBGSize()
		Shadow.Size = Background.Size + UDim2.fromOffset(ShadowSize, ShadowSize)
		Shadow.Position = Background.Position - UDim2.fromOffset(0, ShadowSize / 2)
	end
	UpdatetoBGSize()
	Background:GetPropertyChangedSignal("Size"):Connect(UpdatetoBGSize)
	Background:GetPropertyChangedSignal("Position"):Connect(UpdatetoBGSize)

	local SettingContainer = New("Frame")({
		Name = "SettingContainer",
		ClipsDescendants = true,
		Parent = Background,
		Visible = false,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		Position = UDim2.new(0.5, 0, 2, 0),
		Size = UDim2.fromScale(0.6, 0.6),
		ZIndex = 999,
		[OnCreate] = function(ins)
			AddtoTheme(ins, "BackgroundColor3", "BackgroundColor")
		end,
		[Children] = {
			New("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 3),
			}),
			New("TextLabel")({
				Name = "SettingTitle",
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = "Setting",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 24),
			}),

			New("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 3),
				PaddingLeft = UDim.new(0, 3),
				PaddingRight = UDim.new(0, 3),
				PaddingTop = UDim.new(0, 3),
			}),

			New("Frame")({
				Name = "Line",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.5,
				Position = UDim2.fromOffset(0, 25),
				Size = UDim2.new(1, 0, 0, 1),
				[OnCreate] = function(ins)
					AddtoTheme(ins, "BackgroundColor3", "MainColor")
				end,

				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 100),
					}),
				},
			}),

			New("Frame")({
				Name = "SettingCompoents",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BorderColor3 = Color3.fromRGB(53, 53, 53),
				Position = UDim2.new(0.5, 0, 0, 30),
				Size = UDim2.new(1, 0, 1, -30),
				[OnCreate] = function(ins)
					AddtoTheme(ins, "BackgroundColor3", "BackgroundColor")
				end,
				[Children] = {
					New("UIListLayout")({
						Name = "UIListLayout",
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),

					New("UIPadding")({
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 3),
						PaddingLeft = UDim.new(0, 3),
						PaddingRight = UDim.new(0, 3),
						PaddingTop = UDim.new(0, 3),
					}),
				},
			}),

			New("ImageButton")({
				Name = "SettingClose",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 85, 127),
				Position = UDim2.fromScale(1, 0),
				Size = UDim2.fromOffset(20, 20),
				AutoButtonColor = false,
				[OnCreate] = function(ins)
					AddtoTheme(ins, "BackgroundColor3", "MainColor")
					MakeClickArea(ins, function() end)
				end,
				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 3),
					}),
				},
			}),
		},
	})

	local BackgroundCover = New("ImageButton")({
		Parent = Background,
		AutoButtonColor = false,
		ZIndex = 100,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		BackgroundTransparency = 0.5,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Crop,
	})

	MakeDragable(Background)
	local Leftbar = New("Frame")({
		Name = "LeftBar",
		Parent = Background,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 125, 1, 0),

		[Children] = {
			New("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 0),
			}),

			New("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 5),
			}),
			New("ImageLabel")({
				Name = "Banner",
				Image = "http://www.roblox.com/asset/?id=" .. tostring(Banner),
				ScaleType = Enum.ScaleType.Crop,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.0, 0),
				Size = UDim2.new(1, 0, 0, 125),

				[OnCreate] = function(ins)
					print(ins.AbsoluteSize)
					AddtoTheme(ins, "BackgroundColor3", "LeftBarColor")
					-- AddtoTheme(ins, "Image", "Banner")
				end,

				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 1),
					}),

					New("TextLabel")({
						Name = "ScriptName",
						Font = Enum.Font.GothamBold,
						Text = HubName,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Right,
						AnchorPoint = Vector2.new(1, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0.0811, 0),
						Size = UDim2.new(1, 0, 0, 26),
					}),

					New("UIPadding")({
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 3),
						PaddingLeft = UDim.new(0, 3),
						PaddingRight = UDim.new(0, 3),
						PaddingTop = UDim.new(0, 3),
					}),

					New("TextLabel")({
						Name = "Info",
						Font = Enum.Font.GothamBold,
						Text = HubInfo,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 10,
						TextTransparency = 0.5,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Right,
						AnchorPoint = Vector2.new(1, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.982, 0, 0.819, 0),
						Size = UDim2.new(1, 0, -0.109, 26),
					}),

					New("TextLabel")({
						Name = "Link",
						Font = Enum.Font.GothamBold,
						Text = HubInvite,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 10,
						TextTransparency = 0.5,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Right,
						AnchorPoint = Vector2.new(1, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0.27, 0),
						Size = UDim2.new(1, 0, -0.109, 26),
					}),
				},
			}),
			New("UIListLayout")({
				Name = "ElementHandlerList",
				Padding = UDim.new(0, 3),
				Parent = ElementHandler,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			New("Frame")({
				Name = "ScroolingFrameHolder",
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 1, 0),
				Size = UDim2.new(1, 0, 0.7, -10),

				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 5),
					}),
				},
			}),
		},
	})
	AddtoTheme(Leftbar, "BackgroundColor3", "LeftBarColor")
	local BannerHolder = Leftbar:WaitForChild("Banner")
	ThemeChanged:Connect(function()
		Tween(BannerHolder, 0.1, "Linear", "In", {
			ImageTransparency = 1,
		}, function()
			local Newbanner = CurrentTheme.Banner or ThemeList["Default"].Banner
			BannerHolder.Image = "http://www.roblox.com/asset/?id=" .. tostring(Newbanner)
			Tween(BannerHolder, 0.1, "Linear", "In", {
				ImageTransparency = 0,
			})
		end)
	end)
	local SettingBackground = New("Frame")({
		Name = "SettingBackground",
		Parent = Background,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		Visible = false,
		ZIndex = 1000,
		BackgroundTransparency = 0.5,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0),

		[Children] = {
			New("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 5),
			}),

			New("Frame")({
				Name = "SettingModal",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, 400, 0, 250),

				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 5),
					}),

					New("TextLabel")({
						Name = "Title",
						Font = Enum.Font.Gotham,
						Text = "Setting",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 200, 0, 29),
					}),

					New("UIPadding")({
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 5),
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 5),
					}),
					New("ImageButton")({
						Name = "Close",
						Image = "http://www.roblox.com/asset/?id=10965413935",
						AnchorPoint = Vector2.new(1, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0, 0),
						Size = UDim2.new(0, 30, 0, 30),
					}),

					New("TextLabel")({
						Name = "Description",
						Font = Enum.Font.Gotham,
						Text = "customize the look",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 14,
						TextTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0, 29),
						Size = UDim2.new(0, 200, 0, 18),
					}),
				},
			}),
		},
	})
	local function ToggleSetting()
		SettingBackground.Visible = not SettingBackground.Visible
	end
	local LeftBarToggler = New("ImageButton")({
		Name = "LeftBarToggler",
		Parent = Leftbar.Banner,
		Image = "http://www.roblox.com/asset/?id=10978502474",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		AutoButtonColor = false,
		BackgroundTransparency = 0.5,
		Size = UDim2.new(0, 20, 0, 20),
		[Children] = {
			New("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 4),
			}),
		},
	})
	WindowTypeToggler = New("ImageButton")({
		Name = "WindowTypeToggler",
		Parent = Leftbar.Banner,
		Image = "http://www.roblox.com/asset/?id=10965446903",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 23),
		Size = UDim2.new(0, 20, 0, 20),
	})

	local PagesHolder
	local Topbar
	MakeClickArea(WindowTypeToggler, TogglerWindow)
	local LeftbarClosed = false
	local time_tween = 0.15
	local LeftbarState = Signal.new()

	local ToggleLeftbar = function()
		task.spawn(function()
			repeat
				wait()
			until PagesHolder ~= nil
			if LeftbarClosed then
				Tween(Leftbar, time_tween, "Linear", "In", {
					["Size"] = UDim2.new(0, 125, 1, 0),
				})
				Tween(PagesHolder, time_tween, "Linear", "In", {
					["Size"] = UDim2.new(1, -125, 1, -5),
				})

				Tween(Topbar, time_tween, "Linear", "In", {
					["Size"] = UDim2.new(1, -125, 0, 15),
				})
				LeftBarToggler.Image = "http://www.roblox.com/asset/?id=10978502474"

				LeftbarClosed = false
			else
				LeftBarToggler.Image = "http://www.roblox.com/asset/?id=10986691394"

				Tween(Leftbar, time_tween, "Linear", "In", {
					["Size"] = UDim2.new(0, 37, 1, 0),
				})
				Tween(PagesHolder, time_tween, "Linear", "In", {
					["Size"] = UDim2.new(1, -37, 1, 0),
				})

				Tween(Topbar, time_tween, "Linear", "In", {
					["Size"] = UDim2.new(1, -37, 0, 15),
				})

				LeftbarClosed = true

				--[[
                        LeftbarClosed = true 
                        Leftbar.Size = UDim2.new(0,37,1,0)
                        PagesHolder.Size = UDim2.new(1,-37,0,271)
                        Topbar.Size = UDim2.new(1, -37, 0, 15)
                        ]]
			end
			LeftbarState:Fire(not LeftbarClosed)
			librarySetting["LeftbarClosed"] = LeftbarClosed
			SaveLibraryData()
		end)
	end
	LeftbarState:Connect(function(state)
		Leftbar.Banner.ScriptName.Visible = state
		Leftbar.Banner.Info.Visible = state
		Leftbar.Banner.Link.Visible = state
		if state then
			Leftbar.Banner.ImageTransparency = 0

			Leftbar.Banner.Size = UDim2.new(1, 0, 0, 90)

			Leftbar.ScroolingFrameHolder.Size = UDim2.new(1, 0, 0.7, -10)
		else
			Leftbar.Banner.Size = UDim2.new(1, 0, 0.2, 0)

			Leftbar.ScroolingFrameHolder.Size = UDim2.new(1, 0, 0.77, 0)
			Leftbar.Banner.ImageTransparency = 1
		end
	end)

	librarySetting["LeftbarClosed"] = librarySetting["LeftbarClosed"] or false
	local IsAlreadyClose = librarySetting["LeftbarClosed"] or false
	SaveLibraryData()
	if IsAlreadyClose then
		ToggleLeftbar()
	end

	LeftbarState:Fire(not IsAlreadyClose)

	MakeClickArea(LeftBarToggler, ToggleLeftbar)
	MakeClickArea(SettingBackground.SettingModal.Close, ToggleSetting)

	local Tab_Switch_Container = New("ScrollingFrame")({
		Parent = Leftbar.ScroolingFrameHolder,
		Name = "ScrollingFrame",
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		ScrollBarThickness = 2,
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),

		[Children] = {
			New("UIListLayout")({
				Name = "UIListLayout",
				Padding = UDim.new(0, 7),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			New("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 5),
			}),
		},
	})
	MakeDynamicScrolling(Tab_Switch_Container.UIListLayout, Tab_Switch_Container, 10)
	Topbar = New("Frame")({
		Name = "Topbar",
		Parent = Background,
		AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(1, -125, 0, 15),

		[Children] = {
			New("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 3),
			}),
			New("Frame")({
				Name = "TwoHolder",
				AnchorPoint = Vector2.new(1, 0.5),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -50, 0.5, 0),
				Size = UDim2.fromScale(0, 1),
				[Children] = {
					New("UIListLayout")({
						Name = "UIListLayout",
						Padding = UDim.new(0, 10),
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					New("TextLabel")({
						Name = "Theme",
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
						Text = "Theme",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 14,
						Active = true,
						TextTransparency = 0.5,
						AnchorPoint = Vector2.new(1, 0.5),
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -200, 0.5, 0),
						Size = UDim2.fromScale(0, 1),
					}),
					New("TextLabel")({
						Name = "ToggleUI",
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
						Text = "[ Left Control ]",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 14,
						Active = true,
						TextTransparency = 0.5,

						AnchorPoint = Vector2.new(1, 0.5),
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -50, 0.5, 0),
						Size = UDim2.fromScale(0, 1),
					}),
				},
			}),

			New("ImageButton")({
				Name = "Minimize",
				Image = "http://www.roblox.com/asset/?id=10965565068",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -22, 0, -3),
				Size = UDim2.new(0, 20, 0, 20),
			}),

			New("ImageButton")({
				Name = "CloseAll",
				Image = "http://www.roblox.com/asset/?id=10965413935",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, -3),
				Size = UDim2.new(0, 20, 0, 20),
			}),
		},
	})
	AddtoTheme(Topbar, "BackgroundColor3", "TopbarColor")
	local CloseAll = Topbar:WaitForChild("CloseAll")
	MakeClickArea(CloseAll, function()
		ScreenGui:Destroy()
	end)
	local TwoHolder = Topbar:WaitForChild("TwoHolder")
	ToggleUI = TwoHolder:WaitForChild("ToggleUI")

	local Minimized = false
	local Minimize = Topbar:WaitForChild("Minimize")
	local OldSize = Background.Size
	local MDB = false
	local OldTopbarSize = Topbar.Size
	-- local SaveLibraryData
	MakeClickArea(Minimize, function()
		if MDB then
			return
		end
		MDB = true
		delay(0.6, function()
			MDB = false
		end)
		if Minimized then
			Minimized = false
			Tween(Background, 0.2, "Linear", "In", {
				Size = OldSize,
			})
			wait(0.2)
			Tween(Topbar, 0.2, "Linear", "In", {
				Size = OldTopbarSize,
			}, function()
				Leftbar.Visible = true

				Tween(Shadow, 0.2, "Linear", "In", {
					ImageTransparency = 0.401,
				})
			end)
		else
			OldTopbarSize = Topbar.Size
			OldSize = Background.Size
			Minimized = true
			Leftbar.Visible = false

			Tween(Shadow, 0.2, "Linear", "In", {
				ImageTransparency = 1,
			})

			Tween(Background, 0.2, "Linear", "In", {
				Size = UDim2.new(OldSize.X.Scale, OldSize.X.Offset, 0, 18),
			})
			wait(0.25)
			Tween(Topbar, 0.2, "Linear", "In", {
				Size = UDim2.new(1, 0, 0, 15),
			})
		end
	end)
	local UIToggleKey = librarySetting["UIToggleKey"] or Enum.KeyCode["RightControl"].Name
	ToggleUI.Text = string.format("[ %s ]", UIToggleKey)
	local OnInput = false
	MakeClickArea(ToggleUI, function()
		OnInput = true
		ToggleUI.Text = "Press Any Key"

		Tween(ToggleUI, 0.2, "Linear", "In", {
			TextColor3 = CurrentTheme.MainColor,
		})
		local con
		con = UserInputService.InputBegan:Connect(function(input, gp)
			if not gp and input.UserInputType == Enum.UserInputType.Keyboard then
				con:Disconnect()
				UIToggleKey = input.KeyCode.Name
				librarySetting["UIToggleKey"] = UIToggleKey
				ToggleUI.Text = string.format("[ %s ]", UIToggleKey)
				SaveLibraryData()
				wait(0.1)

				Tween(ToggleUI, 0.2, "Linear", "In", {
					TextColor3 = White,
				})
				OnInput = false
			end
		end)
	end)
	local Theme = TwoHolder:WaitForChild("Theme")
	local SettingClose = SettingContainer:WaitForChild("SettingClose")
	local SettingCompoents = SettingContainer:WaitForChild("SettingCompoents")
	MakeClickArea(SettingClose, function()
		Tween(BackgroundCover, 0.2, "Linear", "In", {
			--Size = UDim2.new(0,0,0,0),
			ImageTransparency = 1,
			BackgroundTransparency = 1,
		})
		Tween(SettingContainer, 0.4, "Quad", "Out", {
			--Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 2, 0),
		}, function()
			SettingContainer.Visible = true
			BackgroundCover.Visible = false
		end)
	end)
	function MakeSettingDropdown(s_name, s_list, s_callback)
		local Dropdown = New("Frame")({
			Name = "Dropdown",
			Parent = SettingCompoents,
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			BorderColor3 = Color3.fromRGB(50, 50, 50),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 25),
			[OnCreate] = function(ins)
				AddtoTheme(ins, "BackgroundColor3", "DropdownBackgroundColor")
			end,
			[Children] = {
				New("TextLabel")({
					Name = "Title",
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
					Text = s_name,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -30, 1, 0),
				}),

				New("UIPadding")({
					Name = "UIPadding",
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
				}),

				New("ImageButton")({
					Name = "Down",
					Image = "rbxassetid://10934039279",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = White,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(1, 0.5),
					Size = UDim2.fromOffset(20, 20),

					[Children] = {
						New("UIGradient")({

							Color = CurrentTheme.Gradient and WithGradient or NoGradient,
							[OnCreate] = function(ins)
								AddtoThemeGradient(ins)
							end,
						}),
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),
					},
				}),
			},
		})

		local DropdownContainer = New("Frame")({
			Name = "DropdownContainer",
			Parent = SettingCompoents,
			Visible = false,
			ClipsDescendants = true,

			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			BorderColor3 = Color3.fromRGB(50, 50, 50),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 25),

			[Children] = {
				New("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 3),
					PaddingLeft = UDim.new(0, 3),
					PaddingRight = UDim.new(0, 3),
					PaddingTop = UDim.new(0, 3),
				}),

				New("UIListLayout")({
					Name = "UIListLayout",
					Padding = UDim.new(0, 1),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			},
		})
		local LIST = DropdownContainer:WaitForChild("UIListLayout")
		repeat
			wait()
		until DropdownContainer ~= nil

		for i, v in pairs(s_list) do
			local Button = New("TextButton")({
				Name = "BTN",
				ClipsDescendants = true,
				Parent = DropdownContainer,
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = tostring(v),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 14,
				TextTransparency = 0.5,
				BackgroundColor3 = White,
				Size = UDim2.new(1, 0, 0, 16),
				[OnCreate] = function(Ins) end,
				[Children] = {

					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 2),
					}),
					New("UIGradient")({

						Color = CurrentTheme.Gradient and WithGradient or NoGradient,
						[OnCreate] = function(ins)
							AddtoThemeGradient(ins)
						end,
					}),
				},
			})
			Button.MouseButton1Click:Connect(function()
				s_callback(Button.Text)
			end)
		end
		MakeClickArea(Dropdown, function()
			DropdownContainer.Visible = not DropdownContainer.Visible
		end)
	end
	function MakeSettingToggle()
		local Toggle = New("Frame")({
			Name = "Toggle",
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			BorderColor3 = Color3.fromRGB(50, 50, 50),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 25),

			[Children] = {
				New("TextLabel")({
					Name = "Title",
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
					Text = "Auto Save Enabled",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -30, 1, 0),
				}),

				New("UIPadding")({
					Name = "UIPadding",
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
				}),

				New("ImageButton")({
					Name = "Switch",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 85, 127),
					Position = UDim2.fromScale(1, 0.5),
					Size = UDim2.fromOffset(20, 20),

					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),
					},
				}),
			},
		})
	end
	local themeindex = {}
	for i, v in pairs(ThemeList) do
		table.insert(themeindex, tostring(i))
	end
	MakeSettingDropdown("Library Theme", themeindex, function(a)
		CurrentTheme = ThemeList[a]
		SetTheme()
	end)

	local ThemeOpened = false
	MakeClickArea(Theme, function()
		BackgroundCover.Visible = true

		SettingContainer.Visible = true
		BackgroundCover.Size = UDim2.new(1, 0, 1, 0)
		BackgroundCover.BackgroundTransparency = 1
		Tween(BackgroundCover, 0.2, "Linear", "In", {

			BackgroundTransparency = 0.5,
		})
		Tween(SettingContainer, 0.2, "Quad", "In", {

			Position = UDim2.new(0.5, 0, 0.5, 0),
		})
	end)
	-- SaveLibraryData()
	local Open = true
	local OldBgSize = Background.Size
	local OpenDb = false
	UserInputService.InputBegan:Connect(function(input, gp)
		if OpenDb then
			return
		end
		if not gp and not OnInput then
			if input.KeyCode.Name == UIToggleKey then
				OpenDb = true
				delay(0.2, function()
					OpenDb = false
				end)
				if Open then
					Open = false
					OldBgSize = Background.Size
					Tween(Background, 0.2, "Quad", "In", {
						Size = UDim2.new(0, OldBgSize.X.Offset, 0, 0),
					})
					Tween(Shadow, 0.2, "Linear", "In", {
						ImageTransparency = 1,
					})
				else
					Tween(Background, 0.2, "Quad", "Out", {
						Size = OldBgSize,
					}, function()
						Tween(Shadow, 0.2, "Linear", "In", {
							ImageTransparency = 0.401,
						})
					end)

					Open = true
				end
			end
		end
	end)
	local TabTitle = New("TextLabel")({
		Name = "TextLabel",
		Parent = Topbar,
		Font = Enum.Font.Gotham,
		Text = "Tab",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 13,
		TextTransparency = 0.5,
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		[Children] = {
			New("UIPadding")({
				Name = "UIPadding",

				PaddingLeft = UDim.new(0, 10),
			}),
		},
	})
	PagesHolder = New("ImageLabel")({
		Name = "PagesHolder",
		Parent = Background,
		Active = true,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 17),
		Selectable = true,
		Size = UDim2.new(1, -125, 1, -5),
		SelectionGroup = true,

		[Children] = {

			New("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 5),
			}),
		},
	})

	AddtoTheme(PagesHolder, "BackgroundColor3", "BackgroundColor")

	local PageController = New("UIPageLayout")({
		Name = "PageController",
		EasingDirection = Enum.EasingDirection.Out,
		EasingStyle = Enum.EasingStyle.Quad,
		Padding = UDim.new(0, 10),
		Parent = PagesHolder,
		TweenTime = 0.4,
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		GamepadInputEnabled = false,

		ScrollWheelInputEnabled = false,
		TouchInputEnabled = false,
	})

	local Tabs = {
		["list"] = {},
	}
	local TabsChange = Signal.new()
	TabsChange:Connect(function(tabname)
		for i, v in next, Tabs.list do
			if v.Name == tabname then
				TabTitle.Text = string.format("#%s", v.Name)
				PageController:JumpTo(v.Container)
				-- Toggle On

				Tween(v.Mini_Button.Icon, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					--ImageColor3 = CurrentTheme.MainColor
					ImageTransparency = 0,
				})
				Tween(v.Button.Title, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					--ImageColor3 = CurrentTheme.MainColor
					TextTransparency = 0,
				})
				Tween(v.Button.Icon, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					--ImageColor3 = CurrentTheme.MainColor
					ImageTransparency = 0,
				})

				Tween(v.Button, 0.2, "Quad", "Out", {

					BackgroundTransparency = 1,
				})
				Tween(v.Button.LeftLine, 0.2, "Quad", "Out", {

					Size = UDim2.new(0, 1, 0.7, 0),
				})

				Size =
					UDim2.new(0, 1, 0.8, 0), Tween(v.Icon, 0.1, "Linear", "Out", {
						Rotation = 25,
					}, function()
						Tween(v.Icon, 0.1, "Linear", "Out", {
							Rotation = 0,
						})
					end)
			else
				Tween(v.Mini_Button, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
				})
				Tween(v.Mini_Button.Icon, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = 0.6,
				})

				Tween(v.Button.Icon, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					--ImageColor3 = CurrentTheme.MainColor
					ImageTransparency = 0.6,
				})

				Tween(v.Button.LeftLine, 0.2, "Quad", "Out", {

					Size = UDim2.new(0, 1, 0, 0),
				})

				Tween(v.Button, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					BackgroundTransparency = 1,
				})
				Tween(v.Button.Title, 0.2, "Quad", "Out", {
					-- BackgroundColor3 = Color3.fromRGB(40,40,40)
					--ImageColor3 = CurrentTheme.MainColor
					TextTransparency = 0.6,
				})

				-- Toggle Off
			end
		end
	end)
	function Tabs:NewTab(tab_options)
		local tab_Name = tab_options.Name or "Tab"
		local tab_Icon = tab_options.Icon or ""

		local Tab_Switch = New("Frame")({

			Name = "Tab_Switch",
			Parent = Tab_Switch_Container,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.new(1, 0, 0, 30),
			BorderSizePixel = 0,
			BackgroundTransparency = 0.5,

			[Children] = {
				New("Frame")({
					Name = "LeftLine",
					Size = UDim2.new(0, 1, 0, 0),
					Position = UDim2.new(0, 0, 0.5, 0),
					BorderSizePixel = 0,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					[Children] = {
						New("UIGradient")({
							Color = CurrentTheme.Gradient and WithGradient or NoGradient,
							[OnCreate] = function(ins)
								AddtoThemeGradient(ins)
							end,
							Rotation = 90,
						}),
					},
				}),
				New("TextLabel")({
					Name = "Title",
					Font = Enum.Font.Gotham,
					Text = tab_Name,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 13,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.943, 0, 0.5, 0),

					Size = UDim2.new(0.564, 0, 1, 0),
				}),

				New("ImageLabel")({
					Name = "Icon",
					Image = "http://www.roblox.com/asset/?id=" .. tostring(tab_Icon),
					BackgroundColor3 = Color3.fromRGB(0, 170, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 25, 0, 25),
					Position = UDim2.new(0, 5, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
				}),

				New("UIStroke")({
					Name = "UIStroke",
					Transparency = 1,
					Color = Color3.fromRGB(255, 255, 255),
				}),

				New("UIPadding")({
					Name = "UIPadding",
				}),
			},
		})

		local Tab_Switch_Mini = New("Frame")({

			Name = "Tab_Switch",
			Parent = Tab_Switch_Container,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.new(0, 30, 0, 30),
			BorderSizePixel = 0,
			Visible = false,
			BackgroundTransparency = 1,

			[Children] = {

				New("ImageLabel")({
					Name = "Icon",
					Image = "http://www.roblox.com/asset/?id=" .. tostring(tab_Icon),
					BackgroundColor3 = Color3.fromRGB(0, 170, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
				}),
			},
		})

		Tab_Container = New("ScrollingFrame")({
			Name = "Tab_Container",
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			Parent = PagesHolder,
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Position = UDim2.new(1, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,

			[Children] = {
				New("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 5),
				}),

				New("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingTop = UDim.new(0, 5),
				}),

				New("UIListLayout")({
					Name = "UIListLayout",
					Padding = UDim.new(0, 15),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			},
		})
		local List = Tab_Container:WaitForChild("UIListLayout")
		MakeDynamicScrolling(List, Tab_Container)
		RowMode:Connect(function(a)
			if a == "Vertical" then
				List.FillDirection = Enum.FillDirection.Vertical
			else
				List.FillDirection = Enum.FillDirection.Horizontal
			end
		end)
		MakeClickArea(Tab_Switch, function()
			TabsChange:Fire(tab_Name)
		end)
		MakeClickArea(Tab_Switch_Mini, function()
			TabsChange:Fire(tab_Name)
		end)

		Tabs["list"][#Tabs["list"] + 1] = {
			["Name"] = tab_Name,
			["Icon"] = Tab_Switch.Icon,
			["Title"] = Tab_Switch.Title,
			["Button"] = Tab_Switch,
			["Mini_Button"] = Tab_Switch_Mini,
			["Container"] = Tab_Container,
		}

		local _tab = {
			Name = tab_Name,
		}

		function _tab:Select()
			TabsChange:Fire(tab_Name)
		end
		AddtoTheme(Tab_Container, "BackgroundColor3", "TabContainerColor")
		local LeftSideHandler
		local RightSideHandler
		LeftSideHandler = New("ScrollingFrame")({
			Parent = Tab_Container,
			Size = UDim2.new(0.5, -5, 1, 0),
			Position = UDim2.new(0, 0),
			AnchorPoint = Vector2.new(0, 0),
			BackgroundTransparency = 1,
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			[Children] = {
				New("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 5),
				}),
				New("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 3),
					PaddingLeft = UDim.new(0, 3),
					PaddingRight = UDim.new(0, 3),
					PaddingTop = UDim.new(0, 3),
				}),
				New("UIListLayout")({
					Name = "UIListLayout",
					Padding = UDim.new(0, 17),
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			},
		})

		RightSideHandler = LeftSideHandler:Clone()
		RightSideHandler.Parent = Tab_Container

		RightSideHandler.Size = UDim2.new(0.5, -5, 1, 0)
		RightSideHandler.Position = UDim2.new(1, 0)
		RightSideHandler.AnchorPoint = Vector2.new(1, 0)
		table.insert(AllTabs, RightSideHandler)
		table.insert(AllTabs, LeftSideHandler)

		table.insert(LeftRightList, {
			Left = LeftSideHandler,
			Right = RightSideHandler,
		})
		MakeDynamicScrolling(LeftSideHandler.UIListLayout, LeftSideHandler, 20)
		MakeDynamicScrolling(RightSideHandler.UIListLayout, RightSideHandler, 20)
		LeftbarState:Connect(function(state)
			if state == false then
				Tab_Switch.Visible = false
				Tab_Switch_Mini.Visible = true
			else
				Tab_Switch.Visible = true

				Tab_Switch_Mini.Visible = false
			end
		end)

		function _tab:NewSection(section_option)
			local section_name = section_option["Name"] or "Section"
			local section_side = section_option["Side"] or "Left"

			local MainSection = New("Frame")({
				Name = "MainSection",
				Parent = section_side == "Left" and LeftSideHandler or RightSideHandler,
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.new(0.5, 0, 0, 0),
				Size = UDim2.new(1, 0, 0, 0),
				AnchorPoint = Vector2.new(0.5, 0),

				[Children] = {
					New("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 3),
					}),

					New("UIPadding")({
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 5),
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 5),
					}),

					New("UIStroke")({
						Name = "UIStroke",
						Transparency = 0.4,
						Color = CurrentTheme.MainColor,
						[OnCreate] = function(ins)
							AddtoTheme(ins, "Color", "SectionFrameColor")
						end,
					}),
					New("Frame")({
						Name = "SecrtionTitle",

						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						BackgroundTransparency = 0,
						BorderSizePixel = 0,
						Position = UDim2.new(0, 1, 0, -15),
						Size = UDim2.new(0, 0, 0, 25),
						[OnCreate] = function(ins)
							AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
						end,
						[Children] = {
							New("TextLabel")({
								Name = "SecrtionTitle",
								Font = Enum.Font.Gotham,
								Text = section_name,
								TextColor3 = CurrentTheme.SectionFrameColor,
								TextSize = 16,
								TextXAlignment = Enum.TextXAlignment.Left,
								AutomaticSize = Enum.AutomaticSize.X,
								BackgroundColor3 = Color3.f,
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								[OnCreate] = function(ins)
									AddtoTheme(ins, "TextColor3", "SectionFrameColor")
								end,
								[Children] = {

									New("UIPadding")({
										Name = "UIPadding",
										PaddingBottom = UDim.new(0, 5),
										PaddingLeft = UDim.new(0, 5),
										PaddingRight = UDim.new(0, 5),
										PaddingTop = UDim.new(0, 5),
									}),
								},
							}),
						},
					}),
				},
			})
			AddtoTheme(MainSection, "BackgroundColor3", "TabContainerColor")
			local ElementHandler = New("Frame")({
				Name = "ElementHandler",
				Parent = MainSection,

				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 1, 0),

				Size = UDim2.new(1, 0, 1, -7),

				[Children] = {},
			})
			local ElementHandlerList = New("UIListLayout")({
				Name = "ElementHandlerList",
				Padding = UDim.new(0, 3),
				Parent = ElementHandler,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			})

			local HDynamic = function()
				local ContentSize = ElementHandlerList.AbsoluteContentSize.Y
				MainSection.Size = UDim2.new(1, 0, 0, ContentSize + 20)
			end
			HDynamic()

			ElementHandlerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(HDynamic)

			local _sections = {
				flags = {},
			}
			function _sections:Label(label)
				local text = label or "TextLabel"
				local Label = New("TextLabel")({
					Name = "TextLabel",
					Parent = ElementHandler,
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
					Text = text,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 13,
					TextWrapped = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 25),
				})
				local label_obj = {}
				setmetatable(label_obj, {
					__newindex = function(t, i, v)
						if i == "Text" then
							Label.Text = tostring(v)
						end
					end,
				})

				return label_obj
			end
			function _sections:Divider(label)
				local text = label or "TextLabel"
				local Label = New("Frame")({
					Name = "Divider",
					BackgroundColor3 = Color3.fromRGB(30, 30, 30),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 20),
					Parent = ElementHandler,
					[OnCreate] = function(ins)
						AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
					end,
					[Children] = {
						New("TextLabel")({
							Name = "Title",
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
							Text = text,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 13,
							TextWrapped = false,
							AnchorPoint = Vector2.new(0.5, 0.5),
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundColor3 = Color3.fromRGB(30, 30, 30),
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(0, 25),
							[OnCreate] = function(ins)
								AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
							end,
							[Children] = {
								New("UIPadding")({
									Name = "UIPadding",
									PaddingLeft = UDim.new(0, 5),
									PaddingRight = UDim.new(0, 5),
								}),
							},
						}),

						New("Frame")({
							Name = "Line",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 0.5,
							BorderSizePixel = 0,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.new(1, 0, 0, 1),
							ZIndex = -1,
						}),
					},
				})
			end

			function _sections:Toggle(toggle_options)
				local toggle_name = toggle_options["Name"] or "Toggle"
				local toggle_autosave = toggle_options["AutoSave"] or false
				local toggle_callback = toggle_options["Callback"] or function() end
				local toggle_flag = toggle_options["Flag"] or flagify(toggle_name)
				local toggle_description = toggle_options["des"] or toggle_options["Info"] or nil
				local toggle_icon = toggle_options["Icon"] or nil
				local toggle_default = toggle_options["Default"] or toggle_options["Value"] or false

				local ToggleContainer = New("Frame")({
					Name = "ToggleContainer",
					Parent = ElementHandler,
					BackgroundColor3 = Color3.fromRGB(15, 15, 15),
					Size = UDim2.new(1, 0, 0, toggle_description and 30 or 20),
					BackgroundTransparency = 1,
					ZIndex = 10,

					[Children] = {
						New("Frame")({
							Name = "ToggleClickArea",
							AnchorPoint = Vector2.new(0, 0),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 0, 0, 0),
							Size = UDim2.new(1, 0, 0, 20),
						}),
						New("Frame")({
							Name = "LeftSide",
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(0, 0, 0.5, 0),
							Size = UDim2.new(0.8, 0, 1, 0),
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.fromRGB(0, 255, 0),
							[Children] = {
								New("UIListLayout")({
									Name = "LeftSideList",
									Padding = UDim.new(0, 0),
									HorizontalAlignment = Enum.HorizontalAlignment.Left,
									VerticalAlignment = Enum.VerticalAlignment.Top,
									FillDirection = Enum.FillDirection.Vertical,
									SortOrder = Enum.SortOrder.LayoutOrder,
								}),

								New("Frame")({
									Name = "Toggle_Title_Holder",
									Position = UDim2.new(0, 0, 0, 0),
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.8, 0, 0, 20),
									BackgroundTransparency = 1,
									[Children] = {
										New("ImageLabel")({
											Size = UDim2.new(0, 15, 0, 15),
											AnchorPoint = Vector2.new(0, 0.5),
											Position = UDim2.new(0, 0, 0.5, 0),
											Image = "http://www.roblox.com/asset/?id=" .. tostring(toggle_icon),
											Visible = toggle_icon ~= nil,
											BackgroundTransparency = 1,
										}),

										New("TextLabel")({
											Name = "Toggle_Title",
											Font = Enum.Font.Gotham,
											Text = toggle_name,
											TextColor3 = Color3.fromRGB(255, 255, 255),
											TextSize = 13,
											TextTransparency = 0.3,

											TextXAlignment = Enum.TextXAlignment.Left,
											BackgroundColor3 = Color3.fromRGB(255, 255, 255),
											BackgroundTransparency = 1,
											AnchorPoint = Vector2.new(0, 0),
											Position = UDim2.new(0, 0, 0, 0),
											Size = UDim2.new(1, 0, 1, 0),
											[Children] = {

												New("UIPadding")({
													Name = "UIPadding",

													PaddingLeft = UDim.new(0, toggle_icon ~= nil and 20 or 3),
												}),
											},
										}),
									},
								}),

								New("TextLabel")({
									Name = "Toggle_Description",
									Font = Enum.Font.Gotham,
									Text = DesFormat(toggle_description),
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextSize = 12,
									TextWrapped = true,
									ClipsDescendants = true,
									--	AutomaticSize = Enum.AutomaticSize.Y,
									Visible = true, --toggle_description ~= nil ,
									AnchorPoint = Vector2.new(0, 1),
									Position = UDim2.new(0, 0, 1, 0),
									TextTransparency = 0.5,
									TextXAlignment = Enum.TextXAlignment.Left,
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 1,
									Size = UDim2.new(1, 0, 0, 0),
									[Children] = {
										New("Frame")({
											Size = UDim2.new(0, 2, 1, 0),
											AnchorPoint = Vector2.new(0, 0),
											Position = UDim2.new(0, 0),
											BackgroundColor3 = CurrentTheme.MainColor,
											[Children] = {
												New("UICorner")({
													Name = "UICorner",
													CornerRadius = UDim.new(0, 3),
												}),
											},
											[OnCreate] = function(ins)
												AddtoTheme(ins, "BackgroundColor3", "MainColor")
											end,
										}),
										New("UIPadding")({
											Name = "UIPadding",

											PaddingLeft = UDim.new(0, 5),
										}),
									},
								}),
							},
						}),

						New("Frame")({
							Name = "RightSide",
							BackgroundTransparency = 1,

							AnchorPoint = Vector2.new(1, 0.5),
							Position = UDim2.new(1, 0, 0.5, 0),
							Size = UDim2.new(0.2, 0, 1, 0),
							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							[Children] = {
								New("ImageLabel")({
									Name = "Toggle_Outline",
									Parent = Toggle_Container,
									Image = "",
									AnchorPoint = Vector2.new(1, 0),
									BackgroundColor3 = CurrentTheme.ToggleBackgroundColor,
									ZIndex = 1000,
									Visible = true,

									BackgroundTransparency = 0,
									Position = UDim2.new(0.966, 0, 0, 0),
									Size = UDim2.new(0, 30, 0, 20),
									[OnCreate] = function(ins)
										AddtoTheme(ins, "BackgroundColor3", "ToggleBackgroundColor")
									end,

									[Children] = {
										New("UICorner")({
											Name = "UICorner",
											CornerRadius = UDim.new(0, 5),
										}),
										New("UIPadding")({
											Name = "UIPadding",
											PaddingBottom = UDim.new(0, 3),
											PaddingLeft = UDim.new(0, 3),
											PaddingRight = UDim.new(0, 3),
											PaddingTop = UDim.new(0, 3),
										}),

										New("ImageLabel")({
											Name = "Checkmark",
											Image = "",
											AnchorPoint = Vector2.new(0, 0.5),
											BackgroundColor3 = White,

											BackgroundTransparency = 0,
											ImageColor3 = Color3.fromRGB(0, 0, 0),
											ImageTransparency = 1,
											ZIndex = 999,
											Position = UDim2.new(0, 0, 0.5, 0),
											Size = UDim2.new(0, 15, 0, 15),
											[Children] = {

												New("UICorner")({
													Name = "UICorner",
													CornerRadius = UDim.new(0, 5),
												}),
												New("UIStroke")({
													Name = "UIStroke",
													ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
													Color = Color3.fromRGB(0, 0, 0),
													Thickness = 1,
													Transparency = 1,
												}),
											},
										}),
									},
								}),
								New("ImageButton")({
									Name = "Toggle_Des",
									Parent = Toggle_Container,
									Image = "http://www.roblox.com/asset/?id=11197746366",

									BackgroundColor3 = CurrentTheme.MainColor,
									ZIndex = 1000,
									ImageTransparency = 0.5,
									Visible = toggle_description ~= nil,
									AnchorPoint = Vector2.new(1, 0),
									BackgroundTransparency = 1,
									ScaleType = Enum.ScaleType.Stretch,
									Position = UDim2.new(1, -35, 0, 0),
									Size = UDim2.new(0, 20, 0, 20),

									[Children] = {},
								}),
							},
						}),

						New("UIStroke")({
							Name = "UIStroke",
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = CurrentTheme.MainColor,
							Thickness = 1,
							Transparency = 1,
						}),
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),
					},
				})

				New("Frame")({
					Name = "BRUH",
					Visible = toggle_description ~= nil,
					Parent = ElementHandler,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 5),
				})
				local BRUH2 = New("Frame")({
					Parent = ElementHandler,
					Size = UDim2.new(1, 0, 0, 50),
					Visible = false,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
				})
				local Toggle_Description_Test = New("TextLabel")({
					Name = "Toggle_Description_Test",
					Font = Enum.Font.Gotham,
					Text = tostring(toggle_description),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12,
					Parent = BRUH2,
					TextWrapped = true,
					ClipsDescendants = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					Visible = true, --toggle_description ~= nil ,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					TextTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.5,
					Size = UDim2.new(1, 0, 0, 0),
					[Children] = {
						New("UIPadding")({
							Name = "UIPadding",

							PaddingLeft = UDim.new(0, 3),
						}),
					},
				})

				local LeftSide = ToggleContainer:WaitForChild("LeftSide")
				local RightSide = ToggleContainer:WaitForChild("RightSide")
				local ToggleClickArea = ToggleContainer:WaitForChild("ToggleClickArea")
				local LeftSideList = LeftSide:WaitForChild("LeftSideList")
				local ADynamic = function()
					local ContentSize = LeftSideList.AbsoluteContentSize.Y
					ToggleContainer.Size = UDim2.new(1, 0, 0, ContentSize)
				end

				ADynamic()

				LeftSideList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ADynamic)

				local Toggle_Title_Holder = LeftSide:WaitForChild("Toggle_Title_Holder")
				local Toggle_Title = Toggle_Title_Holder:WaitForChild("Toggle_Title")
				local Toggle_Outline = RightSide:WaitForChild("Toggle_Outline")
				local Toggle_Description = LeftSide:WaitForChild("Toggle_Description")
				-- local Toggle_Description_Test = LeftSide:WaitForChild('Toggle_Description_Test')
				local Toggle_Des = RightSide:WaitForChild("Toggle_Des")
				local CheckMark = Toggle_Outline:WaitForChild("Checkmark")
				local CheckMark_Stroke = CheckMark:WaitForChild("UIStroke")
				local Toggled = false
				local CheckMarkSize = 1
				local Des_Open = false
				local TextService = game:GetService("TextService")
				Toggle_Description.TextTransparency = 1

				local function ToggleDesc()
					if Des_Open then
						Des_Open = false

						Tween(Toggle_Des, 0.2, "Linear", "Out", {

							Rotation = 0,
						})
						Tween(Toggle_Description, 0.2, "Linear", "Out", {

							TextTransparency = 1,
						}, function()
							Tween(Toggle_Description, 0.2, "Linear", "Out", {
								Size = UDim2.new(1, 0, 0, 0),
							})
						end)
					else
						Tween(Toggle_Des, 0.2, "Linear", "Out", {

							Rotation = 180,
						})
						Des_Open = true

						local ActualSize = UDim2.new(
							0,
							Toggle_Description_Test.AbsoluteSize.X,
							0,
							Toggle_Description_Test.AbsoluteSize.Y
						)
						Tween(Toggle_Description, 0.2, "Linear", "In", {
							Size = ActualSize,
						}, function()
							Tween(Toggle_Description, 0.2, "Linear", "Out", {
								TextTransparency = 0.5,
							})
						end)
					end
				end
				Toggle_Des.MouseButton1Click:Connect(function()
					ToggleDesc()
				end)
				if toggle_description then
					ToggleDesc()
				end

				local Set = function(b)
					if b then
						Toggled = true
						Tween(CheckMark, 0.1, "Linear", "In", {
							Position = UDim2.new(0.40, 0, 0.5, 0),
							BackgroundColor3 = CurrentTheme.ToggleDotColor_On,
						})

						Tween(Toggle_Outline, 0.1, "Linear", "In", {

							BackgroundColor3 = GetTheme("ToggleBackgroundColor_On"),
						})

						Tween(Toggle_Title, 0.1, "Linear", "In", {
							TextTransparency = 0,
						})
					else
						Toggled = false

						Tween(CheckMark, 0.1, "Linear", "In", {

							Position = UDim2.new(0, 0, 0.5, 0),
							BackgroundColor3 = CurrentTheme.ToggleDotColor_Off,
						})

						Tween(Toggle_Outline, 0.1, "Linear", "In", {

							BackgroundColor3 = GetTheme("ToggleBackgroundColor_Off"),
						})
						Tween(Toggle_Title, 0.1, "Linear", "In", {
							TextTransparency = 0.3,
						})
					end
					toggle_callback(Toggled)

					flags[toggle_flag] = Toggled
					if toggle_autosave then
						if toggle_flag then
							SavedInfo[toggle_flag] = Toggled
						else
							error("Autosave require flags")
						end
						SaveData()
					end
				end
				ThemeChanged:Connect(function()
					Tween(Toggle_Outline, 0.1, "Linear", "In", {
						BackgroundColor3 = flags[toggle_flag] and GetTheme("ToggleBackgroundColor_On")
							or GetTheme("ToggleBackgroundColor_Off"),
					})

					Tween(CheckMark, 0.1, "Linear", "In", {

						BackgroundColor3 = flags[toggle_flag] and CurrentTheme.ToggleDotColor_On
							or CurrentTheme.ToggleDotColor_Off,
					})
				end)

				-- Load Saved Data
				if toggle_autosave then
					if SavedInfo[toggle_flag] ~= nil then
						Set(SavedInfo[toggle_flag])
					else
						Set(toggle_default)
					end
				else
					Set(toggle_default)
				end

				local ToggleController = MakeClickArea(ToggleClickArea, function()
					if Toggled then
						Set(false)
					else
						Set(true)
					end
				end, true)
				ToggleController.Instance.MouseEnter:Connect(function()
					Tween(RightSide.Toggle_Outline, 0.1, "Linear", "In", {
						ImageColor3 = CurrentTheme.MainColor,
					})
				end)

				ToggleController.Instance.MouseLeave:Connect(function()
					Tween(RightSide.Toggle_Outline, 0.1, "Linear", "In", {
						ImageColor3 = Color3.fromRGB(255, 255, 255),
					})
				end)
				HDynamic()
				local ToggleLock = New("ImageButton")({
					Name = "Locked",
					Visible = false,
					Parent = ToggleContainer,
					Image = "http://www.roblox.com/asset/?id=11197236940",
					ScaleType = Enum.ScaleType.Fit,
					AutoButtonColor = false,
					ZIndex = 1000,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0.5,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 5, 1, 5),

					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 2),
						}),
					},
				})

				local ToggleFunction = {}
				local IsToggleLocked = false
				function ToggleFunction:Lock(bool)
					ToggleLock.Visible = true
				end
				function ToggleFunction:Unlock(bool)
					ToggleLock.Visible = false
				end

				function ToggleFunction:Set(bool)
					ToggleLock.Visible = Set(bool)
				end

				return ToggleFunction
			end
			function _sections:Button(button_options)
				local button_name = button_options["Name"] or "Toggle"
				local button_callback = button_options["Callback"] or function() end
				local button_icon = button_options["Icon"] or "10925108056"

				local ButtonContainer = New("Frame")({
					Name = "ButtonContainer",
					Parent = ElementHandler,
					BackgroundColor3 = White,
					Size = UDim2.new(1, 0, 0, 25),

					[Children] = {
						New("UIGradient")({

							Color = CurrentTheme.Gradient and WithGradient or NoGradient,
							[OnCreate] = function(ins)
								AddtoThemeGradient(ins)
							end,
						}),

						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("TextLabel")({
							Name = "TextLabel",
							Font = Enum.Font.Gotham,
							Text = button_name,
							TextColor3 = CurrentTheme.FontColor,
							TextSize = 13,
							TextTransparency = 0,
							TextXAlignment = Enum.TextXAlignment.Center,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1, 0),
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5),
							[OnCreate] = function(ins)
								AddtoTheme(ins, "TextColor3", "ButtonTextColor")
							end,
						}),
						New("ImageButton")({
							Name = "ImageButton",
							Image = "http://www.roblox.com/asset/?id=" .. tostring(button_icon),
							AnchorPoint = Vector2.new(1, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.966, 0, 0.5, 0),
							Size = UDim2.new(0, 20, 0, 20),
							ImageColor3 = CurrentTheme.FontColor,
							[OnCreate] = function(ins)
								AddtoTheme(ins, "ImageColor3", "ButtonTextColor")
							end,
							[Children] = {
								New("UIPadding")({
									Name = "UIPadding",
									PaddingBottom = UDim.new(0, 3),
									PaddingLeft = UDim.new(0, 3),
									PaddingRight = UDim.new(0, 3),
									PaddingTop = UDim.new(0, 3),
								}),
							},
						}),
					},
				})

				MakeClickArea(ButtonContainer, function()
					button_callback()
				end)
			end
			function _sections:TextBox(textbox_options)
				local textbox_title = textbox_options["Name"] or "Textbox"
				local textbox_default = textbox_options["Default"] or ""
				local textbox_callback = textbox_options["Callback"] or function() end
				local textbox_autosave = textbox_options["AutoSave"] or false
				local textbox_flag = textbox_options["Flag"] or flagify(textbox_title)

				local TextBoxContainer = New("Frame")({
					Parent = ElementHandler,
					Name = "TextBoxContainer",
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(20, 20, 20),
					Position = UDim2.new(0.213, 0, 0.324, 0),
					Size = UDim2.new(1, 0, 0, 40),
					[OnCreate] = function(ins)
						AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
					end,
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("TextLabel")({
							Name = "Title",
							Font = Enum.Font.Gotham,
							Text = textbox_title,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							TextXAlignment = Enum.TextXAlignment.Left,
							AnchorPoint = Vector2.new(0, 0),
							BackgroundColor3 = Color3.fromRGB(20, 20, 20),
							BackgroundTransparency = 0,
							ZIndex = 90,
							BorderSizePixel = 0,
							Position = UDim2.new(0, 5, 0, -4),
							AutomaticSize = Enum.AutomaticSize.X,
							Size = UDim2.new(0, 0, 0, 15),
							[OnCreate] = function(ins)
								AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
							end,
							[Children] = {
								New("UIPadding")({
									Name = "UIPadding",

									PaddingLeft = UDim.new(0, 5),
								}),
							},
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, 3),
							PaddingLeft = UDim.new(0, 3),
							PaddingRight = UDim.new(0, 3),
							PaddingTop = UDim.new(0, 3),
						}),

						New("TextBox")({
							Name = "TextInput",
							ClearTextOnFocus = false,
							CursorPosition = -1,
							Font = Enum.Font.Gotham,
							PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
							PlaceholderText = ". . .",
							Text = "",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(1, 0, 0, 25),

							[Children] = {
								New("UICorner")({
									Name = "UICorner",
									CornerRadius = UDim.new(0, 3),
								}),

								New("UIStroke")({
									Name = "UIStroke",
									Transparency = 0.5,
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Color3.fromRGB(255, 255, 255),
								}),

								New("ImageButton")({
									Name = "Clear",
									Image = "rbxassetid://11104757707",
									ImageColor3 = White,
									AnchorPoint = Vector2.new(1, 0.5),
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 1,
									ImageTransparency = 0,
									Position = UDim2.new(1, 0, 0.5, 0),
									Size = UDim2.new(0, 20, 0, 20),
									[Children] = {
										New("UIGradient")({

											Color = CurrentTheme.Gradient and WithGradient or NoGradient,
											[OnCreate] = function(ins)
												AddtoThemeGradient(ins)
											end,
										}),
									},
								}),
							},
						}),
					},
				})
				local TextInput = TextBoxContainer:WaitForChild("TextInput")
				local Clear = TextInput:WaitForChild("Clear")
				local textbox_obj = {}
				function textbox_obj:Clear()
					TextInput.Text = ""
				end
				function textbox_obj:Get()
					return tostring(TextInput.Text)
				end
				function textbox_obj:Set(value)
					TextInput.Text = tostring(value)
					flags[textbox_flag] = value
					textbox_callback(value)
					if textbox_autosave then
						if textbox_flag then
							SavedInfo[textbox_flag] = value
						else
							error("Autosave require flags")
						end
						SaveData()
					end
				end
				TextInput.Focused:Connect(function()
					Clear.Visible = false
					Tween(TextInput.UIStroke, 0.2, "Linear", "In", {
						Transparency = 0,
						Color = CurrentTheme.MainColor,
					})
				end)

				TextInput.FocusLost:Connect(function()
					Clear.Visible = true

					Tween(TextInput.UIStroke, 0.2, "Linear", "In", {
						Transparency = 0.5,
						Color = White,
					})
					textbox_obj:Set(TextInput.Text)
				end)
				if textbox_autosave then
					if textbox_flag and SavedInfo[textbox_flag] ~= nil then
						if SavedInfo[textbox_flag] ~= nil then
							textbox_obj:Set(SavedInfo[textbox_flag])
						end
					end
				else
					textbox_obj:Set(textbox_default)
				end

				MakeClickArea(Clear, function()
					textbox_obj:Clear()
				end)
				return textbox_obj
			end
			function _sections:Slider(slider_options)
				local slider_title = slider_options["Name"] or "slider"
				local slider_default = slider_options["Default"] or slider_options["Value"] or 0
				local slider_callback = slider_options["Callback"] or function() end
				local slider_autosave = slider_options["AutoSave"] or false
				local slider_flag = slider_options["Flag"] or flagify(slider_title)
				local slider_min = slider_options["Min"] or 0
				local slider_max = slider_options["Max"] or 1

				local sliderContainer = New("Frame")({
					Parent = ElementHandler,
					Name = "sliderContainer",
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(20, 20, 20),
					Position = UDim2.new(0.213, 0, 0.324, 0),
					Size = UDim2.new(1, 0, 0, 40),
					[OnCreate] = function(ins)
						AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
					end,
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("TextLabel")({
							Name = "Title",
							Font = Enum.Font.Gotham,
							Text = slider_title,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							TextXAlignment = Enum.TextXAlignment.Left,
							AnchorPoint = Vector2.new(0, 0),
							BackgroundColor3 = Color3.fromRGB(20, 20, 20),
							BackgroundTransparency = 0,
							ZIndex = 20,
							BorderSizePixel = 0,
							Position = UDim2.new(0, 10, 0, -4),
							AutomaticSize = Enum.AutomaticSize.X,
							Size = UDim2.new(0, 0, 0, 15),
							[OnCreate] = function(ins)
								AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
							end,
							[Children] = {
								New("UIPadding")({
									Name = "UIPadding",

									PaddingLeft = UDim.new(0, 5),
								}),
							},
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, 3),
							PaddingLeft = UDim.new(0, 3),
							PaddingRight = UDim.new(0, 3),
							PaddingTop = UDim.new(0, 3),
						}),

						New("TextButton")({
							Name = "TextInput",

							Font = Enum.Font.Gotham,

							Text = "",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(1, 0, 0, 25),

							[Children] = {
								New("UICorner")({
									Name = "UICorner",
									CornerRadius = UDim.new(0, 3),
								}),

								New("UIStroke")({
									Name = "UIStroke",
									Transparency = 0.5,
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Color3.fromRGB(255, 255, 255),
								}),

								New("ImageButton")({
									Name = "Clear",
									Image = "rbxassetid://11144672563",
									ImageColor3 = White,
									AnchorPoint = Vector2.new(1, 0.5),
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 1,
									ImageTransparency = 0,
									Position = UDim2.new(1, 0, 0.5, 3),
									Size = UDim2.new(0, 20, 0, 20),
									[Children] = {
										New("UIGradient")({

											Color = CurrentTheme.Gradient and WithGradient or NoGradient,
											[OnCreate] = function(ins)
												AddtoThemeGradient(ins)
											end,
										}),
									},
								}),
							},
						}),
					},
				})
				local TextInput = sliderContainer:WaitForChild("TextInput")
				local Clear = TextInput:WaitForChild("Clear")
				local slider_obj = {}

				local SliderHolder = New("TextButton")({
					Parent = sliderContainer,
					Text = "",
					AutoButtonColor = false,
					Size = UDim2.new(1, -40, 0, 3),
					Position = UDim2.new(0, 10, 0.5, 0),
					BackgroundColor3 = Color3.fromRGB(100, 100, 100),
					AnchorPoint = Vector2.new(0, 0.5),
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 4),
						}),
					},
				})
				local SliderBox = New("TextBox")({
					Name = "Title",
					Parent = sliderContainer,
					PlaceholderText = ". . .",
					Font = Enum.Font.Gotham,
					Text = slider_default,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 10,
					TextXAlignment = Enum.TextXAlignment.Center,
					AnchorPoint = Vector2.new(1, 0),

					BackgroundColor3 = Color3.fromRGB(20, 20, 20),
					BackgroundTransparency = 0,
					ZIndex = 90,
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0, 0, -4),
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.new(0, 30, 0, 15),
					[OnCreate] = function(ins)
						AddtoTheme(ins, "BackgroundColor3", "TabContainerColor")
					end,
					[Children] = {
						New("UIStroke")({
							Name = "UIStroke",
							Transparency = 0.5,
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = Color3.fromRGB(255, 255, 255),
						}),
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 4),
						}),
						New("UIPadding")({
							Name = "UIPadding",
						}),
					},
				})

				local SliderDot = New("ImageButton")({
					Parent = SliderHolder,
					Size = UDim2.fromOffset(10, 10),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.fromScale(0.4, 0.5),
					BackgroundTransparency = CurrentTheme.MainColor,
					AutoButtonColor = false,
					ZIndex = 40,
					BackgroundColor3 = White,
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(1, 0),
						}),
					},
				})

				local SliderDotFx = New("ImageButton")({
					Parent = SliderDot,
					Size = UDim2.fromOffset(30, 30),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),

					AutoButtonColor = false,
					Visible = false,

					BackgroundTransparency = 1,
					ZIndex = 50,
					BackgroundColor3 = White,
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(1, 0),
						}),
					},
				})

				local SliderFill = New("Frame")({
					Parent = SliderHolder,

					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0.5, 0),
					BackgroundColor3 = White,
					AnchorPoint = Vector2.new(0, 0.5),
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 4),
						}),
						New("UIGradient")({

							Color = CurrentTheme.Gradient and WithGradient or NoGradient,
							[OnCreate] = function(ins)
								AddtoThemeGradient(ins)
							end,
							Rotation = 180,
						}),
					},
				})

				local Area = New("ImageButton")({
					AutoButtonColor = false,
					Parent = sliderContainer,
					Size = UDim2.new(1, -20, 0.7, 0),
					Position = UDim2.fromScale(0, 1),
					AnchorPoint = Vector2.new(0, 1),
					BackgroundTransparency = 1,
				})

				local Drag = false
				local Hover = false
				local currentvalue = slider_default

				local function SetPercent(percent)
					Tween(SliderDot, 0.05, "Linear", "In", {
						Position = UDim2.new(percent, -5, 0.5, 0),
					})
					Tween(SliderFill, 0.05, "Linear", "In", {
						Size = UDim2.new(percent, -5, 1, 0),
					})
				end
				SliderBox.Focused:Connect(function()
					Tween(SliderBox.UIStroke, 0.2, "Linear", "In", {
						Transparency = 0,
						Color = CurrentTheme.AccentColor,
					})
				end)

				function slider_obj:Set(newval)
					local min = slider_min
					local max = slider_max

					-- local percent = (newval * 100)/ slider_max
					local percent = ((newval - min) * 100) / (max - min)
					SliderBox.Text = tostring(math.round(newval))

					SetPercent(math.clamp(percent / 100, 0, 1))
					flags[slider_flag] = newval
					if slider_autosave then
						SavedInfo[slider_flag] = newval
						SaveData()
					end
					slider_callback(newval)
				end

				SliderBox.FocusLost:Connect(function()
					Tween(SliderBox.UIStroke, 0.2, "Linear", "In", {
						Transparency = 0.5,
						Color = White,
					})
					local val = tonumber(SliderBox.Text)
					if val then
						if val > slider_max then
							val = slider_max
						end
						if val < slider_min then
							val = slider_min
						end

						slider_obj:Set(val)
						SliderBox.Text = tostring(val)
					else
						slider_obj:Set(currentnumber)
						SliderBox.Text = tostring(currentnumber)
					end
				end)
				local currentnumber = slider_default

				local function StartDragging()
					local min = slider_min
					local max = slider_max
					local valuefrompercent = (currentvalue * 100) / 100 * slider_max
					Tween(SliderDotFx, 0.2, "Linear", "In", {
						BackgroundTransparency = 0.5,
					})
					Tween(SliderDot, 0.2, "Linear", "In", {
						Size = UDim2.fromOffset(14, 14),

						BackgroundTransparency = 0,
						BackgroundColor3 = CurrentTheme.MainColor,
					})

					repeat
						wait()
						currentvalue =
							math.clamp((Mouse.X - SliderHolder.AbsolutePosition.X) / SliderHolder.AbsoluteSize.X, 0, 1)
						SetPercent(currentvalue)
						valuefrompercent = tonumber(((currentvalue * max) / max) * (max - min) + min) --(currentvalue * 100)/100 * slider_max
						SliderBox.Text = tostring(math.round(valuefrompercent))
					until not Drag

					currentnumber = valuefrompercent
					slider_obj:Set(valuefrompercent)

					Tween(SliderDotFx, 0.2, "Linear", "In", {
						BackgroundTransparency = 1,
					})
					Tween(SliderDot, 0.2, "Linear", "In", {
						BackgroundTransparency = 0,
						BackgroundColor3 = White,
						Size = UDim2.fromOffset(10, 10),
					})
				end

				UserInputService.InputBegan:Connect(function(input, gp)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Drag then
							Drag = false

							return
						end
						if Hover == true and not Drag then
							Drag = true
							Tween(SliderDotFx, 0.2, "Linear", "In", {
								ImageTransparency = 0.5,
							})
							StartDragging()
						end
					end
				end)
				UserInputService.InputEnded:Connect(function(input, gp)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Drag then
							Drag = false
							return
						end
					end
				end)

				Area.MouseEnter:Connect(function()
					Hover = true
				end)
				Area.MouseLeave:Connect(function()
					Hover = false
				end)

				if slider_autosave then
					if slider_flag and SavedInfo[slider_flag] ~= nil then
						if SavedInfo[slider_flag] ~= nil then
							slider_obj:Set(SavedInfo[slider_flag])
						end
					end
				else
					slider_obj:Set(slider_default)
				end

				MakeClickArea(Clear, function()
					slider_obj:Set(slider_default)
				end)
				return slider_obj
			end

			function _sections:Dropdown(dropdown_option)
				local dropdown_name = dropdown_option["Name"] or "Dropdown"
				local dropdown_callback = dropdown_option["Callback"] or function() end
				local dropdown_list = dropdown_option["List"] or dropdown_option["list"] or {}
				local dropdown_default = dropdown_option["Default"] or dropdown_option["default"] or nil
				local dropdown_autosave = dropdown_option["AutoSave"] or false
				local dropdown_flag = dropdown_option["Flag"] or flagify(dropdown_name)
				local dropdown_static = dropdown_option["Static"] or dropdown_option["Keep"] or false
				local DropdownBackground = New("Frame")({
					Name = "DropdownContainer",
					Parent = ElementHandler,
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.213, 0, 0.324, 0),
					Size = UDim2.new(1, 0, 0, 40),

					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("UIStroke")({
							Name = "UIStroke",
							Transparency = 1,
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = CurrentTheme.MainColor,
							[OnCreate] = function(ins)
								AddtoTheme(ins, "Color", "MainColor")
							end,
						}),
					},
				})
				local DropdownContainer = New("Frame")({
					Name = "DropdownContainer",
					Parent = DropdownBackground,
					BorderSizePixel = 0,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(20, 20, 20),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 1, 0),
					[OnCreate] = function(ins)
						AddtoTheme(ins, "BackgroundColor3", "DropdownBackgroundColor")
					end,

					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("TextLabel")({
							Name = "Title",
							Font = Enum.Font.Gotham,
							Text = dropdown_name,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							TextXAlignment = Enum.TextXAlignment.Left,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.00575, 0, 0, 0),
							Size = UDim2.new(0.7, 0, 0, 19),
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, 3),
							PaddingLeft = UDim.new(0, 7),
							PaddingRight = UDim.new(0, 7),
							PaddingTop = UDim.new(0, 3),
						}),

						New("TextLabel")({
							Name = "Display",
							Font = Enum.Font.Gotham,
							Text = dropdown_default or "N/A",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 13,
							TextTransparency = 0.5,
							TextXAlignment = Enum.TextXAlignment.Left,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.00575, 0, 0.529, 0),
							Size = UDim2.new(0.7, 0, -0.235, 19),
						}),
						New("ImageLabel")({
							Name = "Icon",
							Image = "rbxassetid://10934039279",
							AnchorPoint = Vector2.new(1, 0.5),
							BackgroundColor3 = Color3.fromRGB(30, 30, 30),
							Position = UDim2.new(1, 0, 0.5, 0),
							Size = UDim2.new(0, 30, 0, 30),
							[OnCreate] = function(ins)
								AddtoTheme(ins, "ImageColor3", "MainColor")
								AddtoTheme(ins, "BackgroundColor3", "BackgroundColor")
							end,
							[Children] = {
								New("UICorner")({
									Name = "UICorner",
									CornerRadius = UDim.new(0, 5),
								}),
							},
						}),
					},
				})

				local DropdownHandler = New("Frame")({
					Parent = ElementHandler,
					Name = "DropdownHandler",
					BorderSizePixel = 0,
					ClipsDescendants = true,
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(40, 40, 40),
					Position = UDim2.new(0.5, 0, 0.412, 0),
					Size = UDim2.new(1, 0, 0.162, 40),
					[OnCreate] = function(ins)
						AddtoTheme(ins, "BackgroundColor3", "DropdownBackgroundColor")
					end,
					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, 3),
							PaddingLeft = UDim.new(0, 3),
							PaddingRight = UDim.new(0, 3),
							PaddingTop = UDim.new(0, 3),
						}),

						New("TextBox")({
							Name = "Searchbox",
							Font = Enum.Font.Gotham,
							PlaceholderText = "Search ...",
							Text = "",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 20),

							[Children] = {
								New("UICorner")({
									Name = "UICorner",
									CornerRadius = UDim.new(0, 3),
								}),

								New("UIStroke")({
									Name = "UIStroke",
									Transparency = 0.5,
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Color3.fromRGB(255, 255, 255),
								}),
							},
						}),
					},
				})
				local DropdownButtonHolder = New("ScrollingFrame")({
					Name = "DropdownButtonHolder",
					Parent = DropdownHandler,
					BorderSizePixel = 0,
					ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
					ScrollBarThickness = 2,
					BackgroundTransparency = 1,

					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = Color3.fromRGB(50, 50, 50),
					Position = UDim2.new(0.5, 0, 0, 25),
					Size = UDim2.new(1, 0, 1, -25),
					CanvasSize = UDim2.new(0, 0, 0, 0),

					[Children] = {
						New("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(0, 3),
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, 3),
							PaddingLeft = UDim.new(0, 3),
							PaddingRight = UDim.new(0, 3),
							PaddingTop = UDim.new(0, 3),
						}),
					},
				})
				local DropdownHandlerList = New("UIListLayout")({
					Name = "UIListLayout",
					Parent = DropdownButtonHolder,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})
				local Title = DropdownContainer:WaitForChild("Title")
				local Icon = DropdownContainer:WaitForChild("Icon")
				local Display = DropdownContainer:WaitForChild("Display")
				local Searchbox = DropdownHandler:WaitForChild("Searchbox")
				local Button_list = {}
				Searchbox.Focused:Connect(function()
					Tween(Searchbox.UIStroke, 0.2, "Linear", "In", {
						Transparency = 0,
						Color = CurrentTheme.AccentColor,
					})
				end)
				Searchbox.FocusLost:Connect(function()
					Tween(Searchbox.UIStroke, 0.2, "Linear", "In", {
						Transparency = 0.5,
						Color = White,
					})
				end)
				Searchbox:GetPropertyChangedSignal("Text"):Connect(function()
					for i, v in pairs(Button_list) do
						if v.Instance ~= nil then
							if (v.Instance.Text):lower():find((Searchbox.Text):lower()) then
								v:Show()
							else
								v:Hide()
							end
						end
					end
				end)
				local HandlerOpening = false

				local MaxSize = 130
				local ClampSize = function() end
				local ChangeDropdownButtonHolderSize = function()
					if HandlerOpening then
						local ContentSize = DropdownHandlerList.AbsoluteContentSize.Y

						if ContentSize <= MaxSize then
							DropdownHandler.Size = UDim2.new(1, 0, 0, ContentSize + 35)
							DropdownButtonHolder.CanvasSize = UDim2.fromOffset(0, 0)
						else
							DropdownHandler.Size = UDim2.new(1, 0, 0, MaxSize + 5)
							DropdownButtonHolder.CanvasSize = UDim2.fromOffset(0, ContentSize + 20)
						end
					end
				end
				local function Set(value)
					Display.Text = tostring(value)

					dropdown_callback(value)
					flags[dropdown_flag] = value
					if dropdown_autosave then
						if dropdown_flag then
							SavedInfo[dropdown_flag] = value
						else
							error("Autosave require flags")
						end
						SaveData()
					end
				end

				-- Load Saved Data
				if dropdown_autosave then
					if SavedInfo[dropdown_flag] ~= nil then
						Set(SavedInfo[dropdown_flag])
						flags[dropdown_flag] = SavedInfo[dropdown_flag]
					else
						Set(dropdown_default)
						flags[dropdown_flag] = dropdown_default
					end
				else
					Set(dropdown_default)
					flags[dropdown_flag] = dropdown_default
				end

				local function SetHandlerState(b)
					if b then
						HandlerOpening = true
						Icon.BackgroundTransparency = 1
						Tween(Icon, 0.2, "Quad", "Out", {
							Rotation = 180,
						}, function()
							Icon.BackgroundTransparency = 0
						end)

						local s = 0
						for i, v in pairs(DropdownButtonHolder:GetChildren()) do
							if v:IsA("TextButton") then
								s = s + v.Size.Y.Offset
							end
						end

						if s <= MaxSize then
							DropdownHandler.Visible = true
							Tween(DropdownHandler, 0.2, "Quad", "Out", {
								Size = UDim2.new(1, 0, 0, s + 35),
							})
						else
							Tween(DropdownHandler, 0.2, "Quad", "Out", {
								Size = UDim2.new(1, 0, 0, MaxSize + 10),
							}, function()
								ChangeDropdownButtonHolderSize()
							end)
							-- DropdownButtonHolder.CanvasSize = UDim2.fromOffset(0, s+20)
						end
					else
						HandlerOpening = false
						Icon.BackgroundTransparency = 1
						Tween(Icon, 0.2, "Quad", "Out", {
							Rotation = 0,
						}, function()
							Icon.BackgroundTransparency = 0
						end)
						Tween(DropdownHandler, 0.2, "Quad", "Out", {
							Size = UDim2.new(1, 0, 0, 0),
						})
					end
				end
				local MakeDropdownButton = function(ButtonName)
					local NewButton = New("TextButton")({
						Name = "DropdownButton",
						Font = Enum.Font.Gotham,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 13,
						Text = ButtonName,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						TextTransparency = 0.5,
						Size = UDim2.new(1, 0, 0, 20),
						Parent = DropdownButtonHolder,
					})
					MakeClickArea(NewButton, function()
						Set(NewButton.Text)

						if not dropdown_static then
							SetHandlerState(false)
						end
					end)
					NewButton.MouseEnter:Connect(function()
						Tween(NewButton, 0.1, "Linear", "In", {
							TextTransparency = 0,
						})
					end)
					NewButton.MouseLeave:Connect(function()
						Tween(NewButton, 0.1, "Linear", "In", {
							TextTransparency = 0.5,
						})
					end)
					local button_obj = {
						Instance = NewButton,
						Name = ButtonName,
					}
					function button_obj:Destroy()
						NewButton:Destroy()
					end
					function button_obj:Hide()
						NewButton.Visible = false
					end
					function button_obj:Show()
						NewButton.Visible = true
					end

					Button_list[#Button_list + 1] = button_obj
				end
				for i, v in pairs(dropdown_list) do
					MakeDropdownButton(v)
				end

				SetHandlerState(false)
				--SetHandlerState(true)

				DropdownHandlerList:GetPropertyChangedSignal("AbsoluteContentSize")
					:Connect(ChangeDropdownButtonHolderSize)
				ChangeDropdownButtonHolderSize()

				MakeClickArea(DropdownBackground, function()
					if HandlerOpening then
						SetHandlerState(false)
					else
						SetHandlerState(true)
					end
				end)

				local dropdown_obj = {}
				function dropdown_obj:Add(value)
					if tostring(value) ~= "" and tostring(value) ~= "nil" then
						MakeDropdownButton(value)
					end
				end
				function dropdown_obj:Set(newvalue)
					Set(newvalue)
				end
				function dropdown_obj:Clear(newvalue)
					for i, v in pairs(Button_list) do
						v:Destroy()
					end
				end
				function dropdown_obj:Get()
					return library[dropdown_flag][dropdown_flag]
				end
				function dropdown_obj:Remove(val)
					for i, v in pairs(Button_list) do
						if v.Name == val then
							v:Destroy()
						end
					end
				end

				function dropdown_obj:GetList()
					do
						local lists = {}
						for i, v in pairs(Button_list) do
							if v.Name ~= nil then
								lists[#lists + 1] = v.Name
							end
						end
						return lists
					end
				end
				function dropdown_obj:Refresh(newlist)
					do
						self:Clear()
						for i, v in pairs(newlist) do
							MakeDropdownButton(v)
						end
					end
				end

				return dropdown_obj
			end

			return _sections
		end
		return _tab
	end
	return Tabs
end
return library
