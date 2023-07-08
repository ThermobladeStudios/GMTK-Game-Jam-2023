extends TileMap

var LastSelectedTile = Vector2(0, 0)
var LeftCorner = Vector2i(1, 1)
var RightCorner = Vector2i(17, 5)
var spawn_obj = preload("res://Placables/Minions/Melee_Minion.tscn")
var X_COORD = 18
var Y_COORD = 6

func create_map(w, h):
	var map = []

	for x in range(w):
		var col = [0]
		col.resize(h)
		map.append(col)

	return map
func _ready():
	var map = create_map(X_COORD, Y_COORD)
	
func _process(delta):
	erase_cell(2, LastSelectedTile)
	
	var SelectedTile = local_to_map(get_global_mouse_position())
	#print(SelectedTile - LeftCorner)
	if SelectedTile - LeftCorner <= RightCorner:
		set_cell(2, SelectedTile, 3, Vector2i(0, 0), 0)

	LastSelectedTile = SelectedTile

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var obj = spawn_obj.instantiate()
			obj.Initialize("Skeleton1")
			obj.position = local_to_map(get_global_mouse_position())*16
			add_child(obj)
