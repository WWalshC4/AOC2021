do	--generate inputData from input text
	io.input ('day4_input.txt')

	local data

	input = {}

	repeat
		data = io.read ('*line')
		table.insert (input, data)
	until
		data == nil
end

table.insert (input, '')

callOrder = table.remove (input, 1)

boards = {}

thisBoard = {}

while #input > 0 do
	local line = table.remove (input, 1)
	if (line == '') then
		if (#thisBoard > 0) then
			table.insert (boards, thisBoard)
			thisBoard = {}
		end
	else
		local boardLine = {}
		for item in string.gmatch (line, '(%d+)') do
			table.insert (boardLine, tonumber (item))
		end
		table.insert (thisBoard, boardLine)
	end
end
function markBoard (board, num)
	local left = 0
	for row = 1, 5 do
		for column = 1, 5 do
			if (board [row][column] == num) then
				board [row][column] = true
			elseif (board [row][column] ~= true) then
				left = left + board [row][column]
			end
		end
	end
	return left
end

function checkBoard (board)
	for i = 1, 5 do
		if (board [i] [1] == true and
				board [i] [2] == true and
				board [i] [3] == true and
				board [i] [4] == true and
				board [i] [5] == true) then
			return true
		end
		if (board [1] [i] == true and
				board [2] [i] == true and
				board [3] [i] == true and
				board [4] [i] == true and
				board [5] [i] == true) then
			return true
		end
	end
	return false
end


for call in string.gmatch (callOrder, '(%d+)') do
	call = tonumber (call)
	for _, board in ipairs (boards) do
		local left = markBoard (board, call)
		local win = checkBoard (board)
		if (win) then
			local score = left * call
			print (score) -- 74320
			return
		end
	end
end

