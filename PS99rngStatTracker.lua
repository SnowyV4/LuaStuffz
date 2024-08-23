-- EmbedSendCoolodwn needs to be defined as an integer and WebHookUrl needs to be defined as a string when executing!!!!
local WebHookService = loadstring(game:HttpGet("https://raw.githubusercontent.com/SnowyV4/LuaStuffz/main/WebHookService.lua"))()
local WebHookProtectionInc = loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/0c2c98fcbf178f8eb9b8e9bc8486da7d.lua"))()

local LP = game.Players.LocalPlayer

local paths = {
    rolls = LP.leaderstats["🎲 Rolls"],
    rngCoins = LP.PlayerGui.MainLeft.Left.Currency.RngCoins["RNG Coins"].Amount.Text,
    petsDir = LP.PlayerGui.Inventory.Frame.Main.Pets.Pets
}

if game.PlaceId ~= 8737899170 then
    return game.Players.LocalPlayer:Kick("Invalid game, lol!")
end

local exclusivesBeforeCount = 0
local exclusivesAfterCount = 0

for a,b in pairs(paths.petsDir:GetChildren()) do
    for c,d in pairs(b:GetChildren()) do
        if d.Name == "Strength" then
            if d.Text == "???" then
                exclusivesBeforeCount = exclusivesBeforeCount + 1
            end
        end
    end
end

local function getExclusivesCount()
    for a,b in pairs(paths.petsDir:GetChildren()) do
        for c,d in pairs(b:GetChildren()) do
            if d.Name == "Strength" then
                if d.Text == "???" then
                    exclusivesAfterCount = exclusivesAfterCount + 1 - exclusivesBeforeCount
                end
            end
        end
    end
end

local function sendEmbed(url)
    getExclusivesCount()
    local embed = WebHookService:CreateEmbed(
    "Snowy's PS99 Stat Tracker",
    "Here are somes stats for the user "..LP.Name,
    6624993,
    {
        {name = "🎲Rolls", value = tostring(paths.rolls.Value), inline = true},
        {name = "💰RNG Coins", value = paths.rngCoins, inline = true},
        {name = "🐱RNG Exclusives", value = tostring(exclusivesAfterCount), inline = true},
    })

    local data = { 
        embeds = {embed}
    }

    WebHookService:SendWebhook(url, data)
end

while wait(EmbedSendCooldown) do
    sendEmbed(WebHookUrl)
end
