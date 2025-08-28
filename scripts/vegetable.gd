extends Node2D

class_name abstractVeg

@export_category("Starting Values")

@export var seedGrowTime : Globals.VEG_SEED_GROW_TIME_SECS = Globals.VEG_SEED_GROW_TIME_SECS.DEFAULT;
@export var saplingGrowTime : Globals.VEG_SAPLING_GROW_TIME_SECS = Globals.VEG_SAPLING_GROW_TIME_SECS.DEFAULT;

@export var seedTexture : Texture2D;
@export var halfGrowTexture : Texture2D;
@export var fullGrowTexture : Texture2D;

@export var goldValue : Globals.VEG_GOLD_SELL_VALUE = Globals.VEG_GOLD_SELL_VALUE.DEFAULT;
@export var goldCost : Globals.VEG_GOLD_BUY_COST = Globals.VEG_GOLD_BUY_COST.DEFAULT;

@export var currentHealth = 3;



var isFullyGrown:bool = false;
var isHarvested:bool = false;

var grown_shader: Shader = preload("res://assets/shaders/vegetable_wind_sway.gdshader")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VegSprite.texture = seedTexture;
	$SeedTimer.start(seedGrowTime);
	
func _process(delta: float) -> void:
	if !is_plant_healthy():
		delete_self()
		
func is_plant_healthy() -> bool :
	if currentHealth > 0 : 
		return true
	return false;

func _on_seed_timer_timeout() -> void:
	$VegSprite.texture = halfGrowTexture;
	$HalfGrownTimer.start(saplingGrowTime)
	
func _on_half_grown_timer_timeout() -> void:
	$VegSprite.texture = fullGrowTexture;
	isFullyGrown = true;
	var shader_material = ShaderMaterial.new();
	shader_material.shader = grown_shader;
	$VegSprite.material = shader_material;
	
func vegetable_harvest_popup() -> void:
	$HarvestSprite.visible = true
	$HarvestSprite.z_index = 10
	$HarvestSprite/AnimationPlayer.play("HarvestPop")
	$VegSprite.visible = false
	isHarvested = true;
	add_child(load("res://scenes/gold_coin.tscn").instantiate())
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "HarvestPop"):
		delete_self()
		
func remove_one_health() -> void :
	currentHealth -= 1;
	
func delete_self() -> void :
	Globals.plantedGround.erase(self.get_instance_id())
	queue_free()
