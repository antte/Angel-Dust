-- Sprint 2 
-- Story "NPC: Basic Functions" 
-- Created by Chux

function npcLoad()

	npcWalkingDirection = {}

end

function npcUpdate(dt)

	for i=1, #entityShape, 1 do

		if entityType[i]=="npc" then
			vx, vy = entityBody[i]:getVelocity();
			angle = entityBody[i]:getAngle();
			if angle < 1 and angle > -1 then
				if npcWalkingDirection[i] == "right" then
					entityBody[i]:applyImpulse(3000,0);
				elseif npcWalkingDirection[i] == "left" then
					entityBody[i]:applyImpulse(-3000,0);
				end
			end

		end

	end	

end


-- x and y sets position, 
-- width and height the size of the item
-- hp the "hitpoints"(health) it got
function createNPC(x, y, hp)

	npcBody = love.physics.newBody( world_layer0, x, y );
	npcShape = love.physics.newRectangleShape(npcBody, 15, 20)
	npcBody:setMassFromShapes();

	npcShape:setFriction(0);

	addEntity(npcBody,npcShape,"npc", hp);
	local npcId = idOfLastCreatedEntity();	
	npcShape:setData(npcId);

	table.insert(npcWalkingDirection, npcId, "right");

end

function npcDraw(i) 
	
		-- Draws the "boxcolored filling"
		if entityHitpoints[i] == false then
			love.graphics.setColor( 200, 0, 0);
		else 
			love.graphics.setColor( 200, 200, 0);
		end
		
		love.graphics.polygon(love.draw_fill, entityShape[i]:getPoints())

		-- Draws a border for the "filling"
		love.graphics.setColor( 0, 0, 0);
		love.graphics.polygon(love.draw_line, entityShape[i]:getPoints())

		love.graphics.setColor( 0, 0, 0)
		love.graphics.draw(i, entityBody[i]:getX(), entityBody[i]:getY());
	
end

function npcReceiveDmg(npcId, dmg)

	if entityHitpoints[npcId] then	
		
		entityHitpoints[npcId] = entityHitpoints[npcId] - dmg;

		if entityHitpoints[npcId] <= 0 then

			debugMsg("NPC"..npcId.." destroyed!");

			-- entityHitpoints is set to false!!! THIS NEED TO BE KNOWN!!! Bad solution perhaps?
			entityHitpoints[npcId] = false;
	
		end

	end

end

function createTestNPC()  -- used for testing purposes only
	math.randomseed(os.time());	
	local i=0;
	while i<1 do
		createNPC(250+100*i,700,70);
		i=i+1;
	end

end


function npcCollision(a,b,c)

	-- This function is only called upon if a is an NPC
	if getEntityType(b) == "item" then
		v = checkVelocity(c);
		b = tonumber(b);
		power = math.floor(((entityBody[b]:getMass()/2) * v)/1000)
		if power >= 9 then	
		
			npcReceiveDmg(a,power);

		end
	elseif b == "house" then
		if npcWalkingDirection[a]=="left" then
			npcWalkingDirection[a]="right"
			entityBody[a]:applyImpulse(-300000,0);
			debugMsg("turn right");
		else
			debugMsg("turn left");
			entityBody[a]:applyImpulse(300000,0);
			npcWalkingDirection[a]="left"
		end

	end	
end
