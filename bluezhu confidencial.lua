local Whitelist = {
  "BT42OOR54XV2CT15", -- Key do Galaxy
  "H04Ece30ZkVEbRHW", -- minha key
  "G8mL0Xp4RzW7FjKy",
  "T2vKp9AeQd5LX3Ho",
  "J4ZFbX7mYtK8rWv2",
  "N3LXp6JkT9AeH0Wz",
  "R5W7LXp2Y8mK9ZFb"
}
local Stop = nil
if not getgenv().Key then
  print("Nenhuma chave foi definida. Acesso negado.")
  return
end

-- Valida a chave
local CanAcess = false
for _, verify in ipairs(Whitelist) do
  if getgenv().Key == verify then
    CanAcess = true
    break
  end
end
-- Impede a execução se a chave for inválida
if not CanAcess then
  print("Chave inválida. Acesso negado.")
  return
end


if game.PlaceId ~= 4924922222 then
  return
end

local players = {}
for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
  table.insert(players, player.Name)
end

local props = workspace.WorkspaceCom["001_TrafficCones"]

local Players = game:GetService("Players")

local pl = game.Players.LocalPlayer
local ch = pl.Character
local hum = ch.HumanoidRootPart
local backpack = pl.Backpack
local humanoid = ch.Humanoid

local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
  pl = game.Players.LocalPlayer
  ch = pl.Character
  hum = ch.HumanoidRootPart
  backpack = pl.Backpack
  humanoid = ch.Humanoidu
end)
RunService.RenderStepped:Connect(function()
  players = {} -- Limpa a tabela
  for _, player in ipairs(Players:GetPlayers()) do
    table.insert(players, player.Name) -- Adiciona nomes dos jogadores
  end
end)

local AutoUnban = nil

local lots = workspace["001_Lots"]

local function Unban()
  for _, house in ipairs(lots:GetChildren()) do
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
      if house.Name == player.Name .. "House" then
        local housePicked = house:FindFirstChild("HousePickedByPlayer")
        if housePicked then
          local houseModel = housePicked:FindFirstChild("HouseModel")
          if houseModel then
            -- Procura e destrói objetos com "BannedBlock" no nome
            for _, child in ipairs(houseModel:GetChildren()) do
              if string.find(child.Name, "BannedBlock") then
                print("Destroying:", child.Name)
                child:Destroy()
              end
            end
          end
        end
      end
    end
  end
end

game:GetService("RunService").RenderStepped:Connect(function()
  if AutoUnban then
    Unban()
  end
end)

local HouseNumber = {
  1, 2, 3, 4, 5, 6, 7, 11, 12, 13, 14, 15, 16, 17, 18, 19,
  20, 21, 22, 23, 24, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37
}

local function TakeObject(tool)
  local args = {
    [1] = "PickingTools",
    [2] = tool
  }
  game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
end

local function RemoveObject(tool)
  local args = {
    [1] = "PlayerWantsToDeleteTool",
    [2] = tool
  }
  game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
end

local function GetPermission(houseNumber)
  local args = {
    [1] = "GivePermissionLoopToServer",
    [2] = game:GetService("Players").LocalPlayer,
    [3] = houseNumber
  }
  game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
end
local function GivePermission(player, house)
  local args = {
    [1] = "GivePermissionLoopToServer",
    [2] = game:GetService("Players")[player],
    [3] = house
  }
  game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
end
local function RemovePermission(player, house)
  local args = {
    [1] = "RemovePermissionLoopToServer",
    [2] = game:GetService("Players")[player],
    [3] = house
  }
  game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
end
-- Script Local

