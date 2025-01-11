local CorrectKeys = {
  "LHPLAYZacess",
  "RandomPersonAcess"
}
local CanAcess = false
for _, verify in ipairs(CorrectKeys) do
  if getgenv().Key ~= CorrectKeys then
    CanAcess = true
  else
    CanAcess = false
  end
end
if not CanAcess then
  print("Acess Denied")
end


local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local playerstable = Players:GetPlayers()
local allPlayers = {}
for _, pl in ipairs(playerstable) do
  table.insert(allPlayers, pl.Name)
end

local Player = Players.LocalPlayer
local Data = Player.Data
local Level = Data.Level.Value
local Character = Player.Character

local Backpack = Player.Backpack

local Enemies = workspace.Enemies

local Humanoid = Character.Humanoid
local HumanoidRootPart = Character.HumanoidRootPart

local function farmFromPlayerLevel()
  if Level >= 1 and Level < 10 then
    -- Criar o BodyPosition
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.Parent = HumanoidRootPart
    bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000) -- Permite que ele aplique força suficiente em todas as direções
    bodyPosition.D = 100 -- Amortecimento para suavizar os movimentos
    bodyPosition.P = 5000 -- Potência para manter a posição
    -- Definir a posição fixa
    bodyPosition.Position = Enemies.Bandit.HumanoidRootPart.Position + Vector3.new(0, 10, 0) -- Mantém o humanoid 10 unidades acima da posição atual
  end
end
local function Comprar(NomeDoEstilodeLuta)
  local args = {
    [1] = "Buy" .. NomeDoEstilodeLuta
  }
  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
--[[
SharkmanKarate
FishmanKarate
Godhuman
DragonTalon
SanguineArt
DarkStep
DeathStep
ElectricClaw
]]
local function StoreFruit()
    for _, item in ipairs(Backpack:GetChildren()) do
        local space = item.Name:split(" ")  -- Divide o nome do item por espaços
        if space[2] == "Fruit" then  -- Verifica se o segundo elemento é "Fruit"
            -- Constrói o nome do fruto no formato "Dark-Dark"
            local fruitName = space[1] .. "-" .. space[1]
            local args = {
                [1] = "StoreFruit",
                [2] = fruitName,  -- Usa o nome gerado no formato "Dark-Dark"
                [3] = item  -- Passa o próprio item
            }
            -- Invoca o RemoteEvent para armazenar o fruto
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    end
end
local function changeWalkspeed(walkspeed)
    Humanoid.WalkSpeed = walkspeed
end
local function changeJumpHeight(Power)
    Humanoid.JumpHeight = Power
end
local function BuyRandomFruit()
  local args = {
    [1] = "Cousin",
    [2] = "Check"
  }
  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  
  local args1 = {
    [1] = "Cousin",
    [2] = "Buy"
  }
  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))
end
local function KenHaki()
  local args = {
    [1] = "Ken",
    [2] = true
  }
  game:GetService("ReplicatedStorage").Remotes.CommE:FireServer(unpack(args))
end
local function BusoHaki()
  local args = {
    [1] = "Buso"
  }
  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
local function EquipItem(Item)
  local args = {
    [1] = "LoadItem",
    [2] = Item
  }
  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
