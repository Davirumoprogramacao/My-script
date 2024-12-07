-- Mapa
local Workspace = game.Workspace
local Map = Workspace.Map
local MysticIsland = Map:FindFirstChild("MysticIsland")

-- Jogadores
local Players = game:GetService("Players")
local allPlayers = Players:GetPlayers()
local PlayerCount = #allPlayers

-- Tempo
local Lighting = game:GetService("Lighting")
local Time = Lighting.ClockTime

local nord = nil
-- Condições
if Time >= 6 and Time < 18 then
    nord = "Day"
else
    nord = "Night"
end

-- Importante
local jobId = game.JobId
local script = "game:GetService('TeleportService'):TeleportToPlaceInstance(7449423635, '" .. game.JobId .. "')"

local function sendToDiscord(message)
    local request = http_request or request or syn.request or http.request
    if not request then
        warn("Executor não suporta requisições HTTP.")
        return
    end

    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = message,
            ["fields"] = {
                {["name"] = "Hora do Dia:", ["value"] = "```" .. nord .. "```", ["inline"] = false},
                {["name"] = "Jogadores:", ["value"] = "```" .. PlayerCount .. "```", ["inline"] = false},
                {["name"] = "Job ID:", ["value"] = "```" .. tostring(jobId) .. "```", ["inline"] = false},
                {["name"] = "Script:", ["value"] = "```" .. script .. "```", ["inline"] = false},
            },
            ["color"] = 16711680,
            ["footer"] = {
                ["text"] = "By @veenoooom",
                ["icon_url"] = ""
            }
        }}
    }

    request({
        Url = "https://discord.com/api/webhooks/1313848180735086644/PwUGL3B5PRhMYnkk48ZwQiTh1W5fYJS8dh_RNz2WZLHoPzjSm6vhvBiiDQvVQnumimXo",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(data)
    })
end

if game.Workspace.Map:FindFirstChild("MysticIsland") then
    sendToDiscord("Mirage Island Notifier")
end

local function Mandar()
    -- Definindo as fases da lua (corrigidas)
    local moonPhases = {
        "First Quarter",    -- Primeiro quarto
        "Waxing Crescent",  -- Crescente
        "Waxing Gibbous",   -- Gibbosa crescente
        "Full Moon",        -- Lua cheia
        "Waning Gibbous",   -- Minguante Gibbosa
        "Last Quarter",     -- Último quarto
        "Waning Crescent",  -- Minguante
        "New Moon"          -- Lua nova
    }

    -- Variáveis de controle
    local nightDuration = 600  -- 10 minutos em segundos (duração da noite)
    local dayDuration = 600    -- 10 minutos em segundos (duração do dia)
    local cycleDuration = 8 * nightDuration  -- Lua cheia a cada 8 noites (aproximadamente 8 * 10 minutos)

    -- Função para calcular a fase da lua baseada no tempo do servidor
    local function calculateMoonPhase()
        -- Calculando o tempo desde a criação do servidor usando tick()
        local currentTime = tick()  -- Tempo total desde o início do servidor
        local elapsedTime = currentTime % cycleDuration  -- Tempo dentro do ciclo lunar

        -- Calcular qual fase da lua está ativa com base no tempo decorrido
        local phaseIndex = math.floor(elapsedTime / nightDuration) % #moonPhases
        return moonPhases[phaseIndex + 1]  -- Lua começa com First Quarter
    end

    local request = http_request or request or syn.request or http.request
    if not request then
        warn("Executor não suporta requisições HTTP.")
        return
    end

    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = message,
            ["fields"] = {
                {["name"] = "Hora do Dia:", ["value"] = "```" .. nord .. "```", ["inline"] = false},
                {["name"] = "Jogadores:", ["value"] = "```" .. PlayerCount .. "```", ["inline"] = false},
                {["name"] = "Job ID:", ["value"] = "```" .. tostring(game.JobId) .. "```", ["inline"] = false},
                {["name"] = "Fase da Lua:", ["value"] = "```" .. calculateMoonPhase() .. "```", ["inline"] = false},
            },
            ["color"] = 16711680,
            ["footer"] = {
                ["text"] = "By @veenoooom",
                ["icon_url"] = ""
            }
        }}
    }
    if calculateMoonPhase == "Full Moon" then
      request({
          Url = "https://discord.com/api/webhooks/1313848180735086644/PwUGL3B5PRhMYnkk48ZwQiTh1W5fYJS8dh_RNz2WZLHoPzjSm6vhvBiiDQvVQnumimXo",
          Method = "POST",
          Headers = {["Content-Type"] = "application/json"},
          Body = game:GetService("HttpService"):JSONEncode(data)
      })
    end
end
Mandar()