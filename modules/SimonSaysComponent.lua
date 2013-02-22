
local SimonSaysComponent = {}

local colorsNames = {"green", "red", "yellow", "blue"}
local colours = {}
local colorEvent



function SimonSaysComponent.create(w,h,colorevent)
	SimonSaysComponent = display.newGroup()
	local indx=1
	local x , y = 0 , 0
	local botonSize = 230
	colorEvent=colorevent
	for i = 1,2 do
		for j = 1,2 do
				
				local img="res/img/activity/"..colorsNames[indx]..".png"
				local boton=display.newImageRect(img,botonSize,botonSize)
				boton:setReferencePoint( display.TopLeftReferencePoint )
				boton.x, boton.y =   x + ((j-1)*botonSize), y + ((i-1)*botonSize)
				--boton:addEventListener('touch',colorevent)
				boton:addEventListener('touch',colorEvent)
				boton.name=colorsNames[indx]
				SimonSaysComponent:insert(boton)
				indx = indx + 1 
		end
	end

	local img="res/img/activity/play.png"
	local botonPlay=display.newImageRect(img,250,250)
	botonPlay.x, botonPlay.y =   centx, centy
	botonPlay:addEventListener('touch',animateSimpleButton)
	botonPlay.name="play"
	botonPlay.x ,botonPlay.y = w/2 , h/2
	SimonSaysComponent:insert(botonPlay)

	return SimonSaysComponent
end

local endAnimateSimpleButton = function( obj )
	transition.to( obj, { time=100, width=obj.previousW,height= obj.previousH , onComplete=colorEvent } )
end

function animateSimpleButton(event)
	if event.phase=="began" then
		event.target.previousW=event.target.width
		event.target.previousH=event.target.height
		transition.to( event.target, { time=100, width=event.target.width*1.3,height=event.target.height*1.3, onComplete=endAnimateSimpleButton } )
	end
end

return SimonSaysComponent

