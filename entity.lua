-- This is used to make distinction between the diffrent bodies in the "world"

function entityLoad() 

	entityId = 0
	entityBody = {}
	entityShape = {}
	entityType = {}
	entityHitpoints = {}

end

function entityDraw()

	for i=1, #entityShape, 1 do
		if entityType[i]=="item" then
			itemDraw(i);
		elseif entityType[i]=="npc" then
			npcDraw(i);
		end	
	end

end

-- This function returns which type a body is, by it's id
-- if not an entity, return name of it anyway
function getEntityType(id) 

	if tonumber(id) then	
		return entityType[id];
	else
		return id;
	end

end

function isEntity(name)

	if tonumber(name) == nil then
		return false;
	else
		return true;
	end

end

function addEntity(body,shape,inEntityType, inHp)

	entityId = entityId + 1;
	table.insert( entityBody, body)
	table.insert( entityShape, shape)
	table.insert( entityType, inEntityType)
	table.insert( entityHitpoints, inHp);
	
	return entityId;

end

function idOfLastCreatedEntity()
	
	return entityId;

end

function getEntityBody(id)

	id = tonumber(id);
	return entityBody[id];

end
