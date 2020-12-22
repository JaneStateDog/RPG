//If the platformer surface exists draw it and it's outline to the application surface
if (surface_exists(platSurf)) {
	surface_set_target(application_surface);
	
	
	//Set outline shader
	shader_set(shOutline);
	shader_set_uniform_f(upixelW, texelSize);
	shader_set_uniform_f(upixelH, texelSize);
	
	//Draw outline border thingy
	draw_sprite(sPlatOutline, 0, platSurfX - 3, platSurfY - 3);
	
	//Reset shader
	shader_reset();
	
	
	draw_surface(platSurf, platSurfX, platSurfY);
	part_system_drawit(particlePlatSystem);
	
	surface_reset_target();
}