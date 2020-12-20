//Set platformer surface location
platSurfX = (room_width / 2) - (platSurfWidth / 2);
platSurfY = -platSurfHeight - 32;


//Define move speed
moveSpeed = 0.2;

//Define target
target = oPlatPlayer;


//Define variables for outline shader
upixelH = shader_get_uniform(shOutline, "pixelH");
upixelW = shader_get_uniform(shOutline, "pixelW");

texelW = texture_get_texel_width(sprite_get_texture(sPlatOutline, 0));
texelH = texture_get_texel_height(sprite_get_texture(sPlatOutline, 0));