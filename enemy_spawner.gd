extends Node2D

@onready var red_dragon_scene = preload("res://red_dragon.tscn")

var spawn_points = []

func _ready() -> void:
	randomize()
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)




func _on_red_dragon_spawn_timer_timeout() -> void:
	var red_dragons = get_tree().get_nodes_in_group("red_dragons")
	
	if red_dragons.size() < Main.max_red_dragons:
		var spawn = spawn_points[randi() % spawn_points.size()]
		
		var red_dragon_instance = red_dragon_scene.instantiate()
		red_dragon_instance.position = spawn.position
		get_tree().get_current_scene().get_node("Enemies").add_child(red_dragon_instance)
		red_dragon_instance.add_to_group("red_dragons")
