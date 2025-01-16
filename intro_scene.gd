extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer2/file_name_input.text = Data.file_name.split("-")[1].split(".")[0]
	$HBoxContainer2/player_name_input.text = Data.player_name
	$HSlider.value = Data.question_count
	for action in Data.get_all_actions():
		$OptionButton.add_item(action)
	Input.connect("joy_connection_changed",handle_controller_connection)
	check_controller_status()
	pass # Replace with function body.

func check_controller_status():
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
	

func handle_controller_connection(device:int, connected:bool):
	var device_name = Input.get_joy_name(device)
	if connected:
		print("Controller %s (%s) connected" % [device_name, device])
	else:
		print("Controller %s discconnected" % [device])
	check_controller_status()


func _on_vibration_check_pressed() -> void:
	Data.vibration = $vibration_check.button_pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _start_button_pressed() -> void:
	Data.player_name = $HBoxContainer2/player_name_input.text
	Data.file_name= Data.player_name + "-" + $HBoxContainer2/file_name_input.text + ".json"
	get_tree().change_scene_to_file("res://MainScene.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	Data.question_count = value
	$slidername.text = str(value)+"/50"


func _on_option_button_item_selected(index: int) -> void:
	print(index)
	Data.actions_file = Data.get_all_actions()[index]
