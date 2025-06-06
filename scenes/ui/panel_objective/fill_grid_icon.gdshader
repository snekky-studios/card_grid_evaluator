shader_type canvas_item;

//const int NUM_COLS = 5;
//const int NUM_ROWS = 5;
//const int NUM_TILES = NUM_ROWS * NUM_COLS;
//
//uniform vec2 tiles[NUM_COLS][NUM_ROWS];

uniform sampler2D tex;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	//for(int index_tile_col = 0; index_tile_col < NUM_COLS; index_tile_col++)
	//{
		//for(int index_tile_row = 0; index_tile_row < NUM_ROWS; index_tile_row++)
		//{
			//if(UV == tiles[index_tile_col][index_tile_row])
			//{
				//
			//}
		//}
	//}
	COLOR = color;
}
