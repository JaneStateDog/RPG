//Wrap PROBABLY REMOVE THIS JUST KEEP IT FOR TESTING
move_wrap(true, true, 0);


///Movement
//Move the player using the keys and move speed
moveX = keyRight - keyLeft;
moveY = keyDown - keyUp;

//If moving use some point direction stuff to make sure diagonal movement
//is not faster than it should be
//(P.S. I only half understand this code because I stole it from YouTube and I don't
//really care enough to actually pay attention to it)
if (moveX != 0 or moveY != 0) {
	moveDir = point_direction(0, 0, moveX, moveY);
	
	moveX = lengthdir_x(moveSpeed, moveDir);
	moveY = lengthdir_y(moveSpeed, moveDir);
}


//If moving change state to running
if (state != playerStates.swordStriking) if (moveX != 0 or moveY != 0) state = playerStates.running;
else state = playerStates.idle;


//Do collision
//Horizontal
if (place_meeting(x + moveX, y, oWall)) {
	while (!place_meeting(x + sign(moveX), y, oWall)) x += sign(moveX);
	moveX = 0;
}

//Move horizontally
if (state != playerStates.swordStriking and canMove) x += round(moveX); //Make sure we're not striking and we can move

//Vertical
if (place_meeting(x, y + moveY, oWall)) {
	while (!place_meeting(x, y + sign(moveY), oWall)) y += sign(moveY);
	moveY = 0;
}
	
//Move vertically
if (state != playerStates.swordStriking and canMove) y += round(moveY); //Make sure we're not striking and we can move


//On space press do sword strike if not talking to NPC
if (keySpacePressed and state != playerStates.swordStriking) {
	mask_index = sPlayerNPCHitbox;
	
	if (!place_meeting(x, y, oNPC))  {
		state = playerStates.swordStriking;
		image_index = 0; //Reset animation
	}
	
	
	mask_index = sPlayerDefaultHitbox;
}


//Do things depending on the state
switch (state) {
	case playerStates.idle: sprite_index = sPlayerIdle; break;
	case playerStates.running: sprite_index = sPlayerRun; break;
	case playerStates.swordStriking:
		//Change sprite
		sprite_index = sPlayerSwordStrike;
		
		//Change state to idle if animation is over
		if (round(image_index) == image_number) state = playerStates.idle;
		
		//On the hit frame get monster at hitbox and change it's color to red
		//then start battle
		if (round(image_index) == 4) with (instance_place(x, y, oMonster)) if (!beingDamaged) {
			other.canMove = false;
			
			beingDamaged = true;
			
			part_particles_create(particleSystem, x, y, pBlood, 200);
			image_blend = c_red;
			image_speed = 0;
			
			//Make hurt sound effect
			audio_sound_gain(audio_play_sound(sndHurt, 1, false), volume, 0);
			
			//Inact battle
			battle_start(mobGroupID);
		}
	
		break;
}

//Depending on the move x change the direction we're facing
if (moveX > 0) image_xscale = 1; else if (moveX < 0) image_xscale = -1;