--Sprint 1: Collition detection w/ velocity check
--author: antte
--två objekt möts, trace:a med vilken kraft de slår mot varandra

function collisionLoad()
	
	world_layer0:setCallback(collision)
	
end

function checkVelocity(c)
	--[[
	Tar in en collision och skriver ut velocity i debuggen.
	]]--
	
	local vx, vy = c:getVelocity()
	debugMsg("Velocity: " .. vx .. "," .. vy)
	
end
