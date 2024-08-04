extends CanvasLayer

var affirmation_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_button_pressed():
	toggle_menu()

func toggle_menu():
	affirmation_open = !affirmation_open
	if affirmation_open:
		$Affirmation.visible = true
	else:
		$Affirmation.visible = false
