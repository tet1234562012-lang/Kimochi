-- 🌟 Tô Ngọc Khánh Hub 🌟 - Menu đẹp
local player = game.Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ToNgocKhanhHub"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Bo góc
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- Bóng mờ
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 200, 255)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "🌟 Tô Ngọc Khánh 🌟"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = mainFrame

-- Gradient chữ tiêu đề
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
}
uiGradient.Parent = title

-- Layout cho nút
local buttonLayout = Instance.new("UIListLayout")
buttonLayout.Parent = mainFrame
buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonLayout.Padding = UDim.new(0, 10)
buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Top
buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
buttonLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    mainFrame.Size = UDim2.new(0, 280, 0, buttonLayout.AbsoluteContentSize.Y + 60)
end)

-- Khoảng cách dưới tiêu đề
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 60)
padding.Parent = mainFrame

-- Hàm tạo nút đẹp
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = false
    btn.Parent = mainFrame

    -- Bo góc
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    end)

    btn.MouseButton1Click:Connect(callback)
end

-- Các nút
createButton("⚔️ Farm", function()
    print("Farm ON cho Tô Ngọc Khánh")
end)

createButton("🔥 Auto Raid", function()
    print("Auto Raid cho Tô Ngọc Khánh")
end)

createButton("📈 Farm Level", function()
    print("Farm Level cho Tô Ngọc Khánh")
end)

local fastAttack = false
createButton("⚡ Fast Attack", function()
    fastAttack = not fastAttack
    print("Fast Attack:", fastAttack)
end)

-- Auto đánh nhanh (demo)
task.spawn(function()
    while true do
        task.wait(0.05)
        if fastAttack and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            print("💥 Đánh siêu nhanh 💥")
        end
    end
end)