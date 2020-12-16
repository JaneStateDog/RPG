//Set data depending on the type
switch (type) {
	case entityType.member:
		sprite_index = members[party[ID]][memberData.sprIdle];
	
		level = members[party[ID]][memberData.level];
		HP = members[party[ID]][memberData.HP];
		str = members[party[ID]][memberData.str];
		def = members[party[ID]][memberData.def];
	
		break;
		
	case entityType.monster:
		sprite_index = monsters[queuedMonsters[ID]][mobData.sprIdle];
	
		HP = monsters[queuedMonsters[ID]][mobData.maxHP];
		str = monsters[queuedMonsters[ID]][mobData.maxStr];
		def = monsters[queuedMonsters[ID]][mobData.maxDef];

		break;
}