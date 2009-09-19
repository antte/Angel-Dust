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
	
	if love.keyboard.isDown(love.key_right) then
		characterBody:applyImpulse( 800, 0)
	elseif love.keyboard.isDown(love.key_left) then
		characterBody:applyImpulse( -800, 0)
	end
	
	if love.keyboard.isDown(love.key_up) then
		characterBody:applyImpulse( 0, -3000)
	end
	
end

function collision(a, b, c) 
     
--	if

end

