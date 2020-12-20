//Set outline shader
shader_set(shOutline);
shader_set_uniform_f(upixelW, texelW);
shader_set_uniform_f(upixelH, texelH);

//Draw self but make sure the x and y is rounded
draw_sprite_ext(sprite_index, round(image_index), round(x), round(y),
				image_xscale, image_yscale, image_angle, image_blend, image_alpha);
				
//Reset shader
shader_reset();