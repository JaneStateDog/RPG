//Define entity x and it's destination
entityX = 0;
destinationEntityX = 130;


//Define member entities
globalvar memberEntities;
memberEntities = [];

//Function to place a member in the room
function place_member(ID) {
	//Create member
	var member = instance_create_layer(0, 0, "BottomEntities", oEntity);
	
	//Set their image_xscale
	member.image_xscale = -1;
	
	//Set their type and data
	member.type = entityType.member;
	member.ID = ID;
	
	//Put the member in the member entities array
	memberEntities[array_length(memberEntities)] = member;
}

//Place the party member entities in the room
for (i = 0; i < array_length(party); i++) place_member(i);


//Define monster entities
globalvar monsterEntities;
monsterEntities = [];

//Function to place monster in the room
function place_monster(ID) {
	//Create monster
	var mob = instance_create_layer(0, 0, "BottomEntities", oEntity);
	
	//Set their type and data
	mob.type = entityType.monster;
	mob.ID = ID;
	
	//Add the monster into the monster entities array
	monsterEntities[i] = mob;
}

//Place the monster entities in the room
for (i = 0; i < array_length(queuedMonsters); i++) place_monster(i);