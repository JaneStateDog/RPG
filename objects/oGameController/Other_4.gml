//Put walls at all collidable tiles
//Set some variables
var tileMapID = -1;
var collidableTiles = [];

//Depending on what layers exist then add to collidable tiles the tiles we want to place walls on
var lay = "TilesetBottom";
var tileset;

if (layer_exists(lay)) {
	tileMapID = layer_tilemap_get_id(layer_get_id(lay));
	tileset = tilemap_get_tileset(tileMapID);
		
	//Change what collidable tiles get set using what tileset is used
	switch (tileset) {
		case tsDesert:
			collidableTiles[0] = 3; //Cactus
			collidableTiles[1] = 4; //Rocks
		
			break;
	}
}

//If there is a tilemap then loop through all of the room by 32 intervls (because that's how large the cells are)
//and find out if what's in that cell is in the collidable tiles array and if so then palce a wall there
if (tileMapID != -1) for (i = 0; i < room_width; i += 32) for (b = 0; b < room_height; b += 32) {
	var tile = tilemap_get_at_pixel(tileMapID, i, b);
	if (tile != 0) for (v = 0; v < array_length(collidableTiles); v++) {
		if (tile == collidableTiles[v] and layer_exists("Walls")) instance_create_layer(i, b, "Walls", oWall);
	}
}