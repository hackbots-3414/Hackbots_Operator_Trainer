extends Node


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
var _default_binding_names = {
	"left_trigger": "Left Trigger",
	"left_bumper": "Left Bumper",
	"right_trigger": "Right Trigger",
	"right_bumper": "Right Bumper",
	"dpad_up": "Dpad Up",
	"dpad_down": "Dpad Down",
	"dpad_right": "Dpad right",
	"dpad_left": "Dpad left",
	"back": "Back",
	"start": "Start",
	"up_button": "Up Button",
	"right_button": "Right Button",
	"down_button": "Down Button",
	"left_button": "Left Button",
	"left_stick_press": "Left stick press",
	"right_stick_press": "Right stick press",
	"share": "Share",
	"home": "Home",
	"touchpad": "Touchpad"
}

var _controller_bindings = {}

var _binding_name = "default"

func _get_clean_bindings_names():
	# Loads all of the files within the res://controllers directory, removes the .json ending, and returns them
	var dirty_names = DirAccess.get_files_at("res://controllers")
	var clean_names = []
	for name in dirty_names:
		clean_names.append(name.split(".")[0])
	return clean_names

func set_bindings_for_controller_type(controller_name: String):
	print("Setting bindings for controller")
	var names = _get_clean_bindings_names()
	_controller_bindings = _default_binding_names
	for name in names:
		var possible_names = _get_possible_controller_names(name)
		for possible_name in possible_names:
			if controller_name.containsn(possible_name):
				print("Controller type found, %s (%s)" % [possible_name, name])
				_binding_name = name
				break
	_modify_bindings()
	
func _get_possible_controller_names(file_name: String):
	var file = FileAccess.open("res://controllers/%s.json" % file_name, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data.get("possible-names")

func _load_bindings_file(file_name: String):
	print("Loading file %s" % file_name)
	var file = FileAccess.open("res://controllers/%s" % file_name, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data.get("binding-names")

func _modify_bindings():
	if _binding_name == "default":
		print("Unknown controller, no modification")
		return
	var file_name = _binding_name+".json"
	var file_data = _load_bindings_file(file_name)
	print("Starting binding modification")
	for binding in file_data.keys():
		if binding in _controller_bindings.keys():
			_controller_bindings[binding] = file_data[binding]
		else:
			print("Action name %s unknown!" % binding)
	print("Binding modification finished")
	
	

func get_binding_from_action(action: String) -> String:
	### Returns the correct binding name based on the action name
	return _controller_bindings[action]
	pass
	
