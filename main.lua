love.filesystem.include("angel.lua");
love.filesystem.include("landscape.lua");
love.filesystem.include("item.lua");
love.filesystem.include("debug.lua");

debugtext = "ehehe"

function load()
	
	debugLoad();
	landscapeLoad();
	angelLoad();
	itemLoad();
	createTestItems();

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
