
local numberComponent = require ("modules.NumberComponent")

local TimerComponent = {}

local urlSeparator = "res/img/timer_separator.png"

local min 
local sec 

function TimerComponent.create(m,s,timeOverFunction)

	min = m
	sec = s

	TimerComponent = display.newGroup()

	local minutes = numberComponent.create(2)
	minutes.x,minutes.y = 0 , 0
	if min then numberComponent.setValue(minutes,min) end

	local urlTextTime = "res/img/time_separator.png"
	local timeTxt = display.newImageRect(urlTextTime,18,70)
	timeTxt:setReferencePoint( display.TopLeftReferencePoint )
	timeTxt.x,timeTxt.y = minutes.width + 10 , 0

	local seconds = numberComponent.create(2)
	seconds.x,timeTxt.y = minutes.width + timeTxt.width + 10 , 0
	if sec then numberComponent.setValue(seconds,sec) end

	TimerComponent:insert(minutes)
	TimerComponent:insert(timeTxt)
	TimerComponent:insert(seconds)

	timer.performWithDelay(1000,advanceSecond)

	return TimerComponent
end

function advanceSecond()
	if not min then min = 0 end
	if not sec then sec = 1 end

	numberComponent.setValue(TimerComponent[3],sec)
	sec = sec + 1
	min = min + 1
	timer.performWithDelay(1000,advanceSecond)
end


return TimerComponent

