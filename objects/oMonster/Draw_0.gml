//Set outline shader
shader_set(shOutline);
shader_set_uniform_f(upixelW, texelSize);
shader_set_uniform_f(upixelH, texelSize);

//Draw self
draw_self();

//Reset shader
shader_reset();