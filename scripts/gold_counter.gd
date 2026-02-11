extends Control

class_name goldCounter

var original_position

var goldLabel;
	

func _ready():
	# Save the initial position (so we can return to it)
	original_position = position
	goldLabel = $PanelContainer/VSplitContainer/MarginContainer2/total_value
	goldLabel.text = str(Globals.currentGold);
	SignalBus.gold_change.connect(change_gold_label)
	
func change_gold_label() -> void :
	goldLabel.text = str(Globals.currentGold);
	
	if Globals.currentGold >= Globals.targetGold :
		SignalBus.game_ended.emit();

func not_enough_gold_animation():
	$NotEnoughGoldAudio.play();
	goldLabel.add_theme_color_override("font_color", Color(1, 0, 0));

	var tween = get_tree().create_tween()

	tween.tween_property(self, "position", original_position - Vector2(8, 0), 0.05).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", original_position + Vector2(4, 0), 0.05)
	tween.tween_property(self, "position", original_position, 0.05)
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished():
	goldLabel.add_theme_color_override("font_color", Color(1, 1, 1));
	
	
