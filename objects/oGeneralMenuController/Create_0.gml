//Set can select and selected which holds the current selected slot
canSelect = false;
selected = 0;



//Define changing values for when we need to change a value via menu
enum changeValues {
	none,
	volume
}
changingValue = changeValues.none;



//Define the options and menus that can be used
enum menus {
	main,
	items,
	equipment,
	system
}
menu = menus.main;

mainOptions = ["Items", "Equipment", "System"];
systemOptions = ["Volume", "Fullscreen"];
options = mainOptions;



//Define transition states
enum transStates {
	up,
	left,
	right,
	down,
	
	partyDown,
	partyUp,
	
	systemDown,
	systemUp
}
transState = transStates.up;



//Define variables for the main box's location and destination
mainBoxOffScreenDestX = (cameraWidth / 2) - (sprite_get_width(sGMBox) / 2);
mainBoxOffScreenDestY = cameraHeight + sprite_get_height(sGMBox);

mainBoxOnScreenDestX = 32;
mainBoxOnScreenDestY = (cameraHeight / 2) - (sprite_get_height(sGMBox) / 2);

mainBoxDestX = mainBoxOffScreenDestX;
mainBoxDestY = mainBoxOffScreenDestY;

mainBoxX = mainBoxDestX;
mainBoxY = mainBoxDestY;


//Define variables for the party box's location and destination
partyBoxOffScreenDestY = -sprite_get_height(sPartyBox) - 32;
partyBoxOnScreenDestY = (cameraHeight / 2) - (sprite_get_height(sPartyBox) / 2);

partyBoxDestY = partyBoxOffScreenDestY;

partyBoxX = cameraWidth - sprite_get_width(sPartyBox) - 32;
partyBoxY = partyBoxDestY;


//Define variables for the system box's location and destination
systemBoxOffScreenDestY = -sprite_get_height(sSystemBox) - 32;
systemBoxOnScreenDestY = mainBoxOnScreenDestY + (sprite_get_height(sGMBox) / 2) - (sprite_get_height(sSystemBox) / 2);

systemBoxDestY = systemBoxOffScreenDestY;

systemBoxX = mainBoxOnScreenDestX + sprite_get_width(sGMBox) + 4;
systemBoxY = systemBoxDestY;



//Woo system controller stuff wooooooo