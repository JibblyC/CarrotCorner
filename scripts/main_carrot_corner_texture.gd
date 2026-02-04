
extends TextureRect

@onready var original_position = position;

func _ready() -> void:
	visible = false
	
func play_intro() -> void :
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", original_position - Vector2(0, 100), 0.1)
	visible = true
	tween.tween_property(self, "position", original_position, 2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
func _on_timer_timeout() -> void:
	play_intro()
