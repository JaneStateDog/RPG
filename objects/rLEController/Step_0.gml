//On ctrl + alt + o toggle overlay
if (keyCtrl and keyAlt and keyOPressed) overlay = !overlay;

//On ctrl + alt + middle press toggle camera target to player
if (keyCtrl and keyAlt and mouseMiddlePressed) {
	if (oCameraController.target != oPlatPlayer) oCameraController.target = oPlatPlayer; else oCameraController.target = noone;
}


//Move the camera if holding the middle mouse button
if (mouseMiddle) {
	var lerpSpeed = 0.08;
	oCameraController.x = lerp(oCameraController.x, mouse_x, lerpSpeed);
	oCameraController.y = lerp(oCameraController.y, mouse_y, lerpSpeed);
}


//On left click place data depeneding on held keys
if (mouseLeft) {
	var data = noone;
	
	if (keyCtrl) { //Place player
		instance_destroy(oPlatPlayer);
		instance_create_layer(mouse_x, mouse_y, "Player", oPlatPlayer);
	} else if (keyAlt) data = instance_create_layer(mouse_x, mouse_y, "Blocks", oOneWay); //One way
	else if (keyE) data = instance_create_layer(mouse_x, mouse_y, "Blocks", oPlatExit); //Exit
	else if (keyQ) data = instance_create_layer(mouse_x, mouse_y, "Blocks", oPlatAttack); //Attack cube
	else if (keyT) data = instance_create_layer(mouse_x, mouse_y, "Blocks", oPlatSpikes); //Spikes
	else data = instance_create_layer(mouse_x, mouse_y, "Blocks", oPlatWall); //Wall
	
	if (data != noone) snap_and_destroy(data);
}

//Destroy the data under the mouse on right click
if (mouseRight) {
	var block = noone;
	for (i = 0; i < array_length(platDataTypeObjects); i++) if (block == noone) block = instance_position(mouse_x, mouse_y, platDataTypeObjects[i]); else break;
	
	if (block != noone) instance_destroy(block);
}

//Rotate the data under the mouse
if (keyRPressed) {
	var data = noone;
	for (i = 0; i < array_length(platDataTypeObjects); i++) if (data == noone) data = instance_position(mouse_x, mouse_y, platDataTypeObjects[i]); else break;
	if (data != oPlatPlayer and data != noone) {
		data.image_angle += 90;
		if (data.image_angle >= 360) data.image_angle = 0;
	}
}


//Save the level
if (keyCtrl and keySPressed) {
	//Get level name and define save data
	var lvlName = get_string("Level name:", "");
	var saveData = [];
	
	
	//Go through all the data types and save their data into a struct and put that struct into the save data array
	for (i = 0; i < array_length(platDataTypeObjects); i++) with (platDataTypeObjects[i]) {
		var saveEntity = {
			type : type,
			x : x,
			y : y,
			image_angle: image_angle
		}
		
		array_push(saveData, saveEntity);
	}
	
	
	//Put the data into string form and put it into a buffer
	var str = json_stringify(saveData);
	var buffer = buffer_create(string_byte_length(str) + 1, buffer_fixed, 1);
	
	//Write the buffer, save it to file, then delete the buffer
	buffer_write(buffer, buffer_string, str);
	buffer_save(buffer, "levels/" + lvlName + ".lvl");
	buffer_delete(buffer);
}

//Load a new level
if (keyCtrl and keyLPressed) if (show_question("Load level?")) load_level(get_string("Level name:", ""));