extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var controllers = Input.get_connected_joypads()
	var controller_label:Label = $VBoxContainer/HBoxContainer2/controller_connect_text
	var start_button:Button = $VBoxContainer/start_button
	var controller_settings = controller_label.label_settings
	
	if len(controllers) > 0:
		controller_settings.font_color = Color("#00FF00")
		controller_label.text = "Controller Connected!"
		start_button.disabled = false
	else:
		controller_settings.font_color = Color("#FF0000")
		controller_label.text = "No Controller Connected!"
		start_button.disabled = true


func _start_button_pressed() -> void:
	Data.player_name = $HBoxContainer2/player_name_input.text
	Data.file_name= Data.player_name + "-" + $HBoxContainer2/file_name_input.text + ".json"
	get_tree().change_scene_to_file("res://MainScene.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	Data.question_count = value
	$slidername.text = str(value)+"/50"
