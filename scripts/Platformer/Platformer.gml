//Define platformer surface and it's size, position, camera, etc
globalvar platSurf;
platSurf = -1;

globalvar platSurfWidth, platSurfHeight;
platSurfWidth = 256;
platSurfHeight = 144;

globalvar platCamX, platCamY;
platCamX = 0;
platCamY = 0;

globalvar platSurfY, platSurfX;
platSurfX = 0;
platSurfY = 0;

//Enum for platformer data types
enum platDataTypes {
	wall,
	oneWay,
	ext,
	atk,
	player,
	spikes
}

//Array that stores the objects associated with the enum platformer data types
globalvar platDataTypeObjects;
platDataTypeObjects[platDataTypes.wall] = oPlatWall;
platDataTypeObjects[platDataTypes.oneWay] = oOneWay;
platDataTypeObjects[platDataTypes.ext] = oPlatExit;
platDataTypeObjects[platDataTypes.atk] = oPlatAttack;
platDataTypeObjects[platDataTypes.player] = oPlatPlayer;
platDataTypeObjects[platDataTypes.spikes] = oPlatSpikes;



//Function to draw objects onto the platformer surface
function draw_plat() {
	//Draw self and switch to the platformer surface if it exists
	//Also change the draw location depending on if the platformer surface exists or not
	var drawX = x;
	var drawY = y;

	if (surface_exists(platSurf)) {
		surface_set_target(platSurf);
	
		drawX = x - platCamX + (platSurfWidth / 2);
		drawY = y - platCamY + (platSurfHeight / 2);
	}

	//Draw self but make sure the x and y is rounded
	draw_sprite_ext(sprite_index, image_index, round(drawX), round(drawY),
					image_xscale, image_yscale, image_angle, image_blend, image_alpha);
				
	if (surface_exists(platSurf)) surface_reset_target();
}


//Function to destroy level
function destroy_level() {
	//Get rid of all parts of whatever loaded level there is
	for (i = 0; i < array_length(platDataTypeObjects); i++) instance_destroy(platDataTypeObjects[i]);
}

//Function to load level into room
function load_level(lvlName) {
	//If the level exists load it
	if (file_exists("levels/" + lvlName + ".lvl")) {
		//Put the buffer inside the file and into a string and then delete the buffer
		var buffer = buffer_load("levels/" + lvlName + ".lvl");
		var str = buffer_read(buffer, buffer_string);
		buffer_delete(buffer);
		
		//Load the string into an array holding all the data
		var loadData = json_parse(str);
		
		//Destroy the existing loaded level
		destroy_level()
		
		//Loop through the array and delete from it until we have no more
		while (array_length(loadData) > 0) {
			//Load the struct from the array into a variable
			var loadEntity = array_pop(loadData);
			
			//Create the proper type of data type
			var data;
			if (loadEntity.type == platDataTypes.player) data = instance_create_layer(0, 0, "Player", oPlatPlayer);
			else data = instance_create_layer(0, 0, "Blocks", platDataTypeObjects[loadEntity.type]);
			
			//Set the data's data (lol)
			with (data) {
				x = loadEntity.x;
				y = loadEntity.y;
				image_angle = loadEntity.image_angle;
			}
		}
	}
}


//Function to put level into room
function run_level(lvlName) {
	//Make sure a level isn't already placed and if it is then destroy it
	if (instance_exists(oPlatController)) instance_destroy(oPlatController);
	
	instance_create_layer(0, 0, "Controllers", oPlatController);
	load_level(lvlName);
}