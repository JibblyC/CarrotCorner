extends Control

@export var mainMenu : PackedScene;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _on_resume_pressed() -> void:
	PauseManager.togglePauseMenu()

func _on_main_menu_pressed() -> void:
	#PauseManager.togglePauseMenu()
	get_tree().change_scene_to_packed(mainMenu)
	
