//Do different things depending on the transition at play
if (transition == transitions.toBattle or transition == transitions.fromBattle) {
	//Set some values and go to the set room
	transOut = false;
	lerpSpeed = ogLerpSpeed;
			
	room = roomGoTo;
}