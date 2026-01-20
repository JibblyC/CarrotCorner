extends Node

var currentSeedSelection : VEGETABLES;
var currentSeedSelectionSprite : Sprite2D;
var totalGold : int = 100;
var goldSpent : int = 0;
var birdsPunched : int = 0;

enum VEGETABLES {CARROT, POTATOE, PUMPKIN,TOMATOE,BROCCOLI,NONE};

var vegToScenePath = {
		VEGETABLES.CARROT : "res://scenes/carrot.tscn",
		VEGETABLES.POTATOE: "res://scenes/potatoe.tscn",
		VEGETABLES.PUMPKIN: "res://scenes/pumpkin.tscn",
		VEGETABLES.TOMATOE: "res://scenes/tomatoe.tscn",
		VEGETABLES.BROCCOLI: "res://scenes/broccoli.tscn"
};

var plantedGround = {};
var outOfBoundsGround = {};

enum VEG_GOLD_BUY_COST {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 4, TOMATOE = 5, BROCCOLI = 6 }
enum VEG_GOLD_SELL_VALUE {DEFAULT, CARROT = 2, POTATOE = 4, PUMPKIN = 6, TOMATOE = 8, BROCCOLI = 10 }

enum VEG_SEED_GROW_TIME_SECS {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 3, TOMATOE = 4, BROCCOLI = 4 }
enum VEG_SAPLING_GROW_TIME_SECS {DEFAULT, CARROT = 1, POTATOE = 2, PUMPKIN = 3, TOMATOE = 4, BROCCOLI = 4 }


enum CURSOR_STATE { IDLE, HOLD , RELEASE }
		
func check_if_enough_gold(cost : int) -> bool :
	return totalGold - cost >= 0;
