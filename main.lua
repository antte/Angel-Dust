love.filesystem.include("angel.lua");
love.filesystem.include("landscape.lua");
love.filesystem.include("item.lua");
love.filesystem.include("debug.lua");
love.filesystem.include("collision.lua");
love.filesystem.include("entity.lua");
love.filesystem.include("npc.lua");

function load()
	
	entityLoad();
	debugLoad();
	landscapeLoad();
	angelLoad();
	npcLoad();

	createTestItems()
	createTestNPC()

	collisionLoad();
	
end

function update(dt)

	landscapeUpdate(dt);
	angelUpdate(dt);
	npcUpdate(dt);
	
end

function draw()

	debugDraw();
	landscapeDraw();
	angelDraw();
	entityDraw();

end


