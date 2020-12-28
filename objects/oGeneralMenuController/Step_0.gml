//If the player is in the room make sure they cannot move
if (instance_exists(oPlayer)) oPlayer.canMove = false;



//Set lerp speed and range for moving the box
var lerpSpeed = 0.18;
var range = 4;

//Depending on the transition state move the box
//Function for getting if a box is done going to it's destination
function box_get_done(dest, pos, range) {
	return in_range(pos, dest - range, dest + range);
}

switch (transState) {
	case transStates.up: 
		mainBoxDestY = mainBoxOnScreenDestY;
		if (box_get_done(mainBoxDestY, mainBoxY, range)) transState = transStates.left;
				
		break;
	case transStates.left:
		mainBoxDestX = mainBoxOnScreenDestX;
		if (box_get_done(mainBoxDestX, mainBoxX, range)) transState = transStates.partyDown;
				
		break;
	case transStates.right: 
		mainBoxDestX = mainBoxOffScreenDestX;
		if (box_get_done(mainBoxDestX, mainBoxX, range)) transState = transStates.down;
		
		canSelect = false;
				
		break;
	case transStates.down: 
		mainBoxDestY = mainBoxOffScreenDestY;
		if (box_get_done(mainBoxDestY, mainBoxY, range)) instance_destroy();
				
		break;

	
	case transStates.partyDown:
		partyBoxDestY = partyBoxOnScreenDestY;
		if (box_get_done(partyBoxDestY, partyBoxY, range)) canSelect = true;
	
		break;
	case transStates.partyUp:
		partyBoxDestY = partyBoxOffScreenDestY;
		if (box_get_done(partyBoxDestY, partyBoxY, range)) transState = transStates.right;
		
		break;
		
	
	case transStates.systemDown:
		systemBoxDestY = systemBoxOnScreenDestY;
		if (box_get_done(systemBoxDestY, systemBoxY, range)) {
			menu = menus.system;
			canSelect = true;
		}
		
		break;
	case transStates.systemUp:
		systemBoxDestY = systemBoxOffScreenDestY;
		if (box_get_done(systemBoxDestY, systemBoxY, range)) {
			menu = menus.main;
			canSelect = true;
		}
		
		break;
}



//If we are able to select then do things that use the selection ability/feature
if (canSelect) {
	//Changed selected using keys if we are not changing a value
	if ((keyDownPressed or keyLeftPressed or keyUpPressed or keyRightPressed) and changingValue == changeValues.none) {
		//Change selected depending on which keys are pressed
		if (keyDownPressed or keyLeftPressed) selected++; else if (keyUpPressed or keyRightPressed) selected--;

		//Fix selected
		if (selected >= array_length(options)) selected = 0;
		else if (selected < 0) selected = array_length(options) - 1;
	
		//Make select sound effect
		audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
	}
	
	
	
	//Depending on which menu we are in do different things
	switch (menu) {
		case menus.main: //Main
			//On selection of an options do an action depending on what that option is
			if (keySpacePressed) {
				//Make select sound effect
				audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
				
				switch(selected) {
					case 0: //Items
					
				
						break;
					case 1: //Equipment
					
				
						break;
					case 2: transState = transStates.systemDown; break; //System
				}
				
				//Reset selected and stop the allowance of selecting (selecting is allowed once the transition is over)
				selected = 0;
				canSelect = false;
			}
		
		
			break;
		case menus.system: //System
			//On selection of an options do an action depending on what that option is
			if (keySpacePressed) {
				//Make select sound effect
				audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
				
				switch(selected) {
					case 0: //Volume
						if (changingValue == changeValues.none) changingValue = changeValues.volume; else changingValue = changeValues.none;
	
						break;
					case 1: window_set_fullscreen(!window_get_fullscreen()); break; //Fullscreen
				}
			}
			
			
			
			if ((keyDownPressed or keyLeftPressed or keyUpPressed or keyRightPressed) and changingValue == changeValues.volume) {
				if (keyDownPressed or keyLeftPressed) masterVolume -= 0.1; else if (keyUpPressed or keyRightPressed) masterVolume += 0.1;

				if (masterVolume > 1) masterVolume = 0;
				else if (masterVolume < 0) masterVolume = 1;
				
				//Make select sound effect
				audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
			}
			
			
			break;
	}
}



//Lerp the boxes to their destinations
mainBoxX = lerp(mainBoxX, mainBoxDestX, lerpSpeed);
mainBoxY = lerp(mainBoxY, mainBoxDestY, lerpSpeed);

partyBoxY = lerp(partyBoxY, partyBoxDestY, lerpSpeed);

systemBoxY = lerp(systemBoxY, systemBoxDestY, lerpSpeed);



//Close general menu on escape press
if (keyEscapePressed) {
	//Make select sound effect
	audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
	
	//Depending on what menu is open close the box in it's way
	switch (menu) {
		case menus.main: transState = transStates.partyUp; break; //Main
		case menus.system: //System
			//If changing a value such as volume the set it to not be but if we aren't then close the system menu
			if (changingValue == changeValues.volume) changingValue = changeValues.none else {
				transState = transStates.systemUp;
		
				selected = 0;
				canSelect = false;
			}
		
			break;
	}
}



//Set the volume part of system options to include the master volume
systemOptions[0] = "Volume: " + string(round(masterVolume * 10));


//Set options dependig on what menu we are on
switch (menu) {
	case menus.main: options = mainOptions; break; //Menu
	case menus.system: options = systemOptions; break; //System
}