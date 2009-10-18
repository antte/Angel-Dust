function splatLoad()

	graphic_splat = love.graphics.newImage("images/splat.png");

	splatTable = {};
	
end

function splatUpdate(dt)
	for i=1, #splatTable, 1 do
		splatTable[i]:update(dt);
	end

end

function splatDraw()

	for i=1, #splatTable, 1 do
		debugMsg("splat"..i.."draw at "..splatTable[i]:getX() );
		love.graphics.setColorMode(love.color_modulate);
		love.graphics.draw(splatTable[i], splatTable[i]:getX(), splatTable[i]:getY())
		love.graphics.setColorMode(love.color_normal);

	end

end

function putSplat(x,y)
	local psSplat = love.graphics.newParticleSystem(graphic_splat, 1000)
	psSplat:setEmissionRate(70)
	psSplat:setSpeed(40, 100)
	psSplat:setGravity(40, 90)
	psSplat:setSize(0.4, 1)
	psSplat:setColor( love.graphics.newColor(180,0,0,255), love.graphics.newColor(100,0,0,0))
	psSplat:setLifetime(2.4)
	psSplat:setParticleLife(0.7)
	psSplat:setDirection(270)
	psSplat:setSpread(50)
	
	psSplat:start();
	psSplat:setPosition(600,600);

	table.insert(splatTable, psSplat);

end
