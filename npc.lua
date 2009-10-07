-- Sprint 2 
-- Story "NPC: Basic Functions" 
-- Created by Chux

function npcLoad()

	graphic_npcLeft = love.graphics.newImage("images/npcLeft.png", love.image_optimize);
	graphic_npcRight = love.graphics.newImage("images/npcRight.png", love.image_optimize);
	graphic_npcDead = love.graphics.newImage("images/npcDead.png", love.image_optimize);

	npcWalkingDirection = {}
	npcWalkingWait = {}
	npcRiseWait = {}

	-- Tweakable values
	constNpcWalkingWait = 60; -- How long after collision with something direction is reversed and walking starts( not actuallty true though)
	constNpcMaxWalkSpeed = 50; -- At what speed the npc's speed should be capped
	constNpcMinWalkSpeed = 25; -- If the npc doesnt reach this speed - it turns around
	constNpcRiseWait = 100; -- When NPC has fallen - how long should he lie before he rises
	constNpcDmgAbsorb = 15; -- If damage dealt doesnt reach this minimum - no hitpoints are lost

end

function npcUpdate(dt)

	for i=1, #entityShape, 1 do

		if entityType[i]=="npc" and entityHitpoints[i] then

			angle = entityBody[i]:getAngle();
			vx, vy = entityBody[i]:getVelocity();

			-- Is the npc standing up?
			if angle < 1 and angle > -1 then

				if vx < constNpcMinWalkSpeed and vx > -constNpcMinWalkSpeed and npcWalkingWait[i] < 1 then
					npcWalkingWait[i] = constNpcWalkingWait;
					if npcWalkingDirection[i]=="left" then
						npcWalkingDirection[i]="right"
					else
						npcWalkingDirection[i]="left"
					end
				end

				-- The actual "walking"
				if vx < constNpcMaxWalkSpeed and vx > -constNpcMaxWalkSpeed then
					if npcWalkingDirection[i] == "right" then
						entityBody[i]:applyImpulse(40000*dt,0);
					elseif npcWalkingDirection[i] == "left" then
						entityBody[i]:applyImpulse(-40000*dt,0);
					end
				end
				npcWalkingWait[i] = npcWalkingWait[i] - 1;

			else
				v=vx+vy;
				if v < 5 and v > -5 and (angle < -30 or angle > 30) then
					-- NPC is lying, he should rise!
					if npcRiseWait[i] == 0 then
						entityBody[i]:setAngle(0);
						npcRiseWait[i] = constNpcRiseWait;
					else
						npcRiseWait[i] = npcRiseWait[i] - 1;
					end

				end
			end

		end

	end	

end


-- x and y sets position, 
-- width and height the size of the item
-- hp the "hitpoints"(health) it got
function createNPC(x, y, hp)

	npcBody = love.physics.newBody( world_layer0, x, y);
	npcShape = love.physics.newRectangleShape(npcBody, 10, 18)
	npcBody:setMassFromShapes();
	nx,ny=npcBody:getWorldPoint(10,10); -- The mass it gets is probably too much

	npcShape:setCategory(5);
	npcShape:setMask(5);
	npcBody:setAngularDamping(10);

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
	table.insert(npcRiseWait, npcId, constNpcRiseWait);


end

function npcDraw(i) 

	if entityHitpoints[i] then
		if npcWalkingDirection[i] == "left" then
			love.graphics.draw(graphic_npcLeft, entityBody[i]:getX(),entityBody[i]:getY(),entityBody[i]:getAngle());
		elseif npcWalkingDirection[i] == "right" then

			love.graphics.draw(graphic_npcRight, entityBody[i]:getX(),entityBody[i]:getY(),entityBody[i]:getAngle());
		end
	else
		love.graphics.draw(graphic_npcDead, entityBody[i]:getX(),entityBody[i]:getY(),entityBody[i]:getAngle());
	end

end

function npcReceiveDmg(npcId, dmg)

	if dmg >= constNpcDmgAbsorb then

		if entityHitpoints[npcId] then	
		
			entityHitpoints[npcId] = entityHitpoints[npcId] - dmg;
			debugMsg("npc lost "..dmg.."hp");
			if entityHitpoints[npcId] <= 0 then
	
				debugMsg("NPC"..npcId.." destroyed!");
				
				entityBody[npcId]:setSpin(1000);
				entityShape[npcId]:setMask(4,5);

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
	while i<10 do
		createNPC(math.random(0,1000),700,40);
		i=i+1;
	end

end


function npcCollision(a,b,c)

	-- This function is only called upon if a is an NPC
	if getEntityType(b) == "item" then
		v = getVelocity(c);
		b = tonumber(b);
		power = getPower(v,entityBody[b]:getMass()); 
		if power > constGamePowerAbsorb then	
		
			npcReceiveDmg(a,power);

		end
	end	

end
