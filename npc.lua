-- Sprint 2 
-- Story "NPC: Basic Functions" 
-- Created by Chux

function npcLoad()

	graphic_npcLeft = love.graphics.newImage("images/npcLeft.png", love.image_optimize);
	graphic_npcRight = love.graphics.newImage("images/npcRight.png", love.image_optimize);

	npcWalkingDirection = {}
	npcWalkingWait = {}

	-- Tweakable values
	constNpcWalkingWait = 50; -- How long after collision with something direction is reversed and walking starts( not actuallty true though)
	constNpcMaxWalkSpeed = 50; -- At what speed the npc's speed should be capped
	constNpcMinWalkSpeed = 30; -- If the npc doesnt reach this speed - it turns around

	constNpcDmgAbsorb = 15; -- If damage dealt doesnt reach this minimum - no hitpoints are lost

end

function npcUpdate(dt)

	for i=1, #entityShape, 1 do

		if entityType[i]=="npc" and entityHitpoints[i] then


			-- The walking direction stuff
			vx, vy = entityBody[i]:getVelocity();
			angle = entityBody[i]:getAngle();

			if vx < constNpcMinWalkSpeed and vx > -constNpcMinWalkSpeed and npcWalkingWait[i] < 1 then
				npcWalkingWait[i] = constNpcWalkingWait;
				if npcWalkingDirection[i]=="left" then
					npcWalkingDirection[i]="right"
				else
					npcWalkingDirection[i]="left"
				end
			end

			-- The actual "walking"
			if angle < 1 and angle > -1 and vx < constNpcMaxWalkSpeed and vx > -constNpcMaxWalkSpeed then
				if npcWalkingDirection[i] == "right" then
					entityBody[i]:applyImpulse(50000*dt,0);
				elseif npcWalkingDirection[i] == "left" then
					entityBody[i]:applyImpulse(-50000*dt,0);
				end
			end
			npcWalkingWait[i] = npcWalkingWait[i] - 1


		end

	end	

end


-- x and y sets position, 
-- width and height the size of the item
-- hp the "hitpoints"(health) it got
function createNPC(x, y, hp)

	npcBody = love.physics.newBody( world_layer0, x, y);
	npcShape = love.physics.newRectangleShape(npcBody, 12, 18)
	npcBody:setMassFromShapes();
	nx,ny=npcBody:getWorldPoint(10,10); -- The mass it gets is probably too much

	npcShape:setCategory(5);
	npcShape:setMask(5);


	addEntity(npcBody,npcShape,"npc", hp);
	local npcId = idOfLastCreatedEntity();	
	npcShape:setData(npcId);

	if math.random(2)== 1 then
		startDirection="right";
	else
		startDirection="left";
	end

	table.insert(npcWalkingDirection, npcId, startDirection);
	table.insert(npcWalkingWait, npcId, 0);

end

function npcDraw(i) 
	if npcWalkingDirection[i] == "left" then
		love.graphics.draw(graphic_npcLeft, entityBody[i]:getX(),entityBody[i]:getY(),entityBody[i]:getAngle());
	elseif npcWalkingDirection[i] == "right" then

		love.graphics.draw(graphic_npcRight, entityBody[i]:getX(),entityBody[i]:getY(),entityBody[i]:getAngle());
	end

end

function npcReceiveDmg(npcId, dmg)

	if dmg >= constNpcDmgAbsorb then

		if entityHitpoints[npcId] then	
		
			entityHitpoints[npcId] = entityHitpoints[npcId] - dmg;
			debugMsg("npc lost "..dmg.."hp");
			if entityHitpoints[npcId] <= 0 then
	
				debugMsg("NPC"..npcId.." destroyed!");

				putSplat(entityBody[npcId]:getX(), entityBody[npcId]:getY())

				-- entityHitpoints is set to false!!! THIS NEED TO BE KNOWN!!! Bad solution perhaps?
				entityHitpoints[npcId] = false;
	
			end

		end
	else
		debugMsg("npc, Damaga abosorbed");
	end

end

function createTestNPC()  -- used for testing purposes only
	math.randomseed(os.time());	
	local i=0;
	while i<2 do
		createNPC(300+100*i,700,40);
		i=i+1;
	end

end


function npcCollision(a,b,c)

	-- This function is only called upon if a is an NPC
	if getEntityType(b) == "item" then
		v = checkVelocity(c);
		b = tonumber(b);
		power = math.floor(((entityBody[b]:getMass()/2) * v)/1000)
		if power > constGamePowerAbsorb then	
		
			npcReceiveDmg(a,power);

		end
	end	

end
