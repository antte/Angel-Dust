love.filesystem.include("angel.lua");
love.filesystem.include("landscape.lua");
love.filesystem.include("item.lua");
love.filesystem.include("debug.lua");
love.filesystem.include("collision.lua");
love.filesystem.include("entity.lua");

function load()
	
	entityLoad();
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
	entityDraw();
	--itemDraw(); is now in entity

end

function collision(a,b,c)

	angelCollision(a,b,c);
	itemCollision(a,b,c);

end
