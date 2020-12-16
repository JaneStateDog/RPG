//If views are not enabled, set camera settings and allow views
if (!view_enabled) {
	//Allow views so we can use the camera
	view_enabled = true;
	
	//Create the camera and set it's visibility
	view_camera[0] = camera_create();
	view_set_visible(0, true);
}

//Set the camera size and position
camera_set_view_size(view_camera[0], round(cameraWidth), round(cameraHeight)); //Change camera size
camera_set_view_pos(view_camera[0], round(x - (cameraWidth / 2)), round(y - (cameraHeight / 2))); //Follow us

//Change some things with the window if the size of the window has changed
if (window_get_width() != oldWinWidth or window_get_height() != oldWinHeight) {
	//Change the application surface size
	surface_resize(application_surface, cameraWidth, cameraHeight);
	
	//Change the gui layer size
	display_set_gui_size(cameraWidth, cameraHeight);
	
	
	//Set the old window size so we can know when the window changes
	oldWinWidth = window_get_width();
	oldWinHeight = window_get_height();
	
	
	//Center the window
	window_center();
}