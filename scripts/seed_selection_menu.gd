extends HBoxContainer

var defaultFauntSize : int = 12

func _ready() -> void:
	$CarrotVBox/CarrotPriceLabel.text = str(Globals.VEG_GOLD_BUY_COST.CARROT);
	$TomatoeVBox/TomatoePriceLabel.text = str(Globals.VEG_GOLD_BUY_COST.TOMATOE);
	$PotatoeVBox/PotatoePriceLabel.text = str(Globals.VEG_GOLD_BUY_COST.POTATOE);
	$PumpkinVBox/PumpkinPriceLabel.text = str(Globals.VEG_GOLD_BUY_COST.PUMPKIN);
	$BroccoliVBox/BroccoliPriceLabel.text = str(Globals.VEG_GOLD_BUY_COST.BROCCOLI);
	

func _on_potatoe_button_pressed() -> void:
	_current_seed_selected("potatoe");

func _on_carrot_button_pressed() -> void:
	_current_seed_selected("carrot");

func _on_pumpkin_button_pressed() -> void:
	_current_seed_selected("pumpkin");

func _on_tomatoe_button_pressed() -> void:
	_current_seed_selected("tomatoe");
	
func _on_broccoli_button_pressed() -> void:
	_current_seed_selected("broccoli");
	
func _current_seed_selected(seedString : String) -> void:
	Globals.reset_sprite_on_button_press()
	Globals.currentSeedSelection = seedString;
	Globals.currentSeedSelectionSprite.texture = load("res://assets/vegetables/" + seedString + "/" + seedString + "SeedPack.png")
	Globals.add_sprite_to_scene()
