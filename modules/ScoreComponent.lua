
local ScoreComponent = display.newGroup()

local score = 0
local urlTextScore = "res/img/score.png"
local urlNumbers = "res/img/numbers.png"

local numbersScore={}


function ScoreComponent:create()
	local score = display.newImageRect(urlTextScore,200,70)
	score:setReferencePoint( display.TopLeftReferencePoint )
	score.x, score.y = 0 , 0

	local options ={width = 33,height = 70,numFrames = 10 }
	local numbersSheet = graphics.newImageSheet( urlNumbers, options )

	local sequenceData = { name="conteo", time=1000, loopCount = 23, count=10, start=1 }

	for i=1,3 do
		number = display.newSprite( numbersSheet, sequenceData )
		number:setReferencePoint( display.TopLeftReferencePoint )
		number.x, number.y = 220 + 34*(i-1) , 0
		table.insert(numbersScore,number)
	end

	ScoreComponent:insert(score)
	for i=1,3 do
		ScoreComponent:insert(numbersScore[i])
	end

end

function ScoreComponent:setScoreValue(score)

	local centenas = score / 100
	centenas = math.floor(centenas)
	local decenas = (score - (centenas*100)) / 10
	decenas = math.floor(decenas)
	local unidades = (score - (decenas*10 ) - (centenas*100)  )

	print("u "..unidades.." d "..decenas.." c "..centenas)
	numbersScore[1]:setFrame( centenas + 1)
	numbersScore[2]:setFrame( decenas + 1)
	numbersScore[3]:setFrame( unidades + 1)
end



return ScoreComponent

