


local storyboard = require("storyboard")
local widget = require "widget"
local scene = storyboard.newScene()
-- Variables locales
local pathToConfigFile="res/dat/GameConfig.dat"

local backButton
local sliderMusic
local sliderEfect

--Funciones que podrian ser removidas por cambios de animacion de boton
local doActionButton = function(obj)

	if obj.name=="back" then
		storyboard.gotoScene( "WowSays", "slideLeft", 200 )
	end

end

local endAnimateSimpleButton = function( obj )
	transition.to( obj, { time=100, width=obj.previousW,height= obj.previousH , onComplete=doActionButton } )
end

function animateSimpleButton(event)
	if event.phase=="began" then
		event.target.previousW=event.target.width
		event.target.previousH=event.target.height
		transition.to( event.target, { time=100, width=event.target.width*1.3,height=event.target.height*1.3, onComplete=endAnimateSimpleButton } )
	end
	return true
end

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
function scene:createScene( event )

	local group = self.view
	local imgBackground = "res/img/background.png"
	local background = display.newImageRect(imgBackground,768,1024)
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0 , 0

	local imgTitle = "res/img/txtConfig.png"
	local txtConfig = display.newImageRect(imgTitle,600,150)
	txtConfig:setReferencePoint( display.TopLeftReferencePoint )
	txtConfig.x, txtConfig.y = 80 , 40

	local imgTitle = "res/img/music.png"
	local txtMusic = display.newImageRect(imgTitle,200,100)
	txtMusic:setReferencePoint( display.TopLeftReferencePoint )
	txtMusic.x, txtMusic.y = 80 , 250

	local imgTitle = "res/img/efect.png"
	local txtEfect = display.newImageRect(imgTitle,200,100)
	txtEfect:setReferencePoint( display.TopLeftReferencePoint )
	txtEfect.x, txtEfect.y = 80 , 480

	--sliders
	local opSlider1={ id = "music",left = 120,top = 380,value = 25,listener = sliderCallback,width = 500,height = 30}
	local opSlider2={ id = "efect",left = 120,top = 600,value = 25,listener = sliderCallback,width = 500,height = 30}

	sliderMusic = widget.newSlider(opSlider1)
	sliderEfect = widget.newSlider(opSlider2)

	local imgBack="res/img/button/backconfig.png"
	backButton=display.newImageRect(imgBack,160,160)
	backButton:setReferencePoint( display.TopLeftReferencePoint )
	backButton.x, backButton.y =   580, 840
	backButton:addEventListener('touch',animateSimpleButton)
	backButton.name="back"

	group:insert(background)
	group:insert(txtConfig)
	group:insert(txtMusic)
	group:insert(txtEfect)
	group:insert(sliderMusic)
	group:insert(sliderEfect)
	group:insert(backButton)

end

function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view
end

function scene:destroyScene( event )
	local group = self.view
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene