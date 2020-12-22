//Draw self
//Set outline shader
shader_set(shOutline);
shader_set_uniform_f(upixelW, texelSize);
shader_set_uniform_f(upixelH, texelSize);

//Draw self but make sure the x and y is rounded
draw_sprite_ext(sprite_index, image_index, round(x), round(y),
				image_xscale, image_yscale, image_angle, image_blend, image_alpha);
				
//Reset shader
shader_reset();



//Set the font and color
draw_set_color(c_white);
draw_set_font(fMain);



//Draw the options
var drawY = y + 6;
for (i = 0; i < array_length(selectOptions); i++) draw_text(x + 6, y + 6 + (16 * i), selectOptions[i]);


//Depending on the state draw the select indentifier on the monsters or the options box
switch (state) {
	case states.select: draw_text_outlined(x - 10, drawY + (16 * selected), ">", c_black, c_white); break;
	case states.chooseAttack: draw_text_outlined(round(monsterEntities[selected].x + (sprite_get_width(monsterEntities[selected].sprite_index) / 2) + 8), 
												 monsterEntities[selected].y - 8, "<", c_black, c_white); break;
}

//Draw the select indentifier for the member whose turn it is but only do so if we are selecting an option or an entity to attack
if (state == states.select or state == states.chooseAttack) {
	draw_text_outlined(round(memberEntities[party[turn]].x - (sprite_get_width(memberEntities[party[turn]].sprite_index) / 2) - 8), memberEntities[party[turn]].y - 8, ">",
					   c_black, c_white);
}


//Draw the members' health
for (i = 0; i < array_length(memberEntities); i++) if (memberEntities[i].HP > 0) {
	var str = "HP: "
	
	//Use the idle animation to find out where behind the member to place the HP
	var space = (sprite_get_width(members[party[memberEntities[i].ID]][memberData.sprIdle]) / 2) + 8;
	
	draw_text_outlined(memberEntities[i].drawX + space, memberEntities[i].drawY - 8, str, c_black, c_white);
	draw_text_outlined(memberEntities[i].drawX + space + string_width(str), memberEntities[i].drawY - 10, 
					   string(memberEntities[i].HP) + "/" + string(members[party[memberEntities[i].ID]][memberData.maxHP]), c_black, memberEntities[i].image_blend);
}

//Draw the monsters' health
for (i = 0; i < array_length(monsterEntities); i++) if (monsterEntities[i].HP > 0) {
	var str = "HP: "
	var str2 = string(monsterEntities[i].HP) + "/" + string(monsters[queuedMonsters[monsterEntities[i].ID]][mobData.maxHP]);
	
	//Use the idle animation to find out where behind the monster to place the HP
	var space = (sprite_get_width(monsters[queuedMonsters[monsterEntities[i].ID]][mobData.sprIdle]) / 2) + 8;
	
	draw_text_outlined(monsterEntities[i].drawX - space - string_width(str2) - string_width(str), monsterEntities[i].drawY - 8, str, c_black, c_white);
	draw_text_outlined(monsterEntities[i].drawX - space - string_width(str2), monsterEntities[i].drawY - 10, str2, c_black, monsterEntities[i].image_blend);
}