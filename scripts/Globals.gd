extends Node

var currentSeedSelection : VEGETABLES;
var currentGold : int = 10;
var targetGold : int = 60;
var goldSpent : int = 0;

#Bird Related Vars
var birdsPunched : int = 0;
var birdSpawnWaitTime : float = 0;

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

enum VEG_SEED_GROW_TIME_SECS {DEFAULT, CARROT = 2, POTATOE = 3, PUMPKIN = 4, TOMATOE = 5, BROCCOLI = 6 }
enum VEG_SAPLING_GROW_TIME_SECS {DEFAULT, CARROT = 2, POTATOE = 3, PUMPKIN = 4, TOMATOE = 5, BROCCOLI = 6 }


enum CURSOR_STATE { IDLE, HOLD , RELEASE }
	
	
func clear_global_values() -> void :
	currentSeedSelection = VEGETABLES.NONE
	currentGold = 10;
	goldSpent = 0;
	birdsPunched = 0;
	birdSpawnWaitTime = 0;
	plantedGround = {};
	SignalBus.change_cursor_to_idle.emit()
	outOfBoundsGround = {};
