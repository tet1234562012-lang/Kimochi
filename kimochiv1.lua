-- LocalScript AutoQuest & AutoFarm Blox Fruits
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- =================== GUI ===================
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 500)
Frame.Position = UDim2.new(0,50,0,50)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.FillDirection = Enum.FillDirection.Vertical

local function createButton(name, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1,0,0,45)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createLabel(text)
    local lbl = Instance.new("TextLabel", Frame)
    lbl.Size = UDim2.new(1,0,0,45)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255,0,0)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Text = text
    return lbl
end

createLabel("REDZ HUB AUTO QUEST BY TÔ NGỌC KHÁNH")

-- =================== Settings ===================
local settings = {
    autoFarm = false,
    fly = false,
    targetLevel = 1,
    autoSkill = true,
    killAll = false,
    hideChar = false,
    autoQuest = false,
}

-- =================== Fly ===================
createButton("Fly ON/OFF", function()
    settings.fly = not settings.fly
    if settings.fly then
        humanoid.PlatformStand = true
        spawn(function()
            while settings.fly do
                root.CFrame = root.CFrame + Vector3.new(0,0.5,0)
                wait(0.05)
            end
        end)
    else
        humanoid.PlatformStand = false
    end
end)

-- =================== Auto Quest & Auto Farm ===================
createButton("Auto Quest/Farm ON/OFF", function()
    settings.autoQuest = not settings.autoQuest
    if settings.autoQuest then
        spawn(function()
            while settings.autoQuest do
                -- 1. Lấy NPC nhiệm vụ theo level
                local questNPC = workspace:FindFirstChild("QuestNPCs")
                local quest = nil
                for _, npc in pairs(questNPC:GetChildren()) do
                    local minLvl = npc:FindFirstChild("MinLevel") and npc.MinLevel.Value or 1
                    local maxLvl = npc:FindFirstChild("MaxLevel") and npc.MaxLevel.Value or 1
                    if player.Level.Value >= minLvl and player.Level.Value <= maxLvl then
                        quest = npc
                        break
                    end
                end
                if quest then
                    -- Di chuyển tới NPC nhận quest
                    root.CFrame = quest.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                    wait(0.5)
                    -- Fire remote để nhận quest
                    local questRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Quest")
                    questRemote:FireServer("Accept", quest.Name)
                    wait(1)
                    -- Tìm quái trong nhiệm vụ
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            if mob.Name == quest.TargetMob.Value then
                                root.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                                if settings.autoSkill then
                                    local damageRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Damage")
                                    for i=1,3 do
                                        damageRemote:FireServer(mob.Humanoid)
                                        wait(0.2)
                                    end
                                end
                                wait(0.3)
                            end
                        end
                    end
                    -- Hoàn thành quest
                    questRemote:FireServer("Complete", quest.Name)
                end
                wait(1)
            end
        end)
    end
end)

-- =================== Kill All Players ===================
createButton("Kill All Players", function()
    settings.killAll = not settings.killAll
    spawn(function()
        while settings.killAll do
            for i,v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
                    if character:FindFirstChildOfClass("Tool") then
                        v.Character.Humanoid.Health = 0
                    end
                end
            end
            wait(0.5)
        end
    end)
end)

-- =================== Hide Character ===================
createButton("Hide Character ON/OFF", function()
    settings.hideChar = not settings.hideChar
    if settings.hideChar then
        for i,v in pairs(character:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("MeshPart") then
                v.Transparency = 1
            elseif v:IsA("BillboardGui") or v:IsA("TextLabel") then
                v.Enabled = false
            end
        end
    else
        for i,v in pairs(character:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("MeshPart") then
                v.Transparency = 0
            elseif v:IsA("BillboardGui") or v:IsA("TextLabel") then
                v.Enabled = true
            end
        end
    end
end)

-- =================== Auto Skill Combo ===================
createButton("Toggle Auto Skill Combo", function()
    settings.autoSkill = not settings.autoSkill
end)

createLabel("✅ Tất cả chức năng: Fly, Auto Quest/Farm, Auto Skill, Kill All, Hide")