


local storyboard = require("storyboard")
local xml = require( "modules.xml" ).newParser()
local scene = storyboard.newScene()

local configButton
local gameButtons = {}

local endAnimateSimpleButton = function( obj )
	print("llego hasta aka")
	transition.to( obj, { time=150, width=obj.previousW,height= obj.previousH} )
end

function animateSimpleButton(event)
	if event.phase=="began" then
		event.target.previousW=event.target.width
		event.target.previousH=event.target.height
		transition.to( event.target, { time=150, width=event.target.width*1.3,height=event.target.height*1.3, onComplete=endAnimateSimpleButton } )
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
	
	local imgLogo = "res/img/logo.png"
	local logo = display.newImageRect(imgLogo,600,225)
	logo:setReferencePoint( display.TopLeftReferencePoint )
	logo.x, logo.y = 100 , 50

	local imgConfig="res/img/botton/config.png"
	configButton=display.newImageRect(imgConfig,200,200)
	configButton:setReferencePoint( display.TopLeftReferencePoint )
	configButton.x, configButton.y =   590, 800
	configButton:addEventListener('touch',actionButton)

	local activities = xml:loadFile( "res/dat/gamemods.xml" )

	for i=1,#activities.child do
		if activities.child[i].properties['isenable']=="true" then
			local name = activities.child[i].properties['name']
			local action = activities.child[i].properties['actionSceneName']
			local urllocation=activities.child[i].child[1].properties['location']
			local w=activities.child[i].child[1].child[1].properties['width']
			local h=activities.child[i].child[1].child[1].properties['height']

			print(activities.child[i].child[1].properties['usageAnimatedSprite'])
			if activities.child[i].child[1].properties['usageAnimatedSprite']=="true" then

			else
				print("cree el boton")
				local boton=display.newImageRect(urllocation,w,h)

				-- le ponemos una simple animacion de que se agrandesca
				--boton:setReferencePoint( display.TopLeftReferencePoint )
				boton.x, boton.y = 384 , 512
				boton:addEventListener('touch',animateSimpleButton)
				table.insert(gameButtons,boton)

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