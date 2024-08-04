extends Node

@onready var inventory_slot_scene = preload("res://scenes/inventory_slot.tscn")

var player_current_axe = false
var tree_inaxe_range = false


var save_path = "user://wood.save"
var player_wood : int
var save_path1 = "user://point.save"
var player_point : int
var save_path2 = "user://coin.save"
var player_coin : int
var save_path3 = "user://aff1.save"
var save_path4 = "user://aff2.save"
var save_path5 = "user://aff3.save"
var affirmation_1_date : String
var affirmation_2_date : String
var affirmation_3_date : String

var save_path6 = "user://inventory.save"
var inventory = []
var player_node = null

#var buildings_dropped = []



signal inventory_updated

func _ready():
	inventory.resize(9)

func _process(delta):
	load_wood_data()
	load_point_data()
	load_coin_data()
	load_aff1_date()
	load_aff2_date()
	load_aff3_date()
	#load_inventory_data()

func set_player_reference(player):
	player_node = player

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and  inventory[i]["type"] == item["type"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			print("item added", inventory)
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			print("item added", inventory)
			return true
	return false

func remove_item(item_type):
	for i in range(inventory.size()):
		if inventory[i] != null and  inventory[i]["type"] == item_type:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			save_inventory()
			return true
	save_inventory()
	return false

func adjust_drop_position(position):
	var radius = 100
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_position.distance_to(position) < radius:
			var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position

func drop_item(item_data, drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position = adjust_drop_position(drop_position)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)
	

func save_inventory():
	var file = FileAccess.open(save_path6, FileAccess.WRITE)
	file.store_var(inventory)

func save_wood():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(player_wood)

#func load_inventory_data():
	#if FileAccess.file_exists(save_path6):
		#var file = FileAccess.open(save_path6, FileAccess.READ)
		#inventory = file.get_var(inventory)

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

func save_aff1_date():
	var file = FileAccess.open(save_path3, FileAccess.WRITE)
	file.store_var(affirmation_1_date)

func save_aff2_date():
	var file = FileAccess.open(save_path4, FileAccess.WRITE)
	file.store_var(affirmation_2_date)

func save_aff3_date():
	var file = FileAccess.open(save_path5, FileAccess.WRITE)
	file.store_var(affirmation_3_date)

func load_aff1_date():
	if FileAccess.file_exists(save_path3):
		var file = FileAccess.open(save_path3, FileAccess.READ)
		affirmation_1_date = file.get_var(true)

func load_aff2_date():
	if FileAccess.file_exists(save_path4):
		var file = FileAccess.open(save_path4, FileAccess.READ)
		affirmation_2_date = file.get_var(true)

func load_aff3_date():
	if FileAccess.file_exists(save_path5):
		var file = FileAccess.open(save_path5, FileAccess.READ)
		affirmation_3_date = file.get_var(true)
		#print(affirmation_3_date)
