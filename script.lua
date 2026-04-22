-- FINAL VERSION: GIỮ UI CŨ + FIX ESP + AIMBOT
local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

local espEnabled = false
local aimbotEnabled = false
local aiming = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 350, 0, 320)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
main.BackgroundTransparency = 0.3
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "THINH"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- EXIT
local exitBtn = Instance.new("TextButton", main)
exitBtn.Size = UDim2.new(0,30,0,30)
exitBtn.Position = UDim2.new(1,-35,0,0)
exitBtn.Text = "X"
exitBtn.BackgroundColor3 = Color3.fromRGB(30,0,0)
exitBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", exitBtn)

exitBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- HIDE
local hideBtn = Instance.new("TextButton", main)
hideBtn.Size = UDim2.new(0,30,0,30)
hideBtn.Position = UDim2.new(1,-70,0,0)
hideBtn.Text = "-"
hideBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
hideBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", hideBtn)

-- OPEN ICON
local openBtn = Instance.new("ImageButton", gui)
openBtn.Size = UDim2.new(0,50,0,50)
openBtn.Position = UDim2.new(0,20,0.5,0)
openBtn.BackgroundTransparency = 1
openBtn.Visible = false
openBtn.Image = "rbxassetid://94815922213367"
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1,0)

hideBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

-- TOGGLE (GIỮ STYLE CŨ)
local function createToggle(parent, text, y, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.85,0,0,35)
    frame.Position = UDim2.new(0.075,0,0,y)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BackgroundTransparency = 0.2
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)

    local toggle = Instance.new("Frame", frame)
    toggle.Size = UDim2.new(0,50,0,20)
    toggle.Position = UDim2.new(1,-60,0.5,-10)
    toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Instance.new("UICorner", toggle)

    local circle = Instance.new("Frame", toggle)
    circle.Size = UDim2.new(0,18,0,18)
    circle.Position = UDim2.new(0,1,0.5,-9)
    circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", circle)

    local state = false

    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state

            if state then
                toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
                circle:TweenPosition(UDim2.new(1,-19,0.5,-9), "Out", "Quad", 0.2, true)
            else
                toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
                circle:TweenPosition(UDim2.new(0,1,0.5,-9), "Out", "Quad", 0.2, true)
            end

            callback(state)
        end
    end)
end

-- BUTTONS
createToggle(main, "ESP", 60, function(v)
    espEnabled = v
end)

createToggle(main, "Aimbot", 110, function(v)
    aimbotEnabled = v
end)

-- thêm nút Fly
createToggle(main, "BAY", 160, function(v)
    flyEnabled = v

    if v then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Thinh69/baycungthinh/main/bay.lua"))()
    end
end)

createToggle(main, "Xuyên Tường", 210, function(v)
    NOCLIPEnabled = v

    if v then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Thinh69/noclip/main/noclip.lua"))()
	end
end)

createToggle(main, "Tàng Hình", 260, function(v)
    TANGHINHEnabled = v

    if v then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Thinh69/tanghinh/main/tanghinh.lua"))()
    end
end)

-- HELPER: tìm part an toàn cho mọi game
local function getPart(char)
    return char:FindFirstChild("Head")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("HumanoidRootPart")
end

-- ESP SYSTEM (FIX FULL GAME FPS)
RunService.RenderStepped:Connect(function()
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end

    local myPos = myChar.HumanoidRootPart.Position

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local char = p.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")

            if not espEnabled then
                if char:FindFirstChild("ESP_H") then char.ESP_H:Destroy() end
                if game.CoreGui:FindFirstChild(p.Name.."_ESP") then
                    game.CoreGui[p.Name.."_ESP"]:Destroy()
                end
                continue
            end

            -- HIGHLIGHT
            if not char:FindFirstChild("ESP_H") then
                local h = Instance.new("Highlight")
                h.Name = "ESP_H"
                h.FillTransparency = 0.7
                h.Parent = char
            end

            local highlight = char.ESP_H
            highlight.FillColor = (p.Team == player.Team)
                and Color3.fromRGB(0,255,0)
                or Color3.fromRGB(255,0,0)

            -- ESP GUI
            local espGui = game.CoreGui:FindFirstChild(p.Name.."_ESP")

            if not espGui then
                espGui = Instance.new("BillboardGui")
                espGui.Name = p.Name.."_ESP"
                espGui.Size = UDim2.new(0,200,0,50)
                espGui.AlwaysOnTop = true
                espGui.StudsOffset = Vector3.new(0,2.5,0)
                espGui.Parent = game.CoreGui

                local txt = Instance.new("TextLabel", espGui)
                txt.Name = "TXT"
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(255,255,255)
                txt.TextStrokeTransparency = 0
            end

            -- gán part an toàn
            local part = getPart(char)
            if part then
                espGui.Adornee = part
            end

            -- khoảng cách (nếu có HRP)
            if hrp and espGui:FindFirstChild("TXT") then
                local dist = (hrp.Position - myPos).Magnitude
                espGui.TXT.Text = p.Name.." ["..math.floor(dist).."m]"
            end
        end
    end
end)

-- AUTO RE-ATTACH ESP KHI PLAYER RESPAWN / MAP MỚI
local function hookPlayer(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(1)
        if not espEnabled then return end

        if char and char:FindFirstChild("Head") then
            if not game.CoreGui:FindFirstChild(p.Name.."_ESP") then
                local espGui = Instance.new("BillboardGui")
                espGui.Name = p.Name.."_ESP"
                espGui.Size = UDim2.new(0,200,0,50)
                espGui.AlwaysOnTop = true
                espGui.StudsOffset = Vector3.new(0,2.5,0)
                espGui.Parent = game.CoreGui
                espGui.Adornee = char:FindFirstChild("Head")

                local txt = Instance.new("TextLabel", espGui)
                txt.Name = "TXT"
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(255,255,255)
                txt.TextStrokeTransparency = 0
            end
        end
    end)
end

for _,p in pairs(Players:GetPlayers()) do
    hookPlayer(p)
end

Players.PlayerAdded:Connect(function(p)
    hookPlayer(p)
end)

-- AIMBOT
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = false
    end
end)

local function getClosest()
    local closest,dist = nil,math.huge

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            local pos,vis = camera:WorldToViewportPoint(p.Character.Head.Position)
            if vis then
                local mag = (Vector2.new(pos.X,pos.Y) - UIS:GetMouseLocation()).Magnitude
                if mag < dist then
                    dist = mag
                    closest = p
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not aimbotEnabled or not aiming then return end

    local t = getClosest()
    if t and t.Character and t.Character:FindFirstChild("Head") then
        camera.CFrame = CFrame.new(camera.CFrame.Position, t.Character.Head.Position)
    end
end)
