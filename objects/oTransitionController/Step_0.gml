//Depending on what transition we are doing do different things
switch (transition) {
	case transitions.toBattle: diagonal_move(rBattle); break; //Go to battle
	case transitions.fromBattle: //Leave battle
		diagonal_move(rMain);
		
		if (instance_exists(oBattleOptions)) with (oBattleOptions) destinationY = belowScreenDest;
		if (instance_exists(oBattleEntityController)) oBattleEntityController.destinationEntityX = 0;
		
		break;
}