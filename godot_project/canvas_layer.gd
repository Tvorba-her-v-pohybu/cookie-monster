extends CanvasLayer

var smrt := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Healthbar.value = %CharacterBody2D.health
	
	if %CharacterBody2D.health <= 0 and not smrt:
		%smrtLbl.visible = true
		%KoupilJsemTo.play()
		smrt = true
	
