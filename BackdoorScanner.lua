local toolbar = plugin:CreateToolbar("Fake_t's tools")
local tbar = toolbar:CreateButton("Backdoor Scanner", "One scan a free model keeps exploiters away. Some of the detections might be a false positive ALWAYS check scripts before destroying them", "http://www.roblox.com/asset/?id=5652011015")

local size = 300

local version = '1.0'

local function g(str)
	local res = false
	
	if str:find('require') then
		res = true
	end
	
	return res
end

local function main()
	local ret = {}
	
	for i, obj in ipairs(game:GetDescendants()) do
		local success, message = pcall(function()
			if obj:IsA("Script") or obj:IsA("LocalScript") then
				local s = obj.Source

				if g(s) then
					local r = obj:GetFullName()
					for j, line in ipairs(s:split('\n')) do
						if g(line) then
							r = r..'BDSplitString'..tostring(j)
						end
					end
					
					table.insert(ret, r)
				end
			end
		end)
	end
	
	return ret
end

local interface = plugin:CreateDockWidgetPluginGui("FaketsBackdoorFinder_Interface", 
	DockWidgetPluginGuiInfo.new(
		Enum.InitialDockState.Float,
		false, 
		false, 
		size + 50,
		size, 
		size + 50,  
		size  
	)
)

local interr = plugin:CreateDockWidgetPluginGui("FaketsBackdoorFinder_Interface_info", 
	DockWidgetPluginGuiInfo.new(
		Enum.InitialDockState.Float,
		false,
		false,
		(size + 50) / 1.5,
		size / 1.5,
		(size + 50) / 1.5,
		size / 1.5 
	)
)

local intf = Instance.new("Frame")
intf.Size = UDim2.new(10, 0, 10, 0)
intf.BackgroundColor3 = Color3.fromRGB(55, 55, 55)

intf.Parent = interface
interface.Title = 'Backdoor Scanner v'..version


local InfoBox = Instance.new("Frame")
InfoBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
InfoBox.Size = UDim2.new(10, 0, 10, 0)

InfoBox.Parent = interr

--Can't be bothered to change these bois

local WeldChildren = Instance.new("TextButton")
local SelectedLabel = Instance.new("TextLabel")
local ListBox = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

WeldChildren.Name = "Scan"
WeldChildren.Parent = intf
WeldChildren.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
WeldChildren.BorderColor3 = Color3.fromRGB(20, 20, 20)
WeldChildren.Size = UDim2.new(0, 130, 0, 33)
WeldChildren.Position = UDim2.new(0, ((size + 50) - 15) - WeldChildren.Size.X.Offset, 0, (size - WeldChildren.Size.Y.Offset) - 15)
WeldChildren.Font = Enum.Font.SourceSans
WeldChildren.Text = "Scan"
WeldChildren.TextColor3 = Color3.fromRGB(255, 255, 255)
WeldChildren.TextSize = 14.000
WeldChildren.TextWrapped = true

SelectedLabel.Name = "SelectedLabel"
SelectedLabel.Parent = intf
SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SelectedLabel.BackgroundTransparency = 0.9
SelectedLabel.Position = UDim2.new(0, 15, 0, 15)
SelectedLabel.Size = UDim2.new(0, 320, 0, 200)
SelectedLabel.Text = "Selected:"
SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedLabel.TextSize = 14.000
SelectedLabel.TextWrapped = true
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectedLabel.TextYAlignment = Enum.TextYAlignment.Top

ListBox.Name = "ListBox"
ListBox.Parent = intf
ListBox.Active = true
ListBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ListBox.BorderColor3 = Color3.fromRGB(20, 20, 20)
ListBox.CanvasSize = UDim2.new(0, 0, 0, 0)
ListBox.Position = UDim2.new(0, 15, 0, 15)
ListBox.Selectable = false
ListBox.Size = UDim2.new(0, 320, 0, 202)

UIListLayout.Parent = ListBox
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

tbar.Click:Connect(function()
	interface.Enabled = not interface.Enabled
	
	if not interface.Enabled then
		interr.Enabled = false
	end
end)

