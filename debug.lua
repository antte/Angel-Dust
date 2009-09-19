--Sprint1 unplanned: debug functions

function debugLoad()
	
	debugfont = love.graphics.newFont(love.default_font, 12)
	love.graphics.setFont(debugfont)
	
	
end

function debugDraw()
	
	love.graphics.setColor( 0, 0, 0)
	love.graphics.draw(debugtext, 10, 10)
	
end