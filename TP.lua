-- ===================== VARIABLES GLOBALES =====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ===================== MODULE TELEPORT =====================
local Teleport = {}

-- Fonction pour obtenir tous les joueurs (sauf le joueur local)
function Teleport.GetPlayers()
    local playerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

-- Fonction pour téléporter vers un joueur par son nom
function Teleport.ToPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    
    if not targetPlayer then
        warn("Joueur introuvable: " .. playerName)
        return false
    end
    
    local targetCharacter = targetPlayer.Character
    local localCharacter = LocalPlayer.Character
    
    if not targetCharacter or not localCharacter then
        warn("Personnage introuvable")
        return false
    end
    
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
    
    if not targetRoot or not localRoot then
        warn("HumanoidRootPart introuvable")
        return false
    end
    
    -- Téléportation
    localRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3) -- 3 studs derrière le joueur
    return true
end

-- Fonction pour téléporter vers des coordonnées spécifiques
function Teleport.ToPosition(x, y, z)
    local localCharacter = LocalPlayer.Character
    
    if not localCharacter then
        warn("Personnage introuvable")
        return false
    end
    
    local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
    
    if not localRoot then
        warn("HumanoidRootPart introuvable")
        return false
    end
    
    localRoot.CFrame = CFrame.new(x, y, z)
    return true
end

-- Fonction pour obtenir la position d'un joueur
function Teleport.GetPlayerPosition(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    
    if not targetPlayer then
        return nil
    end
    
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then
        return nil
    end
    
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        return nil
    end
    
    return targetRoot.Position
end

-- Événement quand un joueur rejoint (utile pour mettre à jour la liste)
function Teleport.OnPlayerAdded(callback)
    Players.PlayerAdded:Connect(callback)
end

-- Événement quand un joueur quitte (utile pour mettre à jour la liste)
function Teleport.OnPlayerRemoving(callback)
    Players.PlayerRemoving:Connect(callback)
end

-- ===================== RETOUR DU MODULE =====================
return Teleport