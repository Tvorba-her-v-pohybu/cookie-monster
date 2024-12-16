extends CharacterBody2D


@export var SPEED = 90.0
@export var ACCEL = 8.0

@export var target : Node2D


@onready var navigation : NavigationAgent2D = $NavigationAgent2D

var player = null

func _physics_process(delta: float) -> void:
	if player == null and $DmgTimer.is_stopped():
		navigation.target_position = target.global_position

		var next_pos = navigation.get_next_path_position()
		var direction = next_pos - global_position
		direction = direction.normalized()
			
		velocity = velocity.lerp(direction*SPEED, ACCEL*delta)
			
		look_at(next_pos)
			
		move_and_slide()

	


func _on_dmg_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		%DmgAreaImg.visible = true
		$DmgTimer.start()
		


func _on_dmg_timer_timeout() -> void:
	$AnimatedSprite2D.set_animation("utok")
	$AnimatedSprite2D.play()
	
	if player != null:
		player.process_damage(10)
		


func _on_dmg_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "utok":
		$AnimatedSprite2D.set_animation("default")
		$AnimatedSprite2D.play()
		if player == null:
			%DmgAreaImg.visible = false
		else:
			$DmgTimer.start()
