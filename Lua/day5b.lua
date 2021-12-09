do	--generate inputData from input text
	io.input ('day5_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

vents = {}

local minX, minY, maxX, maxY = math.huge, math.huge, 0, 0

for _, line in ipairs (input) do
	local startX, startY, endX, endY = string.match (line, '(%d+),(%d+) %-%> (%d+),(%d+)')
	startX = tonumber (startX)
	startY = tonumber (startY)
	endX = tonumber (endX)
	endY = tonumber (endY)

	minX = math.min (minX, startX, endX)
	minY = math.min (minY, startY, endY)
	maxX = math.max (maxX, startX, endX)
	maxY = math.max (maxY, startY, endY)

	local diffX = endX - startX
	local diffY = endY - startY
	if (diffX == 0 or diffY == 0 or math.abs (diffX) == math.abs (diffY)) then
		local deltaX, deltaY = 0, 0
		if (diffX ~= 0) then
			deltaX = diffX / math.abs (diffX)
		end
		if (diffY ~= 0) then
			deltaY = diffY / math.abs (diffY)
		end

		for i = 0, math.max (math.abs(diffX), math.abs (diffY)) do
			vents [startX + (i * deltaX)] = vents [startX + (i * deltaX)] or {}
			vents [startX + (i * deltaX)] [startY + (i * deltaY)] = (vents [startX + (i * deltaX)] [startY + (i * deltaY)] or 0) + 1
		end
	end
end

local overlaps = 0

for x = minX, maxX do
	for y = minY, maxY do
		if (vents [x] and vents [x] [y] and vents [x] [y] > 1) then
			overlaps = overlaps + 1
		end
	end
end

print (overlaps) -- 20500