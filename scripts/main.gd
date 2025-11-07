extends Node 

@export var bird_scene: PackedScene
@onready var cursor = $Cursor

func _ready() -> void:
	for child in $OutOfBoundsLocations.get_children():
		Globals.outOfBoundsGround[child.get_instance_id()] = child;
		
func _unhandled_input(event) :
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if Globals.currentSeedSelectionSprite and Globals.currentSeedSelectionSprite.is_inside_tree() :
			#TODO -- Seedselection stays on screen after clear, they are stacking
			Globals.currentSeedSelection = ""
			Globals.currentSeedSelectionSprite.queue_free()
			cursor.change_cursor_sprite(Globals.CURSOR_STATE.IDLE)
	
func _on_bird_spawn_timer_timeout() -> void:
	if Globals.plantedGround.size() > 0 :
		var spawned_bird = bird_scene.instantiate();
		var bird_spawn_location = $BirdSpawn/BirdSpawnLocation
		bird_spawn_location.progress_ratio = randf()
		spawned_bird.global_position = bird_spawn_location.position
		var keys = Globals.plantedGround.keys()
		var random_key = keys[randi() % keys.size()]
		spawned_bird.targetGround = Globals.plantedGround[random_key]
		Globals.plantedGround.erase(random_key)
		add_child(spawned_bird)
