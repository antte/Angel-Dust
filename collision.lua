--Sprint 1: Collition detection w/ velocity check
--author: antte
--två objekt möts, trace:a med vilken kraft de slår mot varandra
-- "Collision Damage"
-- edits by: Chux 

function collisionLoad()
	
	world_layer0:setCallback(collision)
	
end

function checkVelocity(c)
	--[[
	Tar in en collision och skriver ut velocity i debuggen.
	]]--
	
	local vx, vy = c:getVelocity()
	--debugMsg("Velocity: " .. vx .. "," .. vy)
	
	-- Maybe the highest velocity should be returned or something? This'll work for now
	if vy<0 then
		vy = -vy;
	end

	return vy;	
end

function collision(a,b,c)

	aType = getEntityType(a);
	bType = getEntityType(b);


	if isEntity(a) and isEntity(b) then
		aType = getEntityType(a);
		bType = getEntityType(b);

		if (aType=="item" and bType=="npc") then

			npcCollision(b,a,c);

		elseif (aType=="npc" and bType=="item") then

			npcCollision(a,b,c);

		end

	end

	if aType=="npc" and bType == "house" then

			npcCollision(a,b,c);

	elseif aType=="house" and bType == "npc" then

			npcCollision(b,a,c);

	end



	if isEntity(a) then

		aType = getEntityType(a);
		if aType=="item" then

			itemCollision(a,b,c)

		end

	elseif a == "character" then	
	
		angelCollision(a,b,c);

	end

	if isEntity(b) then

		bType = getEntityType(b);
		if bType=="item" then

			itemCollision(b,a,c)

		end

	elseif b == "character" then

		angelCollision(b,a,c);

	end

end
