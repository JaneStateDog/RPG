//Draw self and set the font and color
draw_self();
draw_set_color(c_white);
draw_set_font(fMain);


//Draw the options
var drawY = y + 6;
for (i = 0; i < array_length(selectOptions); i++) draw_text(x + 6, y + 6 + (16 * i), selectOptions[i]);


var theNumber = 1.5; //Don't ask
//Depending on the state draw the select indentifier
switch (state) {
	case states.select: draw_text(x - 10, drawY + (16 * selected), ">"); break;
	case states.chooseAttack: draw_text(round(monsterEntities[selected].x + (sprite_get_width(monsterEntities[selected].sprite_index) / (theNumber))), 
										monsterEntities[selected].y - 8, "<"); break;
}

//Draw the select indentifier for the member whose turn it is but only do so if we are selecting an option or an entity to attack
if (state == states.select or state == states.chooseAttack) {
	draw_text(round(memberEntities[party[turn]].x - (sprite_get_width(memberEntities[party[turn]].sprite_index) / theNumber)), memberEntities[party[turn]].y - 8, ">");
}


//Draw the members' health
for (i = 0; i < array_length(memberEntities); i++) if (memberEntities[i].HP > 0) {
	var str = "HP: "
	
	//Use the idle animation to find out where behind the member to place the HP
	var space = sprite_get_width(members[party[memberEntities[i].ID]][memberData.sprIdle]) / theNumber;
	
	draw_text(memberEntities[i].drawX + space, memberEntities[i].drawY - 8, str);
	draw_set_color(memberEntities[i].image_blend);
	draw_text(memberEntities[i].drawX + space + string_width(str), memberEntities[i].drawY - 10, 
			  string(memberEntities[i].HP) + "/" + string(members[party[memberEntities[i].ID]][memberData.maxHP]));
	draw_set_color(c_white);
}

//Draw the monsters' health
for (i = 0; i < array_length(monsterEntities); i++) if (monsterEntities[i].HP > 0) {
	var str = "HP: "
	var str2 = string(monsterEntities[i].HP) + "/" + string(monsters[queuedMonsters[monsterEntities[i].ID]][mobData.maxHP]);
	
	//Use the idle animation to find out where behind the monster to place the HP
	var space = sprite_get_width(monsters[queuedMonsters[monsterEntities[i].ID]][mobData.sprIdle]) / theNumber;
	
	draw_text(monsterEntities[i].drawX - space - string_width(str2) - string_width(str), monsterEntities[i].drawY - 8, str);
	draw_set_color(monsterEntities[i].image_blend);
	draw_text(monsterEntities[i].drawX - space - string_width(str2), monsterEntities[i].drawY - 10, str2);
	draw_set_color(c_white);
}