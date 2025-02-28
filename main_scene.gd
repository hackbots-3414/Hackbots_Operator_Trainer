extends Node2D
var time_left:Timer
var started = false
var ended = false
var running = false
var showing_correct = false

var current_question = -1
var max_question = Data.question_count

@onready var time_label = $Time_label

@onready var time_to_start = $start_timer
var current_action = ""
var last_action = ""

var start_seconds = 0
var incorrect = false

var action_texts = Data.load_actions()

var data = []

var actions = InputMap.get_actions()

var processed_actions = []

var last_actions = []

# I don't like this :(
func get_action_from_input():
	var pressed = []
	for action in actions:
		if Input.is_action_pressed(action):
			pressed.append(action)
	return pressed

# From https://forum.godotengine.org/t/how-to-round-to-a-specific-decimal-place/27552
func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
	
func check_actions(action_list):
	for action in action_list:
		if action not in processed_actions:
			return false
	return true

var action_real = []


func handle_input(action):
	#if action == "" or not action in action_texts.keys():
		#return
		
	if ($time_out_timer.wait_time - $time_out_timer.time_left) < 0.2:
		return
		
	action_real = []
	for act in action:
		if act not in action_real:
			action_real.append(act.to_lower())
	last_actions = []
	
	if action_real == [] or not check_actions(action_real):
		return
		
	print(action_real)
	if running:
		last_action = action_real
		var time = $time_out_timer.time_left
		var hatred_action = action_real
		hatred_action.sort()
		#action.sort()
		#if len(hatred_action) > 1:
			#temp_action = ",".join(hatred_action)
		#else:
			#temp_action = hatred_action[0]
		var curr_action = []
		if "," in current_action:
			curr_action = Array(current_action.split(","))
		else:
			curr_action = [current_action]
		curr_action.sort()
		if hatred_action == curr_action:
			$time_out_timer.stop()
			data.append({"number":current_question, "action":current_action, "time":$time_out_timer.wait_time - time, "correct":true})
			correct()
		else:
			$time_out_timer.stop()
			data.append({"number":current_question, "action":current_action, "time":$time_out_timer.wait_time - time, "correct":false})
			incorrect = true
			incorrect_or_timeout()


func _input(event: InputEvent) -> void:
	#print(event.as_text())
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var action = get_action_from_input()
		last_actions += action
		ticker = 10
		#handle_input(action)

func set_new_action():
	var keys = action_texts.keys()
	current_action = keys.pick_random()
	print("Current Action: "+current_action)
	$main_label.text = action_texts.get(current_action)

func after_showing_correct():
	$error_label.visible = false
	showing_correct = false
	run()
	pass
	
func reset_text():
	$main_label.text = "Wait"

func _get_binding_names(actions):
	var temp = []
	for action in actions:
		temp.append(BindingNames.get_binding_from_action(action))
	return "+".join(temp)

func _figure_out_binding_names(actions):
	if "," in actions:
		return _get_binding_names(actions.split(","))
	return BindingNames.get_binding_from_action(actions)

func incorrect_or_timeout():
	reset_text()
	running = false
	#print("Incorrect action, inputed "+last_action+" instead of "+current_action)
	print("Incorrect action")
	print(last_action)
	print(current_action)
	showing_correct = true
	$error_label.visible = true
	if incorrect:
		$error_label.text = "You pressed %s instead of %s!" % [_get_binding_names(last_action), _figure_out_binding_names(current_action)]
	else:
		$error_label.text = "Ran out of time!\nYou need to press %s for action \"%s\"!" %[_figure_out_binding_names(current_action), action_texts.get(current_action)]
	incorrect = false
	$temp_false_timer.start()

func correct():
	reset_text()
	running = false
	$time_out_timer.wait_time = 5
	print("Correct action")
	if Data.vibration:
		Input.start_joy_vibration(0, 0, 0.5, 0.5)
	$temp_correct_timer.start()

func start_first_time():
	start_seconds += 1
	$main_label.text = "Starting in " + str(3-start_seconds)
	if start_seconds == 3:
		time_to_start.stop()
		_start()

func _start():
	started = true
	time_label.visible = true
	$time_out_timer.connect("timeout", incorrect_or_timeout)
	run()

func handle_end():
	print("Ending Scene, starting ending")
	print(data)
	var temp = {"data":data, "total_actions":max_question}
	var avg_temp = 0
	var correct = 0
	for d in data:
		avg_temp += d.get("time")
		if d.get("correct"):
			correct += 1
	temp.get_or_add("average_time", avg_temp/len(data))
	temp.get_or_add("name", Data.player_name)
	temp.get_or_add("correct_count", correct)
	Data.player_data = temp
	get_tree().change_scene_to_file("res://ending.tscn")
	
	#var file = FileAccess.open("user://last.json", FileAccess.WRITE)
	#var json_string = JSON.stringify(temp)
	#file.store_string(json_string)
	#file.close()

func run():
	current_question += 1
	$question_bar.value = current_question
	if current_question >= max_question:
		handle_end()
	running = true
	set_new_action()
	$time_out_timer.start()
	
	
func process_actions():
	var temp = action_texts.keys()
	for temp2 in temp:
		if "," not in temp2:
			processed_actions.append(temp2)
		else:
			var part2 = temp2.split(",")
			processed_actions = processed_actions + Array(part2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Data.vibration:
		Input.start_joy_vibration(0, 1, 1, 0.5)
	process_actions()
	#time_to_start = SceneTree.create_timer(3.0)
	time_to_start.start()
	time_to_start.connect("timeout", start_first_time)
	
	$temp_correct_timer.connect("timeout", run)
	$temp_false_timer.connect("timeout", after_showing_correct)
	$question_bar.max_value = max_question
	
	
	
	pass # Replace with function body.

var ticker = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running:
		ticker += 1
		#var gaming = get_action_from_input()
		if ticker >= 20:
			ticker = 0
			handle_input(last_actions)
			last_actions = []
	#print("process")
	if running and started:
		time_label.text = str(round_place(($time_out_timer.wait_time - $time_out_timer.time_left), 3)) + "s"
	#var action = get_action_from_input()
	#handle_input(action)
	pass


func _on_time_out_timer_timeout() -> void:
	running = false
	showing_correct = true
