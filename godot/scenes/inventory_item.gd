@tool
extends Node2D


var item_type = ""
var item_texture : Texture
var scene_path : String = "res://scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D/Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func set_item_data(data):
	item_type = data["type"]
	item_texture = data["texture"]


func _on_button_pressed():
	$remove.visible = !$remove.visible


func _on_remove_house_pressed():
	var item_prices = {
		"small_house": 100,
		"small_hut": 100,
		"small_tavern": 150,
		"dock_house": 250,
		"big_hut": 500,
		"keep": 500
	}
	
	if item_type in item_prices:
		var refund = max(item_prices[item_type] - 30, 0) # Ensure refund is not negative
		Global.player_wood += refund
		Global.save_wood() # Save updated wood value
		print("Refunded wood:", refund)
	
	
	for i in range(Global.buildings_dropped.size()):
		var saved_building = Global.buildings_dropped[i]
		if saved_building["type"] == item_type and saved_building["position"] == self.global_position:
			Global.buildings_dropped.remove_at(i)
			Global.save_building_data()
			break
	self.queue_free()
