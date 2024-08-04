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
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func set_item_data(data):
	item_type = data["type"]
	item_texture = data["texture"]
