extends TileMap

var LastSelectedTile = Vector2(0, 0)
var LeftCorner = Vector2i(1, 1)
var RightCorner = Vector2i(18, 6)
var spawn_obj = preload("res://Placables/Minions/Melee_Minion.tscn")
var X_COORD = 18
var Y_COORD = 6
var curr_x = 0
var curr_y = 0
var matrix
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)

func create_map(h, w):
	var map = []

	for x in range(h+1):
		var col = []
		col.resize(w+1)
		map.append(col)

	return map

func _ready():
	matrix = create_map(Y_COORD, X_COORD)
	
func _process(delta):
	erase_cell(3, LastSelectedTile)
	
	var SelectedTile = local_to_map(get_global_mouse_position())
	if SelectedTile.x >= LeftCorner.x and SelectedTile.x <= RightCorner.x and SelectedTile.y >= LeftCorner.y and SelectedTile.y <= RightCorner.y:
		set_cell(3, SelectedTile, 3, Vector2i(0, 0), 0)

	LastSelectedTile = SelectedTile

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clear_layer(4)
			var possible_position = local_to_map(get_global_mouse_position())
			if possible_position.x > X_COORD or possible_position.y > Y_COORD or possible_position.x <=0 or possible_position.y <= 0:
				pass
			elif matrix[possible_position.y][possible_position.x] == null:
				var obj = spawn_obj.instantiate()
				obj.Initialize("Skeleton1") 
				matrix[possible_position.y][possible_position.x] = obj.Name
				obj.position = local_to_map(get_global_mouse_position())*16
				add_child(obj)
			elif matrix[possible_position.y][possible_position.x] in Json:
				for x in Json[matrix[possible_position.y][possible_position.x]]["AttackArea"]:
					set_cell(4, possible_position - Vector2i(x[0], x[1]), 4, Vector2i(0, 0), 0)
			#elif matrix[possible_position.y][possible_position.x] == "Skeleton2"
