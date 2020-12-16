//Define overlay
overlay = true;


//Place the player
instance_create_layer(-1000, -1000, "Player", oPlatPlayer);


//Function to snap the object to the grid and to destroy it if it's over another object
function snap_and_destroy(object) {
	with (object) {
		move_snap(8, 8);
			
		for (i = 0; i < array_length(platDataTypeObjects); i++) if (place_meeting(x, y, platDataTypeObjects[i])) instance_destroy(self);
	}
}


//Load a level by asking if a level shall be loaded
if (show_question("Load level?")) load_level(get_string("Level name:", ""));