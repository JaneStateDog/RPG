//Define monsters (array that holds all monster data)
globalvar monsters;
monsters = [];

//Define mob data (enum that holds the data, such as  and strength, that is in the monsters. Use this to index the array
//in the monsters array)
enum mobData {
	maxHP,
	maxDef,
	maxStr,
	
	sprIdle,
	sprRun,
	sprAttack,
	
	moveSpeed,
	
	platLevel,
	attackSpeed
}

//Define mobs (enum that holds the monster names. Use this to index the monsters array)
enum mobs {
	goblin,
	leg,
	spider,
	mouthCat
}

//Function to create monsters
function monster_create(ID, maxHP, maxDef, maxStr, sprIdle, sprRun, sprAttack, moveSpeed, platLevel, attackSpeed) {
	monsters[ID][mobData.maxHP] = maxHP;
	monsters[ID][mobData.maxDef] = maxDef;
	monsters[ID][mobData.maxStr] = maxStr;
	
	monsters[ID][mobData.sprIdle] = sprIdle;
	monsters[ID][mobData.sprRun] = sprRun;
	monsters[ID][mobData.sprAttack] = sprAttack;
	
	monsters[ID][mobData.moveSpeed] = moveSpeed;
	
	monsters[ID][mobData.platLevel] = platLevel;
	monsters[ID][mobData.attackSpeed] = attackSpeed;
}


//Create monsters
monster_create(mobs.goblin, 10, 3, 2.25, sGoblinIdle, sGoblinRun, sGoblinIdle, 1.5, "goblin", 4);
monster_create(mobs.leg, 12, 2, 2, sLegIdle, sLegRun, sLegIdle, 1, "leg", 3);
monster_create(mobs.spider, 30, 4, 8, sSpiderIdle, sSpiderIdle, sSpiderIdle, 0, "spider", 6);
monster_create(mobs.mouthCat, 5, 1, 4, sMouthCatIdle, sMouthCatIdle, sMouthCatBite, 2, "mouthCat", 0);


//Define monster groups
globalvar monsterGroups;
monsterGroups = [];

//Enum for monster groups
enum mobGroups {
	goblin,
	leg,
	goblinLeg1,
	goblinLeg2,
	spider
}

//Function to create monster groups (first argument is the ID for the group (reference mob groups enum above) and the rest of the arugments are the mob IDs for that group)
function monster_group_create(ID) {
	for (i = 0; i < argument_count - 1; i++) monsterGroups[ID][i] = argument[i + 1];
}

//Create monster groups
monster_group_create(mobGroups.goblin, mobs.goblin, mobs.goblin);
monster_group_create(mobGroups.leg, mobs.leg, mobs.leg);
monster_group_create(mobGroups.goblinLeg1, mobs.goblin, mobs.leg, mobs.goblin);
monster_group_create(mobGroups.goblinLeg2, mobs.leg, mobs.goblin, mobs.leg);
monster_group_create(mobGroups.spider, mobs.mouthCat, mobs.spider, mobs.mouthCat,);




//Define max level
globalvar maxLevel;
maxLevel = 100;

//Define party members array
globalvar members;
members = [];

//Define member data (enum to hold all members' data such as defense and strength. Use this for indexing the array
//inside the members array)
enum memberData {
	name,
	
	level,
	
	maxHP,
	HP,
	maxDef,
	def,
	maxStr,
	str,
	
	sprIdle,
	sprRun,
	sprDefend,
	sprAttack
}

//Define member names (enum to hold all members' names. Use this for indexing the members array)
enum memberNames {
	player,
	John //Put John in FOR TESTING PURPOSES
}

//Function to create members
function member_create(name, ID, level, maxHP, maxDef, maxStr, sprIdle, sprRun, sprDefend, sprAttack) {
	members[ID][memberData.name] = name;
	
	if (level <= maxLevel) members[ID][memberData.level] = level; else members[ID][memberData.level] = 1;
	
	members[ID][memberData.maxHP] = maxHP;
	members[ID][memberData.HP] = maxHP;
	members[ID][memberData.maxDef] = maxDef;
	members[ID][memberData.def] = maxDef;
	members[ID][memberData.maxStr] = maxStr;
	members[ID][memberData.str] = maxStr;
	
	members[ID][memberData.sprIdle] = sprIdle;
	members[ID][memberData.sprRun] = sprRun;
	members[ID][memberData.sprDefend] = sprDefend;
	members[ID][memberData.sprAttack] = sprAttack;
}

//Create the members
member_create("Player", memberNames.player, 1, 15, 2, 3.5, sPlayerIdle, sPlayerRun, sPlayerDefend, sPlayerSwordStrike);
member_create("John", memberNames.John, 1, 10, 2, 2.5, sPlayerIdle, sPlayerRun, sPlayerDefend, sPlayerIdle); //Put John in FOR TESTING PURPOSES

//Define party array (this array stores the current party)
globalvar party;
party = [memberNames.player, memberNames.John]; //Put John in FOR TESTING PURPOSES


