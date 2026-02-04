extends Node2D

class_name ground

var planted :bool = false;
var plantedVeg;
var isBirdOnPlant : bool = false;
@onready var hilightBorder = Sprite2D.new()

var grown_shader: Shader = preload("res://assets/shaders/outline.gdshader")

func _ready() -> void:
	var shader_material = ShaderMaterial.new();
	shader_material.shader = grown_shader;
	hilightBorder.texture = $GroundSprite.texture
	hilightBorder.material = shader_material
	hilightBorder.z_index = z_index + 10
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not planted and Globals.currentSeedSelection != Globals.VEGETABLES.NONE:
			plantedVeg = load(Globals.vegToScenePath[Globals.currentSeedSelection]).instantiate() as abstractVeg;
			if(Globals.check_if_enough_gold(plantedVeg.goldCost)):
				planted = true
				Globals.totalGold -= plantedVeg.goldCost;
				Globals.plantedGround[plantedVeg.get_instance_id()] = self;
				plantedVeg.vegetable_eaten.connect(reset_ground_status)
				$PlantSeedParticles.emitting = true;
				Globals.goldSpent += plantedVeg.goldCost;
			else:
				$"../../UI/GoldCounter".not_enough_gold_animation();
				
		else:
			if plantedVeg and plantedVeg.isFullyGrown and !plantedVeg.isHarvested and !isBirdOnPlant: 
				Globals.totalGold += plantedVeg.goldValue;
				planted = false;
				plantedVeg.vegetable_harvest_popup()
				
func set_bird_planted(value: bool) -> void:
		isBirdOnPlant = value
		
func reset_ground_status() -> void :
	planted = false;
	isBirdOnPlant = false;
				
func _on_area_2d_mouse_entered() -> void:
	add_child(hilightBorder)
	
func _on_area_2d_mouse_exited() -> void:
	remove_child(hilightBorder)

func _on_plant_seed_particles_finished() -> void:
	add_child(plantedVeg)
