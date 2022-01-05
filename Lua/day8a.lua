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

--input = test

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

local pattern = '(%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) (%a+) | (%a+) (%a+) (%a+) (%a+)'

local simple = 0

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

	for _, val in ipairs (outs) do
		if (#val == 2 or #val == 4 or #val == 3 or #val == 7) then
			simple = simple  + 1
		end
	end
end

print (simple)