love.filesystem.include("angel.lua");
love.filesystem.include("landscape.lua");
love.filesystem.include("item.lua");

function load()

	landscapeLoad();
	angelLoad();
	itemLoad();

end

function update(dt)

	landscapeUpdate(dt);
	angelUpdate(dt);
	
end

function draw()

	landscapeDraw();
	angelDraw();
	itemDraw();

end
