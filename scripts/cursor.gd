extends Node

var state_to_sprite_map = {
	Globals.CURSOR_STATE.IDLE: "res://assets/Cursor/idle.png",
	Globals.CURSOR_STATE.HOLD: "res://assets/Cursor/holding.png"
}

var cursorHotSpot = Vector2(4,0);

func _ready():
	change_cursor_sprite(Globals.CURSOR_STATE.IDLE);
	SignalBus.bird_clicked.connect(play_punch_animation)
	SignalBus.seed_selected.connect(cursor_sprite_hold)
	
func cursor_sprite_hold(_input : Globals.VEGETABLES) -> void:
	change_cursor_sprite(Globals.CURSOR_STATE.HOLD)

	
func change_cursor_sprite(cursor_state_change : Globals.CURSOR_STATE) -> void:

	var cursor_texture = load(state_to_sprite_map[cursor_state_change])
	var cursor_image = cursor_texture.get_image()
	# Resize the image (width, height, interpolation mode)
	cursor_image.resize(32, 32, Image.INTERPOLATE_NEAREST)
	
	# Create new texture from resized image
	var new_texture = ImageTexture.create_from_image(cursor_image)
	
	match cursor_state_change :
		Globals.CURSOR_STATE.HOLD:
			cursorHotSpot = Vector2(0,16)
			
	# Set as cursor (adjust hotspot accordingly)
	Input.set_custom_mouse_cursor(new_texture, Input.CURSOR_ARROW, cursorHotSpot)

	
func play_punch_animation(bird_location : Vector2) -> void :
	$PunchAnimation.z_index = 10
	$PunchAnimation.visible = true
	$PunchAnimation.play()
	$PunchAnimation.set_position(bird_location)
	
func _on_punch_animation_animation_finished() -> void:
	$PunchAnimation.visible = false;

	
