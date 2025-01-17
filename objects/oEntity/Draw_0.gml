//Draw self if we even have an image to draw
if (sprite_index != -1) {								
	//Set outline shader
	shader_set(shOutline);
	shader_set_uniform_f(upixelW, texelSize);
	shader_set_uniform_f(upixelH, texelSize);

	//Draw self but make sure the x and y is rounded
	draw_sprite_ext(sprite_index, image_index, round(drawX), round(drawY),
					image_xscale, image_yscale, image_angle, image_blend, image_alpha);
				
	//Reset shader
	shader_reset();
}