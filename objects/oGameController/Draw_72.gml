//Clear the visible application surface if not in the level editor because if we are in there and are clearing the application surface then drawing doesn't work
if (room != rLevelEditor) {
	var cameraX = camera_get_view_x(view_camera[0]);
	var cameraY = camera_get_view_y(view_camera[0]);

	draw_set_color(c_black);
	draw_rectangle(cameraX, cameraY, cameraX + cameraWidth, cameraY + cameraHeight, false);
}