-- Função para teletransportar o jogador local para trás de outro jogador
local function TeleportAround(player)
  local Players = game:GetService("Players")
  local RunService = game:GetService("RunService")
  
  local localPlayer = Players.LocalPlayer
  local targetPlayer = Players:FindFirstChild(player) -- Substitua pelo nome do jogador alvo.
  
  if not targetPlayer then
      warn("Jogador alvo não encontrado!")
      return
  end
  
  local targetCharacter = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
  local humanoid = targetCharacter:WaitForChild("Humanoid")
  local targetRoot = targetCharacter:WaitForChild("HumanoidRootPart")
  
  local myCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local myRoot = myCharacter:WaitForChild("HumanoidRootPart")
  
  local teleporting = true -- Controle do loop de teleporte
  
  local did = false
  -- Função para teleportar ao redor do jogador alvo
  local function teleportAroundTarget()
      if not targetRoot or not myRoot then return end
  
      -- Define raio horizontal e vertical para teleporte
      local radiusHorizontal = 5
      local radiusVertical = 5
  
      -- Calcula uma posição aleatória ao redor do jogador alvo
      local angle = math.rad(math.random(0, 360))
      local offsetHorizontal = Vector3.new(math.cos(angle) * radiusHorizontal, 0, math.sin(angle) * radiusHorizontal)
      local offsetVertical = Vector3.new(0, math.random(-radiusVertical, radiusVertical), 0)
  
      -- Posição final
      local teleportPosition = targetRoot.Position + offsetHorizontal + offsetVertical
  
      -- Move o jogador para a posição calculada e ajusta a rotação para olhar para o alvo
      myRoot.CFrame = CFrame.new(teleportPosition, targetRoot.Position)
  end
  
  -- Monitorar o estado do Humanoid e interromper o loop quando o alvo sentar
  humanoid.StateChanged:Connect(function(_, newState)
      if newState == Enum.HumanoidStateType.Seated then
          print("Jogador alvo está sentado. Parando teleporte.")
          teleporting = false
      end
  end)
  
  -- Loop de teleporte contínuo
  local onceDid = false
  RunService.Heartbeat:Connect(function()
      if teleporting then
        if Stop then
          return
        end
        teleportAroundTarget()
        did = false
        task.wait(0.1) -- Tempo entre os teleportes
      elseif not teleporting and not onceDid then
        wait(.3)
        local Teleport = Vector3.new(-213.10760498046875, -456.403564453125, 116.18391418457031)
        hum.Position = Teleport
        wait(.5)
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
        wait(.5)
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        onceDid = true
        did = true
      end
  end)
end
-- Making UI
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Bluez Brookhaven🏡", HidePremium = false, SaveConfig = true, ConfigFolder = "Bluez Brookhaven"})

local House = Window:MakeTab({
  Name = "House",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})

local Perm = House:AddSection({
  Name = "Permission"
})
local Ban = House:AddSection({
  Name = "Ban"
})
local Selected = nil
Perm:AddDropdown({
  Name = "Get House permission",
  Default = "",
  Options = HouseNumber,
  Callback = function(Value)
    Selected = Value
  end
})
Perm:AddButton({
  Name = "Confirm",
  Callback = function()
    GetPermission(Selected)
  end
})
Perm:AddButton({
  Name = "Get all houses perms",
  Callback = function()
    for _, house in ipairs(lots:GetChildren()) do
      -- Verifica se o nome da casa corresponde ao nome do jogador concatenado com "House"
      for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if house.Name == player.Name .. "House" then
          -- Acesse a propriedade Number dentro da casa (house.Number.Number)
          local houseNumber = house:FindFirstChild("Number")
          
          -- Verifique se "Number" existe e se a propriedade "Number" dentro dele está presente
          if houseNumber and houseNumber:FindFirstChild("Number") then
            -- Chama a função para conceder permissão usando o valor do número da casa
            GetPermission(houseNumber.Number.Value)
          else
            -- Caso "Number" não seja encontrado ou não tenha a propriedade correta
            warn("House number not found or invalid for house:", house.Name)
          end
          
          -- Adicionando delay de 0.5 segundos entre as verificações
          wait(0.5)
        end
      end
    end
  end
})
local tirar = nil
Perm:AddDropdown({
  Name = "Remove all House permission",
  Default = "",
  Options = HouseNumber,
  Callback = function(Option)
    tirar = Option
  end
})
Perm:AddButton({
  Name = "Confirm",
  Callback = function()
    for i, each in ipairs(Players:GetPlayers()) do
      local Table = {}
      table.insert(Table, each.Name)
      table.remove(Table, 1)
      for a, b in ipairs(Table) do
        RemovePermission(each.Name, tirar)
        wait(0.5)
      end
    end
  end
})

