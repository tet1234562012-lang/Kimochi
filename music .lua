--================================================--
--  SCRIPT ÂM NHẠC - TÔ NGỌC KHÁNH
--================================================--

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local SoundService = game:GetService("SoundService")

-- Hiện thông báo khi chạy
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "TÔ NGỌC KHÁNH",
        Text = "Nhập ID nhạc để phát cho server!",
        Duration = 8
    })
end)

-- GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TO_NGOC_KHANH_GUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.3
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎵 TÔ NGỌC KHÁNH 🎵"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0, 300, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 40)
TextBox.PlaceholderText = "Nhập ID nhạc Roblox..."
TextBox.Text = ""
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = false
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local PlayBtn = Instance.new("TextButton", Frame)
PlayBtn.Size = UDim2.new(0, 140, 0, 40)
PlayBtn.Position = UDim2.new(0, 10, 0, 90)
PlayBtn.Text = "▶ Phát Nhạc"
PlayBtn.TextScaled = true
PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local StopBtn = Instance.new("TextButton", Frame)
StopBtn.Size = UDim2.new(0, 140, 0, 40)
StopBtn.Position = UDim2.new(0, 170, 0, 90)
StopBtn.Text = "⏹ Tắt Nhạc"
StopBtn.TextScaled = true
StopBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)

local VolumeLabel = Instance.new("TextLabel", Frame)
VolumeLabel.Size = UDim2.new(0, 300, 0, 20)
VolumeLabel.Position = UDim2.new(0, 10, 0, 140)
VolumeLabel.BackgroundTransparency = 1
VolumeLabel.Text = "Âm lượng: 10"
VolumeLabel.TextScaled = true
VolumeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local VolumeSlider = Instance.new("TextBox", Frame)
VolumeSlider.Size = UDim2.new(0, 60, 0, 30)
VolumeSlider.Position = UDim2.new(0, 250, 0, 140)
VolumeSlider.Text = "10"
VolumeSlider.TextScaled = true
VolumeSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)

-- Biến nhạc
local music

-- Hàm phát nhạc
local function playMusic(musicId, volume)
    -- Xoá nhạc cũ nếu có
    local old = SoundService:FindFirstChild("TO_NGOC_KHANH_MUSIC")
    if old then old:Destroy() end

    -- Tạo sound mới
    music = Instance.new("Sound")
    music.Name = "TO_NGOC_KHANH_MUSIC"
    music.SoundId = "rbxassetid://"..musicId
    music.Volume = math.clamp(volume, 0, 10)
    music.Looped = true
    music.Parent = SoundService
    music:Play()

    -- Thông báo
    game.StarterGui:SetCore("SendNotification", {
        Title = "TÔ NGỌC KHÁNH",
        Text = "Đang phát nhạc ID: "..musicId,
        Duration = 6
    })
end

-- Sự kiện nút
PlayBtn.MouseButton1Click:Connect(function()
    local id = TextBox.Text
    if tonumber(id) then
        local vol = tonumber(VolumeSlider.Text) or 10
        playMusic(id, vol)
        VolumeLabel.Text = "Âm lượng: "..tostring(vol)
    else
        TextBox.Text = "⚠️ ID không hợp lệ!"
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    if music then
        music:Stop()
    end
end)

VolumeSlider.FocusLost:Connect(function()
    local vol = tonumber(VolumeSlider.Text)
    if music and vol then
        music.Volume = math.clamp(vol, 0, 10)
        VolumeLabel.Text = "Âm lượng: "..tostring(music.Volume)
    end
end)