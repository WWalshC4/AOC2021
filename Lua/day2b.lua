do	--generate inputData from input text
	io.input ('day2_input.txt')

	local data

	directions = {}

	repeat
		data = io.read ('*line')
		table.insert (directions, data)
	until
		data == nil
end

depth = 0
progress = 0
aim = 0

for _, direction in ipairs (directions) do
	local down = string.match (direction, 'down (%d+)')
	local up = string.match (direction, 'up (%d+)')
	local forward = string.match (direction, 'forward (%d+)')

	if (down) then
		aim = aim + tonumber (down)
	elseif (up) then
		aim = aim - tonumber (up)
	elseif (forward) then
		progress = progress + tonumber (forward)
		depth = depth + (aim * tonumber (forward))
	end
end

print (depth * progress) -- 1568138742