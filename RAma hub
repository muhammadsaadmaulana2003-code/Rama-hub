-- RAMA HUB LITE V6
wait(3)
local lp = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")

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
r.Active = true -- PENTING BIAR BISA DI DRAG
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

-- FRAME
local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0,210,0,170)
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
_G.speed = false
_G.fly = false
_G.esp = false
local speedVal = 50
local hum

-- 1. SPEED HACK
local btnSpeed = newBtn("Speed Hack")
btnSpeed.MouseButton1Click:Connect(function()
    _G.speed = not _G.speed
    btnSpeed.Text = "Speed Hack: "..(_G.speed and "ON" or "OFF")
    btnSpeed.BackgroundColor3 = _G.speed and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
end)

-- 2. FLY ON/OFF
local btnFly = newBtn("Fly")
btnFly.MouseButton1Click:Connect(function()
    _G.fly = not _G.fly
    btnFly.Text = "Fly: "..(_G.fly and "ON" or "OFF")
    btnFly.BackgroundColor3 = _G.fly and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
    
    if _G.fly then
        btnFly.Text = "Fly: LOADING..."
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-goktug110gx-fly-gui-236664"))()
        wait(0.5)
        btnFly.Text = "Fly: ON"
    else
        for _,v in pairs(lp.PlayerGui:GetChildren()) do
            if v.Name:find("Fly") or v.Name:find("fly") then
                v:Destroy()
            end
        end
    end
end)

-- 3. ESP SEMUA
local btnESP = newBtn("ESP All")
btnESP.MouseButton1Click:Connect(function()
    _G.esp = not _G.esp
    btnESP.Text = "ESP All: "..(_G.esp and "ON" or "OFF")
    btnESP.BackgroundColor3 = _G.esp and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
    
    for _,v in pairs(game.Players:GetPlayers()) do
        if v.Character then
            if _G.esp then
                if not v.Character:FindFirstChild("ESP") then
                    local hl = Instance.new("Highlight", v.Character)
                    hl.Name = "ESP"
                    hl.FillColor = Color3.fromRGB(0,255,255)
                    hl.OutlineColor = Color3.new(1,1,1)
                end
            else
                if v.Character:FindFirstChild("ESP") then v.Character.ESP:Destroy() end
            end
        end
    end
end)

-- KONTROL SPEED
game:GetService("RunService").RenderStepped:Connect(function()
    hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
    if _G.speed and hum then hum.WalkSpeed = speedVal end
    if not _G.speed and hum then hum.WalkSpeed = 16 end
end)

r.MouseButton1Click:Connect(function()
    if not dragging then -- biar pas di drag ga kebuka
        f.Visible = not f.Visible
    end
end)

game.StarterGui:SetCore("SendNotification",{Title="RAMA LITE V6";Text="hapoy cuy";Duration=10})
