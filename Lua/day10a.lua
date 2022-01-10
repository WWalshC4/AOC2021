do	--generate inputData from input text
	io.input ('day10_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local test = {
	'[({(<(())[]>[[{[]{<()<>>',
	'[(()[<>])]({[<{<<[]>>(',
	'{([(<{}[<>[]}>{[]{[(<()>',
	'(((({<>}<{<{<>}{[]{[]{}',
	'[[<[([]))<([[{}[[()]]]',
	'[{[{({}]{}}([{[{{{}}([]',
	'{<[[]]>}<{[{[{[]{()[[[]',
	'[<(<(<(<{}))><([]([]()',
	'<{([([[(<>()){}]>(<<{{',
	'<{([{{}}[<[[[<>{}]]]>[]]',
}

-- input = test -- 26397

local points = {
	[')'] = 3,
	[']'] = 57,
	['}'] = 1197,
	['>'] = 25137,
}

local match = {
	['{'] = '}',
	['<'] = '>',
	['['] = ']',
	['('] = ')',
}

local score = 0

for _, line in pairs (input) do
	local stack = {}
	for i = 1, #line do
		local thisChar = string.sub (line, i, i)
		local isOpen = match [thisChar]

		if (isOpen)  then
			table.insert (stack, 1, isOpen)
		else
			local pop = table.remove (stack, 1)
			if (pop ~= thisChar) then
				score = score + points [thisChar]
				break
			end
		end
	end
end

print (score) -- 268845