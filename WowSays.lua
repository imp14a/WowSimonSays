


local storyboard = require("storyboard")
local jsonHelper = require( "modules.JSONHelper" )
local scene = storyboard.newScene()

local configButton
local gameButtons = {}
local busyButton

local doActionButton = function(obj)

	busyButton = false
	if obj.name=="config" then
		storyboard.gotoScene( "MainConfiguration", "slideRight", 200 )
	else		
		storyboard.gotoScene( obj.action, "slideLeft", 200 )
	end

end

function animateSimpleButton(event)
	if event.phase=="began" and not busyButton then
		busyButton = true
		transition.from( event.target, { time=100, width=event.target.width*1.3,height=event.target.height*1.3, onComplete=doActionButton } )
	end
end

function scene:createScene( event )
	local group = self.view
	local imgBackground = "res/img/background.png"
	local background = display.newImageRect(imgBackground,768,1024)
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0 , 0
	
	local imgLogo = "res/img/logo.png"
	local logo = display.newImageRect( imgLogo , 600 , 200 )
	logo:setReferencePoint( display.TopLeftReferencePoint )
	logo.x, logo.y = 80 , 50

	local imgConfig="res/img/button/config.png"
	configButton=display.newImageRect(imgConfig,160,160)
	configButton:setReferencePoint( display.TopLeftReferencePoint )
	configButton.x, configButton.y =   580, 840
	configButton:addEventListener('touch',animateSimpleButton)
	configButton.name="config"

	local activities = jsonHelper:decodeFile(  "res/dat/gamemods.json" )

	for i=1,#activities.activities do
		if activities.activities[i].enabled then
			local name = activities.activities[i].name
			local action = activities.activities[i].action
			local urllocation=activities.activities[i].spriteSheetInfo.location
			local w=activities.activities[i].spriteSheetInfo.spriteDimention.width
			local h=activities.activities[i].spriteSheetInfo.spriteDimention.height

			print(name.." "..action.." "..urllocation.." "..w..h)
			if activities.activities[i].spriteSheetInfo.isAnimatedSprite then

			else
				local button=display.newImageRect(urllocation,w,h)
				local x=activities.activities[i].defaultLocation.x
				local y=activities.activities[i].defaultLocation.y
				button.x, button.y = x , y
				button:addEventListener('touch',animateSimpleButton)
				button.name=name
				button.action=action
				table.insert(gameButtons,button)

			end
		end
	
	end
	group:insert(background)
	group:insert(logo)
	group:insert(configButton)

	for i=1,#gameButtons do
		group:insert(gameButtons[i])		
	end

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