//Define queued monsters array (this array stores the monsters currently lined up for battle)
globalvar queuedMonsters;
queuedMonsters = [];


//Define queued monster group
globalvar queuedMonsterGroup;
queuedMonsterGroup = -1;




//Define items (array  that holds all items and their data
globalvar items;
items = [];

//Enum for all item names
enum itemNames {
	potion,
	dmg
}

//Enum for all item data and is used for indexing the items array
enum itemData {
	name,
	sprite,
	description,
	
	onlyInBattle //This is if the item can only be used in battle or not
}

//Function to create items
function item_create(name, ID, spr, des, onlyInBattle) {
	items[ID][itemData.name] = name;
	items[ID][itemData.sprite] = spr;
	items[ID][itemData.description] = des;
	
	items[ID][itemData.onlyInBattle] = onlyInBattle;
}

//Create items
item_create("Potion", itemNames.potion, sTestItem, "Heals 2 HP", false);
item_create("Damage", itemNames.dmg, sTestItem, "Does 2 damage to an enemy", true);

//Define item inventory (this holds what items are currently in the player's inventory)
globalvar itemInventory;
itemInventory = [[-1, 0]];

//Enum used for indexing the second dimension of item inventory (used for things like getting the item ID and how many the player has)
enum iIData {
	ID,
	amount
}

//Function to add a item to the player item inventory
function add_item(item, amount) {
	var failed = true;
	
	//Try and add the inputted amount to the existing item in the inventory but if that item is not in the inventory then
	//find a new/empty slot to put it in
	for (i = 0; i < array_length(itemInventory); i++) if (itemInventory[i][iIData.ID] == item) {
		itemInventory[i][iIData.amount] += amount;
		failed = false;
			
		break;
	}
	
	if (failed) for (i = 0; i < array_length(itemInventory); i++) {
		//If we didn't end up finding an empty slot than add it to the end of the array
		if (i == array_length(itemInventory) - 1) {
			var temp = i + 1;
			
			itemInventory[temp][iIData.ID] = item;
			itemInventory[temp][iIData.amount] = amount;
			
			break;
		}
		
		//Add item to empty slot if we find one
		if (itemInventory[i][iIData.ID] == -1) {
			itemInventory[i][iIData.ID] = item;
			itemInventory[i][iIData.amount] = amount;

			break;
		}
	}
}

//Function to remove a item from the player item inventory
function remove_item(item, amount) {
	//Loop through the inventory and find the item in it and remove from it but if we don't find it return false
	var failed = true;
	for (i = 0; i < array_length(itemInventory); i++) if (itemInventory[i][iIData.ID] == item) {
		itemInventory[i][iIData.amount] -= amount;
		failed = false;
			
		break;
	}
	
	return failed;
}

//Add items FOR TESTING PURPOSES
add_item(itemNames.potion, 4);
add_item(itemNames.dmg, 3);




//Function to inact battle
function battle_start(mobGroupID) {
	//Save the room we are in
	overworldIn = room;
	
	//Put the mob group into the queued monsters array then go to the battle room
	if (mobGroupID != -1) queuedMonsters = monsterGroups[mobGroupID];
	
	//Put the monster group ID into the queued monster group
	queuedMonsterGroup = mobGroupID;
	
	//Do transition to move to the battle room
	do_transition(transitions.toBattle);
}



//Function to do death effects
function death_effects(victim) {
	//Do camera shake but more intense because somebody died
	camera_shake(7, 10);
		
	//Make hurt sound effect
	audio_sound_gain(audio_play_sound(sndHurt, 1, false), volume, 0);
		
	//Do large amount of particles
	part_particles_create(particleSystem, victim.drawX, victim.drawY, pDeath, 300);
}

//Function to go to the next turn
function next_turn() {
	//Go to the next turn
	//Get what turn the next turn will be
	var otherTurn = turn + 1;
	if (otherTurn >= array_length(memberEntities)) otherTurn = 0;
		
	//Test if the next member is dead and if so skip their turn
	var times = 1;
	if (memberEntities[party[otherTurn]].HP <= 0) times = 2;
	for (i = 0; i < times; i++) {
		turn++;
		if (turn >= array_length(memberEntities)) turn = 0;
	}
}



//Function for the player to do damage to the monster
function player_attack(player, monster) {
	//Remove health from the monster using a dumb formula
	monster.HP -= (player.str - (monster.def / 2));
			
	//If the monster is out of health test to see if the rest are dead
	//and if not then do the damage animation
	if (monster.HP <= 0) {
		var failed = false;
		for (i = 0; i < array_length(monsterEntities); i++) if (monsterEntities[i].HP > 0) {
			failed = true;
			break;
		}
		if (!failed) do_transition(transitions.fromBattle); //Return to main room CHANGE THIS LATER TO INCLUDE XP AND SUCH
					
		//Do death effects
		death_effects(monster);
		
		attackState = attackStates.runBack;
	} else {
		//If not killed just do damage animation and camera shake
		with (monster) do_damage_animation();
		camera_shake(2, 8);
	}
}

