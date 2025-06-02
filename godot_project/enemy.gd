extends CharacterBody2D


@export var SPEED = 90.0
@export var ACCEL = 8.0

@export var damage = 5

@export var target : Node2D


@onready var navigation : NavigationAgent2D = $NavigationAgent2D

var following := false
var death := false


var player = null

func _ready() -> void:
	var rand = randi_range(0, 1)
	$Zombie.visible = rand == 1
	$Zombie2.visible = rand != 1
		

func _physics_process(delta: float) -> void:
	if death:
		return
	
	if not following and target:
		var dist = global_position.distance_to(target.global_position)
		if dist < 500:
			following = true
	
	if player == null and $DmgTimer.is_stopped() and following:
		navigation.target_position = target.global_position

		var next_pos = navigation.get_next_path_position()
		var direction = next_pos - global_position
		direction = direction.normalized()
			
		velocity = velocity.lerp(direction*SPEED, ACCEL*delta)
			
		look_at(next_pos)
			
		move_and_slide()


func process_damage(value: int):
	$DeathAudio.play()
	$Zombie.visible = false
	$Zombie2.visible = false
	%Krev.visible = true
	%DmgAreaImg.visible = false
	death = true
	collision_layer = 0
	collision_mask = 0

func _on_dmg_area_2d_body_entered(body: Node2D) -> void:
	if death:
		return
	if body.is_in_group("player"):
		player = body
		%DmgAreaImg.visible = true
		$DmgTimer.start()
		


func _on_dmg_timer_timeout() -> void:
	if death:
		return
		
	$AnimatedSprite2D.set_animation("utok")
	$AnimatedSprite2D.play()
	
	if player != null:
		player.process_damage(damage)
		


func _on_dmg_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if death:
		return
	if $AnimatedSprite2D.animation == "utok":
		$AnimatedSprite2D.set_animation("default")
		$AnimatedSprite2D.play()
		if player == null:
			%DmgAreaImg.visible = false
		else:
			$DmgTimer.start()


func _on_death_audio_finished() -> void:
	#queue_free()
	pass
