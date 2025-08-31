local PrintQueue = {}
local Queue = {}
local IsProcessing = false
local DefaultDelay = 0.1

local function ProcessQueue()
	if IsProcessing then return end
	IsProcessing = true

	while #Queue > 0 do
		local Item = table.remove(Queue, 1)
		local Delay = Item.Delay or DefaultDelay
		Item.Func(Item.Msg)
		task.wait(Delay)
	end

	IsProcessing = false
end

function PrintQueue.Print(Msg, Delay)
	table.insert(Queue, {Msg = Msg, Delay = Delay, Func = print})
	task.spawn(ProcessQueue)
end

function PrintQueue.Printconsole(Msg, Delay)
	table.insert(Queue, {Msg = Msg, Delay = Delay, Func = printconsole})
	task.spawn(ProcessQueue)
end

return PrintQueue
