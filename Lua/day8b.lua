do	--generate inputData from input text
	io.input ('day8_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local example = {
	'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf',
}

local test = {
	'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
	'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
	'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
	'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
	'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
	'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
	'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
	'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
	'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
	'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce',
}

--input = test -- 61229

segments = {
	[0] =
	{'a', 'b', 'c', 'e', 'f', 'g',},		-- 0 has 6 [0, 6, 9]
	{'c', 'f',},							-- 1 has 2 [1]
	{'a', 'c', 'd', 'e', 'g',},				-- 2 has 5 [2, 3, 5]
	{'a', 'c', 'd', 'f', 'g',},				-- 3 has 5 [2, 3, 5]
	{'b', 'c', 'd', 'f',},					-- 4 has 4 [4]
	{'a', 'b', 'd', 'f', 'g',},				-- 5 has 5 [2, 3, 5]
	{'a', 'b', 'd', 'e', 'f', 'g',},		-- 6 has 6 [0, 6, 9]
	{'a', 'c', 'f',},						-- 7 has 3 [7]
	{'a', 'b', 'c', 'd', 'e', 'f', 'g',},	-- 8 has 7 [8]
	{'a', 'b', 'c', 'd', 'f', 'g',},		-- 9 has 6 [0, 6, 9]
}

segmentsConcat = {
	['abcefg'] = 0,
	['cf'] = 1,
	['acdeg'] = 2,
	['acdfg'] = 3,
	['bcdf'] = 4,
	['abdfg'] = 5,
	['abdefg'] = 6,
	['acf'] = 7,
	['abcdefg'] = 8,
	['abcdfg'] = 9,
}

LETTER_COUNTS = {
	e = 4, -- unique
	b = 6, -- unique
	d = 7,
	g = 7,
	a = 8,
	c = 8,
	f = 9, -- unique
}

local pattern = '(%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) | (%a+) (%a+) (%a+) (%a+)'

local sum = 0

for _, line in ipairs (input) do
	local values = table.pack (string.match (line, pattern))
	assert (#values == 14)

	local sigpat = {}
	for i = 1, 10 do
		table.insert (sigpat, table.remove (values, 1))
	end
	local outs = {}
	for i = 1, 4 do
		table.insert (outs, table.remove (values, 1))
	end

	local uniques = {}

	for _, pat in ipairs (sigpat) do
		if (#pat == 2) then
			uniques [1] = pat
		elseif (#pat == 3) then
			uniques [7] = pat
		elseif (#pat == 4) then
			uniques [4] = pat
		elseif (#pat == 7) then
			uniques [8] = pat
		end
	end

	local mapping = {}

	local letterCount = {}

	for i = 1, 10 do
		for j = 1, #sigpat [i] do
			local letter = string.sub (sigpat [i], j, j)
			letterCount [letter] = (letterCount [letter] or 0) + 1
		end
	end

	for letter, count in pairs (letterCount) do
		if (count == 4) then
			mapping [letter] = 'e'
		elseif (count == 6) then
			mapping [letter] = 'b'
		elseif (count == 9) then
			mapping [letter] = 'f'
		elseif (count == 8) then
			if (string.find (uniques [1], letter)) then
				mapping [letter] = 'c'
			else
				mapping [letter] = 'a'
			end
		elseif (count == 7) then
			if (string.find (uniques [4], letter)) then
				mapping [letter] = 'd'
			else
				mapping [letter] = 'g'
			end
		end
	end

	local newOuts = {}

	for _, out in ipairs (outs) do
		local s = {}
		for i = 1, #out do
			local l = string.sub (out, i, i)
			l = mapping [l]
			table.insert (s, l)
		end
		table.sort (s)
		table.insert (newOuts, table.concat (s))
	end

	local output = ''
	for _, out in ipairs (newOuts) do
		output = output .. segmentsConcat [out]
	end
	sum = sum + tonumber (output)

end

print (sum) -- 1084606

