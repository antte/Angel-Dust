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

	landscapeUpdate(dt);
	angelUpdate(dt);
	npcUpdate(dt);
	splatUpdate(dt);
	
end

function draw()

	debugDraw();
	landscapeDraw();
	angelDraw();
	entityDraw();
	splatDraw();

end


