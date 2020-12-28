//Set the font
draw_set_font(fMain);



//Set some variables
var textBoxWidth = sprite_get_width(sDialogueBox);
var textBoxX = (cameraWidth / 2) - (textBoxWidth / 2);


//Draw the diaglogue box
outline_shader_set();
draw_sprite(sDialogueBox, 0, textBoxX, diaBoxY);

//Draw portrait
shader_reset();
if (portraitSprite != noone) draw_sprite(portraitSprite, portraitIndex, textBoxX + 8, diaBoxY + 3);

//Draw name text box and name
if (name != "") {
	var nameSpace = 8;
	var nameBoxWidth = string_width(name) + nameSpace;
	
	var nameBoxX = textBoxX - 4;
	var nameBoxY = diaBoxY - 18;
	
	outline_shader_set();
	
	draw_sprite(sNameBoxSide, 0, nameBoxX - 3, nameBoxY + 1);
	draw_sprite(sNameBoxSide, 0, nameBoxX + nameBoxWidth, nameBoxY + 1);
	draw_sprite_stretched(sNameBoxCenter, 0, nameBoxX, nameBoxY, nameBoxWidth, sprite_get_height(sNameBoxCenter));
	
	
	shader_reset();
	
	draw_set_color(c_white);
	draw_text(nameBoxX + (nameSpace / 2), nameBoxY + 6, name);
} else shader_reset();



//Draw message
var textX = textBoxX + (lineSpace / 2);
if (portraitSprite != noone) textX += sprite_get_width(portraitSprite) + 4;

var lineOn = 0;
var charIndent = 0;

var justJumpedLines = true;

var modifier = -1;
var modifier2 = -1;

for (i = 1; i < string_length(messageToShow) + 1; i++) {
	if (!justJumpedLines) charIndent += string_width(string_char_at(messageToShow, i - 1));
	var xToDraw = textX + charIndent;
	
	var char = string_char_at(messageToShow, i);
	
	if (char == " " and xToDraw >= (textBoxX + textBoxWidth) - lineSpace) {
		lineOn++;
		charIndent = 0;
		xToDraw = textX;
		justJumpedLines = true;
	
		continue;
	}
	
	
	//If the character is the modifier character then add it to the modifier variable for modifying use
	if (char == "&") {
		modifier = string_char_at(messageToShow, i + 1);
		
		i += 2;
		char = string_char_at(messageToShow, i);
	} else if (char == "|") {
		modifier2 = string_char_at(messageToShow, i + 1);
		
		i += 2;
		char = string_char_at(messageToShow, i);
	}
	
	//Use the modifiers2 to change the location of the drawing
	var drawX = xToDraw;
	var drawY = diaBoxY + 10 + (string_height(string_char_at(messageToShow, i - 1)) * lineOn);
	switch (modifier2) {
		case modifiers2.shaky: //Shaky
			var pwr = 0.75;
			drawX += random_range(-pwr, pwr);
			drawY += random_range(-pwr, pwr);
		
			break;
	}
	
	//Draw the modifiers
	switch (modifier) {
		case modifiers.blue: //Blue
			draw_set_color(c_blue);
			draw_text(drawX, drawY, char);	
			
			break;
		case modifiers.lightBlue: //Light blue
			draw_set_color(c_aqua);
			draw_text(drawX, drawY, char);
			
			break;
		case modifiers.red: //Red
			draw_set_color(c_red);
			draw_text(drawX, drawY, char);
			
			break;
		case modifiers.rainbow: //Rainbow
			
			
			break;
		
		
		default:
			draw_set_color(c_white);
			draw_text(drawX, drawY, char);
			
			break;
	}
	
	
	justJumpedLines = false;
}