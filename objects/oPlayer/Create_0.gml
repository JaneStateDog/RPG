//Define move variables
moveX = 0;
moveY = 0;

moveSpeed = 3; //Only use full digits

moveDir = 0


//Define states
enum playerStates {
	idle,
	running,
	swordStriking
}

state = playerStates.idle;