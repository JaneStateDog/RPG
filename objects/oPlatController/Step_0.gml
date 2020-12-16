//Move the platformer camera to it's target
if (instance_exists(target)) {
	platCamX = round(lerp(platCamX, target.x, moveSpeed));
	platCamY = round(lerp(platCamY, target.y, moveSpeed));
}