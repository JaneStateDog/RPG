//The ID variable this object uses is different than the ones oEntity uses
//This one is used only for indexing the monsters array (example monsters[ID] not monsters[queuedMonsters[ID]])

//The mobGroupID variable holds the ID for the mob group we will use when the player starts battle with us


//Define move variables
moveX = 0;
moveY = 0;

moveSpeed = monsters[ID][mobData.moveSpeed];

moveDir = 0

//Set alarm to inact movement
alarm_set(0, 1);


//Define being damaged
beingDamaged = false;