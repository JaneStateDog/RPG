//Function to do camera shake
function camera_shake(vibratePower, timeLength) {
	oCameraController.ogX = oCameraController.x;
	oCameraController.ogY = oCameraController.y;
	
	oCameraController.isShaking = true;
	oCameraController.shakePower = vibratePower;
		
	oCameraController.alarm[0] = timeLength;
}


//Function to check a value is in range of other values
function in_range(value1, value2, value3) {
	return value1 >= value2 and value1 <= value3;
}


//Function to transition and move to a new room
enum transitions {
	toBattle,
	fromBattle
}
function do_transition(transition) {
	var trans = instance_create_layer(0, 0, "Controllers", oTransitionController);
	trans.transition = transition;
}


//Function to draw text with outline
function draw_text_outlined(dX, dY, str, outlineColor, stringColor) {
	//Draw the outline  
	draw_set_color(outlineColor);  
	draw_text(dX + 1, dY + 1, str);  
	draw_text(dX - 1, dY - 1, str);  
	draw_text(dX, dY + 1, str);  
	draw_text(dX + 1, dY, str); 
	draw_text(dX, dY - 1, str);  
	draw_text(dX - 1, dY, str);  
	draw_text(dX - 1, dY + 1, str);  
	draw_text(dX + 1, dY - 1, str);  
  
	//Draw the string  
	draw_set_color(stringColor);  
	draw_text(dX, dY, str);
	draw_set_color(c_white);
}


//Function to queue dialogue
function queue_dialogue(str, name, portrait, portraitIndex) {
	var controller = oDialogueController;
	if (!instance_exists(oDialogueController)) instance_create_layer(0, 0, "Controllers", oDialogueController);
	
	array_push(controller.ourMessages, [str, name, portrait, portraitIndex]);
}


//Function to play music
function play_music(song) {
	if (!instance_exists(oMusicController)) instance_create_layer(0, 0, "Controllers", oMusicController).song = song;
}