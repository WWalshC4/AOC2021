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

-- input = test -- 1134

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

lowpoints = {}

for yPos, rowData in pairs (heightmap) do
	for xPos, height in pairs (rowData) do
		local up = (heightmap [yPos - 1] and heightmap [yPos - 1] [xPos]) or math.huge
		local down = (heightmap [yPos + 1] and heightmap [yPos + 1] [xPos]) or math.huge
		local left = (heightmap [yPos] and heightmap [yPos] [xPos - 1]) or math.huge
		local right = (heightmap [yPos] and heightmap [yPos] [xPos + 1]) or math.huge
		if (height < math.min (up, down, left, right)) then
			table.insert (lowpoints, {yPos, xPos})
		end
	end
end

function buildBasin (yPos, xPos, basin)
	basin [yPos] = basin [yPos] or {}
	basin.size = basin.size or 0
	if (basin [yPos] [xPos] == nil) then
		if (heightmap [yPos] and heightmap [yPos][xPos]) then
			local height = heightmap [yPos][xPos]
			if (height < 9) then
				basin [yPos] [xPos] = true
				basin.size = basin.size + 1
				buildBasin (yPos - 1, xPos, basin)
				buildBasin (yPos + 1, xPos, basin)
				buildBasin (yPos , xPos - 1, basin)
				buildBasin (yPos , xPos + 1, basin)
			else
				basin [yPos] [xPos] = false
			end
		end
	end
end

local basinSizes = {}

for _, coords in pairs (lowpoints) do
	local yPos = coords [1]
	local xPos = coords [2]

	local basin = {}
	buildBasin (yPos, xPos, basin)
	table.insert (basinSizes, basin.size)
end

table.sort (basinSizes)

local biggest = basinSizes [#basinSizes] * basinSizes [#basinSizes - 1] * basinSizes [#basinSizes - 2]

print (biggest) -- 821560