//Function for a monster to do damage to the player
function monster_attack(monster, player) {
	//Remove health from the player using a dumb formula
	var defend = player.def / 2;
	if (player.defending) defend = player.def;
	
	var damage = monster.str - defend;
	if (spikeAttack) damage *= 4;
	if (damage >= 0) player.HP -= damage;
		
	//If the player is out of health then test if all party members are dead
	//and if so then end the game
	if (player.HP <= 0) {
		var failed = false;
		for (i = 0; i < array_length(memberEntities); i++) if (memberEntities[i].HP > 0) {
			failed = true;
			break;
		}
		if (!failed) game_end(); //FIX THIS TO GO TO A DEATH SCREEN OR SOMETHING
			
		//Do death effects
		death_effects(player);
	} else {
		//If not killed just do damage animation and camera shake
		with (player) do_damage_animation();
		camera_shake(2, 8);
	}
}


//Function to do attack animation only on certain frames
function attack_entity(hitFrame, attacker, victim, didHit) {
	//Set sprite
	if (attacker.type == entityType.member) attacker.sprite_index = members[party[attacker.ID]][memberData.sprAttack];
	else if (attacker.type == entityType.monster) attacker.sprite_index = monsters[queuedMonsters[attacker.ID]][mobData.sprAttack];
	
	
	//On the strike hit of the animation, do damage and also set did hit
	if (round(attacker.image_index) == hitFrame) {
		if (!didHit) if (attacker.type == entityType.member) player_attack(attacker, victim); else if (attacker.type == entityType.monster) monster_attack(attacker, victim);
		didHit = true;
	}
					
	//If we have hit and the animation is over, remove from queued attacks
	if (didHit and round(attacker.image_index) == sprite_get_number(attacker.sprite_index)) {
		didHit = false;
		
		//Go to idle animation and subtract from queued attacks
		if (attacker.type == entityType.member) {
			attacker.sprite_index = members[party[attacker.ID]][memberData.sprIdle];
			attacker.image_index = 0;
			
			queuedAttacks--;
		} else if (attacker.type == entityType.monster) {
			attacker.sprite_index = monsters[queuedMonsters[attacker.ID]][mobData.sprIdle];
			queuedMonsterAttacks--;
			
			//If this was from spike damage then run back
			if (spikeAttack) {
				attackState = attackStates.runBack;
				spikeAttack = false;
			}
		}
		
		//If the victim is dead run back
		if (victim.HP <= 0) attackState = attackStates.runBack;
	}
	
	return didHit;
}

//Function to do bounce attack animation
function bounce_attack_entity(attacker, victim, didHit) {
	//Set sprite
	if (attacker.type == entityType.member) attacker.sprite_index = members[party[attacker.ID]][memberData.sprAttack];
	else if (attacker.type == entityType.monster) attacker.sprite_index = monsters[queuedMonsters[attacker.ID]][mobData.sprAttack];
					
	
	//Use a value to add gravity to the attacker's move y
	attacker.moveY += 0.08;
						
	//If in range of the floor and have not hit then bounce
	var range = 0.1;
	if (!didHit and in_range(attacker.drawY, attacker.oldDrawY - range, attacker.oldDrawY + range)) {
		//Make jump sound effect
		audio_sound_gain(audio_play_sound(sndJump, 1, false), volume, 0);
						
		attacker.moveY = -1.75;
	}
					
	//On the land hit of the bounce, do damage and also say we hit this frame
	if ((attacker.drawY + attacker.moveY) >= attacker.oldDrawY) { //Test if on ground
		while ((attacker.drawY + sign(attacker.moveY)) < attacker.oldDrawY) attacker.drawY += sign(attacker.moveY); //Loop till fully on ground
		attacker.moveY = 0; //Reset move y
							
		if (!didHit) if (attacker.type == entityType.member) player_attack(attacker, victim); else if (attacker.type == entityType.monster) monster_attack(attacker, victim);
		didHit = true;
	}
						
	//Add to draw y with move y to actually make them move
	attacker.drawY += attacker.moveY;
					
	//If we have hit this frame and the animation is over, reset attack hit count and remove from queued attacked
	if (didHit) {
		didHit = false;	
		
		attacker.moveY = 0;
		attacker.drawY = attacker.oldDrawY;
		
		//Go to idle animation and subtract from queued attacks
		if (attacker.type == entityType.member) {
			attacker.sprite_index = members[party[attacker.ID]][memberData.sprIdle];
			attacker.image_index = 0;
			
			queuedAttacks--;
		} else if (attacker.type == entityType.monster) {
			attacker.sprite_index = monsters[queuedMonsters[attacker.ID]][mobData.sprIdle];
			queuedMonsterAttacks--;
			
			//If this was from spike damage then run back
			if (spikeAttack) {
				attackState = attackStates.runBack;
				spikeAttack = false;
			}
		}
		
		//If the victim is dead run back
		if (victim.HP <= 0) attackState = attackStates.runBack;
	}
	
	return didHit;
}