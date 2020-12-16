//Lerp the entity x
entityX = lerp(entityX, destinationEntityX, 0.08);

//Allow the battle options menu to select if we've moved the entities into place
var range = 1;
if (in_range(entityX, destinationEntityX - range, destinationEntityX + range)) oBattleOptions.canSelect = true;


//Update the party members so they are always in entity form in the battle room
if (array_length(party) != array_length(memberEntities)) for (i = 0; i < array_length(party); i++) {
	var failed = true;
	for (b = 0; b < array_length(memberEntities); b++) if (memberEntities[b].type == entityType.member and memberEntities[b].ID == i) {
		failed = false;
		break;
	}
		
	if (failed) place_member(i);
}

//Update the monsters so they are always in entity form in the battle room
if (array_length(queuedMonsters) != array_length(monsterEntities)) for (i = 0; i < array_length(queuedMonsters); i++) {
	var failed = true;
	for (b = 0; b < array_length(monsterEntities); b++) if (monsterEntities[b].type == entityType.monster and monsterEntities[b].ID == i) {
		failed = false;
		break;
	}
		
	if (failed) place_monster(i);
}


//Define monster positions
var tempHeight = room_height / (array_length(monsterEntities) + 1);
var monsterY = room_height - tempHeight;
var maxMonsterY = tempHeight;

//Define party positions
var tempHeight = room_height / (array_length(memberEntities) + 1);
var partyY = room_height - tempHeight;
var maxPatyY = tempHeight;

//Move every member entity into their proper positions
var divValue = array_length(memberEntities);
for (i = 0; i < array_length(memberEntities); i++) {
	memberEntities[i].x = room_width - entityX;
	memberEntities[i].y = maxPatyY + (((partyY - maxPatyY) / divValue) * i);
}

//Move ever monster entity into their proper positions
var divValue = array_length(monsterEntities);
for (i = 0; i < array_length(monsterEntities); i++) {
	monsterEntities[i].x = entityX;
	monsterEntities[i].y = maxMonsterY + (((monsterY - maxMonsterY) / divValue) * i);
}