local function draw()
	for i, f in ipairs(ListBox:GetChildren()) do
		if f.ClassName == 'Frame' then
			f:Destroy()
		end
	end
	
	interr.Title = ""
	interr.Enabled = false
	
	for i, obj in ipairs(InfoBox:GetChildren()) do
		if obj:IsA("TextLabel") then
			print(i)
			obj:Destroy()
		end
	end
	
	local rtable = main()
	
	local xsize = 320
	if #rtable > 8 then
		xsize = 308
	end
	
	ListBox.CanvasSize = UDim2.new(0, 0, 0, 25 * #rtable)
	
	for i, infotable in ipairs(rtable) do
		local scriptname = infotable:split('BDSplitString')[1]
		
		local List = Instance.new("Frame")
		local Name = Instance.new("TextLabel")
		local Info = Instance.new("TextButton")
		local Destroy = Instance.new("TextButton")
			
		List.Name = "List"
		List.Parent = ListBox
		List.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		List.BorderColor3 = Color3.fromRGB(20, 20, 20)
		List.Position = UDim2.new(0.043341212, 0, 0.355184734, 0)
		List.Size = UDim2.new(0, xsize, 0, 25)
			
		Name.Name = "Name"
		Name.Parent = List
		Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Name.BackgroundTransparency = 1.000
		Name.Position = UDim2.new(-0.00312983524, 0, 0, 1)
		Name.Size = UDim2.new(0, 177, 0, 23)
		Name.Font = Enum.Font.SourceSans
		Name.Text = scriptname
		Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		Name.TextScaled = true
		Name.TextSize = 14.000
		Name.TextWrapped = true
			
		Info.Name = "Info"
		Info.Parent = List
		Info.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Info.BorderSizePixel = 0
		Info.Position = UDim2.new(0.57099998, 5, 0.0399999991, 0)
		Info.Size = UDim2.new(0, 61, 0, 23)
		Info.Font = Enum.Font.SourceSans
		Info.Text = "Info"
		Info.TextColor3 = Color3.fromRGB(255, 255, 255)
		Info.TextSize = 14.000
			
		Destroy.Name = "Destroy"
		Destroy.Parent = List
		Destroy.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Destroy.BorderSizePixel = 0
		Destroy.Position = UDim2.new(0.768999994, 8, 0.0399999991, 0)
		Destroy.Size = UDim2.new(0, 61, 0, 23)
		Destroy.Font = Enum.Font.SourceSans
		Destroy.Text = "Destroy"
		Destroy.TextColor3 = Color3.fromRGB(255, 255, 255)
		Destroy.TextSize = 14.000
			
		Info.MouseButton1Click:Connect(function()		
			local _y = 0
			
			interr.Title = scriptname
			interr.Enabled = true
			
			for i, obj in ipairs(InfoBox:GetChildren()) do
				if obj:IsA("TextLabel") then
					obj:Destroy()
				end
			end
			
			for j, splitted in ipairs(infotable:split('BDSplitString')) do
				if j ~= 1 then
					local inf = Instance.new("TextLabel")
					
					inf.Name = "inf"
					inf.Parent = InfoBox
					inf.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					inf.BorderColor3 = Color3.fromRGB(0, 0, 0)
					inf.Position = UDim2.new(0, 0, 0, _y)
					inf.Size = UDim2.new(1, 0, 0, 23)
					inf.Font = Enum.Font.SourceSans
					inf.Text = "Possible backdoor at line "..splitted
					inf.TextColor3 = Color3.fromRGB(255, 255, 255)
					inf.TextSize = 14.000
					inf.TextXAlignment = Enum.TextXAlignment.Left	
					
					_y = _y + (inf.Size.Y.Offset + 1)
				end			
			end
		end)
		
		Destroy.MouseButton1Click:Connect(function()
			local segments = scriptname:split(".")
			local current = game --location to search
			for i,v in pairs(segments) do
				current=current[v]
			end
			current:Destroy()
			
			draw() --redraw
		end)
	end
end

WeldChildren.MouseButton1Click:Connect(function()
	draw()
end)
