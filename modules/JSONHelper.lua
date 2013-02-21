
local json=require "json"

local JSONHelper={}

function JSONHelper:decodeFile( filename , base)
-- set default base dir if none specified

	if not base then base = system.ResourceDirectory; end
	-- create a file path for corona i/o
	--print(filename.." ".. base)
	local path = system.pathForFile( filename )
	
	-- will hold contents of file
	local contents
	-- io.open opens a file at path. returns nil if no file found
	local file = io.open( path, "r" )
	print(path)
	print(filename)
	if file then
	   -- read all contents of file into a string
	   contents = file:read( "*a" )
	   io.close( file )	-- close the file after using it
	end

	return json.decode( contents )
end

return JSONHelper