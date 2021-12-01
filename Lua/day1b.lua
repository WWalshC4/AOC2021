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

local lastWindow = math.huge

local increaseCount = 0


for i = 3, #depthData do
	local window = depthData [i] + depthData [i-1] + depthData [i-2]
	if window > lastWindow then
		increaseCount = increaseCount + 1
	end
	lastWindow = window
end

print (increaseCount) -- 1359
