extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player

var affirmation_open = false


func _ready():
	#player.in_water()
	print(tile_map.local_to_map(player.position))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_in_water()
	get_wood()
	get_coin()
	#pass

func player_in_water():
	var tile_data : TileData = tile_map.get_cell_tile_data(1, tile_map.local_to_map(player.position))
	#print(tile_data)
	if tile_data == null:
		player.in_water()
	else:
		player.on_land()
	pass

func get_wood():
	Global.load_wood_data()
	$CanvasLayer/Panel/wood_label.text = str(Global.player_wood)

func get_coin():
	Global.load_coin_data()
	$CanvasLayer/coin_count.text = str(Global.player_coin)

func _on_button_pressed():
	toggle_menu()
	

func toggle_menu():
	affirmation_open = !affirmation_open
	if affirmation_open:
		$CanvasLayer/Affirmation.visible = true
	else:
		$CanvasLayer/Affirmation.visible = false
