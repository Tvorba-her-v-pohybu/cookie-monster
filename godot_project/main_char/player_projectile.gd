extends RigidBody2D

var speed := 1000
var direction : Vector2 = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_central_impulse(transform.x * speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass
	#apply_central_force(transform.x * speed)
	#if linear_velocity.length() < 1:
	#	queue_free()

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body.has_method("process_damage"):
		body.process_damage(10)
		queue_free()


func _on_live_timer_timeout() -> void:
	queue_free()
