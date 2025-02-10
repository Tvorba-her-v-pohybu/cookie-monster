extends CharacterBody2D

@export var krecek := 500

@export var blbec := 500
func _ready() -> void:
	$ShootTimer.start()
	%HealthLbl.text = str(blbec)

func _physics_process(delta: float) -> void:
	pass




func _on_shoot_timer_timeout() -> void:
	var dudl = load("res://boss/dudl.tscn").instantiate()
	dudl.speed = krecek
	add_child(dudl)
	dudl.position = Vector2(-116, 137)


func process_damage(value: int):
	blbec = blbec - value
	%HealthLbl.text = str(blbec)
	if blbec <= 0:
		queue_free()
