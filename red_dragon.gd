extends CharacterBody2D
var health = 10
func _ready() -> void:
	show()

func _physics_process(delta: float) -> void:
	position.x -= 1.5
	$AnimatedSprite2D.play("MoveLeft")
	if health <= 0:
		queue_free()
