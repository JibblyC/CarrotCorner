extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _unhandled_input(event) :
	if event.is_action_pressed("pause_menu_open_close"):
		togglePauseMenu();


func togglePauseMenu() -> void :
	var pause_menu = get_tree().root.get_node_or_null("main/UI/PauseMenu")
	if pause_menu:
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused
