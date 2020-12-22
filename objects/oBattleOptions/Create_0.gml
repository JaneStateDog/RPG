//Define can select
canSelect = true; //false


//Define states enum
enum states {
	select,
	chooseAttack,
	attacking
}

//Define state
state = states.select


//Define options
selectOptions = ["Attack", "Defend", "Run"];


//Define turn (this is the current member turn)
turn = -1; //Do this so we can properly set it in the first frame of the step


//Define attacking variables
enum attackStates {
	run,
	attack,
	runBack
}

attackState = attackStates.run;

didHit = false;
didHitMob = false;

queuedAttacks = 0;
queuedMonsterAttacks = 0;

spikeAttack = false;


//Define selected
selected = 0;

//Function to fix selected and prevent it from going over or under the limit
function fix_selected(number, dir) {
	if (selected >= number) selected = 0;
	else if (selected < 0) selected = number - 1;
		
	if (state == states.chooseAttack) if (monsterEntities[selected].HP <= 0) {
		if (dir) selected++; else selected--;
		fix_selected(number, dir);
	}
}


//Define destination y variables
normalScreenDest = 300;
belowScreenDest = 400;

destinationY = normalScreenDest;

//Define platformer surface destination y variables
platSurfAboveScreenDest = -platSurfHeight - 32;
platSurfNormalScreenDest = room_height / 2;

platSurDestY = platSurfAboveScreenDest;