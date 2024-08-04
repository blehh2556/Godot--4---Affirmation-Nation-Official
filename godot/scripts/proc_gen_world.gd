extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D
@onready var player = $Player

var noise : Noise
var tree_noise : Noise

var width : int = 100
var height : int = 100

var noise_val_arr = []

@onready var tile_map = $TileMap

var source_id = 5
var water_atlas = Vector2i(0,0)
var land_atlas = Vector2i(1,0)

var sand_tiles_arr = []
var terrain_sand_int = 1

var grass_tiles_arr = []
var terrain_grass_int = 0

var cliff_tiles_arr = []
var terrain_cliff_int = 2

var water_layer = 0
var ground_1_layer = 1
var ground_2_layer = 2
var cliff_layer = 3
var environment_layer = 4

var tree_atlas_arr = [Vector2i(1,0), Vector2i(3,0)]
func _ready():
	noise = noise_height_text.noise
	tree_noise = noise_tree_text.noise
	generate_world()

func _process(delta):
	player_in_water()
	pass

	
func generate_world():
	for x in range(-width/2, width/2):
		for y in  range(-height/2, height/2):
			var noise_val : float = noise.get_noise_2d(x,y)
			var tree_noise_val : float = tree_noise.get_noise_2d(x,y)
			noise_val_arr.append(tree_noise_val)
			
			if noise_val >= -0.1:
				if noise_val > 0.05 and noise_val < 0.17 and tree_noise_val > 0.8:
					tile_map.set_cell(environment_layer, Vector2i(x,y), 19, Vector2i(0,0),2)
				if noise_val > 0.05 and noise_val < 0.17 and tree_noise_val < -0.5:
					tile_map.set_cell(environment_layer, Vector2i(x,y), 19, Vector2i(0,0),1)
				if noise_val > 0.2:
					if noise_val >0.4:
						cliff_tiles_arr.append(Vector2i(x,y))
					
					grass_tiles_arr.append(Vector2i(x,y))
				sand_tiles_arr.append(Vector2i(x,y))
				
			tile_map.set_cell(water_layer, Vector2(x,y), 20, water_atlas)
	tile_map.set_cells_terrain_connect(ground_1_layer, sand_tiles_arr,0,terrain_sand_int)
	tile_map.set_cells_terrain_connect(ground_2_layer, grass_tiles_arr,0,terrain_grass_int)
	tile_map.set_cells_terrain_connect(cliff_layer, cliff_tiles_arr,0,terrain_cliff_int)

func player_in_water():
	var tile_data : TileData = tile_map.get_cell_tile_data(1, tile_map.local_to_map(player.position))
	#print(tile_data)
	if tile_data == null:
		player.in_water()
	else:
		player.on_land()
	pass
