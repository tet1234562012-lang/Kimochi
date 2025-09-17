-- LocalScript trong StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Mảng màu 7 màu
local colors = {
    Color3.fromRGB(255,0,0),    -- đỏ
    Color3.fromRGB(255,165,0),  -- cam
    Color3.fromRGB(255,255,0),  -- vàng
    Color3.fromRGB(0,255,0),    -- xanh lá
    Color3.fromRGB(0,255,255),  -- xanh da trời
    Color3.fromRGB(0,0,255),    -- xanh dương
    Color3.fromRGB(128,0,128)   -- tím
}

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Tạo Frame menu
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 250)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = colors[1]
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Thêm logo ảnh trên menu
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(1,0,0,100)
Logo.Position = UDim2.new(0,0,0,0)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://INSERT_YOUR_IMAGE_ID"  -- Thay bằng ID decal của ảnh logo
Logo.Parent = Frame

-- Tạo TextLabel thông báo
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -20, 0, 30)
InfoLabel.Position = UDim2.new(0, 10, 0, 105)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
InfoLabel.TextScaled = true
InfoLabel.Font = Enum.Font.SourceSansBold
InfoLabel.Text = ""
InfoLabel.Parent = Frame

-- Hàm tạo nút
local function createButton(text, position, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.Position = position
    btn.Text = text
    btn.BackgroundColor3 = colors[1]
    btn.TextScaled = true
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = Frame

    -- Hiệu ứng đổi màu liên tục khi hover
    local hovering = false
    local index = 1
    btn.MouseEnter:Connect(function() hovering = true end)
    btn.MouseLeave:Connect(function() hovering = false btn.BackgroundColor3 = colors[1] end)

    spawn(function()
        while true do
            if hovering then
                index = index % #colors + 1
                btn.BackgroundColor3 = colors[index]
            end
            wait(0.2)
        end
    end)

    btn.MouseButton1Click:Connect(callback)
end

-- Biến trạng thái Kill All
local killStandaloneActive = false
local killWithSwordActive = false

-- Kill All Standalone vô hạn
createButton("Kill All Standalone", UDim2.new(0,10,0,140), function()
    killStandaloneActive = not killStandaloneActive  -- Bật/Tắt
    if killStandaloneActive then
        InfoLabel.Text = "Kill All Standalone Đang chạy..."
        spawn(function()
            while killStandaloneActive do
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= player and target.Character and target.Character:FindFirstChild("Humanoid") then
                        target.Character.Humanoid.Health = 0
                    end
                end
                wait(1)
            end
        end)
    else
        InfoLabel.Text = "Kill All Standalone Đã tắt!"
        wait(2)
        InfoLabel.Text = ""
    end
end)

-- Kill All với kiếm vô hạn
createButton("Kill All with Sword", UDim2.new(0,10,0,200), function()
    killWithSwordActive = not killWithSwordActive  -- Bật/Tắt
    if killWithSwordActive then
        InfoLabel.Text = "Kill All với kiếm Đang chạy..."
        spawn(function()
            while killWithSwordActive do
                local hasSword = false
                if player.Character then
                    for _, tool in pairs(player.Character:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name:lower():find("sword") then
                            hasSword = true
                            break
                        end
                    end
                end

                if hasSword then
                    for _, target in pairs(Players:GetPlayers()) do
                        if target ~= player and target.Character and target.Character:FindFirstChild("Humanoid") then
                            target.Character.Humanoid.Health = 0
                        end
                    end
                end

                wait(1)
            end
        end)
    else
        InfoLabel.Text = "Kill All với kiếm Đã tắt!"
        wait(2)
        InfoLabel.Text = ""
    end
end)

-- Hiệu ứng đổi màu liên tục cho Frame menu
spawn(function()
    local index = 1
    while true do
        index = index % #colors + 1
        Frame.BackgroundColor3 = colors[index]
        wait(0.5)
    end
end)