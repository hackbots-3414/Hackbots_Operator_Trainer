extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var controllers = Input.get_connected_joypads()
	var controller_label:Label = $VBoxContainer/HBoxContainer2/controller_connect_text
	var controller_settings = controller_label.label_settings
	
	if len(controllers) > 0:
		controller_settings.font_color = Color("#00FF00")
		controller_label.text = "Controller Connected!"
	else:
		controller_settings.font_color = Color("#FF0000")
		controller_label.text = "No Controller Connected!"


func _start_button_pressed() -> void:
	pass # Replace with function body.
