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

	getCamera():scaleBy(1);
 
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

	-- This should probably be placed somewhere else...
	cx, cy = characterBody:getPosition();
	cy = cy - love.graphics.getWindowHeight()/2;

	if cy > 0 then
		cy = 0
	elseif cy < -1000 then
		cy = -1000;
	end

	cx = cx - love.graphics.getWindowWidth()/2; 
	if cx < 0 then
		cx = 0
	elseif cx > 6980 then
		cx = 6980
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
