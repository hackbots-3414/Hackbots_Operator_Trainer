extends Node2D
var time_left:Timer
var started = false
var ended = false
var running = false
var showing_correct = false

@onready var time_label = $Time_label

@onready var time_to_start = $start_timer
var current_action = ""

var start_seconds = 0

var action_texts = {
	"amp": "Shoot Amp"
}

var actions = InputMap.get_actions()

# I don't like this :(
func get_action_from_input(input:InputEvent):
	for action in actions:
		if input.is_action_pressed(action):
			return action
	return "n/a"

# From https://forum.godotengine.org/t/how-to-round-to-a-specific-decimal-place/27552
func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))

	
func _input(event: InputEvent) -> void:
	print(get_action_from_input(event))


func set_new_action():
	var keys = action_texts.keys()
	current_action = keys.pick_random()
	print("Current Action: "+current_action)
	$main_label.text = action_texts.get(current_action)
	
func incorrect_or_timeout():
	pass

func start_first_time():
	start_seconds += 1
	$main_label.text = "Starting in " + str(3-start_seconds)
	if start_seconds == 3:
		time_to_start.stop()
		_start()

func _start():
	started = true
	time_label.visible = true
	run()
	
func run():
	running = true
	set_new_action()
	$time_out_timer.start()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#time_to_start = SceneTree.create_timer(3.0)
	time_to_start.start()
	time_to_start.connect("timeout", start_first_time)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("process")
	if running and started:
		time_label.text = str(round_place(($time_out_timer.wait_time - $time_out_timer.time_left), 3)) + "s"
	pass


func _on_time_out_timer_timeout() -> void:
	running = false
	showing_correct = true
