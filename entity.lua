-- This is used to make distinction between the diffrent bodies in the "world"


function entityLoad() 

	entityId = 0
	entityBody = {}
	entityShape = {}
	entityType = {}

end

function entityDraw()

	for i=1, #entityShape, 1 do
		if entityType[i]=="item" then
			itemDraw(i);
		end
	end

end

-- This function returns which type a body is, by it's id
function checkEntityType(id) 

	return entityType[id];

end

function addEntity(body,shape,inEntityType)

	entityId = entityId + 1;
	table.insert( entityBody, body)
	table.insert( entityShape, shape)
	table.insert( entityType, inEntityType)
	
	return entityId;

end

function idOfLastCreatedEntity()
	
	return entityId;

end
