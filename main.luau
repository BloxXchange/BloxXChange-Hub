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

-- Criar abas
createTab("Geral")
createTab("Brookhaven")
createTab("Blox Fruits")
createTab("Pls Donate")
createTab("Grow a Garden")
createTab("Settings")

-- Ativar aba "Geral" por padrão
tabButtons[1].BackgroundColor3 = Color3.fromRGB(80, 80, 120)
tabFrames["Geral"].Visible = true

-- Função para adicionar botões
local function addButton(tabName, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = tabFrames[tabName]

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end
