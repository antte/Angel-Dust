love.filesystem.include("camera.lua");

love.filesystem.include("gamesettings.lua");
love.filesystem.include("angel.lua");
love.filesystem.include("landscape.lua");
love.filesystem.include("item.lua");
love.filesystem.include("debug.lua");
love.filesystem.include("collision.lua");
love.filesystem.include("entity.lua");
love.filesystem.include("npc.lua");
love.filesystem.include("splat.lua");

function load()

	getCamera():scaleBy(1.5);
 
	entityLoad();
	debugLoad();
	landscapeLoad();
	angelLoad();
	npcLoad();
	itemLoad();
	splatLoad();

	createTestNPC()
	createTestItems()

	collisionLoad();

	
end

function update(dt)

	cx, cy = characterBody:getWorldCenter();
	cy = cy/2;
	if cy >= (love.graphics.getWindowHeight())/3 then
		cy = (love.graphics.getWindowHeight())/3
	end

	cx = cx - love.graphics.getWindowWidth()/2; 
	if cx <= 0 then
		cx = (love.graphics.getWindowWidth())/2 - (love.graphics.getWindowWidth())/2;
	else
		--cx = cx - love.graphics.getWindowWidth()/2;
	end

	getCamera():setOrigin(cx, cy) -- focus on the player

	landscapeUpdate(dt);
	angelUpdate(dt);
	npcUpdate(dt);
	splatUpdate(dt);
	
end

function draw()

	landscapeDraw();
	angelDraw();
	entityDraw();
	splatDraw();
	debugDraw();

end

camera.lateInit(); 
