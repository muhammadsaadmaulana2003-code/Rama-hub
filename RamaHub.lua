-- RAMA HUB LITE V1
wait(3)
local lp = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "RamaLite"
gui.ResetOnSpawn = false

-- TOMBOL R YANG BISA DI DRAG
local r = Instance.new("TextButton", gui)
r.Size = UDim2.new(0,50,0,50)
r.Position = UDim2.new(0,20,0,100)
r.Text = "R"
r.TextScaled = true
r.Font = Enum.Font.GothamBlack
r.TextColor3 = Color3.new(1,1,1)
r.BackgroundColor3 = Color3.fromRGB(0,170,255)
r.Active = true
Instance.new("UICorner",r).CornerRadius = UDim.new(1,0)

-- FUNGSI DRAG
local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	r.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

r.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = r.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

r.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragInput = input
	end
end)

uis.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- FRAME DIKECILIN KARENA CUMA 2 FITUR
local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0,210,0,110)
f.Position = UDim2.new(0,80,0,100)
f.BackgroundColor3 = Color3.fromRGB(25,25,25)
f.Visible = false
Instance.new("UICorner",f).CornerRadius = UDim.new(0,10)

local y = 10
local function newBtn(text)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0.9,0,0,40)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text..": OFF"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
    y = y + 50
    return b
end

-- VARIABEL
_G.esp = false
_G.noclip = false

-- 1. ESP SEMUA PLAYER
local btnESP = newBtn("ESP All")
btnESP.MouseButton1Click:Connect(function()
    _G.esp = not _G.esp
    btnESP.Text = "ESP All: "..(_G.esp and "ON" or "OFF")
    btnESP.BackgroundColor3 = _G.esp and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
    
    local function addESP(plr)
        if plr.Character and not plr.Character:FindFirstChild("ESP") then
            local hl = Instance.new("Highlight", plr.Character)
            hl.Name = "ESP"
            hl.FillColor = Color3.fromRGB(0,255,255)
            hl.OutlineColor = Color3.new(1,1,1)
            hl.FillTransparency = 0.5
        end
    end
    
    local function removeESP(plr)
        if plr.Character and plr.Character:FindFirstChild("ESP") then 
            plr.Character.ESP:Destroy() 
        end
    end
    
    for _,v in pairs(game.Players:GetPlayers()) do
        if _G.esp then addESP(v) else removeESP(v) end
        v.CharacterAdded:Connect(function()
            wait(1)
            if _G.esp then addESP(v) end
        end)
    end
    
    game.Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            wait(1)
            if _G.esp then addESP(plr) end
        end)
    end)
end)

-- 2. NOCLIP ON/OFF
local btnNoclip = newBtn("Noclip")
btnNoclip.MouseButton1Click:Connect(function()
    _G.noclip = not _G.noclip
    btnNoclip.Text = "Noclip: "..(_G.noclip and "ON" or "OFF")
    btnNoclip.BackgroundColor3 = _G.noclip and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
end)

RunService.Stepped:Connect(function()
    if _G.noclip and lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

r.MouseButton1Click:Connect(function()
    if not dragging then
        f.Visible = not f.Visible
    end
end)

game.StarterGui:SetCore("SendNotification",{Title="RAMA LITE V1 HAPPY CUY";Text="ESP + Noclip Loaded";Duration=5})
