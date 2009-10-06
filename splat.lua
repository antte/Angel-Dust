function splatLoad()

	graphic_splat = love.graphics.newImage("images/splat.png");

	psSplat= love.graphics.newParticleSystem(graphic_splat, 1000)
	psSplat:setEmissionRate(70)
	psSplat:setSpeed(40, 100)
	psSplat:setGravity(40, 90)
	psSplat:setSize(0.4, 1)
	psSplat:setColor( love.graphics.newColor(180,0,0,255), love.graphics.newColor(100,0,0,0))
	psSplat:setLifetime(0.4)
	psSplat:setParticleLife(0.7)
	psSplat:setDirection(270)
	psSplat:setSpread(50)
	
	psSplatX = -2000;
	psSplatY = -2000;
	
end

function splatUpdate(dt)
	
	psSplat:update(dt);

end

function splatDraw()
	
	love.graphics.setColorMode(love.color_modulate);

	love.graphics.draw(psSplat, psSplatX,psSplatY)

	love.graphics.setColorMode(love.color_normal);

end

function putSplat(x,y)

	
	psSplat:start();
	psSplatX = x;
	psSplatY = y;

end
