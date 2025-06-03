-- BloxXchange Hub (Zephyrs-style UI com múltiplos jogos)
local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Tela principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxXchange_UI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Toggle GUI (F8)
local guiVisible = true
userInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F8 then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

-- Container principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 800, 0, 500)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Menu lateral (abas)
local sideBar = Instance.new("Frame")
sideBar.Size = UDim2.new(0, 150, 1, 0)
sideBar.Position = UDim2.new(0, 0, 0, 0)
sideBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
sideBar.Parent = mainFrame

local tabButtons = {}
local tabFrames = {}
local currentTab = nil

-- Função para criar abas
local function createTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 40)
    tabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.new(1, 1, 1)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 14
    tabBtn.Parent = sideBar

    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, -160, 1, 0)
    tabFrame.Position = UDim2.new(0, 160, 0, 0)
    tabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    tabFrame.BorderSizePixel = 0
    tabFrame.Visible = false
    tabFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
    tabFrame.ScrollBarThickness = 6
    tabFrame.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.Parent = tabFrame

    table.insert(tabButtons, tabBtn)
    tabFrames[name] = tabFrame

    tabBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        for _, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
        tabFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
        currentTab = name
    end)
end

-- Criar abas em ordem
createTab("Geral")
createTab("Brookhaven")
createTab("Blox Fruits")
createTab("Pls Donate")
createTab("Grow a Garden")
createTab("Settings")

-- Ativar aba "Geral" por padrão
if tabButtons[1] then
    tabButtons[1]:Activate()
    tabButtons[1].MouseButton1Click:Fire()
end

-- Utilitário para adicionar botões em uma aba
local function addButton(tabName, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = tabFrames[tabName]

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- Geral
addButton("Geral", "🛡️ Godmode", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Name = "1"
        local newHum = player.Character.Humanoid:Clone()
        newHum.Name = "Humanoid"
        newHum.Parent = player.Character
        player.Character:FindFirstChild("1"):Destroy()
    end
end)

-- Brookhaven
addButton("Brookhaven", "📍 Teleportar Jogador", function()
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 200, 0, 300)
    menu.Position = UDim2.new(0.5, -100, 0.5, -150)
    menu.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    menu.Parent = screenGui

    local layout = Instance.new("UIListLayout", menu)
    layout.Padding = UDim.new(0, 4)

    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Text = plr.Name
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Parent = menu

            btn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
                menu:Destroy()
            end)
        end
    end
end)

addButton("Brookhaven", "🧲 Puxar Jogador", function()
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 200, 0, 300)
    menu.Position = UDim2.new(0.5, -100, 0.5, -150)
    menu.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    menu.Parent = screenGui

    local layout = Instance.new("UIListLayout", menu)
    layout.Padding = UDim.new(0, 4)

    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Text = plr.Name
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Parent = menu

            btn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    plr.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
                menu:Destroy()
            end)
        end
    end
end)

-- Toggle noclip com F1
local noclip = false
userInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F1 then
        noclip = not noclip
    end
end)\n
runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- Grow a Garden
addButton("Grow a Garden", "💰 Auto Sell", function()
    while task.wait(1) do
        local sell = workspace:FindFirstChild("Sell")
        if sell and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = sell.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)
