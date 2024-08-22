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
        title = title,
        description = description,
        color = color,
        fields = fields or {}
    }
    return embed
end

return WebhookModule
