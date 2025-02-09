extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_central_impulse(Vector2(-1000, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	apply_central_force(Vector2(-1000, 0))
	#if linear_velocity.length() < 1:
	#	queue_free()

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_damage(10)
		queue_free()


func _on_live_timer_timeout() -> void:
	queue_free()
