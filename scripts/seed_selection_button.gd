extends Control

@export var toolTipTexture : Texture2D;
@export var vegetable : Globals.VEGETABLES;
@export var iconImage : Texture2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.release_focus_button.connect(_release_focus_on_button)
	$ToolTipImage.texture = toolTipTexture
	$Button.icon = iconImage


func _on_button_mouse_entered() -> void:
	
	var viewport_size = get_viewport_rect().size
	var yValue = 0
	
	if global_position.y + 80 > viewport_size.y:
		yValue = -60
	
	$ToolTipImage.visible = true
	$ToolTipImage.global_position = global_position + Vector2(size.x - 80, yValue)


func _on_button_mouse_exited() -> void:
	$ToolTipImage.visible = false


func _on_button_pressed() -> void:
	SignalBus.seed_selected.emit(vegetable);
	Globals.currentSeedSelection = vegetable;

func _release_focus_on_button() -> void:
	if($Button.has_focus()) :
		$Button.release_focus()
