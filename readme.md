# Hackbots operator trainer

All the bindings are loaded from the /configs/ folder, in json format
They use this structure:
```
{
	"action_texts":{
		# For each action inside of the bot, that is wanted, create a new line like this:
		"<Action>": "<Action Name>"
		# Example
		"left_button": "Shoot Amp"
		# The bindings are seen below
	}
}
```

## Bindings
### tested on an xbox controller, should work on all
left_trigger
left_bumper
right_trigger
right_bumper
up_button
left_button
right_button
down_button
dpad_up
dpad_down
dpad_left
dpad_right
back
start

The <direction>_button bindings are for ABXY
