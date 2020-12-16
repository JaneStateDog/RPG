//Move in a random direction then reset alarm a random amount
moveX = round(random_range(-1, 1));
moveY = round(random_range(-1, 1));

//Make it so they are always moving horizontally
if (moveY != 0) while (moveX == 0) moveX = round(random_range(-1, 1))


//Reset the alarm with a random time
alarm_set(0, irandom(120));