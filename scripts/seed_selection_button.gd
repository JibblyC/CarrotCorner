extends Control

@export var toolTipTexture : Texture2D;
@export var vegetable : Globals.VEGETABLES;
@export var iconImage : Texture2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ToolTipImage.texture = toolTipTexture;
	$Button.icon = iconImage


func _on_button_mouse_entered() -> void:
	$ToolTipImage.visible = true
	#TODO -- might need some logic here around if out of view
	$ToolTipImage.global_position = global_position + Vector2(size.x - 80, 0)


func _on_button_mouse_exited() -> void:
	$ToolTipImage.visible = false


func _on_button_pressed() -> void:
	SignalBus.seed_selected.emit(vegetable);
	Globals.currentSeedSelection = vegetable;
