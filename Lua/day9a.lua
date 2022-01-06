do	--generate inputData from input text
	io.input ('day9_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local test = {
	'2199943210',
	'3987894921',
	'9856789892',
	'8767896789',
	'9899965678',
}

-- input = test -- 15

local heightmap = {}

for _, line in pairs (input) do
	local row = {}
	for i = 1, #line do
		local height = string.sub (line, i, i)
		height = tonumber (height)
		table.insert (row, height)
	end
	table.insert (heightmap, row)
end

risksum = 0

for column, rowData in pairs (heightmap) do
	for row, height in pairs (rowData) do
		local lowPoint = false
		local up = (heightmap [column - 1] and heightmap [column - 1] [row]) or math.huge
		local down = (heightmap [column + 1] and heightmap [column + 1] [row]) or math.huge
		local left = (heightmap [column] and heightmap [column] [row - 1]) or math.huge
		local right = (heightmap [column] and heightmap [column] [row + 1]) or math.huge
		if (height < math.min (up, down, left, right)) then
			risksum = risksum + 1 + height
		end
	end
end

print (risksum) -- 631