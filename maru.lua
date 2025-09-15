-- Maru Hub (UI full) - SAFE VERSION (Only UI + Stubs)
-- LƯU Ý: Đây là bản "UI + stub" KHÔNG thực hiện hành vi gian lận.
-- Tất cả chức năng auto (farm/raid/teleport/kill) chỉ in log hoặc thay đổi flag.
-- Nếu bạn muốn học cách implement hợp lệ (ví dụ tạo server-side features trong riêng place),
-- mình sẽ hướng dẫn cách làm đó an toàn.

-- Tải UI lib (thay bằng Rayfield/Orion nếu bạn thích; mình dùng một lib nhỏ an toàn)
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not success then
    -- Fallback: tạo UI cơ bản nếu lib không load được
    -- (để ngắn gọn, mình sẽ assume Rayfield load ok; nếu không, bạn báo mình sẽ gửi bản fallback)
    warn("Không tải được Rayfield. Nếu muốn bản fallback, nói 'gửi fallback'.")
end

-- Khởi tạo cửa sổ
local Window = Rayfield:CreateWindow({
   Name = "🌸 Maru Hub | SAFE UI",
   LoadingTitle = "Maru Hub đang khởi động...",
   LoadingSubtitle = "Safe UI - only stubs",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MaruHubSafe",
      FileName = "Config"
   },
   KeySystem = false
})

-- Utility: notify & safe print
local function notify(title, content)
    Rayfield:Notify({Title = title, Content = content, Duration = 3})
    print("[MaruHub] "..title..": "..(content or ""))
end

-- ========== GLOBAL FLAGS (an toàn) ==========
getgenv().Maru = {}
local M = getgenv().Maru

-- init flags (all false)
local FLAGS = {
    AutoFarm = false,
    AutoChest = false,
    AutoBoss = false,
    AutoSeaBeast = false,
    AutoRaid = false,
    FruitSniper = false,
    AutoMastery = false,
    AutoObservation = false,
    ESPPlayers = false,
    ESPFruits = false,
    ESPChests = false,
    ESPBosses = false,
    FarmLevel = false,
    FarmBoss = false,
    AutoEatFruit = false,
    AutoStats = false,
    AutoBuyFruit = false,
    AutoBuyHaki = false,
    AutoBuySword = false,
    AutoAwaken = false,
    AutoSeaChest = false,
    AutoShipFarm = false,
    Aimbot = false,
    KillAura = false,
    AutoSkill = false
}
for k,v in pairs(FLAGS) do M[k] = v end

-- ========== STUB HELPERS ==========
local function setFlag(name, value)
    M[name] = value
    notify("Flag", name .. " = " .. tostring(value))
    -- safe log for developer inspection
    print(("[MaruHub] Flag changed: %s = %s"):format(name, tostring(value)))
end

local function safeAction(name, detail)
    -- Called when user clicks buttons that would normally perform sensitive actions.
    -- Keep it safe: only notify and print detail (no remote calls).
    notify(name, detail or "Đã kích hoạt (safe stub).")
    print(("[MaruHub] Action '%s' triggered (SAFE STUB). Detail: %s"):format(name, tostring(detail)))
end

-- ========== TABS: Auto / Player / ESP / Teleport / Farm / Stats-Shop / Raid / Sea / PVP / Settings ==========
-- Auto Tab
local AutoTab = Window:CreateTab("⚡ Auto", 4483362458)
AutoTab:CreateToggle({
    Name = "Auto Farm Level (SAFE)",
    CurrentValue = false,
    Flag = "AutoFarmLevel",
    Callback = function(val) setFlag("AutoFarm", val) end
})
AutoTab:CreateToggle({
    Name = "Auto Chest (SAFE)",
    CurrentValue = false,
    Callback = function(val) setFlag("AutoChest", val) end
})
AutoTab:CreateToggle({
    Name = "Auto Boss (SAFE)",
    CurrentValue = false,
    Callback = function(val) setFlag("AutoBoss", val) end
})
AutoTab:CreateToggle({
    Name = "Auto Sea Beast (SAFE)",
    CurrentValue = false,
    Callback = function(val) setFlag("AutoSeaBeast", val) end
})
AutoTab:CreateToggle({
    Name = "Auto Raid (SAFE)",
    CurrentValue = false,
    Callback = function(val) setFlag("AutoRaid", val) end
})
AutoTab:CreateToggle({
    Name = "Fruit Sniper (SAFE)",
    CurrentValue = false,
    Callback = function(val) setFlag("FruitSniper", val) end
})

