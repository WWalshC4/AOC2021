do	--generate inputData from input text
	io.input ('day12_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local test1 = {
	'start-A',
	'start-b',
	'A-c',
	'A-b',
	'b-d',
	'A-end',
	'b-end',
}

local test2 = {
	'dc-end',
	'HN-start',
	'start-kj',
	'dc-start',
	'dc-HN',
	'LN-dc',
	'HN-end',
	'kj-sa',
	'kj-HN',
	'kj-dc',
}

local test3 = {
	'fs-end',
	'he-DX',
	'fs-he',
	'start-DX',
	'pj-DX',
	'end-zg',
	'zg-sl',
	'zg-pj',
	'pj-he',
	'RW-he',
	'fs-DX',
	'pj-RW',
	'zg-RW',
	'start-pj',
	'he-WI',
	'zg-he',
	'pj-fs',
	'start-RW',
}

input = test1 -- 10
--input = test2 -- 19
--input = test3 -- 226

local caves = {}

for _, line in ipairs (input) do
	local a, b = string.match (line, '^(.-)%-(.-)$')
	caves [a] = caves [a] or {}
	table.insert (caves [a], b)
	caves [b] = caves [b] or {}
	table.insert (caves [b], a)
end
