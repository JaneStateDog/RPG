//Define move variables
moveX = 0;
moveY = 0;

moveSpeed = 3; //Only use full digits

moveDir = 0

canMove = true;
finishAnimation = false;


//Define states
enum playerStates {
	idle,
	running,
	swordStriking
}

state = playerStates.idle;


//Set collision mask to be the hitbox
mask_index = sPlayerDefaultHitbox;