//Test if the target exists and if so then follow it
if (instance_exists(target)) {
	x = round(lerp(x, target.x, moveSpeed));
	y = round(lerp(y, target.y, moveSpeed));
}

//On F11 press go fullscreen
if (keyboard_check_pressed(vk_f11)) window_set_fullscreen(!window_get_fullscreen());


//Shake if is shaking is true
if (isShaking) {
	if (irandom(1) == 0) x += irandom(shakePower); else x -= irandom(shakePower);
	if (irandom(1) == 0) y += irandom(shakePower); else y -= irandom(shakePower);
}