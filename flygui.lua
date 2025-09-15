-- Kill All + GUI + Ẩn nhân vật + ON/OFF
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local range = 15 -- khoảng cách attack
local attackInterval = 0.1 -- tốc độ đánh

local killAllEnabled = false -- trạng thái on/off

-- Ẩn nhân vật và tên
local function hideCharacter()
    if player.Character then
        for _, part in ipairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
                part.CanCollide = false
            elseif part:IsA("Decal") or part:IsA("MeshPart") then
                part.Transparency = 1
            end
        end
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end
    end
end

-- Lấy kiếm đang cầm
local function getEquippedTool()
    return player.Character and player.Character:FindFirstChildOfClass("Tool")
end

-- Di chuyển tới target và đánh
local function attackTarget(target)
    local tool = getEquippedTool()
    if not tool then return end
    local hrp = target:FindFirstChild("HumanoidRootPart")
    if hrp then
        player.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,2)
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            if tool:FindFirstChildOfClass("RemoteEvent") then
                tool:FindFirstChildOfClass("RemoteEvent"):FireServer(target)
            elseif tool:FindFirstChildOfClass("RemoteFunction") then
                tool:FindFirstChildOfClass("RemoteFunction"):InvokeServer(target)
            end
        end
    end
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,150,0,50)
Frame.Position = UDim2.new(0,10,0,10)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1,0,1,0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1,1,1)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextSize = 20
StatusLabel.Text = "Kill All: OFF"
StatusLabel.Parent = Frame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1,0,1,0)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Text = ""
ToggleButton.Parent = Frame

-- Bật/tắt kill all bằng GUI
ToggleButton.MouseButton1Click:Connect(function()
    killAllEnabled = not killAllEnabled
    StatusLabel.Text = "Kill All: " .. (killAllEnabled and "ON" or "OFF")
    if killAllEnabled then hideCharacter() end
end)

-- Bật/tắt kill all bằng phím F
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        killAllEnabled = not killAllEnabled
        StatusLabel.Text = "Kill All: " .. (killAllEnabled and "ON" or "OFF")
        if killAllEnabled then hideCharacter() end
    end
end)

-- Loop liên tục tìm và đánh tất cả player gần nếu ON
RunService.RenderStepped:Connect(function()
    if killAllEnabled then
        local tool = getEquippedTool()
        if tool then
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= player and pl.Character and pl.Character:FindFirstChild("Humanoid") 
                    and pl.Character.Humanoid.Health > 0 then
                    local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude <= range then
                        attackTarget(pl.Character)
                        wait(attackInterval)
                    end
                end
            end
        end
    end
end)

-- Ẩn nhân vật khi load xong
hideCharacter()