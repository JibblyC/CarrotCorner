extends Button

@export var vegetable : Globals.VEGETABLES;
@export var toolTipTexture : Texture2D;

func _ready():
	$ToolTipImage.texture = toolTipTexture

func _on_mouse_entered() -> void:
	$ToolTipImage.visible = true
	$ToolTipImage.global_position = global_position + Vector2(size.x - 55, 0)
	

func _on_mouse_exited() -> void:
	$ToolTipImage.visible = false

func _on_pressed() -> void:
	SignalBus.seed_selected.emit(vegetable);
