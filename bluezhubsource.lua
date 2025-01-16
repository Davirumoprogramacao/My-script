if game.PlaceId ~= 4924922222 then
  return
end

local players = {}
for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
  table.insert(players, player.Name)
end

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
  humanoid = ch.Humanoid
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
local function teleportBehindPlayer(targetPlayerName)
    local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        -- Distância atrás do jogador alvo (ajuste o valor de "distance" conforme necessário)
        local distance = 5
        local direction = (targetPlayer.Character.HumanoidRootPart.CFrame.LookVector * -1) -- Direção oposta ao olhar
        local teleportPosition = targetPosition + direction * distance
        
        -- Teleporta o jogador local
        pl.Character:SetPrimaryPartCFrame(CFrame.new(teleportPosition))
    else
        warn("Jogador não encontrado ou não está com o personagem carregado.")
    end
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
        RemovePermission(b, tirar)
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
local Tp = Local:AddSection({
  Name = "Teleport"
})
Tp:AddDropdown({
  Name = "TP Player",
  Default = "",
  Options = players,
  Callback = function(Value)
    ch.HumanoidRootPart.CFrame = game.Players[Value].Character.HumanoidRootPart.CFrame
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