extends Node

var state_to_sprite_map = {
	Globals.CURSOR_STATE.IDLE: "res://assets/Cursor/idle.png",
	Globals.CURSOR_STATE.HOLD: "res://assets/Cursor/holding.png"
}

var cursorHotSpot = Vector2(4,0);

@onready var seedSelectionMenu = $"../CanvasLayer/SeedSelectionMenu"

func _ready():
	change_cursor_sprite(Globals.CURSOR_STATE.IDLE);
	seedSelectionMenu.seed_selected.connect(change_cursor_sprite)

	
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
	
func plant_seed_particle() -> void :
	$SeedPlant.emitting = true;
	#TODO -- This might look better attached to veg
	$SeedPlant.set_position(get_viewport().get_mouse_position())
	
	
