extends Control

@export var mainGameScene : PackedScene;

@onready var birdValueLabel = $VSplitContainer/HBoxContainer/VBoxContainer/BirdValueLabel
@onready var birdSlider = $VSplitContainer/HBoxContainer/VBoxContainer/BirdSlider

@onready var startingGoldValueLabel = $VSplitContainer/HBoxContainer/VBoxContainer2/StartingGoldValueLabel
@onready var startingGoldSlider = $VSplitContainer/HBoxContainer/VBoxContainer2/StartingGoldSlider


func _ready() -> void:
	_set_bird_value_label()
	_set_starting_gold_label()
	startingGoldSlider.value = Globals.totalGold;


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(mainGameScene)
	
	
func _on_bird_slider_drag_ended(value_changed: bool) -> void:
	if value_changed :
		_set_bird_value_label()
		Globals.birdSpawnWaitTime = birdSlider.value
		
func _set_bird_value_label() -> void :
	birdValueLabel.text =  "Bird Count : " + str(birdSlider.value)
	
func _set_starting_gold_label() -> void :
	startingGoldValueLabel.text = "Starting Gold : " + str(startingGoldSlider.value)
	

func _on_starting_gold_slider_drag_ended(value_changed: bool) -> void:
	if value_changed :
		_set_starting_gold_label()
		Globals.totalGold = startingGoldSlider.value;
		
