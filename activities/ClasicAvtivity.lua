


local storyboard = require("storyboard")
local scene = storyboard.newScene()

local backButton

local scorePanel = require ("modules.ScoreComponent")
local score = 0

local doActionButton = function(obj)

	if obj.name=="back" then
		storyboard.gotoScene( "WowSays", "slideRight", 200 )
	elseif obj.name=="play" then
		score = score + 5
		scorePanel:setScoreValue(score)
	end

end

local endAnimateSimpleButton = function( obj )
	transition.to( obj, { time=100, width = obj.previousW,height = obj.previousH , onComplete=doActionButton } )
end

function animateSimpleButton(event)
	if event.phase=="began" then
		event.target.previousW=event.target.width
		event.target.previousH=event.target.height
		transition.to( event.target, { time=100, width=event.target.width*1.3,height=event.target.height*1.3, onComplete=endAnimateSimpleButton } )
	end
end

function actionButton(event)
	local button = event.target

	if button==configButton then

	end

end

function scene:createScene( event )
	local group = self.view
	local imgBackground = "res/img/background.png"
	local background = display.newImageRect(imgBackground,768,1024)
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0 , 0
	
	local imgLogo = "res/img/hackertitle.png"
	local logo = display.newImageRect(imgLogo,500,150)
	logo.x, logo.y = 384 , 100

	local img="res/img/button/back.png"
	backButton=display.newImageRect(img,80,80)
	backButton:setReferencePoint( display.TopLeftReferencePoint )
	backButton.x, backButton.y =   10, 10
	backButton:addEventListener('touch',animateSimpleButton)
	backButton.name="back"

	scorePanel.create()
	scorePanel.x,scorePanel.y =30, 930

	group:insert(background)
	group:insert(logo)
	group:insert(backButton)
	group:insert(scorePanel)

	-- Estos bototnes se agregaran dinamicamente
	group:insert(botonGren)
	group:insert(botonRed)
	group:insert(botonYellow)
	group:insert(botonBlue)
	group:insert(botonPlay)

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