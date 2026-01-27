extends Control

@export var mainGameScene : PackedScene;

@onready var birdValueLabel = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer/VBoxContainer/BirdValueLabel
@onready var birdSlider = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer/VBoxContainer/BirdSlider

@onready var startingGoldValueLabel = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer2/VBoxContainer2/StartingGoldValueLabel
@onready var startingGoldSlider = $VSplitContainer/SettingsContainer/HBoxContainer/MarginContainer2/VBoxContainer2/StartingGoldSlider


func _ready() -> void:
	_set_bird_value_label()
	_set_starting_gold_label()
	startingGoldSlider.value = Globals.totalGold;


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(mainGameScene)
		
		
func _set_bird_value_label() -> void :
	birdValueLabel.text =  "Bird Count : " + str(int(birdSlider.value))
	
func _set_starting_gold_label() -> void :
	startingGoldValueLabel.text = "Gold : " + str(int(startingGoldSlider.value))
		
func _on_bird_slider_value_changed(value: float) -> void:
	_set_bird_value_label()
	Globals.birdSpawnWaitTime = birdSlider.value

func _on_starting_gold_slider_value_changed(value: float) -> void:
		_set_starting_gold_label()
		Globals.totalGold = startingGoldSlider.value;
