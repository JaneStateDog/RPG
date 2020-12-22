//Set outline shader
shader_set(shOutline);
shader_set_uniform_f(upixelW, texelSize);
shader_set_uniform_f(upixelH, texelSize);

//Draw self
if (image_alpha != 0) draw_self();

//Reset shader
shader_reset();