extends TileMap

func _process(delta):
	var SelectedTile = local_to_map(get_global_mouse_position())
	
	set_cell(1, SelectedTile, 4, Vector2i(0, 0), 0)

	var LastSelectedTile = SelectedTile

#func _input(event):
#	if event is InputEventMouseButton:
