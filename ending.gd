extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$write_file_button.text = "Write File (%s)" % Data.file_name
	$average_speed.text = "Average Speed: %ss" % Data.player_data.get("average_time")
	$correct_questions.text = "Correct Questions: %s/%s" % [Data.player_data.get("correct_count"),Data.question_count]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#var file = FileAccess.open("user://last.json", FileAccess.WRITE)
	#var json_string = JSON.stringify(temp)
	#file.store_string(json_string)
	#file.close()

#func _on_button_pressed() -> void:



func _on_write_file_button_pressed() -> void:
	var file = FileAccess.open("user://%s"%Data.file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(Data.player_data)
	file.store_string(json_string)
	file.close()


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://intro_scene.tscn")
