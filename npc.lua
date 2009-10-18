-- Sprint 2 
-- Story "NPC: Basic Functions" 
-- Created by Chux

function npcLoad()

	graphic_npc = love.graphics.newImage("images/npc/npc.png", love.image_optimize);
	graphic_npcDead = love.graphics.newImage("images/npc/npcdead.png", love.image_optimize);

	npcWalkingDirection = {}
	npcWalkingWait = {}
	npcRiseWait = {}
	npcLifted = {}

	-- Tweakable values
	constNpcWalkingWait = 60; -- How long after collision with something direction is reversed and walking starts( not actuallty true though)
	constNpcMaxWalkSpeed = 50; -- At what speed the npc's speed should be capped
	constNpcMinWalkSpeed = 20; -- If the npc doesnt reach this speed - it turns around
	constNpcRiseWait = 3; -- When NPC has fallen - how long in seconds should he lie before he rises
	constNpcDmgAbsorb = 15; -- If damage dealt doesnt reach this minimum - no hitpoints are lost

end

function npcUpdate(dt)

	for i=1, #entityShape, 1 do

		if entityType[i]=="npc" and entityHitpoints[i] then

			angle = entityBody[i]:getAngle();
			vx, vy = entityBody[i]:getVelocity();

			-- Only do stuff if the npc is not lifted!
			if  npcLifted[i] == false then
					  -- Is the npc standing up?
					  if angle < 3 and angle > -3 then

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
								  entityBody[i]:applyImpulse(2000,0);
							  elseif npcWalkingDirection[i] == "left" then
								  entityBody[i]:applyImpulse(-2000,0);
							  end
						  end
						  npcWalkingWait[i] = npcWalkingWait[i] - 1;

					  else
						  v=vx+vy;
						  if v < 5 and v > -5 and (angle < -30 or angle > 30) then
							  -- NPC is lying, he should rise!
							  if npcRiseWait[i] < 0 then
								  entityBody[i]:setAngle(0);
								  npcRiseWait[i] = constNpcRiseWait;
							  else
								  npcRiseWait[i] = npcRiseWait[i] - 1*dt;
							  end

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

	npcBody = love.physics.newBody( world_layer0, x, y, 400);
	npcShape = love.physics.newRectangleShape(npcBody, 20, 48)
	--npcBody:setMassFromShapes();
	nx,ny=npcBody:getWorldPoint(10,10); -- The mass it gets is probably too much

	npcShape:setCategory(5);
	npcShape:setMask(5);
	npcBody:setAngularDamping(5);
	npcShape:setFriction(0.4);

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
	table.insert(npcLifted, false);

end

function npcDraw(i) 

	if entityHitpoints[i] then
			love.graphics.draw(graphic_npc, entityBody[i]:getX(),entityBody[i]:getY(),entityBody[i]:getAngle());
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
				
				entityShape[npcId]:setMask(4,5);
				putSplat(entityBody[npcId]:getX(), entityBody[npcId]:getY())
				entityHitpoints[npcId] = false;
	
			end

		end
	end

end

function createTestNPC()  -- used for testing purposes only
	math.randomseed(os.time());	
	local i=0;
	while i<30 do
		createNPC(math.random(0,8000),600,40);
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

	if b == "ground" then
		v = getVelocity(c);
		-- This is not okay. Ugly solution.
		if v  > 250 then	
			npcReceiveDmg(a,100);

		end
	end

end
