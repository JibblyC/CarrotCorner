extends Control

@onready var birdValueLabel = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/BirdValueLabel
@onready var birdSlider = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer/VBoxContainer/BirdSlider

@onready var startingGoldValueLabel = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer2/VBoxContainer2/PanelContainer/StartingGoldValueLabel
@onready var startingGoldSlider = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer2/VBoxContainer2/StartingGoldSlider


enum BIRD_SPAWN_RATE {NONE = 0, LOW = 10, MEDIUM = 5, HIGH = 3 }

func _ready() -> void:
	set_bird_value_label(BIRD_SPAWN_RATE.NONE)
	_set_starting_gold_label()
	startingGoldSlider.value = Globals.totalGold;
		
func set_bird_value_label(spawnRate: BIRD_SPAWN_RATE) -> void :
	birdValueLabel.text =  "Bird Spawn rate : " + str(BIRD_SPAWN_RATE.find_key(spawnRate))
	
func _set_starting_gold_label() -> void :
	startingGoldValueLabel.text = "Starting Gold : " + str(int(startingGoldSlider.value))
		
func _on_bird_slider_value_changed(sliderValue: float) -> void:
	var birdSpawnRate : BIRD_SPAWN_RATE;
	match sliderValue :
		0.0:
			birdSpawnRate = BIRD_SPAWN_RATE.NONE;
		1.0:
			birdSpawnRate = BIRD_SPAWN_RATE.LOW;
		2.0:
			birdSpawnRate = BIRD_SPAWN_RATE.MEDIUM;
		3.0:
			birdSpawnRate = BIRD_SPAWN_RATE.HIGH;
	
	set_bird_value_label(birdSpawnRate)
	Globals.birdSpawnWaitTime = birdSpawnRate

func _on_starting_gold_slider_value_changed(value: float) -> void:
	_set_starting_gold_label()
	Globals.totalGold = startingGoldSlider.value;

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
