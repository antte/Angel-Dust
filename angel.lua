-- Sprint 1
-- Story "Basic Character Movement" and "Basic Character Action: Lift Stuff"
-- Created by Chux

function angelLoad()
	-- Should "world" be an argument in the function?

	-- Create box2d shape and body for the character
	characterBody = love.physics.newBody(world_layer0, 400, 200)
	characterShape = love.physics.newRectangleShape(characterBody, 100,190, 20,20)
	characterShape:setData("character");
	characterBody:setMassFromShapes( );
	characterBody:setAngularDamping(10000)

	world_layer0:setCallback(collision);

end

function angelDraw()
	
	-- Set nice color for the character, for testing purpose
	love.graphics.setColor( 0, 0, 0);
	love.graphics.polygon(love.draw_fill, characterShape:getPoints());

end

-- This is where the player input "happends"
function angelUpdate(dt_angel)

	-- Walking right and left
	if love.keyboard.isDown(love.key_right) then
		characterBody:applyImpulse( 800, 0)
	elseif love.keyboard.isDown(love.key_left) then
		characterBody:applyImpulse( -800, 0)
	end

	-- Flying
	if love.keyboard.isDown(love.key_up) then
		characterBody:applyImpulse( 0, -3000)
	end

	-- Picking stuff up
	if love.keyboard.isDown(love.key_space) then
		
		if distancejoint==nil and lastItem ~= nil then
			
			if love.timer.getTime()-lastItemTime<0.5 then
			
				local id = lastItem;
		
				-- Can't really explain this... Should be commented
				cx, cy = characterBody:getWorldCenter()
				ix, iy = itemsBody[id]:getWorldCenter() 

				distancejoint = love.physics.newDistanceJoint(characterBody, itemsBody[id], cx, cy, ix, iy)	
				
				distancejoint:setLength(25);	
			
			end
		
		end
	
	end

	-- Dropping stuff
	if love.keyboard.isDown(love.key_d) then
		if distancejoint ~= nil then
			distancejoint:destroy()
			distancejoint=nil
		end
	end

end

function collision(a, b, c) 
	
	if a == "character" then
		-- set lastItem to the data of "b", the key for the specific shape in the itemsShape table.
		
		debugtext = b  
		lastItem = b
		lastItemTime = love.timer.getTime()
	end

end
