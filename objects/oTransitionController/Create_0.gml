//Define diagonal x and y variables
diag1X = 0;
diag1Y = 0;

diag2X = cameraWidth;
diag2Y = cameraHeight;

target1X = 0;
target1Y = 0;

target2X = 0;
target2Y = 0;


//Define the transiton we are using
transition = transitions.toBattle;

//Define if we are transitioning in or out
transOut = true;


//Define lerp speed variables
lerpSpeed = 0.01;
ogLerpSpeed = 0;

//Define room goto
roomGoTo = -1;


//Function to draw the diagonal transition
function diagonal_draw() {
	//Draw the left side
	draw_primitive_begin(pr_trianglelist);
	draw_vertex(0, 0);
	draw_vertex(round(diag1X), 0);
	draw_vertex(0, round(diag1Y));
	draw_primitive_end();

	//Draw the right side
	draw_primitive_begin(pr_trianglelist);
	draw_vertex(cameraWidth, cameraHeight);
	draw_vertex(round(diag2X), cameraHeight);
	draw_vertex(cameraWidth, round(diag2Y));
	draw_primitive_end();
}

//Function to move the diagonal transition
function diagonal_move(roomToGoTo) {
	//Set room go to
	roomGoTo = roomToGoTo;
	
	//Change the targets depending on if we are transitioning out or not
	if (transOut) {
		target1X = cameraWidth;
		target1Y = cameraHeight;

		target2X = 0;
		target2Y = 0;
	} else {
		target1X = 0;
		target1Y = 0;

		target2X = cameraWidth;
		target2Y = cameraHeight;
	}

	lerpSpeed = lerp(lerpSpeed, 0.35, 0.02);

	diag1X = lerp(diag1X, target1X, lerpSpeed);
	diag1Y = lerp(diag1Y, target1Y, lerpSpeed);

	diag2X = lerp(diag2X, target2X, lerpSpeed);
	diag2Y = lerp(diag2Y, target2Y, lerpSpeed);
	
	var range = 0.2;
	if (in_range(diag1X, target1X - range, target1X + range)) if (transOut) {
		if (alarm_get(0) == -1) alarm_set(0, 15);
	} else instance_destroy();
}