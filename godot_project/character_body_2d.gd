extends PlatformerController2D

var health := 100
var ammo := 3

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var top_down := false :
	set(value):
		top_down = value
		if value:
			rotation = 0
			$MainChar.visible = false
			$AnimatedSprite2D.visible = true
		else:
			$MainChar.visible = true
			$AnimatedSprite2D.visible = false
		#	$AnimationPlayer.play("camera_top_down")
		#else:
	#		$AnimationPlayer.play("camera_normal")


func disable_camera():
	$Camera2D.enabled = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		rotation = 0
		start_attack()
	if event.is_action_pressed("shoot"):
		shoot()
	if top_down:
		super._input(event)
	
func shoot():
	if ammo > 0 or top_down:
		var projectile = load("res://main_char/player_projectile.tscn").instantiate()
		projectile.rotation = rotation
		get_parent().add_child(projectile)
		projectile.global_position = global_position
		$ShotAudio.play()
		ammo = ammo - 1
		
func start_attack():
	if %AttackDelayTimer.is_stopped():
		enemies_killed = 0
		%AttackAnimationPlayer.play("attack")
		%AttackDelayTimer.start()

func process_damage(value: int):
	$AnimationPlayer.play("dmg")
	health -= value


func _physics_process(delta: float) -> void:

	if top_down:
		super._physics_process(delta)
		return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var direction_up := Input.get_axis("ui_up", "ui_down")
	
	if (direction != 0.0 or direction_up != 0.0) and not $TapTapAudio.playing:
		$TapTapAudio.play()
	
	look_at(global_position + Vector2(direction, direction_up))

	velocity.x = direction * SPEED
	velocity.y = direction_up * SPEED

	move_and_slide()

var enemies_killed := 0
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and not %AttackDelayTimer.is_stopped() and enemies_killed < 1:
		enemies_killed += 1
		body.queue_free()
