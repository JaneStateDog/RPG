//Only move if we can
if (canMove) {
	//Move using keys
	moveX = (keyRight - keyLeft) * moveSpeed;
	if (!keyDown) moveY += grv; else moveY += grv * 4; //If holding down fall faster

	//Jump if hitting space and on the ground
	if (keySpacePressed or keyUpPressed) for (i = 0; i < array_length(collidables); i++) if (place_meeting(x, y + 1, collidables[i])) {
		//Make jump sound effect
		audio_sound_gain(audio_play_sound(sndJump, 1, false), volume, 0);
	
		moveY += -jumpPower;
		break;
	}
}


//Do collision
//Horizontal
for (i = 0; i < array_length(collidables); i++) {
	if (collidables[i] == oOneWay) {
		var oneWay = instance_place(x + moveX, y, oOneWay);
		
		if (oneWay != noone) switch (oneWay.image_angle) {
			case 0: if (sign(moveX) == -1) continue; else break;
			case 180: if (sign(moveX) == 1) continue; else break;
			case 270: continue;
			case 90: continue;
		}
	}
	
	if (place_meeting(x + moveX, y, collidables[i])) {
		while (!place_meeting(x + sign(moveX), y, collidables[i])) x += sign(moveX);
		moveX = 0;
	}
}

if (canMove) x += moveX;

//Vertical
for (i = 0; i < array_length(collidables); i++) {
	if (collidables[i] == oOneWay) {
		var oneWay = instance_place(x, y + moveY, oOneWay);
		
		if (oneWay != noone) switch (oneWay.image_angle) {
			case 270: if (sign(moveY) == -1) continue; else break;
			case 90: if (sign(moveY) == 1) continue; else break;
			case 0: continue;
			case 180: continue;
		}
	}
	
	if (place_meeting(x, y + moveY, collidables[i])) {
		while (!place_meeting(x, y + sign(moveY), collidables[i])) y += sign(moveY);
		moveY = 0;
	}
}

if (canMove) y += moveY;