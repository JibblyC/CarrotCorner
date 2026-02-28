extends Control

@onready var goldSpentLabel = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/GoldSpentLabel
@onready var birdsPunchedLabel = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BirdsPunchedLabel
@onready var vegPickedLabel = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/VegPickedLabel
@onready var runTimeLabel = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RunTimeLabel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	SignalBus.game_ended.connect(update_end_game_stats)

func _on_main_menu_pressed() -> void:
	PauseManager.togglePauseMenu()
	Globals.clear_global_values()
	$EndGameMusic.playing = false;
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	self.visible = false;
	
func update_end_game_stats() -> void:
		$EndGameMusic.playing = true;
		goldSpentLabel.text = "Gold Spent : %s" % Globals.goldSpent;
		birdsPunchedLabel.text = "Birds Punched : %s" % Globals.birdsPunched;
		vegPickedLabel.text = "Vegetables Picked : %s" % Globals.numVegPicked;
		runTimeLabel.text = "Run Time: %02d:%02d" % [floor(Globals.totalTime / 60), int(Globals.totalTime) % 60];
	
func _on_fireworks_timer_timeout() -> void:
	$Fireworks.stop_fire_works();
