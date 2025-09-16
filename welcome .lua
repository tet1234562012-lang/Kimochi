-- SCRIPT BY TÔ NGỌC KHÁNH
-- Kỷ niệm 2/9 & 30/4 với nhạc + pháo hoa + hỏi ID nhạc

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "NgayLeVN"

-- ===== CREDIT =====
local credit = Instance.new("TextLabel", ScreenGui)
credit.Size = UDim2.new(1, 0, 1, 0)
credit.BackgroundTransparency = 1
credit.TextScaled = true
credit.Font = Enum.Font.Arcade
credit.TextColor3 = Color3.fromRGB(255, 215, 0)
credit.TextStrokeTransparency = 0.2
credit.Text = "✨ SCRIPT BY TÔ NGỌC KHÁNH ✨"

task.spawn(function()
    task.wait(3)
    credit:Destroy()
end)

-- ===== MENU =====
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0.4,0,0.3,0)
Frame.Position = UDim2.new(0.3,0,0.35,0)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BackgroundTransparency = 0.2
Frame.Visible = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0.3,0)
Title.BackgroundTransparency = 1
Title.Text = "🇻🇳 Chọn ngày lễ 🇻🇳"
Title.TextColor3 = Color3.fromRGB(255,215,0)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

local btn2_9 = Instance.new("TextButton", Frame)
btn2_9.Size = UDim2.new(0.45,0,0.4,0)
btn2_9.Position = UDim2.new(0.05,0,0.5,0)
btn2_9.Text = "Ngày 2/9"
btn2_9.Font = Enum.Font.SourceSansBold
btn2_9.TextScaled = true
btn2_9.BackgroundColor3 = Color3.fromRGB(200,0,0)
btn2_9.TextColor3 = Color3.new(1,1,1)

local btn30_4 = Instance.new("TextButton", Frame)
btn30_4.Size = UDim2.new(0.45,0,0.4,0)
btn30_4.Position = UDim2.new(0.5,0,0.5,0)
btn30_4.Text = "Ngày 30/4"
btn30_4.Font = Enum.Font.SourceSansBold
btn30_4.TextScaled = true
btn30_4.BackgroundColor3 = Color3.fromRGB(0,100,200)
btn30_4.TextColor3 = Color3.new(1,1,1)

-- Label hiển thị nội dung
local TextLabel = Instance.new("TextLabel", ScreenGui)
TextLabel.Size = UDim2.new(1, 0, 0.2, 0)
TextLabel.Position = UDim2.new(0, 0, 0.7, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextStrokeTransparency = 0.2
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
TextLabel.Text = ""

-- ===== NỘI DUNG =====
local tuyenNgon2_9 = {
    "Tất cả mọi người sinh ra đều có quyền bình đẳng.",
    "Tạo hoá cho họ những quyền không ai có thể xâm phạm được.",
    "Trong những quyền ấy, có quyền được sống, quyền tự do và quyền mưu cầu hạnh phúc.",
    "Tất cả các dân tộc trên thế giới đều sinh ra bình đẳng.",
    "Dân tộc nào cũng có quyền sống, quyền sung sướng và quyền tự do.",
    "Nước Việt Nam có quyền hưởng tự do và độc lập, và sự thật đã thành một nước tự do độc lập.",
    "Toàn thể dân tộc Việt Nam quyết đem tất cả tinh thần và lực lượng, tính mạng và của cải để giữ vững quyền tự do, độc lập ấy."
}

local tuyenBo30_4 = {
    "Chúng ta đã toàn thắng!",
    "Sài Gòn đã hoàn toàn giải phóng.",
    "Miền Nam Việt Nam hoàn toàn giải phóng.",
    "Tổ quốc Việt Nam thống nhất, non sông liền một dải.",
    "Đây là thắng lợi vĩ đại nhất trong lịch sử chống ngoại xâm của dân tộc ta.",
    "Độc lập - Tự do - Hạnh phúc cho toàn thể nhân dân Việt Nam!"
}

-- ===== NHẠC =====
local function phatNhac(id)
    local sound = Instance.new("Sound", workspace)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = 5
    sound.Looped = true
    sound:Play()
end

-- ===== PHÁO HOA =====
local function taoPhaoHoa()
    local part = Instance.new("Part")
    part.Size = Vector3.new(1,1,1)
    part.Position = player.Character.Head.Position + Vector3.new(math.random(-15,15), 10, math.random(-15,15))
    part.Anchored = true
    part.Transparency = 1
    part.Parent = workspace

    local firework = Instance.new("ParticleEmitter", part)
    firework.Texture = "rbxassetid://241876401"
    firework.Lifetime = NumberRange.new(1,2)
    firework.Rate = 200
    firework.Speed = NumberRange.new(20,40)
    firework.VelocitySpread = 360
    firework.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,0))
    }
    game.Debris:AddItem(part, 3)
end

-- ===== HIỆN CHỮ =====
local function hienCau(cau)
    TextLabel.Text = ""
    for i = 1, #cau do
        TextLabel.Text = string.sub(cau, 1, i)
        task.wait(0.05)
    end
    task.wait(3)
end

-- ===== START =====
local function batDoc(noiDung)
    Frame.Visible = false

    -- hỏi ID nhạc
    local nhapId = tonumber(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChildOfClass("ScreenGui"):Prompt("Nhập ID nhạc Roblox (Enter bỏ qua để dùng Quốc ca 18435245):"))
    local musicId = nhapId or 18435245

    -- phát nhạc
    phatNhac(musicId)

    -- loop pháo hoa
    task.spawn(function()
        while true do
            taoPhaoHoa()
            task.wait(1)
        end
    end)

    -- chạy chữ
    while true do
        for _, cau in ipairs(noiDung) do
            hienCau(cau)
        end
    end
end

-- ===== BUTTON EVENT =====
btn2_9.MouseButton1Click:Connect(function()
    batDoc(tuyenNgon2_9)
end)

btn30_4.MouseButton1Click:Connect(function()
    batDoc(tuyenBo30_4)
end)