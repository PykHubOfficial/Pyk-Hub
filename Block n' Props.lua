if game.PlaceId ~= 2537430692 then
	while true do
		wait(1)
	end
end
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local player = game:GetService("Players").LocalPlayer
local teams = game:GetService("Teams")
local Window = Rayfield:CreateWindow({
   Name = "Pyk Hub",
   Icon = 0,
   LoadingTitle = "Pyk-Hub(Blocks n' Props)",
   LoadingSubtitle = "Pyk-Hub(Blocks n' Props)",
   Theme = "Default",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local Tab = Window:CreateTab("Main", 4483362458)
local Button = Tab:CreateButton({
   Name = "Be a destroyer(Don't working when you are Spectator)",
   Callback = function()
      local teams = game:GetService("Teams")
      local players = game:GetService("Players")
      local Workspace = game:GetService("Workspace")
      local player = players.LocalPlayer
	  
      local destroyers = teams:FindFirstChild("Destroyers") or teams:FindFirstChild("Destroyer")
      if not destroyers then
          warn("Команда Destroyers/Destroyer не найдена!")
          return
      end

      player.Team = destroyers
      wait(1)

      -- Телепорт
      local teleportPart1 = Workspace.Map.Classic.Shooter.Ramp
      player.Character.HumanoidRootPart.CFrame = teleportPart1.CFrame

      -- Ждём появления игроков
      task.wait(2)

      -- Ищем другого игрока в команде
      local targetPlayer
      for _, p in pairs(players:GetPlayers()) do
         if p.Team == destroyers and p ~= player then
            targetPlayer = p
            break
         end
      end

      if not targetPlayer then
         warn("Нет других игроков в команде Destroyers/Destroyer!")
         return
      end

      -- Ждём загрузки персонажа и бэкпака
      if not targetPlayer.Character then
         targetPlayer.CharacterAdded:Wait()
      end
      if not targetPlayer:FindFirstChild("Backpack") then
         repeat task.wait() until targetPlayer:FindFirstChild("Backpack")
      end

      -- Копируем инструменты
      local toolsFound = false
      for _, tool in pairs(targetPlayer.Backpack:GetChildren()) do
         if tool:IsA("Tool") then
            toolsFound = true
            local success, err = pcall(function()
               local clone = tool:Clone()
               clone.Parent = player.Backpack
               warn("Успешно скопирован инструмент: " .. tool.Name)
            end)
            if not success then
               warn("Ошибка при копировании "..tool.Name..": "..err)
            end
         end
      end

      if not toolsFound then
         warn("У игрока "..targetPlayer.Name.." нет инструментов в Backpack!")
      end
   end,
})
local Button = Tab:CreateButton({
   Name = "Be a player(Don't working when you are Spectator)",
   Callback = function()
      local character = player.Character or player.CharacterAdded:Wait()
	  local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
      local Towers = teams:FindFirstChild("Towers")
	  local teleportPart2 = Workspace.SpawnLocation
	  player.Team = Towers
	  wait(1)
      local spawnPoints = Workspace:GetChildren()
      local count = 0
	  local targetSpawn

	  for _, obj in pairs(spawnPoints) do
    	  if obj.Name == "SpawnLocation" then
        	  count += 1
        	  if count == 2 then -- например, второй спавн
            	  targetSpawn = obj
            	  break
        	  end
    	  end
	  end
	  if targetSpawn then
    	  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetSpawn.CFrame
	  end
   end,
})
local Button = Tab:CreateButton({
   Name = "Win when you destroyer(Moves object spawn location)",
   Callback = function()
   local shooter = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Classic") and workspace.Map.Classic:FindFirstChild("Shooter")
   if not shooter then
       warn("Shooter не найден!")
       return
   end

   local partSpawnArea = shooter:FindFirstChild("PARTSPAWNAREA")
   if not partSpawnArea then
       warn("PARTSPAWNAREA не найден!")
       return
   end

-- Клонируем и переименовываем
   local clone = partSpawnArea:Clone()
   clone.Parent = shooter -- или workspace, если хочешь вынести
   partSpawnArea.CanCollide = false

   partSpawnArea.CFrame = CFrame.new(0.5, 105.51944, -18.5, 0, 0, 1, 0, 1, 0, -1, 0, 0)
   end,
})
local InfiniteJumpEnabled = false -- Состояние бесконечного прыжка
local Toggle = Tab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      InfiniteJumpEnabled = Value -- Обновляем состояние при переключении
   end,
})

-- Подключаем JumpRequest один раз, а не каждый раз при переключении
game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfiniteJumpEnabled then
      local Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if Humanoid then
         Humanoid:ChangeState("Jumping")
      end
   end
end)

local Tab2 = Window:CreateTab("Teleport", 4483362458)
local Button = Tab2:CreateButton({
   Name = "Teleport To Button",
   Callback = function()
	local teleportPart = Workspace.Map.Classic.Button
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = teleportPart.CFrame
   end,
})
local Button = Tab2:CreateButton({
   Name = "Teleport To Shooter",
   Callback = function()
	local teleportPart1 = Workspace.Map.Classic.Shooter.Ramp
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = teleportPart1.CFrame
   end,
})