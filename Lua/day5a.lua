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

	if (startX == endX) then
		vents [startX] = vents [startX] or {}
		if (startY > endY) then
			for i = endY, startY do
				vents [startX] [i] = (vents [startX] [i] or 0) + 1
			end
		else
			for i = startY, endY do
				vents [startX] [i] = (vents [startX] [i] or 0) + 1
			end
		end
	elseif (startY == endY) then
		if (startX > endX) then
			for i = endX, startX do
				vents [i] = vents [i] or {}
				vents [i] [startY] = (vents [i] [startY] or 0) + 1
			end

		else
			for i = startX, endX do
				vents [i] = vents [i] or {}
				vents [i] [startY] = (vents [i] [startY] or 0) + 1
			end
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

print (overlaps) -- 4655