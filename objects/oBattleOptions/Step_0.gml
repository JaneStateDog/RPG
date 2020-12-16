//Lerp up to the proper spot
y = lerp(y, destinationY, 0.08);

//Lerp the platformer surface to the proper spot
platSurfY = lerp(platSurfY, platSurDestY, 0.08);


//Set turn
if (turn == -1) next_turn();


//Only do selcting things if we can select
if (canSelect) {
	//Get the limit for selected
	var number = 0;
	switch (state) {
		case states.select: number = array_length(selectOptions); break;
		case states.chooseAttack: number = array_length(monsterEntities); break;
	}

	//If pressing a key and not in attacking state then change selection using those keys and other fancy stuff
	if ((keyDownPressed or keyLeftPressed or keyUpPressed or keyRightPressed) and state != states.attacking) {
		//Change selected depending on which keys are pressed
		var dir = true;
		if (keyDownPressed or keyLeftPressed) {
			selected++;
			dir = true;
		} else if (keyUpPressed or keyRightPressed) {
			selected--; 
			dir = false;
		}

		//Fix selected
		fix_selected(number, dir);
	
		//Make select sound effect
		audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
	}


	//Get the current selected monster and player
	var monster = 0;
	if (state != states.select) monster = monsterEntities[selected];
	var player = memberEntities[party[turn]];


	//Do a switch statement to do different things depending on the state
	switch (state) {
		case states.select: //Selecting if you want to attack, defend, etc.
			//Move the options menu onto the screen
			destinationY = normalScreenDest;
		
	
			if (keySpacePressed) switch (selected) {
				case 0: //Attack
					//Make select sound effect
					audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
			
					//Switch to attack state
					state = states.chooseAttack;
				
					//Fix selected to make sure it is not on top of dead monsters
					fix_selected(array_length(monsterEntities), true);

					break;
				case 1: //Defend
					//Make select sound effect
					audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
			
					//Switch to attacking state and defend
					player.defending = true;
					state = states.attacking;
				
					//Fix selected to make sure it is not on top of dead monsters
					for (i = 0; i < array_length(monsterEntities); i++) if (monsterEntities[i].HP > 0) {
						selected = i;
						break;
					}
				
					//Change sprite to defending sprite
					player.sprite_index = members[party[player.ID]][memberData.sprDefend];
	
					break;
				case 2: //Run
					//Make select sound effect
					audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
			
					//Go to the main room
					do_transition(transitions.fromBattle);
	
					break;
			}
		
			break;
		
		case states.chooseAttack: //Selecting and attacking a monster
			//Move the options menu below the screen
			destinationY = belowScreenDest;
		
	
			//On escape press go back to the select state and reset selected
			if (keyEscapePressed) {
				//Make select sound effect
				audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
			
				state = states.select;
				selected = 0;
			
				break;
			} 
		
			//If the selected monster isn't dead and you hit space go to attacking
			if (keySpacePressed) {
				//Make select sound effect
				audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
			
				if (!monster.HP <= 0) state = states.attacking; break;
			}
		
			break;
		
		case states.attacking: //Have the attacking happen
			//Place the level into the room
			if (!instance_exists(oPlatController)) run_level(monsters[queuedMonsters[monster.ID]][mobData.platLevel]);
		
			//If we are defending then delete the attack cubes so we can't attack
			if (player.defending) instance_destroy(oPlatAttack);
		
			//Move the platformer surface to the screen
			platSurDestY = platSurfNormalScreenDest;
	
			//Send the player and monster to their proper layers
			player.layer = layer_get_id("TopEntities");
			monster.layer = layer_get_id("BottomEntities");
	
	
			//Set running sprite if we are running to or from the target
			if (attackState == attackStates.run or attackState == attackStates.runBack) {
				if (player.HP > 0) player.sprite_index = members[party[player.ID]][memberData.sprRun]; else player.sprite_index = members[party[player.ID]][memberData.sprIdle];
				if (monster.HP > 0) monster.sprite_index = monsters[queuedMonsters[monster.ID]][mobData.sprRun]; else player.sprite_index = members[party[player.ID]][memberData.sprIdle];
			}
			
			
			//Set some variables
			var lerpSpeed = 0.1;
			var range = 2;
			
			//Depending on the attack state do different things
			switch (attackState) {
				case attackStates.run:
					//Define target position
					var targetX = room_width / 2;
					var targetY = 96;
				
					var offset = 16;
			
					//Lerp to the target
					player.drawX = lerp(player.drawX, targetX + offset, lerpSpeed);
					player.drawY = lerp(player.drawY, targetY, lerpSpeed);
				
					monster.drawX = lerp(monster.drawX, targetX - offset, lerpSpeed);
					monster.drawY = lerp(monster.drawY, targetY, lerpSpeed);
					

					//Once we get to the target then snap to the correct position and then start attacking
					var targX = targetX + offset;
					if (in_range(player.drawX, targX - range, targX + range) and in_range(player.drawY, targetY - range, targetY + range)) {
						player.drawX = targetX + offset;
						player.drawY = targetY;
						player.oldDrawY = player.drawY;
					
						monster.drawX = targetX - offset;
						monster.drawY = targetY;
						monster.oldDrawY = monster.drawY;
					
						//Put the entities into their idle state
						player.sprite_index = members[party[player.ID]][memberData.sprIdle];
						monster.sprite_index = monsters[queuedMonsters[monster.ID]][mobData.sprIdle];
					
						attackState = attackStates.attack;
					}
					
					break;
					
				case attackStates.attack:
					//If alarm is not running then set it
					if (alarm_get(0) == -1) alarm_set(0, room_speed * monsters[queuedMonsters[monster.ID]][mobData.attackSpeed]);
				
					//If we have queued attacks then have the monster attack
					if (queuedMonsterAttacks > 0) switch (queuedMonsters[monster.ID]) {
						case mobs.goblin: didHitMob = bounce_attack_entity(monster, player, didHitMob); break; //Goblin
						case mobs.leg: didHitMob = bounce_attack_entity(monster, player, didHitMob); break; //Leg
					} else monster.sprite_index = monsters[queuedMonsters[monster.ID]][mobData.sprIdle];
				
				

					//If we have queued attacks then have the member attack
					if (queuedAttacks > 0) switch (party[player.ID]) {
						case memberNames.player: didHit = attack_entity(4, player, monster, didHit); break; //Player
						case memberNames.John: didHit = bounce_attack_entity(player, monster, didHit); break; //John
					} else player.sprite_index = members[party[player.ID]][memberData.sprIdle];
				
					//If defending set the defending sprite
					if (player.defending) player.sprite_index = members[party[player.ID]][memberData.sprDefend];
				
					//If the player runs over certain objects then do certain things
					if (instance_exists(oPlatPlayer)) with (oPlatPlayer) {
						//If the player runs over an attack cube then add to queued attackes
						var atk = instance_place(x, y, oPlatAttack);
						if (atk != noone) {
							other.queuedAttacks++;
							instance_destroy(atk);
						}
						
						//IF the player runs over an exit cube then go to the next state in the attack
						if (place_meeting(x, y, oPlatExit)) {
							other.attackState = attackStates.runBack;
					
							//Make select sound effect
							audio_sound_gain(audio_play_sound(sndSelect, 1, false), volume, 0);
						}
						
						//If the player runs over spikes then do lots of damage to the player and end the attack
						if (place_meeting(x, y, oPlatSpikes)) {
							other.queuedMonsterAttacks++;
							other.spikeAttack = true;
							
							part_particles_create(particlePlatSystem, x + platSurfX - platCamX + (platSurfWidth / 2), 
												  y + platSurfY - platCamY + (platSurfHeight / 2), pBlood, 200);
							
							instance_destroy(self);
						}
					}
				
					break;
					
				case attackStates.runBack:
					//Disable the platformer player
					if (instance_exists(oPlatPlayer)) oPlatPlayer.canMove = false;
				
				
					//Set the x scale for player and monster
					if (player.HP > 0) player.image_xscale = 1;
					if (monster.HP > 0) monster.image_xscale = -1;
					
				
					//Lerp to the target
					player.drawX = lerp(player.drawX, player.x, lerpSpeed);
					player.drawY = lerp(player.drawY, player.y, lerpSpeed);
				
					monster.drawX = lerp(monster.drawX, monster.x, lerpSpeed);
					monster.drawY = lerp(monster.drawY, monster.y, lerpSpeed);
				
				
					//Move the options menu onto the screen
					destinationY = normalScreenDest;
					
					//Move the platformer surface
					platSurDestY = platSurfAboveScreenDest;
					
						
					//Reset the queued attacks
					queuedAttacks = 0;
					queuedMonsterAttacks = 0;
				
					//Reset player defending
					player.defending = false;
				
					//Reset monster attack alarm
					alarm_set(0, 0);
					
					
					//Once we get to the target then reset a bunch of things and start moving the platformer surface away
					if (in_range(player.drawX, player.x - range, player.x + range) and in_range(player.drawY, player.y - range, player.y + range)) {
						//Snap to the proper location of the target
						player.drawX = player.x;
						player.drawY = player.y;
					
						monster.drawX = monster.x;
						monster.drawY = monster.y;
					
						//Set the x scale for player and monster
						player.image_xscale = -1;
						monster.image_xscale = 1;
					
						//Go back to the idle animation
						player.sprite_index = members[party[player.ID]][memberData.sprIdle];
						monster.sprite_index = monsters[queuedMonsters[monster.ID]][mobData.sprIdle];
					
		
						//Test if the platformer surface is in it's destination range and if so move to the next stage
						if (in_range(platSurfY, platSurDestY - range, platSurDestY + range)) {
							//Reset selected
							selected = 0;
							
							//Reset the attack state
							attackState = attackStates.run;
				
							//Set state
							state = states.select;
						
							//Go to the next turn
							next_turn();
						
							//Destroy the exisitng platformer controller
							instance_destroy(oPlatController);
						}
					}
				
					break;
			}
		
			break;
	}
}



if (keyCtrl and keyRPressed) next_turn(); //DEBUG THINGY FOR SWITCHING TURNS