-- Combo Troll Kinh Dị + Thông báo "Phát hiện hack by NGỌC KHÁNH"
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundId = "rbxassetid://1837465123" -- ID nhạc kinh dị

local function trollPlayer(player)
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    -- Nhảy vừa phải
    humanoid.JumpPower = 160
    humanoid.UseJumpPower = true

    -- Xoay mượt bằng Tween
    spawn(function()
        for i = 1, 5 do
            local tween = TweenService:Create(root, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = root.CFrame * CFrame.Angles(0, math.rad(72), 0)})
            tween:Play()
            tween.Completed:Wait()
        end
    end)

    -- Tạo Part riêng cho âm thanh/ánh sáng
    local effectPart = Instance.new("Part")
    effectPart.Anchored = true
    effectPart.CanCollide = false
    effectPart.Size = Vector3.new(1,1,1)
    effectPart.CFrame = root.CFrame
    effectPart.Parent = workspace

    -- Nhạc kinh dị
    local sound = Instance.new("Sound", effectPart)
    sound.SoundId = SoundId
    sound.Volume = 8
    sound:Play()

    -- Ánh sáng nhấp nháy
    local light = Instance.new("PointLight", effectPart)
    light.Range = 15
    light.Brightness = 5
    spawn(function()
        for i = 1, 10 do
            light.Color = Color3.fromHSV(math.random(),1,1)
            wait(0.2)
        end
        light:Destroy()
    end)

    -- Dọn dẹp sau 10 giây
    delay(10, function()
        sound:Stop()
        effectPart:Destroy()
    end)

    -- Thông báo cảnh báo lên tất cả người chơi
    for _, plr in pairs(Players:GetPlayers()) do
        plr:SendNotification({
            Title = "⚠ CẢNH BÁO",
            Text = "Phát hiện hack / xâm nhập by NGỌC KHÁNH!",
            Duration = 5
        })
    end
end

-- Troll tất cả người chơi hiện tại
for _, player in pairs(Players:GetPlayers()) do
    trollPlayer(player)
end

-- Troll người chơi mới vào game
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        trollPlayer(player)
    end)
end)