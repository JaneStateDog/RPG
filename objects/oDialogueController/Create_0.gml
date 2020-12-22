//Define message data
enum msgData {
	msg,
	name,
	port,
	portIndex
}


//Define portrait variables
portraitSprite = noone;
portraitIndex = 0;


//Define message variables
ourMessages = [];

msg = "";
messageToShow = "";

charOn = 0;

messageOn = 0;


//Define name to show variables
name = "";


//Define is alarm done
isAlarmDone = true;


//Define line variables
lineSpeed = 2;
lineSpace = 24;


//Define can continue dialogue
canContinueDialogue = false;


//Define diagloue box y location and it's destination
diaBoxYDest = cameraHeight - 12 - sprite_get_height(sDialogueBox);
diaBoxYDestBelow = cameraHeight + sprite_get_height(sDialogueBox) + 32;
diaBoxY = diaBoxYDestBelow;


//Make sure the player can't move
if (instance_exists(oPlayer)) oPlayer.canMove = false;


//Define the modifiers
enum modifiers {
	red,
	blue,
	lightBlue,
	rainbow
}

enum modifiers2 {
	shaky
}


//Function to turn on outline shader
function outline_shader_set() {
	shader_reset();
	shader_set(shOutline);
	
	shader_set_uniform_f(upixelW, texelSize);
	shader_set_uniform_f(upixelH, texelSize);
}