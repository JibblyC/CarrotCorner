extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_main_menu_pressed() -> void:
	print("ere")
	PauseManager.togglePauseMenu()
	Globals.clear_global_values()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	self.visible = false;
	
	