local function travelSea(Sea)
  if Sea == 1 then
    local args = {
      [1] = "TravelMain"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  elseif Sea == 2 then
    local args = {
      [1] = "TravelDressrosa"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  elseif Sea == 3 then
    local args = {
      [1] = "TravelZou"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  end
end
local function Frag(Action)
  if Action == "Refund" then
    local args = {
      [1] = "BlackbeardReward",
      [2] = "Refund",
      [3] = "2"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  elseif Action == "Reroll" then
    local args = {
      [1] = "BlackbeardReward",
      [2] = "Reroll",
      [3] = "2"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  end
end
local function Hitbox()
  for _, enemies in ipairs(game.Workspace.Enemies:GetChildren()) do
    local hrp = enemies:FindFirstChild("Head")
    if not hrp then
      print(" ")
    end
    hrp.Size = Vector3.new(100, 100, 100)
    hrp.Transparency = 1
  end
end
local function sendPublicMessage(msg)
  local args = {
    [1] = msg,
    [2] = "All"
  }
  game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end
local function sendPrivateMessage(msg, pl)
  local args = {
    [1] = msg,
    [2] = "To " .. pl
  }
  game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
end
-- Make script hub
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Bluez Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local Main = Window:MakeTab({
  Name = "Main",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local SubMain = Window:MakeTab({
  Name = "Sub Main",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local Fruit = Window:MakeTab({
  Name = "Auto Random Fruit",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local Teleport = Window:MakeTab({
  Name = "Teleport",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local Island = Window:MakeTab({
  Name = "Island",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local Shop = Window:MakeTab({
  Name = "Shop",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local Misc = Window:MakeTab({
  Name = "Misc",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
--Main
--Sub Main
--Fruit
Fruit:AddButton({
  Name = "Buy Random Fruit",
  Callback = function()
    BuyRandomFruit()
  end
})
Fruit:AddToggle({
  Name = "Auto Store Fruit",
  Default = false,
  Callback = function(Value)
    while Value and task.wait(0.5) do
      StoreFruit()
    end
  end
})

--Teleport
Teleport:AddButton({
  Name = "Teleport to Sea 1",
  Callback = function()
    travelSea(1)
  end
})
Teleport:AddButton({
  Name = "Teleport to Sea 2",
  Callback = function()
    travelSea(2)
  end
})
Teleport:AddButton({
  Name = "Teleport to Sea 3",
  Callback = function()
    travelSea(3)
  end
})
--Island
--Shop
local FightingStyles = {
  "SanguineArt",
  "Godhuman",
  "SharkmanKarate",
  "ElectricClaw",
  "Superhuman",
  "DragonTalon",
  "DeathStep",
  "BlackLeg",
  "FishmanKarate",
  "DragonBreath",
  "Electric"
}
local Buy = nil
Shop:AddDropdown({
  Name = "Fighting Styles",
  Default = "",
  Options = FightingStyles,
  Callback = function(Value)
    Buy = Value
  end    
})
Shop:AddButton({
  Name = "Buy Fighting Style",
  Callback = function()
    if Buy ~= "DragonBreath" then
      Comprar(Buy)
    else
      local args1 = {
        [1] = "BlackbeardReward",
        [2] = "DragonClaw",
        [3] = "1"
      }
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))
      
      local args = {
        [1] = "BlackbeardReward",
        [2] = "DragonClaw",
        [3] = "2"
      }
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
  end
})
-- Misc
local Game = Misc:AddSection({
  Name = "Game"
})
Game:AddButton({
  Name = "Refund",
  Callback = function()
    Frag("Refund")
  end
})
Game:AddButton({
  Name = "Reroll",
  Callback = function()
    Frag("Reroll")
	 end
})
Game:AddButton({
  Name = "Buso Haki",
  Callback = function()
    BusoHaki()
  end
})
-- Variável para controlar o estado da aura
local auraEnabled = false

-- Função para aplicar a aura a um inimigo
local function updateAura(child)
    local head = child:FindFirstChild("Head")
    if head then
        head.Size = Vector3.new(200, 200, 200)  -- Tamanho da cabeça alterado para 200, 200, 200
        head.Transparency = 1  -- Torna a cabeça invisível
        head.CanCollide = false
    end
end

-- Função para aplicar a aura a todos os filhos existentes
local function applyAuraToAllChildren()
    for _, child in ipairs(Enemies:GetChildren()) do
        updateAura(child)
    end
end

-- Função para monitorar a adição de novos NPCs (inimigos)
local function setupAuraForNewChildren()
    Enemies.ChildAdded:Connect(function(child)
        if auraEnabled then
            updateAura(child)
        end
    end)
end

-- Função para aplicar a aura continuamente
local function continuousAuraApplication()
    -- Verifica se a aura está ativada
    if auraEnabled then
        -- Aplica aura a todos os NPCs já presentes
        applyAuraToAllChildren()
    end
end

-- Toggle para ativar/desativar a aura
Game:AddToggle({
    Name = "Aura",
    Default = true,
    Callback = function(Value)
        auraEnabled = Value
        
        -- Se a aura for ativada, aplicamos a aura aos NPCs já presentes
        if auraEnabled then
            -- Aplica a aura a todos os inimigos existentes
            applyAuraToAllChildren()
        end
    end
})

-- Monitoramento de novos NPCs
setupAuraForNewChildren()

-- Continuamente verifica e aplica aura
RunService.RenderStepped:Connect(function()
    continuousAuraApplication()
end)

local espConnection -- Variável para armazenar a conexão com RenderStepped

Game:AddToggle({
    Name = "Enemies Esp",
    Callback = function(Value)
        -- Desconecta qualquer conexão existente ao RenderStepped
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end

        if Value then
            -- Ativar ESP
            local enemiesFolder = game.Workspace:WaitForChild("Enemies") -- Certifica-se de que "Enemies" existe

            -- Função para criar ESP em um objeto
            local function createESP(objeto)
                if objeto:IsA("Model") and objeto:FindFirstChild("HumanoidRootPart") then
                    if not objeto:FindFirstChild("ESP") then
                        local highlight = Instance.new("BoxHandleAdornment")
                        highlight.Name = "ESP"
                        highlight.Size = Vector3.new(4, 6, 4) -- Ajuste o tamanho do ESP
                        highlight.Adornee = objeto:FindFirstChild("HumanoidRootPart")
                        highlight.AlwaysOnTop = true
                        highlight.ZIndex = 10
                        highlight.Color3 = Color3.fromRGB(255, 255, 255) -- Cor branca
                        highlight.Transparency = 0.5
                        highlight.Parent = objeto:FindFirstChild("HumanoidRootPart")
                    end
                end
            end

            -- Atualiza ESP para todos os objetos no folder
            local function updateESP()
                for _, objeto in pairs(enemiesFolder:GetChildren()) do
                    createESP(objeto)
                end
            end

            -- Conecta ao RenderStepped para atualizar o ESP
            espConnection = RunService.RenderStepped:Connect(updateESP)
        else
            -- Desativar ESP: Remover todos os adornos
            local enemiesFolder = game.Workspace:WaitForChild("Enemies") -- Certifica-se de que "Enemies" existe
            for _, objeto in pairs(enemiesFolder:GetChildren()) do
                if objeto:IsA("Model") and objeto:FindFirstChild("HumanoidRootPart") then
                    local esp = objeto:FindFirstChild("ESP")
                    if esp then
                        esp:Destroy()
                    end
                end
            end
        end
    end
})