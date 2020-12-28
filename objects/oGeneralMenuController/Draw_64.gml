//Set the font and color
draw_set_color(c_white);
draw_set_font(fMain);

//Set dif for drawing options and selection icon use
var dif = 6;



//Draw the system box
outline_shader_set();
draw_sprite(sSystemBox, 0, systemBoxX, systemBoxY);
shader_reset();

//Draw the system options
for (i = 0; i < array_length(systemOptions); i++) draw_text(systemBoxX + dif, systemBoxY + dif + (16 * i), systemOptions[i]);


//Draw the box
outline_shader_set();
draw_sprite(sGMBox, 0, mainBoxX, mainBoxY);
shader_reset();

//Draw the main options
for (i = 0; i < array_length(mainOptions); i++) draw_text(mainBoxX + dif, mainBoxY + dif + (16 * i), mainOptions[i]);


//Draw the party box
outline_shader_set();
draw_sprite(sPartyBox, 0, partyBoxX, partyBoxY);
shader_reset();

//Draw party members in the party box
for (i = 0; i < array_length(party); i++) {
	var yAmount = 0;
	var maxYAmount = 4;
	
	var drawX = partyBoxX + 6;
	var drawY = partyBoxY + 6 + ((16 * (maxYAmount + 1)) * i);
	
	
	//Name
	draw_text(drawX, drawY + (16 * yAmount), members[party[i]][memberData.name]);
	yAmount++;
	
	//Health
	draw_text(drawX, drawY + (16 * yAmount), "HP: " + string(members[party[i]][memberData.HP]) + "/" + string(members[party[i]][memberData.maxHP]));
	yAmount++;
	
	//Strength
	draw_text(drawX, drawY + (16 * yAmount), "Str: " + string(members[party[i]][memberData.str]) + "/" + string(members[party[i]][memberData.maxStr]));
	yAmount++;
	
	//Defense
	draw_text(drawX, drawY + (16 * yAmount), "Def: " + string(members[party[i]][memberData.def]) + "/" + string(members[party[i]][memberData.maxDef]));
	yAmount++;
}



//Draw the options and selection icon
//If we can select in menu then draw the icon
if (canSelect) {
	var drawY = 0;
	var drawX = 0;

	//Get where to draw the icon
	switch (menu) {
		case menus.main: //Main
			drawX = mainBoxX;
			drawY = mainBoxY;
	
			break;
		case menus.system: //System
			drawX = systemBoxX;
			drawY = systemBoxY;
	
			break;
	}

	drawX += dif;
	drawY += dif;

	//Draw the icon
	for (i = 0; i < array_length(options); i++) if (selected == i) draw_text(drawX + 3 + string_width(options[i]), drawY + (16 * i), "<");
}