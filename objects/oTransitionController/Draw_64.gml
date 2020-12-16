//Set draw color
draw_set_color(c_white);


//Depending on what transition we are doing do different things
switch (transition) {
	case transitions.toBattle: //Go to battle
		draw_set_color(c_red);
		diagonal_draw(); 
		
		break;
	case transitions.fromBattle: diagonal_draw(); break; //Leave battle
}