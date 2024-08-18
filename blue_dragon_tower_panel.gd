extends Panel

@onready var BlueDragonTower = preload("res://blue_dragon_tower.tscn")
@onready var reptiles_path = get_tree().get_current_scene().get_node("Reptiles")

func _on_gui_input(event: InputEvent) -> void:
	var TempBlueDragonTower = BlueDragonTower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#Left mouse Button Down
		add_child(TempBlueDragonTower)
		TempBlueDragonTower.global_position = event.global_position
		TempBlueDragonTower.process_mode = Node.PROCESS_MODE_DISABLED
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		#Left mouse button down drag
		if get_child_count() > 1:	
			get_child(1).global_position = event.global_position
		
	elif event is InputEventMouseButton and event.button_mask == 0:
		
		if event.global_position.y >= 542:
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
			reptiles_path.add_child(TempBlueDragonTower)
			TempBlueDragonTower.global_position = event.global_position
			TempBlueDragonTower.get_node("VisibilityPlacementArea").hide()
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
