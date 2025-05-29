local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local Window = Rayfield:CreateWindow({
   Name = "Pyk Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Pyk-Hub(Realistic Street Foot...)",
   LoadingSubtitle = "Pyk-Hub(Realistic S...)",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Pyk-Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Toggle = Tab:CreateToggle({
   Name = "No GK zone",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      local GkLimits1 = workspace.Ignore.Borders.GKLimits
      local GkLimits2 = workspace.Ignore:FindFirstChild("GKLimits2")

      local function setCollisions(model, state)
         for _, part in pairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = state
            end
         end
      end

      if GkLimits1 then
         setCollisions(GkLimits1, not Value)
      end

      if GkLimits2 then
         setCollisions(GkLimits2, not Value)
      end
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "Show GK Hitbox(Work only with bots)",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
      local GkLimits1 = workspace.Goalie.Hitbox
      local GkLimits2 = workspace.HomeGoalie.Hitbox

      if Value then
         GkLimits1.Transparency = 0.5

         if GkLimits2 then
            GkLimits2.Transparency = 0.5
         end
      else
         GkLimits1.Transparency = 1
         if GkLimits2 then
            GkLimits2.Transparency = 1
         end
      end
   end,
})
local Button = Tab:CreateButton({
   Name = "Teleport to ball",
   Callback = function()
      local targetPart = workspace.ball
	  hrp.CFrame = targetPart.CFrame
   end,
})