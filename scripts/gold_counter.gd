extends Control

class_name goldCounter

var original_position  # stores the node's start position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$HSplitContainer/GoldLabel.text = str(Globals.totalGold);
	

func _ready():
	# Save the initial position (so we can return to it)
	original_position = position

func not_enough_gold_animation():
	
	$NotEnoughGoldAudio.play();
	
	$HSplitContainer/GoldLabel.add_theme_color_override("font_color", Color(1, 0, 0));
	# Create a new Tween
	var tween = get_tree().create_tween()
	# Then shake left (-8 pixels)
	tween.tween_property(self, "position", original_position - Vector2(8, 0), 0.05).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Then smaller shake right
	tween.tween_property(self, "position", original_position + Vector2(4, 0), 0.05)
	# Then return to original position
	tween.tween_property(self, "position", original_position, 0.05)
		# Connect the finished signal
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished():
	$HSplitContainer/GoldLabel.add_theme_color_override("font_color", Color(1, 1, 1));
	
	
