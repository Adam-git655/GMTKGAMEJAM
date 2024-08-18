extends StaticBody2D

var scale_damage = 15
var currTargets = []
var curr = null

func _ready() -> void:
	$Hitbox/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("Idle")
	
func _process(delta: float) -> void:
	
	if is_instance_valid(curr):
		if $SlashAttackTimer.is_stopped():
			$SlashAttackTimer.start()
	else:
		$AnimatedSprite2D.stop()
		if !$SlashAttackTimer.is_stopped():
			$SlashAttackTimer.stop()
		
func slash_attack():
	self.look_at(curr.global_position)
	$AnimatedSprite2D.play("FurySlash")
	$Hitbox/CollisionShape2D.disabled = false
	
func _on_slash_attack_timer_timeout() -> void:
	slash_attack()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("red_dragons"):
		check_overlaps()

func check_overlaps():
	var TempArray = []
	currTargets = get_node("Area2D").get_overlapping_bodies()
	
	for i in currTargets:
		if i.is_in_group("red_dragons"):
			TempArray.append(i)
	
	var currTarget = null
	
	for i in TempArray:
		if currTarget == null:
			currTarget = i
		else:
			if i.position.x < currTarget.position.x:
				currTarget = i
				
	curr = currTarget
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	check_overlaps()


func _on_animated_sprite_2d_animation_finished() -> void:
	$Hitbox/CollisionShape2D.disabled = true


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("red_dragons"):
		await get_tree().create_timer(0.3).timeout
		body.health -= scale_damage
		$Hitbox/CollisionShape2D.disabled = true
