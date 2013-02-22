
local SimonSaysComponent = {}

local colorsNames = {"green", "red", "yellow", "blue"}
local colours = {}
local colorEvent

-- Variables privadas para evitar la propagacion de un evento
local buttonBusy= false


function SimonSaysComponent.create(w,h,coloreEent,playEvent)
	SimonSaysComponent = display.newGroup()
	local indx=1
	local x , y = 0 , 0
	local botonSize = 230
	colorEvent = coloreEent
	local sequenceData = { name = "animation", start = 1, count = 2 }
	local options = { width = 230, height = 230, numFrames = 2 }
	for i = 1,2 do
		for j = 1,2 do
				local img="res/img/activity/"..colorsNames[indx]..".png"

				local sheet = graphics.newImageSheet( img, options )
				local boton = display.newSprite( sheet, sequenceData )
				boton:setReferencePoint( display.TopLeftReferencePoint )
				boton.x, boton.y =   x + ((j-1)*botonSize), y + ((i-1)*botonSize)
				--boton:addEventListener('touch',colorevent)
				boton:addEventListener('touch',animateColor)
				boton.name=colorsNames[indx]
				SimonSaysComponent:insert(boton)
				indx = indx + 1 
		end
	end

	local img="res/img/activity/play.png"
	local botonPlay=display.newImageRect(img,230,230)
	botonPlay.x, botonPlay.y =   centx, centy
	botonPlay:addEventListener('touch',animateComponent)
	botonPlay.name="play"
	botonPlay.x ,botonPlay.y = w/2 , h/2
	SimonSaysComponent:insert(botonPlay)

	return SimonSaysComponent
end

local performAction = function(obj)
	buttonBusy = false
	playEvent()
end

function animateComponent(event)
	if event.phase=="began" then
		if event.target.name=="play" and not buttonBusy then
			buttonBusy = true
			transition.from( event.target, { time=150, width=event.target.width*1.3, height=event.target.height*1.3, onComplete=performAction} ) 
		else 

		end
	end
end

function animateColor(event)
	if event.phase=="began" then
		if event.target.name=="play" and not buttonBusy then
			buttonBusy = true
			transition.from( event.target, { time=150, width=event.target.width*1.3, height=event.target.height*1.3, onComplete=performAction} ) 
		else 

		end
	end
end

return SimonSaysComponent