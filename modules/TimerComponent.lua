
local numberComponent = require ("modules.NumberComponent")

local TimerComponent = {}

local urlSeparator = "res/img/timer_separator.png"

local min 
local sec
local mod
local timeOverFunction

function TimerComponent.create(m,s,mode,_timeOverFunction)

	min = m
	sec = s
	mod =  mode
	timeOverFunction = _timeOverFunction

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
	if not sec then sec = 0 end
	
	if mod=="dec" then
		sec = sec - 1
		if sec < 0 then 
			min = min - 1
			sec = 59
		end
		if sec==0 and min ==0 then
			numberComponent.setValue(TimerComponent[3],sec)
			numberComponent.setValue(TimerComponent[1],min)
			timer.performWithDelay(1000,timeOverFunction)
			return
		end
	else
		sec = sec + 1
		if sec == 60 then 
			min = min + 1
			sec = 0
		end
	end

	numberComponent.setValue(TimerComponent[3],sec)
	numberComponent.setValue(TimerComponent[1],min)
	timer.performWithDelay(1000,advanceSecond)
end


return TimerComponent

