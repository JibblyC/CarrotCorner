extends Node

var currentSeedSelection := "";
var currentSeedSelectionSprite : Sprite2D;

var totalGold : int = 1000;

var vegToScenePath = {
		"carrot": "res://scenes/carrot.tscn",
		"potatoe": "res://scenes/potatoe.tscn",
		"pumpkin": "res://scenes/pumpkin.tscn",
		"tomatoe": "res://scenes/tomatoe.tscn",
		"broccoli": "res://scenes/broccoli.tscn"
};

var plantedGround = {};


enum VEG_GOLD_BUY_COST {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 4, TOMATOE = 5, BROCCOLI = 6 }
enum VEG_GOLD_SELL_VALUE {DEFAULT, CARROT = 2, POTATOE = 4, PUMPKIN = 6, TOMATOE = 8, BROCCOLI = 10 }

enum VEG_SEED_GROW_TIME_SECS {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 3, TOMATOE = 4, BROCCOLI = 4 }
enum VEG_SAPLING_GROW_TIME_SECS {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 3, TOMATOE = 4, BROCCOLI = 4 }



func reset_sprite_on_button_press() -> void :
	if Globals.currentSeedSelectionSprite and Globals.currentSeedSelectionSprite.is_inside_tree() :
		Globals.currentSeedSelectionSprite.queue_free()
	Globals.currentSeedSelectionSprite = Sprite2D.new()
	
func add_sprite_to_scene() -> void :
	if not Globals.currentSeedSelectionSprite.is_inside_tree() :
		get_tree().get_current_scene().add_child(Globals.currentSeedSelectionSprite)
		
		
func check_if_enough_gold(cost : int) -> bool :
	return totalGold - cost >= 0;
