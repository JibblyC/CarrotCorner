extends Node

var currentSeedSelection : VEGETABLES;
var currentSeedSelectionSprite : Sprite2D;
var totalGold : int = 100;
var goldSpent : int = 0;
var birdsPunched : int = 0;

enum VEGETABLES {NONE,CARROT,POTATOE,PUMPKIN,TOMATOE,BROCCOLI};

var vegToScenePath = {
		VEGETABLES.CARROT : "res://scenes/carrot.tscn",
		VEGETABLES.POTATOE: "res://scenes/potatoe.tscn",
		VEGETABLES.PUMPKIN: "res://scenes/pumpkin.tscn",
		VEGETABLES.TOMATOE: "res://scenes/tomatoe.tscn",
		VEGETABLES.BROCCOLI: "res://scenes/broccoli.tscn"
};

var plantedGround = {};
var outOfBoundsGround = {};

enum VEG_GOLD_BUY_COST {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 3, TOMATOE = 4, BROCCOLI = 5 }
enum VEG_GOLD_SELL_VALUE {DEFAULT, CARROT = 2, POTATOE = 4, PUMPKIN = 6, TOMATOE = 8, BROCCOLI = 12 }

enum VEG_SEED_GROW_TIME_SECS {DEFAULT, CARROT = 2, POTATOE = 5, PUMPKIN = 7, TOMATOE = 8, BROCCOLI = 10 }
enum VEG_SAPLING_GROW_TIME_SECS {DEFAULT, CARROT = 2, POTATOE = 5, PUMPKIN = 7, TOMATOE = 8, BROCCOLI = 10 }


enum CURSOR_STATE { IDLE, HOLD , RELEASE }
		
func check_if_enough_gold(cost : int) -> bool :
	return totalGold - cost >= 0;
