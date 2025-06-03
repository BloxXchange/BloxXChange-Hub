-- BloxXchange Hub (Corrigido, Expandido e Atualizado)
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleportService = game:GetService("TeleportService")

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxXchange_GUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- GUI Toggle (F8)
local guiVisible = true
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F8 then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

-- Noclip Toggle (F1)
local noclip = false
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F1 then
        noclip = not noclip
    end
end)

runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(0, 300, 0, 600)
scrollingFrame.Position = UDim2.new(0.5, -150, 0.5, -300)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 2500)
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.Active = true
scrollingFrame.Draggable = true
scrollingFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = scrollingFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "🌐 BloxXchange Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Parent = scrollingFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleLabel

-- Rainbow Footer
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamBold
footer.TextSize = 14
footer.TextStrokeTransparency = 0.6
footer.Text = "Made by BloxXchange"
footer.TextColor3 = Color3.fromRGB(255, 255, 255)
footer.Parent = scrollingFrame

local rainbow = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0), Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(148, 0, 211)
}

local rainbowIndex = 1
runService.RenderStepped:Connect(function()
    footer.TextColor3 = rainbow[rainbowIndex]
    rainbowIndex = rainbowIndex % #rainbow + 1
end)

-- Utilitário de criação de botões
local yIndex = 50
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 36)
    btn.Position = UDim2.new(0.1, 0, 0, yIndex)
    yIndex = yIndex + 50
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.TextSize = 14
    btn.Parent = scrollingFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- GUI de seleção de jogador
local function showPlayerSelection(callback)
    local playerListGui = Instance.new("Frame")
    playerListGui.Size = UDim2.new(0, 200, 0, 300)
    playerListGui.Position = UDim2.new(0.5, -100, 0.5, -150)
    playerListGui.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    playerListGui.Parent = screenGui
    playerListGui.Name = "PlayerListGUI"

    local uicorner = Instance.new("UICorner", playerListGui)
    uicorner.CornerRadius = UDim.new(0, 10)

    local uiList = Instance.new("UIListLayout", playerListGui)
    uiList.FillDirection = Enum.FillDirection.Vertical
    uiList.Padding = UDim.new(0, 4)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder

    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.Text = plr.Name
            btn.Parent = playerListGui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                callback(plr)
                playerListGui:Destroy()
            end)
        end
    end
end

-- Comandos
createButton("🛡️ Godmode", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Name = "1"
        local newHumanoid = player.Character.Humanoid:Clone()
        newHumanoid.Name = "Humanoid"
        newHumanoid.Parent = player.Character
        player.Character:FindFirstChild("1"):Destroy()
    end
end)

createButton("🧟 Freeze All", function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.Anchored = true
        end
    end
end)

createButton("⚡ Speed x3", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 48
    end
end)

createButton("🤖 AutoFarm (demo)", function()
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in ipairs(enemies:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") then
                player.Character:SetPrimaryPartCFrame(enemy.HumanoidRootPart.CFrame)
                break
            end
        end
    end
end)

createButton("🏡 Unlock Replicated", function()
    for _, v in pairs(replicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            pcall(function()
                if v:IsA("RemoteEvent") then
                    v:FireServer()
                elseif v:IsA("RemoteFunction") then
                    v:InvokeServer()
                end
            end)
        end
    end
end)

createButton("☢️ Nuke Server", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            pcall(function() obj:Destroy() end)
        end
    end
    task.wait(1)
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            plr:Kick("Servidor apagado por BloxXchange Nuke")
        end
    end
end)

createButton("📍 Teleportar para jogador", function()
    showPlayerSelection(function(target)
        if target.Character and player.Character then
            player.Character:SetPrimaryPartCFrame(target.Character:GetPrimaryPartCFrame())
        end
    end)
end)

createButton("🧲 Puxar jogador", function()
    showPlayerSelection(function(target)
        if target.Character and player.Character then
            target.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
        end
    end)
end)

createButton("🛂 ESP Players", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            local billboard = Instance.new("BillboardGui", v.Character:WaitForChild("Head"))
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.AlwaysOnTop = true
            billboard.Name = "ESP"

            local nameLabel = Instance.new("TextLabel", billboard)
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.Text = v.Name
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextScaled = true
        end
    end
end)

createButton("🚫 Remover ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") then
            local esp = v.Character.Head:FindFirstChild("ESP")
            if esp then
                esp:Destroy()
            end
        end
    end
end)

createButton("📂 Abrir GUI", function()
    screenGui.Enabled = true
end)

createButton("❌ Fechar GUI", function()
    screenGui.Enabled = false
end)

createButton("🧊 Unfreeze All", function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.Anchored = false
        end
    end
end)

createButton("♻️ Unnuke Server", function()
    teleportService:Teleport(game.PlaceId, player)
end)
