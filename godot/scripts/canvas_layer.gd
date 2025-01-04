extends CanvasLayer

@onready var progress_bar = $HBoxContainer/ProgressBar
@onready var level_label = $HBoxContainer/Label



var affirmation_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.update_level()
	update_ui()



func _on_button_pressed():
	toggle_menu()

func toggle_menu():
	affirmation_open = !affirmation_open
	if affirmation_open:
		$Affirmation.visible = true
	else:
		$Affirmation.visible = false

# Update the UI
func update_ui():
	var current_level = Global.player_lvl
	var current_points = Global.player_point
	var points_for_current_level = Global.nextLevel(current_level - 1) if current_level > 1 else 0
	var points_for_next_level = Global.nextLevel(current_level)
	var progress = (current_points - points_for_current_level) / float(points_for_next_level - points_for_current_level)
	progress_bar.value = progress * 100
	level_label.text = "Lvl %d" % current_level
