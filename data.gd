extends Node

var player_data = {}

var player_name = "hackbot"

var question_count = 20

var file_name = "test-last.json"

@export var actions_file:String = "2025.json"

var vibration = false

func get_all_actions():
	return DirAccess.get_files_at("res://configs")

func load_actions():
	var file = FileAccess.open("res://configs/%s" % actions_file, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data.get("action_texts")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