Ban:AddToggle({
  Name = "Auto house unban",
  Default = false,
  Callback = function(Value)
    AutoUnban = Value
  end
})
local Troll = Window:MakeTab({
  Name = "Troll",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
local Invisible = Troll:AddSection({
  Name = "Invisible"
})
Invisible:AddButton({
  Name = "Invisible",
  Callback = function()
    local args = {
      [1] = "CharacterSizeDown",
      [2] = 5
    }
    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clothe1s"):FireServer(unpack(args))
  end
})
Invisible:AddButton({
  Name = "Visible",
  Callback = function()
    local args = {
      [1] = "CharacterSizeUp",
      [2] = 1
    }
    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clothe1s"):FireServer(unpack(args))
  end
})
local kill = Troll:AddSection({
  Name = "Kill"
})
local playerToKill = nil
local killDropdown = kill:AddDropdown({
  Name = "Select Player",
  Default = "",
  Options = players,
  Callback = function(Option)
    playerToKill = Option
  end
})
kill:AddButton({
  Name = "Refresh",
  Callback = function()
    killDropdown:Refresh(players, true) 
  end
})
kill:AddButton({
  Name = "Kill (equip Stretcher)",
  Callback = function()
    Stop = false
    local Teleport = Vector3.new(-213.10760498046875, -456.403564453125, 116.18391418457031)
    humanoid:EquipTool(backpack:FindFirstChild("Stretcher"))
    TeleportAround(tostring(playerToKill))
  end
})
kill:AddButton({
  Name = "Stop killing",
  Callback = function()
    Stop = true
  end
})
kill:AddButton({
  Name = "Sit esp",
  Callback = function()
    -- Obtém o jogador local
    local localPlayer = game.Players.LocalPlayer
    
    -- Loop para monitorar os jogadores
    game:GetService("RunService").RenderStepped:Connect(function()
        for _, player in pairs(game.Players:GetPlayers()) do
            -- Ignora o jogador local
            if player ~= localPlayer then
                local character = player.Character
                local localCharacter = localPlayer.Character
                if character and localCharacter then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local head = character:FindFirstChild("Head")
                    local localHead = localCharacter:FindFirstChild("Head")
    
                    if head and localHead and humanoid then
                        -- Calcula a distância entre os jogadores
                        local distance = (localHead.Position - head.Position).Magnitude
    
                        -- Verifica se o ESP já existe
                        local espTag = head:FindFirstChild("ESP_Tag")
                        if not espTag then
                            -- Cria o BillboardGui para o ESP
                            espTag = Instance.new("BillboardGui", head)
                            espTag.Name = "ESP_Tag"
                            espTag.Size = UDim2.new(8, 0, 2, 0)
                            espTag.StudsOffset = Vector3.new(0, 2, 0)
                            espTag.AlwaysOnTop = true
    
                            -- Cria a TextLabel dentro do BillboardGui
                            local label = Instance.new("TextLabel", espTag)
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundTransparency = 1
                            label.TextColor3 = Color3.new(1, 1, 1)
                            label.TextStrokeTransparency = 0.5
                            label.Font = Enum.Font.SourceSansBold
                            label.TextScaled = false
                        end
    
                        -- Atualiza o texto e o tamanho das letras
                        local label = espTag:FindFirstChildOfClass("TextLabel")
                        if label then
                            label.Text = player.Name .. " | Sentado: " .. tostring(humanoid.Sit)
                            label.TextColor3 = humanoid.Sit and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    
                            -- Ajusta o tamanho do texto com base na distância (ajustado para tamanhos menores)
                            label.TextSize = math.clamp(distance / 4, 14, 20)  -- Tamanho mínimo de 14 e máximo de 20
                        end
                    end
                end
            end
        end
    end)
  end
})
Troll:AddLabel("Coming Soon...")

local Local = Window:MakeTab({
  Name = "Local Player",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
Local:AddTextbox({
  Name = "Walk Speed",
  Default = "",
  TextDisappear = true,
  Callback = function(Value)
    if tonumber(Value) > 1 then
      humanoid.WalkSpeed = Value
    end
  end
})
Local:AddTextbox({
  Name = "Jump Power",
  Default = "",
  TextDisappear = true,
  Callback = function(Value)
    if tonumber(Value) > 1 then
      humanoid.JumpPower = Value
    end
  end
})
Local:AddButton({
  Name = "Prop Esp",
  Callback = function()
    local Players = game:GetService("Players")
    local props = game.Workspace.WorkspaceCom["001_TrafficCones"] -- Caminho correto dos props
    
    -- Função para criar o ESP
    local function createESPForProp(prop, player)
        -- Verifica se o prop já tem um ESP
        local existingESP = prop:FindFirstChild("ESP_" .. player.Name)
        if existingESP then
            return -- Se já existir, não cria outro
        end

        -- Procura qualquer filho que seja um BasePart
        local basePart = nil
        for _, child in ipairs(prop:GetChildren()) do
            if child:IsA("BasePart") then
                basePart = child
                break
            end
        end

        if basePart then
            -- Cria o BillboardGui
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP_" .. player.Name
            billboard.Adornee = basePart -- Associa o ESP à BasePart
            billboard.Size = UDim2.new(5, 0, 1, 0) -- Tamanho do ESP
            billboard.StudsOffset = Vector3.new(0, 3, 0) -- Posição acima da BasePart
            billboard.AlwaysOnTop = true -- Sempre visível

            -- Cria o texto
            local textLabel = Instance.new("TextLabel")
            textLabel.Text = "Prop Owner: " .. player.Name -- Nome do jogador dono do prop
            textLabel.BackgroundTransparency = 1 -- Sem fundo
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Cor do texto (branco)
            textLabel.TextScaled = true -- Escala automática do texto
            textLabel.Size = UDim2.new(1, 0, 1, 0) -- Ocupa todo o espaço do BillboardGui
            textLabel.Font = Enum.Font.SourceSansBold -- Fonte do texto
            textLabel.Parent = billboard

            -- Adiciona o BillboardGui à BasePart
            billboard.Parent = basePart

            print("ESP criado para o prop de:", player.Name)
        else
            print("Nenhuma BasePart encontrada no prop:", prop.Name)
        end
    end

    -- Função para verificar e criar ESP para novos props
    local function checkAndCreateESPForNewProps()
        for _, prop in ipairs(props:GetChildren()) do
            for _, player in ipairs(Players:GetPlayers()) do
                if prop.Name == "Prop" .. player.Name then
                    createESPForProp(prop, player)
                end
            end
        end
    end

    -- Monitorar a chegada de novos props
    props.ChildAdded:Connect(function(prop)
        -- Espera um momento para garantir que o prop foi totalmente carregado
        wait(1)
        for _, player in ipairs(Players:GetPlayers()) do
            if prop.Name == "Prop" .. player.Name then
                createESPForProp(prop, player)
            end
        end
    end)

    -- Criar ESP para todos os props existentes no momento
    checkAndCreateESPForNewProps()
  end
})
local Tp = Local:AddSection({
  Name = "Teleport"
})
local TpDropdown = Tp:AddDropdown({
  Name = "TP Player",
  Default = "",
  Options = players,
  Callback = function(Value)
    ch.HumanoidRootPart.CFrame = game.Players[Value].Character.HumanoidRootPart.CFrame
  end
})

Tp:AddButton({
  Name = "Refresh",
  Callback = function()
    TpDropdown:Refresh(players, true) -- Atualiza o dropdown
  end
})
local Creditos = Window:MakeTab({
  Name = "Credits",
  Icon = "rbxassetid://4483345998",
  PremiumOnly = false
})
Creditos:AddLabel("By: @veenoooom")
Creditos:AddLabel("Espero que tenha gostado do script, ele será atualizado em breve!")

OrionLib:Init()