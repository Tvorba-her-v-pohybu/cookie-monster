extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boss_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.top_down = true


func _on_propast_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$NavigationRegion2D/propast/Dira.visible = true
		$NavigationRegion2D/propast/AnimationPlayer.play("propast")


func start_bossfight():
	get_tree().change_scene_to_file("res://boss_fight.tscn")


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
