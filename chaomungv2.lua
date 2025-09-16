--// SCRIPT TUYÊN NGÔN ĐỘC LẬP FULL
--// BY TÔ NGỌC KHÁNH
--// FLOWERS – @devtoolmess

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Xóa GUI cũ nếu có
if CoreGui:FindFirstChild("TuyenNgonGUI") then
    CoreGui.TuyenNgonGUI:Destroy()
end

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "TuyenNgonGUI"
gui.Parent = CoreGui

-- Intro góc trên (FLOWERS – @devtoolmess)
local intro = Instance.new("TextLabel")
intro.Size = UDim2.new(0.5,0,0.06,0)
intro.Position = UDim2.new(0.25,0,0.02,0)
intro.BackgroundTransparency = 1
intro.TextColor3 = Color3.fromRGB(255, 50, 50)
intro.TextScaled = true
intro.Font = Enum.Font.SourceSansBold
intro.Text = "🌸 FLOWERS – @devtoolmess 🌸"
intro.Parent = gui

-- Label chính giữa
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.9,0,0.3,0)
label.Position = UDim2.new(0.05,0,0.35,0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255,255,255)
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = ""
label.Parent = gui

-- Rainbow mượt cho chữ chính giữa
task.spawn(function()
    while task.wait() do
        local t = tick() * 0.5
        label.TextColor3 = Color3.fromHSV(t % 1, 1, 1)
    end
end)

-- 7 màu nhấp nháy cho intro
local colors = {
    Color3.fromRGB(255,0,0),    -- đỏ
    Color3.fromRGB(255,127,0),  -- cam
    Color3.fromRGB(255,255,0),  -- vàng
    Color3.fromRGB(0,255,0),    -- xanh lá
    Color3.fromRGB(0,0,255),    -- xanh dương
    Color3.fromRGB(75,0,130),   -- chàm
    Color3.fromRGB(148,0,211)   -- tím
}
task.spawn(function()
    while task.wait(0.25) do
        for _,c in ipairs(colors) do
            intro.TextColor3 = c
            task.wait(0.25)
        end
    end
end)

-- Âm thanh nền
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://1843528835" -- 👉 thay bằng ID nhạc bạn muốn
sound.Volume = 5
sound.Looped = true
sound.Parent = workspace
sound:Play()

-- Nội dung Tuyên ngôn Độc lập (rút gọn)
local TuyenNgon = {
    "SCRIPT BY TÔ NGỌC KHÁNH",
    "Tất cả mọi người sinh ra đều có quyền bình đẳng.",
    "Tạo hóa cho họ những quyền không ai có thể xâm phạm được.",
    "Trong những quyền ấy, có quyền được sống, quyền tự do và quyền mưu cầu hạnh phúc.",
    "Đó là những lẽ phải không ai chối cãi được.",
    "Thế mà hơn 80 năm nay, thực dân Pháp đã cướp nước ta, áp bức đồng bào ta.",
    "Hành động của chúng trái hẳn với nhân đạo và chính nghĩa.",
    "Về chính trị, chúng tuyệt đối không cho nhân dân ta một chút tự do dân chủ nào.",
    "Chúng lập ra nhà tù nhiều hơn trường học.",
    "Chúng thẳng tay chém giết những người yêu nước thương nòi.",
    "Chúng tắm các cuộc khởi nghĩa của ta trong những bể máu.",
    "Chúng dùng thuốc phiện, rượu cồn để làm cho nòi giống ta suy nhược.",
    "Về kinh tế, chúng bóc lột dân ta đến tận xương tủy.",
    "Ngày 9 tháng 3 năm 1945, Nhật đảo chính Pháp, nhân dân ta giành chính quyền.",
    "Ngày 19 tháng 8, dưới sự lãnh đạo của Việt Minh, nhân dân ta nổi dậy khắp nơi.",
    "Ngày 2 tháng 9 năm 1945, tại Quảng trường Ba Đình, Chủ tịch Hồ Chí Minh đọc Tuyên ngôn Độc lập.",
    "Chúng tôi, Chính phủ lâm thời của nước Việt Nam Dân chủ Cộng hòa, trịnh trọng tuyên bố:",
    "Nước Việt Nam có quyền hưởng tự do và độc lập, và sự thật đã thành một nước tự do độc lập.",
    "Toàn thể dân tộc Việt Nam quyết đem tất cả tinh thần, lực lượng, tính mạng và của cải...",
    "Để giữ vững quyền tự do, độc lập ấy."
}

-- Hàm chạy chữ từng ký tự
local function typeWriter(text)
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(0.035) -- tốc độ gõ chữ
    end
    task.wait(1.5) -- dừng trước khi sang câu mới
end

-- Chạy lần lượt toàn bộ câu
task.spawn(function()
    for _, cau in ipairs(TuyenNgon) do
        typeWriter(cau)
    end
end)