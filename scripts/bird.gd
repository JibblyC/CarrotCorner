extends Node2D

class_name bird

enum STATES {FLYING, PECKING, IDLE, DEFAULT}

var targetGround : ground;
var state: STATES = STATES.DEFAULT
var movementSpeed: float = 1;
var health: float = 3;

func _ready() -> void:
	change_state(STATES.FLYING)

func _process(delta: float) -> void:
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
	if state == STATES.PECKING and $AnimatedSprite2D.animation == 'peck' :
		if targetGround.plantedVeg :
			change_state(STATES.IDLE)
			targetGround.plantedVeg.remove_one_health()
			if !targetGround.plantedVeg.is_plant_healthy():
				fly_away();
			else :
				$PeckTimer.start()	
				
func change_state(changeState: STATES) -> void :
	match changeState:
		STATES.IDLE:
			state = STATES.IDLE
			$AnimatedSprite2D.play("idle")
		STATES.FLYING:
			$AnimatedSprite2D.play("fly")
			state = STATES.FLYING
			if targetGround.global_position.x > global_position.x :
				$AnimatedSprite2D.flip_h = true
			if targetGround.global_position.x < global_position.x and $AnimatedSprite2D.flip_h == true :
				$AnimatedSprite2D.flip_h = false
		STATES.PECKING:
			$AnimatedSprite2D.play("peck")
			state = STATES.PECKING
			
func move_toward_target(target_position: Vector2, distance: float):
	var direction = (target_position - global_position).normalized()
	global_position += direction * distance
	
	
#TODO -- Add in click logic to "SHOO" birds away
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		health -= 1;
		if(health <= 0):
			fly_away()
		
func fly_away() -> void :
	#TODO -- hardcoded to one OOB node, maybe add a random list?
	targetGround.isBirdOnPlant = false
	targetGround = get_node("/root/main/OutOfBoundsGround")
	change_state(STATES.FLYING)
	
	

#TODO -- Picking plant mid flight of bird causes bug
			
		
