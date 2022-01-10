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

-- input = test -- 288957

local points = {
	[')'] = 1,
	[']'] = 2,
	['}'] = 3,
	['>'] = 4,
}

local match = {
	['{'] = '}',
	['<'] = '>',
	['['] = ']',
	['('] = ')',
}

local corrupted = {}
local incomplete = {}

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
				stack = {}
				break
			end
		end
	end
	if (#stack > 0) then
		local score = 0
		while (#stack > 0) do
			local pop = table.remove (stack, 1)
			score = score * 5
			score = score + points [pop]
		end
		table.insert (incomplete, score)
	end
end

table.sort (incomplete)

print (incomplete [math.ceil (#incomplete / 2)]) -- 4038824534