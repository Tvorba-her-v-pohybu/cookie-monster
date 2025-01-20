extends CharacterBody2D

var health := 100

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		start_attack()
		
func start_attack():
	if %AttackDelayTimer.is_stopped():
		enemies_killed = 0
		%AttackAnimationPlayer.play("attack")
		%AttackDelayTimer.start()

func process_damage(value: int):
	$AnimationPlayer.play("dmg")
	health -= value

func _physics_process(delta: float) -> void:


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var direction_up := Input.get_axis("ui_up", "ui_down")
	
	look_at(global_position + Vector2(direction, direction_up))

	velocity.x = direction * SPEED
	velocity.y = direction_up * SPEED

	move_and_slide()

var enemies_killed := 0
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and not %AttackDelayTimer.is_stopped() and enemies_killed < 1:
		enemies_killed += 1
		body.queue_free()
