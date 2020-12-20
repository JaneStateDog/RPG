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


//Move every member entity into their proper positions
for (i = 0; i < array_length(memberEntities); i++) {
	memberEntities[i].x = room_width - entityX - (sprite_get_width(members[party[memberEntities[i].ID]][memberData.sprIdle]) / 2);
	memberEntities[i].y = (room_height / (array_length(memberEntities) + 1)) * (i + 1);
	
	memberEntities[i].layer = layer_get_id("TopEntities");
}

//Move ever monster entity into their proper positions
for (i = 0; i < array_length(monsterEntities); i++) {
	monsterEntities[i].x = entityX + (sprite_get_width(monsters[queuedMonsters[monsterEntities[i].ID]][mobData.sprIdle]) / 2);
	monsterEntities[i].y = (room_height / (array_length(monsterEntities) + 1)) * (i + 1);
	
	monsterEntities[i].layer = layer_get_id("BottomEntities");
}