extends Area3D

@onready var gui: CanvasLayer = get_tree().get_first_node_in_group("GUI")

func _on_body_entered(body):
	if body is Player:
		var animation_player = gui.get_node("FadeScreen/AnimationPlayer")
		animation_player.play("FadeOut")
