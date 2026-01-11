extends Node2D

class_name bird

enum STATES {FLYING, PECKING, IDLE, DEFAULT}

var targetGround : ground;
var state: STATES = STATES.DEFAULT
var movementSpeed: float = 1;
var health: float = 3;
var clickable: bool = true;
var plantedGround : ground;

func _ready() -> void:
	change_state(STATES.FLYING)
	plantedGround = targetGround

func _process(_delta: float) -> void:
	if state == STATES.FLYING :
		if global_position.distance_to(targetGround.global_position) >= movementSpeed :
			move_toward_target(targetGround.global_position, movementSpeed) 
		else:
			global_position = targetGround.global_position
			change_state(STATES.IDLE)
			targetGround.isBirdOnPlant = true
			$PeckTimer.start()
			
func _on_peck_timer_timeout() -> void:
	change_state(STATES.PECKING)

func _on_animated_sprite_2d_animation_looped() -> void:
	if state == STATES.PECKING and $PeckAnimation.animation == 'peck' :
		if targetGround.plantedVeg :
			change_state(STATES.IDLE)
			targetGround.plantedVeg.remove_one_health()
			if !targetGround.plantedVeg.is_plant_healthy():
				fly_away();
			else :
				$PeckTimer.start()	
		else:
			fly_away()
			
				
func change_state(changeState: STATES) -> void :
	match changeState:
		STATES.IDLE:
			state = STATES.IDLE
			$PeckAnimation.play("idle")
		STATES.FLYING:
			$PeckAnimation.play("fly")
			state = STATES.FLYING
			if targetGround.global_position.x > global_position.x :
				$PeckAnimation.flip_h = true
			if targetGround.global_position.x < global_position.x and $PeckAnimation.flip_h == true :
				$PeckAnimation.flip_h = false
		STATES.PECKING:
			$PeckAnimation.play("peck")
			state = STATES.PECKING
			
func move_toward_target(target_position: Vector2, distance: float):
	var direction = (target_position - global_position).normalized()
	global_position += direction * distance
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and clickable:
		SignalBus.bird_clicked.emit(global_position);
		$ClickableTimer.start()
		clickable = false;
		health -= 1;
		$PunchParticles.restart()
		if(health <= 0):
			fly_away()
	
		
func fly_away() -> void :
	$PeckAnimation.stop()
	$PeckTimer.stop()
	$ShooTimer.start()
	var keys = Globals.outOfBoundsGround.keys()
	var random_key = keys[randi() % keys.size()]
	targetGround = Globals.outOfBoundsGround[random_key]
	change_state(STATES.FLYING)
	clickable = false
	Globals.birdsPunched += 1;
	
func _on_shoo_timer_timeout() -> void:
	plantedGround.isBirdOnPlant = false
			
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.


func _on_clickable_timer_timeout() -> void:
	clickable = true; # Replace with function body.
