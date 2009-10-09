--Sprint1 unplanned: debug functions - Antte
--Sprint2 story "Debug: Enhance debug features" - Chux

function debugLoad()
	
	debugfont = love.graphics.newFont(love.default_font, 10)
	love.graphics.setFont(debugfont)
	debugArray={};
	showDebug=false;
	table.insert(debugArray,"This is the Debugger!");	

end

function debugMsg(text)

	-- Roundfunction thang for time:
	local time = tonumber(string.format("%." .. (2 or 0) .. "f", love.timer.getTime()))


	text = "[" .. time .. "] " .. text;

	table.insert(debugArray,text)
	if(#debugArray>10) then
		table.remove(debugArray,1);
	end

end

function debugDraw()

	if showDebug == true then	
		local text = love.timer.getFPS().."fps\n";

		love.graphics.setColor( 0, 0, 0)

		for i = 1, #debugArray, 1 do
			text = text .. debugArray[i] .. "\n"
			i=i+1
		end


		local x, y = getCamera():unpos(15,15);
		love.graphics.draw(text, x,y);
	end

end

function keypressed(key) 
	if key == love.key_d then 
		showDebug = not showDebug;
	end
	
	if key == love.key_r then
		love.system.restart();
	end 
end 
