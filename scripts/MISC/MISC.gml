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