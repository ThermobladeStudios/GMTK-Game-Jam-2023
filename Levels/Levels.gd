extends TileMap

var LastSelectedTile = Vector2(0, 0)
var LeftCorner = Vector2i(2, 2)
var RightCorner = Vector2i(17, 8)
var spawn_obj = preload("res://Placables/Minions/Melee_Minion.tscn")
var X_COORD = 17
var Y_COORD = 8
var curr_x = 0
var curr_y = 0
var matrix
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)
var SelectedMinion

func create_map(h, w):
	var map = []

	for x in range(h+2):
		var col = []
		col.resize(w+2)
		map.append(col)

	return map

func _ready():
	matrix = create_map(Y_COORD, X_COORD)
	
func _process(delta):
	erase_cell(3, LastSelectedTile)
	
	var SelectedTile = local_to_map(get_global_mouse_position())
	if SelectedTile.x >= LeftCorner.x and SelectedTile.x <= RightCorner.x and SelectedTile.y >= LeftCorner.y and SelectedTile.y <= RightCorner.y:
		set_cell(3, SelectedTile, 4, Vector2i(0, 0), 0)

	LastSelectedTile = SelectedTile

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clear_layer(4)
			var possible_position = local_to_map(get_global_mouse_position())
			var Tile = matrix[possible_position.y][possible_position.x]
			print(get_cell_source_id(4, possible_position))
			print(possible_position)
			if possible_position.x > X_COORD or possible_position.y > Y_COORD or possible_position.x <= 1 or possible_position.y <= 1:
				pass
			elif Tile == null:
				var obj = spawn_obj.instantiate()
				obj.Initialize("Skeleton1") 
				matrix[possible_position.y][possible_position.x] = obj
				obj.position = local_to_map(get_global_mouse_position()) * 16
				add_child(obj)
				SelectedMinion = null
			elif Tile.Name in Json:
				if Tile.Moved == false:
					SelectedMinion = Tile
					for x in Json[Tile.Name]["AttackArea"]:
						if possible_position.x - x[0] >= LeftCorner.x and possible_position.x - x[0] <= RightCorner.x and possible_position.y - x[1] >= LeftCorner.y and possible_position.y - x[1] <= RightCorner.y and matrix[possible_position.y - x[1]][possible_position.x - x[0]] == null:
							set_cell(4, possible_position - Vector2i(x[0], x[1]), 5, Vector2i(0, 0), 0)
				elif Tile.Attacked == false:
					SelectedMinion = Tile
					for x in Json[Tile.Name ]["AttackArea"]:
						if possible_position.x - x[0] >= LeftCorner.x and possible_position.x - x[0] <= RightCorner.x and possible_position.y - x[1] >= LeftCorner.y and possible_position.y - x[1] <= RightCorner.y and matrix[possible_position.y - x[1]][possible_position.x - x[0]] == null:
							set_cell(4, possible_position - Vector2i(x[0], x[1]), 6, Vector2i(0, 0), 0)
				elif SelectedMinion != null and get_cell_source_id(4, possible_position) == 5:
					print(SelectedMinion)
					SelectedMinion.position = possible_position * 16
					SelectedMinion = null
					Tile.Moved = true
				elif SelectedMinion != null and get_cell_source_id(5, possible_position) == 6:
					SelectedMinion = null
					Tile.Attacked = true
