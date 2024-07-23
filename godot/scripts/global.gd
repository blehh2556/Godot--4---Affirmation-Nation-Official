extends Node


var player_current_axe = false
var tree_inaxe_range = false
var save_path = "user://wood.save"
var player_wood : int
var save_path1 = "user://point.save"
var player_point : int
var save_path2 = "user://coin.save"
var player_coin : int
var affirmation_1_prev_date : String = Time.get_date_string_from_system(true)

func _process(delta):
	load_wood_data()
	load_point_data()
	load_coin_data()

func save_wood():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(player_wood)

func load_wood_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		player_wood = file.get_var(player_wood)

func save_points():
	var file = FileAccess.open(save_path1, FileAccess.WRITE)
	file.store_var(player_point)

func load_point_data():
	if FileAccess.file_exists(save_path1):
		var file = FileAccess.open(save_path1, FileAccess.READ)
		player_point = file.get_var(player_point)

func save_coins():
	var file = FileAccess.open(save_path2, FileAccess.WRITE)
	file.store_var(player_coin)

func load_coin_data():
	if FileAccess.file_exists(save_path2):
		var file = FileAccess.open(save_path2, FileAccess.READ)
		player_coin = file.get_var(player_coin)
