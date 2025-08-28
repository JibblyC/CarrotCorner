extends Node2D

class_name ground

var planted :bool = false;
var plantedVeg;
var isBirdOnPlant : bool = false;
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not planted and Globals.currentSeedSelection != "":
			plantedVeg = load(Globals.vegToScenePath[Globals.currentSeedSelection]).instantiate() as abstractVeg;
			if(Globals.check_if_enough_gold(plantedVeg.goldCost)):
				add_child(plantedVeg)
				planted = true
				Globals.totalGold -= plantedVeg.goldCost;
				Globals.plantedGround[plantedVeg.get_instance_id()] = self;
			else:
				var goldNode = get_node("GoldCounter") as goldCounter
				goldNode.not_enough_gold_animation();
				
		else:
			#TODO - Ewww, this can be cleaned up right?
			if plantedVeg and plantedVeg.isFullyGrown and !plantedVeg.isHarvested and !isBirdOnPlant: 
				Globals.totalGold += plantedVeg.goldValue;
				planted = false;
				plantedVeg.vegetable_harvest_popup()
				