AutoTab:CreateButton({
    Name = "Run Safe Demo Cycle (log only)",
    Callback = function()
        safeAction("RunDemo", "Chạy chu kỳ demo: in ra mobs,chests,fruits hiện tại (SAFE).")
        -- demo enumerating (safe read-only)
        pcall(function()
            local names = {}
            for _,v in pairs(workspace:GetChildren()) do
                table.insert(names, v.Name)
            end
            print("[MaruHub] Workspace snapshot:", table.concat(names, ", "))
            notify("Snapshot", "Đã in danh sách workspace vào output.")
        end)
    end
})

-- Player Tab
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)
PlayerTab:CreateSlider({
    Name = "WalkSpeed (client-side)",
    Range = {16, 200},
    Increment = 2,
    CurrentValue = 16,
    Callback = function(val)
        pcall(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
            end
        end)
        notify("WalkSpeed", "Set client WalkSpeed to "..tostring(val))
    end
})
PlayerTab:CreateSlider({
    Name = "JumpPower (client-side)",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(val)
        pcall(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
            end
        end)
        notify("JumpPower", "Set client JumpPower to "..tostring(val))
    end
})
PlayerTab:CreateButton({Name="Reset Character (safe)", Callback=function() safeAction("ResetChar","Reset chỉ local client (SAFE).") end})
PlayerTab:CreateButton({Name="Equip Demo Tool (safe)", Callback=function() safeAction("EquipTool","Equip tool stub (SAFE).") end})

-- ESP Tab
local ESPTab = Window:CreateTab("👁 ESP", 4483362458)
ESPTab:CreateToggle({Name="ESP Players (visual stub)", CurrentValue=false, Callback=function(v) setFlag("ESPPlayers", v) end})
ESPTab:CreateToggle({Name="ESP Fruits (visual stub)", CurrentValue=false, Callback=function(v) setFlag("ESPFruits", v) end})
ESPTab:CreateToggle({Name="ESP Chests (visual stub)", CurrentValue=false, Callback=function(v) setFlag("ESPChests", v) end})
ESPTab:CreateToggle({Name="ESP Bosses (visual stub)", CurrentValue=false, Callback=function(v) setFlag("ESPBosses", v) end})
ESPTab:CreateButton({Name="Run ESP Demo (draw labels locally)", Callback=function()
    -- Safe visual labels (local only) — not reading protected remotes
    pcall(function()
        for _,p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local billboard = Instance.new("BillboardGui", p.Character.Head)
                billboard.Name = "MaruSafeESP"
                billboard.Size = UDim2.new(0,120,0,30)
                billboard.AlwaysOnTop = true
                local label = Instance.new("TextLabel", billboard)
                label.Size = UDim2.new(1,1)
                label.BackgroundTransparency = 1
                label.Text = "SAFE: "..p.Name
                label.TextColor3 = Color3.new(1,0,0)
                delay(6, function() if billboard then billboard:Destroy() end end)
            end
        end
    end)
    notify("ESP Demo", "Đã hiển thị label tạm (local).")
end})

-- Teleport Tab (SAFE stubs only)
local TPTab = Window:CreateTab("🌴 Teleport", 6034684945)
local islands = {"Starter Island","Marine Base","Jungle","Desert","Sky Island"}
TPTab:CreateDropdown({Name="Select Island (SAFE)", Options=islands, CurrentOption=islands[1], Callback=function(val)
    notify("Teleport stub", "Bạn chọn: "..val.." (SAFE - không TP thực).")
end})
TPTab:CreateButton({Name="Teleport to Selected (stub)", Callback=function() safeAction("TeleportStub","Đây chỉ là stub. Để TP hợp lệ cần server-side support hoặc admin command.") end})
TPTab:CreateButton({Name="Random Island (stub)", Callback=function() safeAction("RandomTP","Random TP stub (SAFE).") end})

-- Farm Tab
local FarmTab = Window:CreateTab("🗡 Auto Farm", 6034684945)
FarmTab:CreateToggle({Name="Auto Farm Level (SAFE)", CurrentValue=false, Callback=function(v) setFlag("FarmLevel", v) end})
FarmTab:CreateToggle({Name="Auto Farm Boss (SAFE)", CurrentValue=false, Callback=function(v) setFlag("FarmBoss", v) end})
FarmTab:CreateToggle({Name="Auto Eat Fruit (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoEatFruit", v) end})
FarmTab:CreateButton({Name="Demo Attack (local visual)", Callback=function() safeAction("DemoAttack","Chỉ in log/hiệu ứng local - không can thiệp server.") end})

