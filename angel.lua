-- Sprint 1
-- Story "Basic Character Movement" 
-- and "Basic Character Action: Lift Stuff"
-- and "Game: Damage / Health"
-- Created by Chux

function angelLoad()
	-- Should "world" be an argument in the function?

	-- Create box2d shape and body for the character
	characterBody = love.physics.newBody(world_layer0, 400, 200)
	characterShape = love.physics.newRectangleShape(characterBody, 100,190, 20,20)
	characterShape:setData("character");
	characterBody:setMassFromShapes( );
	characterBody:setAngularDamping(10000)

	-- Character variables
	characterMaxHitpoints = 100;
	characterHitpoints = 100;

	world_layer0:setCallback(collision);

end

function angelDraw()
	
	-- Set nice color for the character, for testing purpose
	love.graphics.setColor( 0, 0, 0);
	love.graphics.polygon(love.draw_fill, characterShape:getPoints());

end

-- This is where the player input "happends"
function angelUpdate(dt_angel)

	-- character still "alive"
	if characterHitpoints > 0 then

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
	
					debugMsg("Character grabbed item " .. id);

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

				debugMsg("Character released item");
				distancejoint:destroy()
				distancejoint=nil

			end
		end
	else 
		debugMsg("Character is dead");
		----
		-- Character is "dead"
		----
		-- It should'nt really be destroyed right? Now it's just imobolized
		--characterBody:destroy();
		--characterShape:destroy();
	end

end

function angelReceiveDmg(dmg) 

	characterHitpoints = characterHitpoints - dmg;

end

function angelRegainHp(hp)

	characterHitpoints = characterHitpoints + hp;
	
	if characterHitpoints > characterMaxHitpoints then
		characterHitpoints = characterMaxHitpoints;
	end

end

function angelCollision(a, b, c) 
	
	if a == "character" then
		-- set lastItem to the data of "b", the key for the specific shape in the itemsShape table.
		
		debugMsg("Character collided with item "..b);
		lastItem = b
		lastItemTime = love.timer.getTime()
	end

end
