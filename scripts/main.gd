extends Node 

@export var bird_scene: PackedScene
@onready var cursor = $Cursor
@onready var birdSpawnTimer = $BirdSpawnTimer;

@onready var pauseMenu = $UI/PauseMenu;

func _ready() -> void:
	for child in $OutOfBoundsLocations.get_children():
		Globals.outOfBoundsGround[child.get_instance_id()] = child;
		
	if Globals.birdSpawnWaitTime != 0 :
		birdSpawnTimer.start()
		birdSpawnTimer.wait_time = Globals.birdSpawnWaitTime;
		
func _unhandled_input(event) :
	if event.is_action_pressed("cancel_seed_selection"):
		Globals.currentSeedSelection = Globals.VEGETABLES.NONE
		cursor.change_cursor_sprite(Globals.CURSOR_STATE.IDLE)
		SignalBus.release_focus_button.emit()
		
	
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
		
		

	
	
