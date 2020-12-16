//Only do things if we are assigned to a monster
if (ID != -1) {
	//Wrap PROBABLY REMOVE THIS JUST KEEP IT FOR TESTING
	move_wrap(true, true, 0);


	//Only move if not being damaged
	if (!beingDamaged) {
		///Movement
		//If moving use some point direction stuff to make sure diagonal movement
		//is not faster than it should be
		//(P.S. I only half understand this code because I stole it from YouTube and I don't
		//really care enough to actually pay attention to it)
		if (moveX != 0 or moveY != 0) {
			moveDir = point_direction(0, 0, moveX, moveY);
	
			moveX = lengthdir_x(moveSpeed, moveDir);
			moveY = lengthdir_y(moveSpeed, moveDir);
		}
		
		//Do collision
		//Horizontal
		if (place_meeting(x + moveX, y, oWall)) {
			while (!place_meeting(x + sign(moveX), y, oWall)) x += sign(moveX);
			moveX = 0;
			
			alarm_set(0, 1); //Reset the movement alarm to start moving somewhere else
		}

		//Move horizontally
		x += round(moveX);

		//Vertical
		if (place_meeting(x, y + moveY, oWall)) {
			while (!place_meeting(x, y + sign(moveY), oWall)) y += sign(moveY);
			moveY = 0;
			
			alarm_set(0, 1); //Reset the movement alarm to start moving somewhere else
		}
	
		//Move vertically
		y += round(moveY);


		///Animation
		//Animate run if we are moving
		if (moveX != 0 or moveY != 0) {
			//Change the sprite to be the run sprite
			sprite_index = monsters[ID][mobData.sprRun];
	
			//Depending on the move x change the direction we're facing
			if (moveX > 0) image_xscale = 1; else if (moveX < 0) image_xscale = -1;
		} else sprite_index = monsters[ID][mobData.sprIdle]; //Change the sprite to be the idle sprite
	}
}