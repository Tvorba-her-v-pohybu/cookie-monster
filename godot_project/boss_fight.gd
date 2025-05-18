extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%CharacterBody2D.top_down = true
	%CharacterBody2D.disable_camera()
	$Camera2D.enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_propast_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$propast/Dira.visible = true
		$propast/AnimationPlayer.play("propast")


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
