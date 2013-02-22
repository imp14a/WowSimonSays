


local storyboard = require("storyboard")
local numberComponent = require ("modules.NumberComponent")
local timerComponent = require ("modules.TimerComponent")
local simonSaysComponent = require ("modules.simonSaysComponent")
local scene = storyboard.newScene()


local backButton
local timerPanel
local scorePanel
local simonSaysPanel

local score = 0

local doActionButton = function(obj)
	if obj.name=="back" then
		storyboard.gotoScene( "WowSays", "slideRight", 500 )
	elseif obj.name=="play" then
		score = score + 5
		--scorePanel:setScoreValue(score)
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
	if event.phase=="began" then
		print("tocoBotonColor")
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

	local urlTextScore = "res/img/score.png"
	local scoreTxt = display.newImageRect(urlTextScore,200,70)
	scoreTxt:setReferencePoint( display.TopLeftReferencePoint )
	scoreTxt.x, scoreTxt.y = 30 , 930

	scorePanel = numberComponent.create(3)
	numberComponent.setValue(scorePanel,153)
	scorePanel.x,scorePanel.y =230, 930
	print(scorePanel)
	--scorePanel:setValue(50)
	
	local urlTextTime = "res/img/time.png"
	local timeTxt = display.newImageRect(urlTextTime,170,70)
	timeTxt:setReferencePoint( display.TopLeftReferencePoint )
	timeTxt.x, timeTxt.y = 400 , 930

	timerPanel = timerComponent.create(5)
	timerPanel.x, timerPanel.y = 590 , 930

	simonSaysPanel = simonSaysComponent.create(460,460, actionButton)
	simonSaysPanel.x,simonSaysPanel.y =154 , 282

	group:insert(background)
	group:insert(logo)
	group:insert(backButton)
	group:insert(scoreTxt)
	group:insert(scorePanel)
	group:insert(timeTxt)
	group:insert(timerPanel)
	group:insert(simonSaysPanel)

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