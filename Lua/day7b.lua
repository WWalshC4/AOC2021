do	--generate inputData from input text
	io.input ('day7_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local test = {'16,1,2,0,4,2,7,1,2,14'}

--input = test

values = {}
for value in string.gmatch (input[1], '(%d+)') do
	table.insert (values, tonumber (value))
end

table.sort (values)

local min = values [1]
local max = values [#values]

local neededFuel = {}

local fuelToMoveBy = {[0] = 0}
for i = 1, math.abs (max - min) do
	fuelToMoveBy [i] = fuelToMoveBy [i - 1] + i
end

for i = min, max do
	neededFuel [i] = 0
	for _, pos in ipairs (values) do
		neededFuel [i] = neededFuel [i] + fuelToMoveBy [math.abs (pos - i)]
	end
end

local minFuel = math.huge
local minFuelPos = -1

for pos, fuelNeeded in pairs (neededFuel) do
	if (fuelNeeded < minFuel) then
		minFuel = fuelNeeded
		minFuelPos = pos
	end
end

print (minFuelPos, minFuel) -- 472, 95581659


