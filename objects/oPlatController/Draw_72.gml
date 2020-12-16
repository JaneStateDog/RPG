//If the platformer surface doesn't exist then create it and if it does then initialize some stuff
if (!surface_exists(platSurf)) platSurf = surface_create(platSurfWidth, platSurfHeight); else {	
	//Clear the surface
	surface_set_target(platSurf);
	draw_clear_alpha(c_white, 0);
	surface_reset_target();
}