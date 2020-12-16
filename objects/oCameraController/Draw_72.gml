//Clear the visible application surface
var cameraX = camera_get_view_x(view_camera[0]);
var cameraY = camera_get_view_y(view_camera[0]);

draw_rectangle_color(cameraX, cameraY, cameraX + cameraWidth, cameraY + cameraHeight,
					 background_color, background_color, background_color, background_color, false);