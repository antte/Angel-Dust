love.filesystem.include("angel.lua");
love.filesystem.include("landscape.lua");
love.filesystem.include("item.lua");
love.filesystem.include("debug.lua");
love.filesystem.include("collision.lua");

debugtext = "!debugtext!"

function load()
	
	debugLoad();
	landscapeLoad();
	angelLoad();
	itemLoad();
	createTestItems();
	collisionLoad();
	
end

function update(dt)

	landscapeUpdate(dt);
	angelUpdate(dt);
	
end

function draw()

	debugDraw();
	landscapeDraw();
	angelDraw();
	itemDraw();

end