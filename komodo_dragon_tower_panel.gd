extends Panel

@onready var KomodoDragonTower = preload("res://komodo_dragon_tower.tscn")
@onready var reptiles_path = get_tree().get_current_scene().get_node("Reptiles")

func _on_gui_input(event: InputEvent) -> void:
	var TempKomodoDragonTower = KomodoDragonTower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#Left mouse Button Down
		add_child(TempKomodoDragonTower)
		TempKomodoDragonTower.global_position = event.global_position
		TempKomodoDragonTower.process_mode = Node.PROCESS_MODE_DISABLED
		
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
			reptiles_path.add_child(TempKomodoDragonTower)
			TempKomodoDragonTower.global_position = event.global_position
			TempKomodoDragonTower.get_node("VisibilityPlacementArea").hide()
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
