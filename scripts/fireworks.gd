extends Node2D

func stop_fire_works() -> void :
	$Trail.emitting = false;
	$Explosion.emitting = false
	
func start_fire_works() -> void :
	$Trail.emitting = true;
	$Explosion.emitting = true;
