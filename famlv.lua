-- =======================
-- Khánh Đẹp Zai Hup - Mini Version
-- Auto Farm Level/Boss, Eat Fruit, ESP, Teleport
-- Chạy trong place test
-- =======================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- =======================
-- UI Library
-- =======================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "🌸 Khánh Đẹp Zai Hup",
    LoadingTitle = "Đang khởi động...",
    LoadingSubtitle = "Mini Version - Dùng được",
    ConfigurationSaving = {Enabled = true, FolderName = "KhánhZaiHub", FileName = "Config"},
    KeySystem = false
})

-- =======================
-- GLOBAL FLAGS
-- =======================
getgenv().Khánh = {
    AutoFarmLevel = false,
    AutoFarmBoss = false,
    AutoEatFruit = false,
    ESP = false,
    TeleportDemo = false
}

-- =======================
-- UTILS
-- =======================
local function notify(title, msg)
    Rayfield:Notify({Title = title, Content = msg, Duration = 3})
end

local function toTarget(pos)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end
end

local function attack(target)
    if target:FindFirstChild("Humanoid") then
        target.Humanoid:TakeDamage(1)
    end
end

-- =======================
-- AUTO TAB
-- =======================
local AutoTab = Window:CreateTab("⚡ Auto", 4483362458)

-- Weapon selector & fast attack
local weapons = {"Vo","Kiem"}
local selectedWeapon = weapons[1]
local attackDelay = 0.1

AutoTab:CreateDropdown({
    Name = "Chọn Weapon",
    Options = weapons,
    CurrentOption = weapons[1],
    Callback = function(val)
        selectedWeapon = val
        notify("Weapon", "Đã chọn: "..val)
    end
})

AutoTab:CreateSlider({
    Name = "Attack Speed (s per hit)",
    Range = {0.05, 1},
    Increment = 0.05,
    CurrentValue = 0.1,
    Callback = function(val)
        attackDelay = val
        notify("Attack Speed", "Đã đặt: "..tostring(val).."s")
    end
})

AutoTab:CreateToggle({Name="Auto Farm Level", CurrentValue=false, Callback=function(val)
    getgenv().Khánh.AutoFarmLevel = val
    notify("Auto Farm Level", val and "Bật" or "Tắt")
end})

AutoTab:CreateToggle({Name="Auto Farm Boss", CurrentValue=false, Callback=function(val)
    getgenv().Khánh.AutoFarmBoss = val
    notify("Auto Farm Boss", val and "Bật" or "Tắt")
end})

AutoTab:CreateToggle({Name="Auto Eat Fruit", CurrentValue=false, Callback=function(val)
    getgenv().Khánh.AutoEatFruit = val
    notify("Auto Eat Fruit", val and "Bật" or "Tắt")
end})

-- =======================
-- TELEPORT TAB (demo)
-- =======================
local TeleTab = Window:CreateTab("🌴 Teleport", 6034684945)
local islands = {"Starter Island","Jungle","Desert","Sky Island"}
local currentIsland = islands[1]
TeleTab:CreateDropdown({Name="Chọn đảo (demo)", Options=islands, CurrentOption=islands[1], Callback=function(val)
    currentIsland = val
    notify("Teleport Demo", "Chọn đảo: "..val)
end})
TeleTab:CreateButton({Name="Teleport tới đảo (demo)", Callback=function()
    local pos = CFrame.new(math.random(-50,50),10,math.random(-50,50))
    toTarget(pos)
    notify("Teleport", "Đã dịch đến đảo "..currentIsland)
end})

-- =======================
-- ESP TAB (demo)
-- =======================
local ESPTab = Window:CreateTab("👁 ESP", 4483362458)
ESPTab:CreateToggle({Name="ESP Demo", CurrentValue=false, Callback=function(val)
    getgenv().Khánh.ESP = val
    notify("ESP Demo", val and "Bật" or "Tắt")
end})

-- =======================
-- LOOP HANDLER
-- =======================
RunService.RenderStepped:Connect(function()
    -- Auto Farm Level
    if getgenv().Khánh.AutoFarmLevel then
        for _,mob in pairs(Workspace:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Name:find("Mob") then
                toTarget(mob.HumanoidRootPart.CFrame * CFrame.new(0,3,3))
                local tool = LocalPlayer.Backpack:FindFirstChild(selectedWeapon)
                if tool then LocalPlayer.Character.Humanoid:EquipTool(tool) end
                if not mob:FindFirstChild("KhánhHitCooldown") then
                    local marker = Instance.new("BoolValue", mob)
                    marker.Name = "KhánhHitCooldown"
                    marker.Value = true
                    attack(mob)
                    delay(attackDelay, function() marker:Destroy() end)
                end
            end
        end
    end

    -- Auto Farm Boss
    if getgenv().Khánh.AutoFarmBoss then
        for _,boss in pairs(Workspace:GetChildren()) do
            if boss:FindFirstChild("Humanoid") and boss.Name:find("Boss") then
                toTarget(boss.HumanoidRootPart.CFrame * CFrame.new(0,5,5))
                local tool = LocalPlayer.Backpack:FindFirstChild(selectedWeapon)
                if tool then LocalPlayer.Character.Humanoid:EquipTool(tool) end
                if not boss:FindFirstChild("KhánhHitCooldown") then
                    local marker = Instance.new("BoolValue", boss)
                    marker.Name = "KhánhHitCooldown"
                    marker.Value = true
                    attack(boss)
                    delay(attackDelay, function() marker:Destroy() end)
                end
            end
        end
    end

    -- Auto Eat Fruit
    if getgenv().Khánh.AutoEatFruit then
        for _,obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and obj.Name:find("Fruit") then
                LocalPlayer.Character.Humanoid:EquipTool(obj)
                obj.Parent = LocalPlayer.Character
            end
        end
    end

    -- ESP
    if getgenv().Khánh.ESP then
        for _,mob in pairs(Workspace:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and (mob.Name:find("Mob") or mob.Name:find("Boss") or mob.Name:find("Fruit")) then
                if not mob:FindFirstChild("KhánhESP") then
                    local bill = Instance.new("BillboardGui", mob.HumanoidRootPart)
                    bill.Name = "KhánhESP"
                    bill.Size = UDim2.new(0,100,0,30)
                    bill.AlwaysOnTop = true
                    local label = Instance.new("TextLabel", bill)
                    label.Size = UDim2.new(1,1)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.new(1,0,0)
                    label.Text = mob.Name
                end
            end
        end
    end
end)

notify("Khánh Đẹp Zai Hup", "Mini version đã sẵn sàng dùng ✅")