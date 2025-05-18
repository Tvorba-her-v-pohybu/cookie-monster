extends CharacterBody2D

@export var krecek := 500
@export var blbec := 500

@export var player := Node2D
@export var player_offset := Vector2.ZERO

func _ready() -> void:
	$ShootTimer.start()
	%HealthLbl.text = str(blbec)

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	if player:
		%Ruka.look_at(player.global_position + player_offset)
		%Ruka.rotate(PI)


func _on_shoot_timer_timeout() -> void:
	var dudl = load("res://boss/dudl.tscn").instantiate()
	dudl.speed = krecek
	add_child(dudl)
	dudl.global_position = %ProjectilePos.global_position
	dudl.rotation = %ProjectilePos.global_rotation
	
	
func process_damage(value: int):
	blbec = blbec - value
	%HealthLbl.text = str(blbec)
	if blbec <= 0:
		queue_free()