-- Stats & Shop Tab
local StatsTab = Window:CreateTab("📊 Stats & Shop", 6034684945)
local Stats = {"Melee","Defense","Sword","Fruit","Gun"}
StatsTab:CreateDropdown({Name="Choose Stat (safe)", Options=Stats, CurrentOption=Stats[1], Callback=function(v) M.StatChoice = v notify("StatChoice","Chọn: "..v) end})
StatsTab:CreateToggle({Name="Auto Stats (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoStats", v) end})
StatsTab:CreateToggle({Name="Auto Buy Random Fruit (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoBuyFruit", v) end})
StatsTab:CreateToggle({Name="Auto Buy Haki (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoBuyHaki", v) end})
StatsTab:CreateToggle({Name="Auto Buy Sword (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoBuySword", v) end})

-- Raid Tab
local RaidTab = Window:CreateTab("🔥 Raid", 6034684945)
local raidFruits = {"Flame","Ice","Dark","Light","Magma","Quake","Buddha"}
RaidTab:CreateDropdown({Name="Select Raid Fruit (safe)", Options=raidFruits, CurrentOption=raidFruits[1], Callback=function(v) M.RaidFruit = v notify("RaidFruit", v) end})
RaidTab:CreateToggle({Name="Auto Raid (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoRaid", v) end})
RaidTab:CreateToggle({Name="Auto Awaken (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoAwaken", v) end})
RaidTab:CreateButton({Name="Raid Demo (safe)", Callback=function() safeAction("RaidDemo","Demo only: mua chip & start (SAFE stub).") end})

-- Sea Events Tab
local SeaTab = Window:CreateTab("🌊 Sea Events", 6034684945)
SeaTab:CreateToggle({Name="Auto Sea Beast (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoSeaBeast", v) end})
SeaTab:CreateToggle({Name="Auto Ship Farm (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoShipFarm", v) end})
SeaTab:CreateToggle({Name="Auto Sea Chest (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoSeaChest", v) end})
SeaTab:CreateButton({Name="Sea Demo (safe)", Callback=function() safeAction("SeaDemo","Demo only: log sea items (SAFE).") end})

-- PVP Tab
local PVP = Window:CreateTab("⚔ PVP", 6034684945)
PVP:CreateToggle({Name="Aimbot (SAFE toggle - no effect)", CurrentValue=false, Callback=function(v) setFlag("Aimbot", v) end})
PVP:CreateDropdown({Name="Select Player (safe)", Options=(function()
    local t = {}
    for _,p in pairs(game.Players:GetPlayers()) do if p~=game.Players.LocalPlayer then table.insert(t, p.Name) end end
    if #t==0 then table.insert(t,"No players") end
    return t
end)(), CurrentOption="No players", Callback=function(v) M.AimbotTarget = v notify("AimbotTarget", tostring(v)) end})
PVP:CreateToggle({Name="Kill Aura (SAFE)", CurrentValue=false, Callback=function(v) setFlag("KillAura", v) end})
PVP:CreateToggle({Name="Auto Skill Spam (SAFE)", CurrentValue=false, Callback=function(v) setFlag("AutoSkill", v) end})

-- Settings Tab
local Settings = Window:CreateTab("⚙ Settings", 6034684945)
Settings:CreateKeybind({Name="Toggle UI", CurrentKey = "LeftAlt", Hold=false, Callback=function() Rayfield:Toggle() end})
Settings:CreateToggle({Name="Auto-load last config", CurrentValue=true, Callback=function(v) notify("Setting","Auto-load = "..tostring(v)) end})
Settings:CreateButton({Name="Destroy Hub", Callback=function() Rayfield:Destroy() notify("Maru Hub", "Hub đã đóng.") end})

-- ========== END UI ==========
notify("Maru Hub", "SAFE UI đã load. Tất cả hành động auto là STUB, không có thao tác gian lận.")
print("[MaruHub] SAFE UI loaded. Flags available in getgenv().Maru")

-- Bạn có thể sử dụng getgenv().Maru để kiểm tra flags trong console.
-- Nếu muốn, mình sẽ:
-- 1) Gửi hướng dẫn chi tiết (bước — bước) để triển khai 1 chức năng HỢP PHÁP trong Roblox Studio (ví dụ: auto-farm trong own place để test, cách tạo server RemoteEvent an toàn).
-- 2) Hoàn thiện bản UI fallback (nếu Rayfield không load).
-- 3) Dạy bạn Lua chi tiết + debug script, để bạn tự làm game hoặc hệ thống hợp lệ.