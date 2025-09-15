-- LocalScript en StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- GUI chính
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- Thêm chữ chính giữa (intro)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 0.2, 0)
title.Position = UDim2.new(0.2, 0, 0.35, 0)
title.Text = "FLY BY TÔ NGỌC KHÁNH"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.FredokaOne
title.Parent = screenGui

-- Viền chữ
local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Parent = title

-- Làm hiệu ứng intro rồi biến mất
task.spawn(function()
	title.TextTransparency = 1
	for i = 1, 0, -0.05 do
		title.TextTransparency = i
		task.wait(0.05)
	end
	task.wait(3) -- giữ chữ 3 giây
	for i = 0, 1, 0.05 do
		title.TextTransparency = i
		task.wait(0.05)
	end
	title:Destroy()
end)

-- Nút bật/tắt rơi chậm
local boton = Instance.new("TextButton")
boton.Size = UDim2.new(0,70,0,30)
boton.Position = UDim2.new(0.05,0,0.05,0)
boton.Text = "Caída"
boton.BackgroundColor3 = Color3.fromRGB(0,255,0)
boton.TextColor3 = Color3.fromRGB(0,0,0)
boton.Parent = screenGui

local caeLento = false
local bodyVel

boton.MouseButton1Click:Connect(function()
	caeLento = not caeLento
	if caeLento then
		boton.Text = "Normal"
		bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(0, math.huge, 0)
		bodyVel.Velocity = Vector3.new(0, -20, 0)
		bodyVel.Parent = root
	else
		boton.Text = "Caída"
		if bodyVel then
			bodyVel:Destroy()
			bodyVel = nil
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if caeLento and bodyVel then
		if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			bodyVel.Velocity = Vector3.new(0, -20, 0)
		else
			bodyVel.Velocity = Vector3.new(0, 0, 0)
		end
	end
end)