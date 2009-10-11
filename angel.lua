-- Sprint 1
-- Story "Basic Character Movement" 
-- and "Basic Character Action: Lift Stuff"
-- and "Game: Damage / Health"
-- and "Flap(improved flying)"
-- and "Stamina"
-- Created by Chux

function angelLoad()

	-- Should "world" be an argument in the function?

	-- Create box2d shape and body for the character
	characterBody = love.physics.newBody(world_layer0, 100, 700)
	--characterShape = love.physics.newRectangleShape(characterBody, 100,190, 20,20)
	characterShape = love.physics.newCircleShape(characterBody, 10);
	characterShape:setData("character");
	characterShape:setCategory(6);

	characterBody:setMassFromShapes( );
	characterBody:setAngularDamping(10000)

	-- Character variables
	characterMaxHitpoints = 100;
	characterHitpoints = 100;
	characterStamina = 100;
	characterMaxStamina = 100;
	characterItemBeingHold = false; -- False if no item, number of the entity if in fact holding one.

	-- Toggles to make an action not repeat over updates. 
	characterFlapped = false; -- Ugly..
	characterItemPickup = false;

	-- Values that should be tweaked
	characterWalkPower = 40000;
	characterFlapPower = 25000; -- How much force a flap gives
	characterFlapStamina = 9; -- How much stamina a flap "cost"
	characterStaminaGain = 28; -- How much stamina is regained per second
	characterGrabTime = 0.5; -- How soon after contact a "grab" must be initiated to succeed
	characterGlide = 25000; -- How much "glide" you get. Higher value = more glide. 

	graphic_angel = love.graphics.newImage("images/angel.png", love.image_optimize);
	graphic_angelFlapped = love.graphics.newImage("images/angelflapped.png", love.image_optimize);

	world_layer0:setCallback(collision);

end

function angelDraw()
	
	cx, cy = characterBody:getWorldCenter();
	if characterFlapped then
		love.graphics.draw(graphic_angelFlapped, cx, cy, 0);
	else	
		love.graphics.draw(graphic_angel, cx, cy, 0);
	end
end

-- This is where the player input "happends"
function angelUpdate(dt)
	-- This is for the "platform-bit"
	o, characterYVelocity = characterBody:getVelocity();
	if characterYVelocity < 0 or love.keyboard.isDown(love.key_down) then
		characterShape:setMask(2);
		if characterItemBeingHold ~= false then
			entityShape[characterItemBeingHold]:setMask(2);
		end
	else
		characterShape:setMask();
		if characterItemBeingHold ~= false then
			entityShape[characterItemBeingHold]:setMask();
		end
	end	

	-- character still "alive"
	if characterHitpoints > 0 then

		-- Walking right and left
		if love.keyboard.isDown(love.key_right) then
			characterBody:applyImpulse( characterWalkPower*dt, 0)
		elseif love.keyboard.isDown(love.key_left) then
			characterBody:applyImpulse( -characterWalkPower*dt, 0)
		end
	
		-- Flying, with stamina
		if love.keyboard.isDown(love.key_up) then
			characterBody:applyForce(0,-characterGlide);		
			if characterFlapped == false then	

				characterFlapped = true;
				
				if characterStamina >= characterFlapStamina then			

					characterBody:applyImpulse( 0, -characterFlapPower)
					characterStamina = characterStamina - characterFlapStamina;				

				else
					debugMsg("Not enough stamina (got "..characterStamina.." need "..characterFlapStamina);
	
				end
			end
		else

			characterFlapped = false;

			if characterStamina < characterMaxStamina then
	
				characterStamina = characterStamina + characterStaminaGain * dt;
			
			end		

		end

		-- Picking stuff up
		if love.keyboard.isDown(love.key_space) then
	
			if characterItemPickup==false then
				
				if characterItemBeingHold == false then -- If an item is NOT being hold...
		
					if distancejoint==nil and lastItem ~= nil then
				
						if love.timer.getTime()-lastItemTime < characterGrabTime then
				
							local id = lastItem;
							characterGrabItem(id);
		
						end
		
					end
				else

					characterReleaseItem();

				end
			end
			characterItemPickup=true;

		else
			characterItemPickup=false;
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

function characterReleaseItem()

	if distancejoint ~= nil then
		
		entityShape[characterItemBeingHold]:setMask();
		grabbedItem=false;
		characterItemBeingHold=false;
		distancejoint:destroy()
		distancejoint=nil;
		distancejoint2:destroy()
		distancejoint2=nil;
	end
	
end

function characterGrabItem(id)

	grabbedItem=getEntityBody(id);					
	characterItemBeingHold=id;
	
	debugMsg("Character grabbed item " .. id);

	-- Can't really explain this... Should be commented
	cx, cy = characterBody:getWorldCenter()
	ix, iy = grabbedItem:getWorldCenter() 

	distancejoint = love.physics.newDistanceJoint(characterBody, entityBody[id], cx-8, cy, ix-8, iy)	
				
	distancejoint:setLength(15);				

	distancejoint:setDamping(0);

	distancejoint2 = love.physics.newDistanceJoint(characterBody, entityBody[id], cx+8, cy, ix+8, iy)	
				
	distancejoint2:setLength(15);

	distancejoint2:setDamping(0);
	

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
	
	-- set lastItem to the data of "b", the key for the specific shape in the itemsShape table.
	if isEntity(b) then
		if getEntityType(b)=="item" then	
			lastItem = b
			lastItemTime = love.timer.getTime()
			getVelocity(c);
		end
	end

end
