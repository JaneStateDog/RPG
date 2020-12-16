//If the platformer surface exists draw it and it's outline to the application surface
if (surface_exists(platSurf)) {
	surface_set_target(application_surface);
	
	draw_sprite(sPlatOutline, 0, platSurfX - 3, platSurfY - 3);
	draw_surface(platSurf, platSurfX, platSurfY);
	part_system_drawit(particlePlatSystem);
	
	surface_reset_target();
}