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
	"left_button": "Left Button"
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
		if controller_name.containsn(name):
			print("Controller type found, %s" % name)
			_binding_name = name
			break
	_modify_bindings()
	pass

func _load_bindings_file(file_name: String):
	print("Loading file %s" % file_name)
	pass

func _modify_bindings():
	if _binding_name == "default":
		print("Unknown controller, no modification")
		return
	var file_name = _binding_name+".json"
	var file_data = _load_bindings_file(file_name)
	

func get_binding_from_action(action: String) -> String:
	return action
	pass
	
