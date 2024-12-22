local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character.Humanoid
local RunService = game:GetService("RunService")
local backpack = player.Backpack
local elementsThatIHave = player.ownedElements:GetChildren()
for _, element in ipairs(elementsThatIHave) do
    local names = element.Name
end

--Global Variables
getgenv().AutoSwing = false
getgenv().AutoSell = false
--conditions
RunService.RenderStepped:Connect(function()
    if getgenv().AutoSwing then
        local children = backpack:GetChildren()
        local firstchild = children[1]
        humanoid:EquipTool(firstchild)
        local args = {
            [1] = "swingKatana"
        }
        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(unpack(args))
    end
end)

--Making UI
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Title of the library", HidePremium = false, SaveConfig = true, ConfigFolder = "UI"})

local Tab = Window:MakeTab({
  Name = "Swing",
  Icon = "rbxassetid://119156926714211",
  PremiumOnly = false
})
Tab:AddToggle({
    Name = "Auto Swing",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSwing = Value
    end    
})
Tab:AddButton({
    Name = "Unlock all elements",
    Callback = function()
        local args = {
            [1] = "Inferno"
        }
        local args1 = {
            [1] = "Frost"
        }
        local args2 = {
            [1] = "Lightning"
        }
        local args3 = {
            [1] = "Shadow Charge"
        }
        local args4 = {
            [1] = "Masterful Wrath"
        }
        local args5 = {
            [1] = "Electral Chaos"
        }
        local args6 = {
            [1] = "Shadowfire"
        }
        local args7 = {
            [1] = "Eternity Storm"
        }
        local args8 = {
            [1] = "Blazing Entity"
        }
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args1))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args2))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args3))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args4))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args5))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args6))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args7))
        wait(.5)
        game:GetService("ReplicatedStorage").rEvents.elementMasteryEvent:FireServer(unpack(args8))
        OrionLib:MakeNotification({
            Name = "Thats okay",
            Content = "Now you have all the elements",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})
OrionLib:Init()