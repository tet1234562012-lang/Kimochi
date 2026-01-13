-- ⚔️ Fly + Invisible Sword + Aura | Delta
-- VIP by Tô Ngọc Khánh

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- ===== TOOL (KIẾM) =====
local tool = Instance.new("Tool")
tool.Name = "Invisible Sword"
tool.RequiresHandle = true
tool.CanBeDropped = false
tool.Parent = player.Backpack

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1,4,1)
handle.Transparency = 1
handle.CanCollide = false
handle.Massless = true
handle.Parent = tool
tool.Handle = handle

tool.Equipped:Connect(function()
	local hand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
	if hand then
		handle.CFrame = hand.CFrame
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = handle
		weld.Part1 = hand
		weld.Parent = handle
	end
end)

-- ===== AURA =====
local auraOn = false
local AURA_DISTANCE = 15

RunService.Heartbeat:Connect(function()
	if not auraOn then return end
	for _,plr in ipairs(game.Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			local h = plr.Character:FindFirstChildOfClass("Humanoid")
			local r = plr.Character:FindFirstChild("HumanoidRootPart")
			if h and r then
				if (r.Position - hrp.Position).Magnitude <= AURA_DISTANCE then
					h.Health = 0
				end
			end
		end
	end
end)

-- ===== FLY =====
local flyOn = false
local speed = 60
local bv, bg

local function startFly()
	bv = Instance.new("BodyVelocity", hrp)
	bv.Velocity = Vector3.zero
	bv.MaxForce = Vector3.new(1e9,1e9,1e9)

	bg = Instance.new("BodyGyro", hrp)
	bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
	bg.CFrame = hrp.CFrame
end

local function stopFly()
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
end

RunService.RenderStepped:Connect(function()
	if not flyOn then return end
	local cam = workspace.CurrentCamera
	bg.CFrame = cam.CFrame

	local dir = Vector3.zero
	if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
	if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
	if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
	if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
	if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
	if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end

	bv.Velocity = dir.Magnitude > 0 and dir.Unit * speed or Vector3.zero
end)

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)

local function makeBtn(text, posY)
	local b = Instance.new("TextButton", gui)
	b.Size = UDim2.new(0,180,0,45)
	b.Position = UDim2.new(0,20,0,posY)
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.TextScaled = true
	b.BorderSizePixel = 0
	b.Text = text
	return b
end

local auraBtn = makeBtn("Aura: OFF", 0.45)
local flyBtn  = makeBtn("Fly: OFF", 0.55)

auraBtn.MouseButton1Click:Connect(function()
	auraOn = not auraOn
	auraBtn.Text = auraOn and "Aura: ON" or "Aura: OFF"
end)

flyBtn.MouseButton1Click:Connect(function()
	flyOn = not flyOn
	flyBtn.Text = flyOn and "Fly: ON" or "Fly: OFF"
	if flyOn then startFly() else stopFly() end
end)

-- ===== NOTI =====
game.StarterGui:SetCore("SendNotification",{
	Title="DELTA SCRIPT",
	Text="Fly + Aura + Kiếm | Tô Ngọc Khánh",
	Duration=3
})
