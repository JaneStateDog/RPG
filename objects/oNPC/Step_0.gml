//Set sprite
if (spr != noone) sprite_index = spr; else {
	sprite_index = sNPC;
	image_alpha = 0;
}


//If we're with the player, they hit space, we have messages, and we're not talking then queue the messages
if (instance_exists(oPlayer) and oPlayer.canMove and keySpacePressed and messages != -1 and !talking) {
	failed = true;
	
	//See if the player (with their NPC hitbox) is in us and if so run the dialogue
	with (oPlayer) {
		mask_index = sPlayerNPCHitbox;
		if (place_meeting(x, y, other)) other.failed = false;
		mask_index = sPlayerDefaultHitbox;
	}
	
	if (!failed) {
		for (i = 0; i < array_length(messages); i++) queue_dialogue(messages[i][0], messages[i][1], messages[i][2], messages[i][3]);
	
		//Set talking
		talking = true;
	}
} else if (keySpacePressed) talking = false; //Put this here so the messages don't repeat when the player hits space to close dialogue