extends RigidBody2D


var speed := 500
var first := true
var shot_dir := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if first:
		first = false
		shot_dir = rotation
		apply_central_impulse(Vector2(-speed, 0).rotated(shot_dir))
		
	apply_central_force(Vector2(-speed, 0).rotated(shot_dir))
	#if linear_velocity.length() < 1:
	#	queue_free()

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_damage(10)
		queue_free()


func _on_live_timer_timeout() -> void:
	queue_free()
