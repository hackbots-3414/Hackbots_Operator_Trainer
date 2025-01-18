# Hackbots operator trainer

## Bindings
### Works on all controllers, inside of trainer has better names.
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

## Building
1. Obtain godot 4.3
2. Clone the repo
   ```
   $ git clone https://github.com/hackbots-3414/Hackbots_Operator_Trainer
   ```
3. Open the `project.godot` file inside of godot
4. Go to project>export
5. Follow the steps to install the export templates
6. Select windows/linux/etc and then press "Export Project", this will build and output the project at the path specified

## Adding new controller button names
1. Create a new `json` file inside of the `/controllers/` directory
2. Name it `<controller type>.json`
3. Follow this format, only for the ones that need to be changed, there are default names:
   ```
   {
	"binding-names": {
   		"<action name(see above)>": "clean name",
   		example:
   		"up_button": "Triangle",
   		"dpad_up": "Dpad Up"
   	}
   }
   ```
4. Rebuild/reexport the project, required as files are baked into the file

    
## Adding new bindings, for a new year
1. Create a new `json` file inside of `/configs/`
2. Name it `<binding names>.json`
3. Follow this format, only actions listed will be used:
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
 4. Rebuild/reexport the project, required as files are baked into the file

   
## Images
![image of intro screen](/images/intro_screen.png)


