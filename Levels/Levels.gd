extends TileMap

var LastSelectedTile = Vector2(0, 0)
var LeftCorner = Vector2i(1, 1)
var RightCorner = Vector2i(17, 5)

func _process(delta):
	erase_cell(1, LastSelectedTile)
	
	var SelectedTile = local_to_map(get_global_mouse_position())
	print(SelectedTile - LeftCorner)
	if SelectedTile - LeftCorner <= RightCorner:
		set_cell(1, SelectedTile, 3, Vector2i(0, 0), 0)

	LastSelectedTile = SelectedTile

#func _input(event):
#	if event is InputEventMouseButton:
