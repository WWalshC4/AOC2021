do	--generate inputData from input text
	io.input ('day6_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local howManyDays = 256

local newFishDaysTilSpawn = 8

local childrenByInitialDays = {}

for a = 0, newFishDaysTilSpawn do

	local daysLeft = {[a] = 1}

	for i = 1, howManyDays do
		for daysTilSpawn = 0, newFishDaysTilSpawn do
			daysLeft [daysTilSpawn - 1] = (daysLeft [daysTilSpawn - 1] or 0) + (daysLeft [daysTilSpawn] or 0)
			daysLeft [daysTilSpawn] = 0
		end
		if (daysLeft [-1] and daysLeft [-1] > 0) then
			daysLeft [6] = (daysLeft [6] or 0) + daysLeft [-1]
			daysLeft [8] = (daysLeft [8] or 0) + daysLeft [-1]
			daysLeft [-1] = 0
		end
	end

	local totalIncFirstFish = 0

	for i = 0, howManyDays do
		totalIncFirstFish = totalIncFirstFish + (daysLeft [i] or 0)
	end

	childrenByInitialDays [a] = totalIncFirstFish
end

local totalFish = 0

--local input = {[1] = '3,4,3,1,2'} -- 26984457539

for daysLeft in string.gmatch (input[1], '(%d+)') do
	totalFish = totalFish + childrenByInitialDays [tonumber (daysLeft)]
end

print (totalFish) -- 372984

