//Define the entity type and type for determining what type of entity this is
enum entityType {
	member,
	monster
}

type = -1;


//Define data for this entity
ID = 0;

level = 0;
HP = 0;
def = 0;
str = 0;

defending = false;

isAttacking = false;

//Set alarm to gather the needed values
alarm_set(0, 1);


//Function to do damage animation
function do_damage_animation() {
	//Make hurt sound effect
	audio_sound_gain(audio_play_sound(sndHurt, 1, false), volume, 0);
	
	image_blend = c_red;
	image_speed = 0;
	
	part_particles_create(particleSystem, drawX, drawY, pBlood, 200);
	
	alarm_set(1, 15);
}


//Define draw x and y
drawX = x;
drawY = y;

//Define move y for possible animations
moveY = 0;
oldDrawY = drawY;