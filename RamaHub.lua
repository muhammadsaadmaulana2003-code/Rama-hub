-- RAMA HUB LITE V7.6
wait(3)
local lp = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local mouse = lp:GetMouse()

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
		dragging = true dragStart = input.Position startPos = r.Position
		input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end)
	end
end)
r.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then dragInput = input end)
uis.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end)

-- FRAME
local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0,210,0,260)
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
_G.infJump = false
_G.waterWalk = false
_G.clickTP = false

-- 1. ESP SEMUA PLAYER
local btnESP = newBtn("ESP All")
btnESP.MouseButton1Click:Connect(function()
    _G.esp = not _G.esp
    btnESP.Text = "ESP All: "..(_G.esp and "ON" or "OFF")
    btnESP.BackgroundColor3 = _G.esp and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
    local function addESP(plr)
        if plr.Character and not plr.Character:FindFirstChild("ESP") then
            local hl = Instance.new("Highlight", plr.Character)
            hl.Name = "ESP" hl.FillColor = Color3.fromRGB(0,255,255) hl.OutlineColor = Color3.new(1,1,1) hl.FillTransparency = 0.5
        end
    end
    local function removeESP(plr)
        if plr.Character and plr.Character:FindFirstChild("ESP") then plr.Character.ESP:Destroy() end
    end
    for _,v in pairs(Players:GetPlayers()) do
        if _G.esp then addESP(v) else removeESP(v) end
        v.CharacterAdded:Connect(function() wait(1) if _G.esp then addESP(v) end)
    end
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function() wait(1) if _G.esp then addESP(plr) end end)
    end)
end)

-- 2. NOCLIP ON/OFF
local btnNoclip = newBtn("Noclip")
btnNoclip.MouseButton1Click:Connect(function()
    _G.noclip = not _G.noclip
    btnNoclip.Text = "Noclip: "..(_G.noclip and "ON" or "OFF")
    btnNoclip.BackgroundColor3 = _G.noclip and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
end)

-- 3. INFINITE JUMP
local btnInfJump = newBtn("Inf Jump")
btnInfJump.MouseButton1Click:Connect(function()
    _G.infJump = not _G.infJump
    btnInfJump.Text = "Inf Jump: "..(_G.infJump and "ON" or "OFF")
    btnInfJump.BackgroundColor3 = _G.infJump and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
end)
uis.JumpRequest:Connect(function()
    if _G.infJump and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- 4. WALK ON WATER - FIX
local waterPlatform
local btnWater = newBtn("Water Walk")
btnWater.MouseButton1Click:Connect(function()
    _G.waterWalk = not _G.waterWalk
    btnWater.Text = "Water Walk: "..(_G.waterWalk and "ON" or "OFF")
    btnWater.BackgroundColor3 = _G.waterWalk and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
    
    if _G.waterWalk then
        waterPlatform = Instance.new("Part")
        waterPlatform.Name = "WaterPlatform"
        waterPlatform.Anchored = true 
        waterPlatform.CanCollide = true 
        waterPlatform.Transparency = 1
        waterPlatform.Size = Vector3.new(6,1,6)
        waterPlatform.Parent = workspace
    else
        if waterPlatform then waterPlatform:Destroy() waterPlatform = nil end
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.waterWalk and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local pos = hrp.Position
        -- bikin pijakan 3 stud di bawah kaki
        waterPlatform.CFrame = CFrame.new(pos.X, pos.Y - 3, pos.Z)
    end
end)

-- 5. CLICK TELEPORT
local btnTP = newBtn("Click TP")
btnTP.MouseButton1Click:Connect(function()
    _G.clickTP = not _G.clickTP
    btnTP.Text = "Click TP: "..(_G.clickTP and "ON" or "OFF")
    btnTP.BackgroundColor3 = _G.clickTP and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
end)
mouse.Button1Down:Connect(function()
    if _G.clickTP and not dragging and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
    end
end)

RunService.Stepped:Connect(function()
    if _G.noclip and lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

r.MouseButton1Click:Connect(function() if not dragging then f.Visible = not f.Visible end)
game.StarterGui:SetCore("SendNotification",{Title="RAMA LITE V7.6";Text="Water Walk Fixed";Duration=5})
