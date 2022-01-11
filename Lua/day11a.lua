do	--generate inputData from input text
	io.input ('day11_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

local test = {
	'5483143223',
	'2745854711',
	'5264556173',
	'6141336146',
	'6357385478',
	'4167524645',
	'2176841721',
	'6882881134',
	'4846848554',
	'5283751526',
}

--input = test -- 1656

local steps = 100

local octos = {}

for i = 1, #input do
	local line = input [i]
	local octoLine = {}
	for j = 1, #line do
		local energy = string.sub (line, j, j)
		energy = tonumber (energy)
		table.insert (octoLine, energy)
	end
	table.insert (octos, octoLine)
end

local numFlashes = 0

--[[
	print ('----')
	local out = {}
	for row, rowData in ipairs (octos) do
		for column, energy in ipairs (rowData) do
			if (energy > 9) then
				table.insert (out, 'X')
			else
				table.insert (out, energy)
			end
		end
		table.insert (out, '\n')
	end
	print (table.concat (out))
	print ('----')
]]


for step = 1, steps do
	local flashedThisStepCount = 0
	local flashedThisStep = {}
	local visitedThisStep = {}

	local function CheckFlash (row, column, addFlashEnergy)
		local energy = octos [row] and octos [row] [column]
		if (energy == nil) then
			return
		end
		local visitedAlready = visitedThisStep [row] and visitedThisStep [row] [column]
		if (not visitedAlready) then
			if (energy > 9) then
				energy = 0
			end
			energy = energy + 1
			visitedThisStep [row] = visitedThisStep [row] or {}
			visitedThisStep [row] [column] = true
		end
		if (addFlashEnergy) then
			energy = energy + 1
		end
		octos [row][column] = energy
		local flashedAlready = flashedThisStep [row] and flashedThisStep [row] [column]
		if (flashedAlready) then
			return
		end
		if (energy <= 9) then
			return
		end
		numFlashes = numFlashes + 1
		flashedThisStep [row] = flashedThisStep [row] or {}
		flashedThisStep [row] [column] = true
		flashedThisStepCount = flashedThisStepCount + 1
		CheckFlash (row - 1, column - 1, true)
		CheckFlash (row - 1, column, true)
		CheckFlash (row - 1, column + 1, true)
		CheckFlash (row, column - 1, true)
		CheckFlash (row, column + 1, true)
		CheckFlash (row + 1, column - 1, true)
		CheckFlash (row + 1, column, true)
		CheckFlash (row + 1, column + 1, true)
	end

	for row, rowData in ipairs (octos) do
		for column, energy in ipairs (rowData) do
			CheckFlash (row, column)
		end
	end

	--[[
	print ('----')
	local out = {}
	for row, rowData in ipairs (octos) do
		for column, energy in ipairs (rowData) do
			if (energy > 9) then
				table.insert (out, 'X')
			else
				table.insert (out, energy)
			end
		end
		table.insert (out, '\n')
	end
	print (table.concat (out))
	print ('----')
	--]]
end

print (numFlashes) -- 1735