local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Création de la fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "Fly Menu",
    LoadingTitle = "Fly Menu by Edaward_01",
    LoadingSubtitle = "by Edaward_01",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AncienMenu", -- Crée un dossier dans les fichiers de configuration
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "https://discord.gg/thcfr", -- L'invitation Discord
        RememberJoins = true -- Se souvient des connexions
    },
    KeySystem = false, -- Mettre à true pour activer le système de clé
    KeySettings = {
        Title = "Ancien Menu",
        Subtitle = "Key System",
        Note = "Contactez Edaward_01 pour obtenir une clé.",
        FileName = "KeyFile",
        SaveKey = true,
        GrabKeyFromSite = false, -- Mettre à true pour récupérer la clé depuis un site web
        KeySiteUrl = "" -- URL du site web pour récupérer la clé
    }
})

local FlyTab = Window:CreateTab("Fly", 'plane') -- Icône d'avion
FlyTab:CreateToggle({
    Name = "Activer le Fly",
    CurrentValue = false,
    Flag = "FlyToggle", -- Optionnel, permet de référencer cette option plus tard
    Callback = function(Value)
        ToggleFly(Value)
    end
})