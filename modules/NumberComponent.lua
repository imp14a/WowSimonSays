
local NumberComponent = {}

local value = 0
local urlNumbers = "res/img/numbers.png"
local numDigits


function NumberComponent.create(_numDigits)
	NumberComponent = display.newGroup()
	numDigits=_numDigits

	local options ={width = 33,height = 70,numFrames = 10 }
	local numbersSheet = graphics.newImageSheet( urlNumbers, options )
	local sequenceData = { name="conteo", time=1000, loopCount = 23, count=10, start=1 }
	for i=1,numDigits do
		number = display.newSprite( numbersSheet, sequenceData )
		number:setReferencePoint( display.TopLeftReferencePoint )
		number.x, number.y = 34*(i-1) , 0
		NumberComponent:insert(number)
	end

	return NumberComponent

end

function NumberComponent.setValue(numberComponent,value)

	if value >= math.pow(10,numDigits) or value < 0 then return end   

	local i=numDigits - 1
	local res = value
	local j = 1
	while i>=0 do
		local exp = math.pow(10,i)
		unidad = res / exp
		unidad = math.floor(unidad)
		res = res - (unidad * exp)
		numberComponent[j]:setFrame(unidad+1)
		j = j + 1
		i = i - 1
	end
end



return NumberComponent

