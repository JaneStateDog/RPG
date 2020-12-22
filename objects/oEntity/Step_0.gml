//Reset draw x and y location if not attacking
if (!isAttacking) {
	drawX = x;
	drawY = y;
}


//If dead show that death via visuals
if (HP <= 0) {
	image_blend = c_red;
	image_speed = 0;
	
	if (type == entityType.member) sprite_index = members[party[ID]][memberData.sprIdle];
	else if (type == entityType.monster) sprite_index = monsters[queuedMonsters[ID]][mobData.sprIdle];
	image_index = 0;
} 


//Always set the member data
if (type == entityType.member) {
	members[party[ID]][memberData.HP] = HP;
	members[party[ID]][memberData.def] = def;
	members[party[ID]][memberData.str] = str;
}