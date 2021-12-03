do	--generate inputData from input text
	io.input ('day3_input.txt')

	local data

	reports = {}

	repeat
		data = io.read ('*line')
		table.insert (reports, data)
	until
		data == nil
end

bit0 = {}
bit1 = {}

for _, report in ipairs (reports) do
	for i = 1, #report do
		local b = string.sub (report, i, i)
		if (b == '0') then
			bit0 [i] = (bit0 [i] or 0) + 1
		elseif (b == '1') then
			bit1 [i] = (bit1 [i] or 0) + 1
		end
	end
end

local most = {}
local least = {}

for i = 1, #bit0 do
	if (bit0[i] > bit1 [i]) then
		table.insert (most, '0')
		table.insert (least, '1')
	elseif (bit0[i] < bit1 [i]) then
		table.insert (most, '1')
		table.insert (least, '0')
	end
end

epsilon = tonumber (table.concat (most), 2)
gamma = tonumber (table.concat (least), 2)

print (epsilon * gamma) -- 2972336

