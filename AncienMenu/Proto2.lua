local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/nictix01/lsscript/refs/heads/main/Fly.lua'))()
local Teleport = loadstring(game:HttpGet('https://raw.githubusercontent.com/nictix01/lsscript/refs/heads/main/TP.lua'))()

-- Création de la fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "Fly Menu",
    LoadingTitle = "Menu by Edaward_01",
    LoadingSubtitle = "Edaward_01",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AncienMenu",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "https://discord.gg/thcfr",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Ancien Menu",
        Subtitle = "Key System",
        Note = "Contactez Edaward_01 pour obtenir une clé.",
        FileName = "KeyFile",
        SaveKey = true,
        GrabKeyFromSite = false,
        KeySiteUrl = ""
    }
})

local FlyTab = Window:CreateTab("Fly", 'plane')

-- ❌ ERREUR 1 CORRIGÉE : Syntaxe du Toggle incorrecte (if/else en dehors de la fonction)
FlyTab:CreateToggle({
    Name = "Activer le Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        if Value then  -- ✅ Le if doit être DANS la fonction Callback
            Lib.Fly.On()
        else
            Lib.Fly.Off()
        end
    end
})

-- ❌ ERREUR 2 CORRIGÉE : Variable "Tab" au lieu de "FlyTab"
local FlySpeedSlider = FlyTab:CreateSlider({  -- ✅ FlyTab au lieu de Tab
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 5,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "FlySpeed",
    Callback = function(Value)
        Lib.Fly.Speed(Value)
    end,
})

local NoClipTab = Window:CreateTab("NoClip", 'ghost')
NoClipTab:CreateToggle({
    Name = "Activer le NoClip",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        if Value then
            Lib.NoClip.On()
        else
            Lib.NoClip.Off()
        end
    end
})

local TeleportTab = Window:CreateTab("Téléportation", 'location')
local PlayerDropdown = TpTab:CreateDropdown({
    Name = "Sélectionner un joueur",
    Options = Teleport.GetPlayers(),
    CurrentOption = "",
    Flag = "PlayerDropdown",
    Callback = function(Option)
        -- Option contient le nom du joueur sélectionné
        print("Joueur sélectionné:", Option)
    end,
})

TpTab:CreateButton({
    Name = "Téléporter au joueur",
    Callback = function()
        local selectedPlayer = PlayerDropdown.CurrentOption
        if selectedPlayer and selectedPlayer ~= "" then
            local success = Teleport.ToPlayer(selectedPlayer)
            if success then
                Rayfield:Notify({
                    Title = "Téléportation",
                    Content = "Téléporté à " .. selectedPlayer,
                    Duration = 3,
                    Image = 4483345998,
                })
            else
                Rayfield:Notify({
                    Title = "Erreur",
                    Content = "Impossible de se téléporter",
                    Duration = 3,
                    Image = 4483345998,
                })
            end
        end
    end,
})

TpTab:CreateButton({
    Name = "Rafraîchir la liste",
    Callback = function()
        PlayerDropdown:Refresh(Teleport.GetPlayers())
        Rayfield:Notify({
            Title = "Liste mise à jour",
            Content = "Liste des joueurs rafraîchie",
            Duration = 2,
            Image = 4483345998,
        })
    end,
})

-- Mise à jour automatique quand un joueur rejoint/quitte
Teleport.OnPlayerAdded(function(player)
    task.wait(1) -- Attendre que le personnage spawn
    PlayerDropdown:Refresh(Teleport.GetPlayers())
end)

Teleport.OnPlayerRemoving(function(player)
    PlayerDropdown:Refresh(Teleport.GetPlayers())
end)