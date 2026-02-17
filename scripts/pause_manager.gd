extends Node

@onready var pause_menu;
@onready var end_menu;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	SignalBus.game_ended.connect(game_ended)
	SignalBus.main_loaded.connect(bind_ui_values)
	
	
func _unhandled_input(event) :
	if event.is_action_pressed("pause_menu_open_close"):
		togglePauseMenu();

func togglePauseMenu() -> void :
	if pause_menu :
		get_tree().paused = !get_tree().paused
		if !end_menu.visible:
			pause_menu.visible = get_tree().paused
			
		
func game_ended() -> void :
	if pause_menu.visible:
		pause_menu.visible = false;
	else :
		get_tree().paused = true
	end_menu.visible = true
	
		
func bind_ui_values() -> void :
	pause_menu = get_tree().root.get_node_or_null("main/UI/PauseMenu")
	end_menu = get_tree().root.get_node_or_null("main/UI/EndGame")
	
