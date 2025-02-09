extends CharacterBody2D


func _ready() -> void:
	$ShootTimer.start()

func _physics_process(delta: float) -> void:
	pass




func _on_shoot_timer_timeout() -> void:
	var dudl = load("res://boss/dudl.tscn").instantiate()
	add_child(dudl)
	dudl.position = Vector2(-116, 137)
