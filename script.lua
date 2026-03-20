local player = game.Players.LocalPlayer
local espEnabled = false

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 350, 0, 250)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
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
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 14
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
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 18
Instance.new("UICorner", hideBtn)

-- OPEN ICON
local openBtn = Instance.new("ImageButton", gui)
openBtn.Size = UDim2.new(0,50,0,50)
openBtn.Position = UDim2.new(0,20,0.5,0)
openBtn.BackgroundTransparency = 1
openBtn.Visible = false
openBtn.Image = "rbxassetid://94815922213367"
openBtn.ZIndex = 10
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1,0)

-- TAB BUTTONS
local tab1Btn = Instance.new("TextButton", main)
tab1Btn.Size = UDim2.new(0.5,0,0,30)
tab1Btn.Position = UDim2.new(0,0,0,30)
tab1Btn.Text = "Tab 1"
tab1Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
tab1Btn.TextColor3 = Color3.fromRGB(255,255,255)

local tab2Btn = Instance.new("TextButton", main)
tab2Btn.Size = UDim2.new(0.5,0,0,30)
tab2Btn.Position = UDim2.new(0.5,0,0,30)
tab2Btn.Text = "Tab 2"
tab2Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
tab2Btn.TextColor3 = Color3.fromRGB(255,255,255)

-- TABS
local tab1 = Instance.new("Frame", main)
tab1.Size = UDim2.new(1,0,1,-60)
tab1.Position = UDim2.new(0,0,0,60)
tab1.BackgroundTransparency = 1

local tab2 = Instance.new("Frame", main)
tab2.Size = UDim2.new(1,0,1,-60)
tab2.Position = UDim2.new(0,0,0,60)
tab2.BackgroundTransparency = 1
tab2.Visible = false

-- BUTTON FUNCTION
local function createButton(parent, text, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.85,0,0,35)
    btn.Position = UDim2.new(0.075,0,0,y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    return btn
end
local function createToggle(parent, text, y, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.85,0,0,35)
    frame.Position = UDim2.new(0.075,0,0,y)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14

    local toggle = Instance.new("Frame", frame)
    toggle.Size = UDim2.new(0,50,0,20)
    toggle.Position = UDim2.new(1,-60,0.5,-10)
    toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

    local circle = Instance.new("Frame", toggle)
    circle.Size = UDim2.new(0,18,0,18)
    circle.Position = UDim2.new(0,1,0.5,-9)
    circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)

    local state = false

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state

            if state then
                toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
                circle:TweenPosition(UDim2.new(1,-19,0.5,-9), "Out", "Quad", 0.2, true)
            else
                toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
                circle:TweenPosition(UDim2.new(0,1,0.5,-9), "Out", "Quad", 0.2, true)
            end

            if callback then
                callback(state)
            end
        end
    end)

    return frame
end

-- TAB 1
createButton(tab1, "Speed", 10)
createButton(tab1, "Jump", 55)
createButton(tab1, "Reset", 100)
createButton(tab1, "Teleport", 145)

-- ESP BUTTON
createToggle(tab2, "ESP", 10, function(state)
    espEnabled = state
end)
espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = espEnabled and "ESP: ON" or "ESP: OFF"
end)

-- TAB 2
createButton(tab2, "Aimbot", 55)
createButton(tab2, "Fly", 100)
createButton(tab2, "Auto Farm", 145)

-- TAB SWITCH
tab1Btn.MouseButton1Click:Connect(function()
    tab1.Visible = true
    tab2.Visible = false
end)

tab2Btn.MouseButton1Click:Connect(function()
    tab1.Visible = false
    tab2.Visible = true
end)

-- HIDE / SHOW
hideBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

-- DRAG ICON
local UIS = game:GetService("UserInputService")
local dragging, dragInput, mousePos, framePos

openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = openBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

openBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        openBtn.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- ESP SYSTEM
local players = game:GetService("Players")
local runService = game:GetService("RunService")

runService.RenderStepped:Connect(function()
    local myChar = players.LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end

    local myPos = myChar.HumanoidRootPart.Position

    for _, p in pairs(players:GetPlayers()) do
        if p ~= players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            
            local char = p.Character
            local hrp = char.HumanoidRootPart

            if not espEnabled then
                if char:FindFirstChild("ESP_H") then char.ESP_H:Destroy() end
                if char:FindFirstChild("ESP_GUI") then char.ESP_GUI:Destroy() end
                continue
            end

            if not char:FindFirstChild("ESP_H") then
                local h = Instance.new("Highlight")
                h.Name = "ESP_H"
                h.FillTransparency = 0.7
                h.OutlineTransparency = 0
                h.OutlineColor = Color3.fromRGB(0,0,0)
                h.Parent = char
            end

            local highlight = char:FindFirstChild("ESP_H")
            highlight.FillColor = (p.Team == players.LocalPlayer.Team)
                and Color3.fromRGB(0,255,0)
                or Color3.fromRGB(255,0,0)

            if not char:FindFirstChild("ESP_GUI") then
                local bill = Instance.new("BillboardGui")
                bill.Name = "ESP_GUI"
                bill.Size = UDim2.new(0,200,0,50)
                bill.AlwaysOnTop = true
                bill.StudsOffset = Vector3.new(0,2.5,0)
                bill.Parent = char
                bill.Adornee = char:FindFirstChild("Head")

                local text = Instance.new("TextLabel", bill)
                text.Name = "TXT"
                text.Size = UDim2.new(1,0,1,0)
                text.BackgroundTransparency = 1
                text.TextColor3 = Color3.fromRGB(255,255,255)
                text.TextStrokeTransparency = 0
                text.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                text.Font = Enum.Font.GothamBold
                text.TextSize = 14
            end

            local dist = (hrp.Position - myPos).Magnitude
            local gui = char:FindFirstChild("ESP_GUI")
            if gui and gui:FindFirstChild("TXT") then
                gui.TXT.Text = p.Name .. " [" .. math.floor(dist) .. "m]"
            end
        end
    end
end)
