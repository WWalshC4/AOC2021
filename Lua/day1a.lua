do	--generate inputData from input text
	io.input ('day1_input.txt')

	local data

	depthData = {}

	repeat
		data = io.read ('*line')
		table.insert (depthData, tonumber (data))
	until
		data == nil
end

local increase = 0

prev = math.huge

for _, current in ipairs (depthData) do
	if (current > prev) then
		increase = increase + 1
	end
	prev = current
end

print (increase) -- 1393
