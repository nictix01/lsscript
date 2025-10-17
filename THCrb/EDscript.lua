local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "THCrb Script Hub",
   LoadingTitle = "THCrb Script Hub",
   LoadingSubtitle = "by THCrb",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "THCrbScriptHub",
      FileName = "THCrbConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "THCrb Script Hub",
      Subtitle = "Key System",
      Note = "Join the discord (discord.gg/thcrb) for the key!",
      FileName = "THCrbKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = ""
   }
})

-- ✅ Un seul onglet
local Tab = Window:CreateTab("Main", 4483362458)

-- ✅ Une section propre
local Section = Tab:CreateSection("Visuels")

-- ✅ Exemple de notification
Rayfield:Notify({
   Title = "Bienvenue !",
   Content = "THCrb Script Hub est bien chargé.",
   Duration = 5,
   Image = 4483362458,
   Actions = {
      Ok = {
         Name = "Ok",
         Callback = function()
            print("Utilisateur a appuyé sur OK !")
         end
      }
   }
})

-- ✅ (Facultatif) cacher ou afficher via une touche
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gpe)
   if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
      Rayfield:Toggle()
   end
end)
