-- KIẾM VIP - by Tô Ngọc Khánh
-- 1 HIT - AOE - HIỆN CHỮ

local DAMAGE = 999999
local AOE_RADIUS = 15

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)

		local tool = Instance.new("Tool")
		tool.Name = "🗡 Kiếm VIP"
		tool.RequiresHandle = true
		tool.CanBeDropped = false

		-- HANDLE
		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(1.2, 7, 1.2)
		handle.Material = Enum.Material.Neon
		handle.Color = Color3.fromRGB(255, 0, 0)
		handle.Parent = tool

		-- ÁNH SÁNG
		local light = Instance.new("PointLight", handle)
		light.Color = Color3.fromRGB(255, 0, 0)
		light.Range = 18
		light.Brightness = 6

		-- MESH KIẾM
		local mesh = Instance.new("SpecialMesh", handle)
		mesh.MeshType = Enum.MeshType.FileMesh
		mesh.MeshId = "rbxassetid://12741387"
		mesh.Scale = Vector3.new(2, 2.5, 2)

		-- HIỆN CHỮ TRÊN KIẾM
		local billboard = Instance.new("BillboardGui", handle)
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 4, 0)
		billboard.AlwaysOnTop = true

		local text = Instance.new("TextLabel", billboard)
		text.Size = UDim2.new(1, 0, 1, 0)
		text.BackgroundTransparency = 1
		text.Text = "KIẾM VIP\nby Tô Ngọc Khánh"
		text.TextColor3 = Color3.fromRGB(255, 215, 0)
		text.TextStrokeTransparency = 0
		text.TextScaled = true
		text.Font = Enum.Font.GothamBold

		-- TẤN CÔNG
		tool.Activated:Connect(function()
			local root = character:FindFirstChild("HumanoidRootPart")
			if not root then return end

			-- HIỆU ỨNG AOE
			local wave = Instance.new("Part", workspace)
			wave.Anchored = true
			wave.CanCollide = false
			wave.Shape = Enum.PartType.Ball
			wave.Material = Enum.Material.Neon
			wave.Color = Color3.fromRGB(255, 0, 0)
			wave.Size = Vector3.new(1,1,1)
			wave.CFrame = root.CFrame
			game.Debris:AddItem(wave, 0.4)

			game:GetService("TweenService"):Create(
				wave,
				TweenInfo.new(0.3),
				{Size = Vector3.new(AOE_RADIUS*2, AOE_RADIUS*2, AOE_RADIUS*2), Transparency = 1}
			):Play()

			-- DAMAGE
			for _, v in pairs(workspace:GetChildren()) do
				if v:IsA("Model") and v ~= character then
					local hum = v:FindFirstChild("Humanoid")
					local hrp = v:FindFirstChild("HumanoidRootPart")
					if hum and hrp then
						if (hrp.Position - root.Position).Magnitude <= AOE_RADIUS then
							hum:TakeDamage(DAMAGE)
						end
					end
				end
			end
		end)

		tool.Parent = player.Backpack
	end)
end)
