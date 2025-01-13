extends CharacterBody2D

var health := 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func process_damage(value: int):
	$AnimationPlayer.play("dmg")
	health -= value

func _physics_process(delta: float) -> void:


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var direction_up := Input.get_axis("ui_up", "ui_down")

	velocity.x = direction * SPEED
	velocity.y = direction_up * SPEED

	move_and_slide()
