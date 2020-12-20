//Define move variables
moveX = 0;
moveY = 0;

moveSpeed = 3; //Only use full digits

moveDir = 0

canMove = true;


//Define states
enum playerStates {
	idle,
	running,
	swordStriking
}

state = playerStates.idle;


//Define variables for outline shader
upixelH = shader_get_uniform(shOutline, "pixelH");
upixelW = shader_get_uniform(shOutline, "pixelW");

texelW = texture_get_texel_width(sprite_get_texture(sprite_index, 0));
texelH = texture_get_texel_height(sprite_get_texture(sprite_index, 0));