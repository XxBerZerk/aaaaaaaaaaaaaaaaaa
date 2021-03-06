local doc = [[
	/shout <term>
	Shout something!
]]

local triggers = {
	'^/shout[@'..bot.username..']*'
}

local action = function(msg)

	local input = msg.text:input()

	if not input then
		sendReply(msg, doc)
		return
	end
	input = input:trim()

	if input:len() > 20 then
		input = input:sub(1,20)
	end

	input = input:upper()
	local output = ''
	local inc = 0
	for match in input:gmatch('.') do
		output = output .. match .. ' '
	end
	output = output .. '\n'
	for match in input:sub(2):gmatch('.') do
		local spacing = ''
		for i = 1, inc do
			spacing = spacing .. '  '
		end
		inc = inc + 1
		output = output .. match .. ' ' .. spacing .. match .. '\n'
	end
	output = '```\n' .. output:trim() .. '\n```'
	sendMessage(msg.chat.id, output, true, false, true)

end

return {
	action = action,
	triggers = triggers,
	doc = doc
}
