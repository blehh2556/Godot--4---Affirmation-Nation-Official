extends Control

#var affirmation_1 = $Panel/affirmation_1.text
#var affirmation_2 = $Panel/affirmation_2.text
#var affirmation_3 = $Panel/affirmation_3.text

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_point_data()
	$Panel/display_points.text = "Points: " + str(Global.player_point)
	print("Points: ", Global.player_point)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Global.player_point)
	pass


func _on_submit_pressed():
	if $Panel/affirmation_1.text != "":
		Global.player_point += 1
	if $Panel/affirmation_2.text != "":
		Global.player_point += 1
	if $Panel/affirmation_3.text != "":
		Global.player_point += 1
	Global.save_points()
