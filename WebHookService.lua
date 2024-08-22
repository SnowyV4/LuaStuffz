local core = {}
local httpService = game:GetService("HttpService")

local function RGBToHex(rgb)
	local r = math.floor(rgb[1] * 255)
	local g = math.floor(rgb[2] * 255)
	local b = math.floor(rgb[3] * 255)

	return string.format("0x%02X%02X%02X", r, g, b)
end

export type ImageOptions = {
	url:string;
	width:number?;
	height:number?;
}

export type AuthorObject = {
	name:string;
	url:string;
	icon_url:string
}

export type FooterObject = {
	text:string;
	icon_url:string;
}

export type FieldObject = {
	name:string;
	value:string;
	inline:boolean;
}

export type SendOptions = {
	embeds:{}?;
	content:string?;
	tts:boolean?;
	username:string?;
}

export type EmbedObject = {
	title:string?;
	description:string?;
	type:string;
	color:number?;
	image:ImageOptions?;
	thumbnail:ImageOptions?;
	author:AuthorObject?;
	footer:FooterObject?;
	fields:{FieldObject}|any;
}

function core.EmbedBuilder(options:EmbedObject?)
	local template = {
		["type"] = "rich"
	}
	if options then
		template = options
	end
	return {
		setTitle = function(title:string)
			template["title"] = title
		end,
		setDescription = function(description:string)
			template["description"] = description
		end,
		setColor = function(color:Color3)
			local r,g,b = color.R, color.G, color.B
			local hexdecimal = RGBToHex({r,g,b})
			template["color"] = tonumber(hexdecimal)
		end,
		setImage = function(image:ImageOptions)
			template["image"] = {
				url = image.url;
				width = image.width;
				height = image.height;
			}
		end,
		setThumbnail = function(image:ImageOptions)
			template["thumbnail"] = {
				url = image.url;
				width = image.width;
				height = image.height;
			}
		end,
		setAuthor = function(author:AuthorObject)
			template["author"] = {
				["name"] = author.name;
				["url"] = author.url;
				["icon_url"] = author.icon_url;
			}
		end,
		setFooter = function(footer:FooterObject)
			template["footer"] = {
				["text"] = footer.text;
				["icon_url"] = footer.icon_url
			}
		end,
		addFields = function(...:FieldObject)
			local fields = {...}
			if (not template["fields"]) then
				template["fields"] = {}
			end
			for i,field in pairs(fields) do
				table.insert(template["fields"],{
					name = field.name;
					value = field.value;
					inline = field.inline;
				})
			end
		end,
		object = template
	}
end

function core.new(webhookurl:string)
	local functions = {}
	function functions:Send(options:SendOptions)
		if (not options.content and not options.embeds) then
			error("Atleast one option is required.")
			return false
		end
		local data = {}
		if options.content then
			data["content"] = options.content;
		else
			data["content"] = ""
		end
		if options.embeds then
			data["embeds"] = {}
			for i,v in pairs(options.embeds) do
				table.insert(data["embeds"],v.object)
			end
		end
		if options.username then
			data["username"] = options.username
		end
		if options.tts then
			data["tts"] = options.tts
		end
		local newdata = httpService:JSONEncode(data)
		local status,res = httpService:PostAsync(webhookurl, newdata)
		if (not status) then
			error(res)
		end
	end
	return functions
end

function core.ConvertColor(color:Color3)
	return tonumber(RGBToHex({
		color.R; color.G; color.B;
	}))
end

return core
