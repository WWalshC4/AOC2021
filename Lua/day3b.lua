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

testreports = {
	'00100',
	'11110',
	'10110',
	'10111',
	'10101',
	'01111',
	'00111',
	'11100',
	'10000',
	'11001',
	'00010',
	'01010',
}

function splitReports (t, pos)
	local zeroes, ones = {}, {}
	for k, v in ipairs (t) do
		if (string.sub (v, pos, pos) == '0') then
			table.insert (zeroes, v)
		elseif (string.sub (v, pos, pos) == '1') then
			table.insert (ones, v)
		end
	end
	return ones, zeroes
end

local oxygen, scrubber = {}, {}

for k, v in ipairs (reports) do
	table.insert (oxygen, v)
	table.insert (scrubber, v)
end

for i = 1, #oxygen[1] do
	local ones, zeroes = splitReports (oxygen, i)
	if (#ones >= #zeroes) then
		oxygen = ones
	elseif (#ones < #zeroes) then
		oxygen = zeroes
	end
	if (#oxygen == 1) then
		break
	end

end

for i = 1, #scrubber[1] do
	local ones, zeroes = splitReports (scrubber, i)
	if (#ones < #zeroes) then
		scrubber = ones
	elseif (#ones >= #zeroes) then
		scrubber = zeroes
	end
	if (#scrubber == 1) then
		break
	end
end

print (tonumber (oxygen [1], 2) * tonumber (scrubber [1], 2)) -- 3368358


