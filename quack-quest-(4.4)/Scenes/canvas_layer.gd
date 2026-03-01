extends CanvasLayer

func _ready():
	# This tells Godot: "Don't freeze this menu when the game pauses!"
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Start the game with the menu hidden
	visible = false
	print("Pause Menu is ready and listening for Input...")

func _input(event):
	# Using 'ui_cancel' (usually Escape) to toggle
	if event.is_action_pressed("ui_cancel"):
		print("Escape key detected, toggling pause.")
		toggle_pause()

func toggle_pause():
	# Flip the pause state (if it was true, it becomes false, and vice versa)
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	
	# Make the menu visible only when paused
	visible = new_pause_state 
	
	if visible:
		print("Game Paused")
	else:
		print("Game Resumed")

func _on_resume_button_pressed():
	toggle_pause()

func _on_quit_button_pressed():
	# IMPORTANT: Always unpause before changing scenes, 
	# or your Main Menu might start frozen!
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
