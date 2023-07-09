extends TileMap

var LastSelectedTile = Vector2(0, 0)
var LeftCorner = Vector2i(2, 2)
var RightCorner = Vector2i(17, 8)
var spawn_obj = preload("res://Placables/Minions/Melee_Minion.tscn")
var spawn_obs = preload("res://Placables/Obastacles/Obstacle.tscn")
var obs_check = false
var Map
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)
var SelectedMinion
var SelectedMinionPosition
var Counter = 1

func create_map(h, w):
	var map = []

	for x in range(h+2):
		var col = []
		col.resize(w+2)
		map.append(col)

	return map

func _ready():
	Map = create_map(RightCorner.y, RightCorner.x)
	
func _process(delta):
	erase_cell(3, LastSelectedTile)
	if Input.is_action_just_pressed("Swap"):
		obs_check = !obs_check
	var SelectedTile = local_to_map(get_global_mouse_position())
	if SelectedTile.x >= LeftCorner.x and SelectedTile.x <= RightCorner.x and SelectedTile.y >= LeftCorner.y and SelectedTile.y <= RightCorner.y:
		set_cell(3, SelectedTile, 4, Vector2i(0, 0), 0)

	LastSelectedTile = SelectedTile

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var possible_position = local_to_map(get_global_mouse_position())
			if possible_position.x > RightCorner.x or possible_position.y > RightCorner.y or possible_position.x <= 1 or possible_position.y <= 1:
				pass
			elif !obs_check:
				var Tile = Map[possible_position.y][possible_position.x]
				if Tile and Tile.Name in Json:
					if Tile.Moved == false:
						SelectedMinion = Tile
						SelectedMinionPosition = possible_position
						for x in Json[Tile.Name]["MoveArea"]:
							if possible_position.x - x[0] >= LeftCorner.x and possible_position.x - x[0] <= RightCorner.x and possible_position.y - x[1] >= LeftCorner.y and possible_position.y - x[1] <= RightCorner.y and Map[possible_position.y - x[1]][possible_position.x - x[0]] == null:
								set_cell(4, possible_position - Vector2i(x[0], x[1]), 5, Vector2i(0, 0), 0)
					elif Tile.Attacked == false:
						SelectedMinion = Tile
						SelectedMinionPosition = possible_position
						for x in Json[Tile.Name]["AttackArea"]:
							if possible_position.x - x[0] >= LeftCorner.x and possible_position.x - x[0] <= RightCorner.x and possible_position.y - x[1] >= LeftCorner.y and possible_position.y - x[1] <= RightCorner.y and Map[possible_position.y - x[1]][possible_position.x - x[0]] == null:
								set_cell(4, possible_position - Vector2i(x[0], x[1]), 6, Vector2i(0, 0), 0)
				elif SelectedMinion and get_cell_source_id(4, possible_position) == 5:
					SelectedMinion.position = possible_position * 16
					Map[SelectedMinionPosition.y][SelectedMinionPosition.x] = null
					Map[possible_position.y][possible_position.x] = SelectedMinion
					SelectedMinion.Moved = true
					SelectedMinion = null
					clear_layer(4)
				elif SelectedMinion and get_cell_source_id(4, possible_position) == 6:
					SelectedMinion.Attacked = true
					SelectedMinion = null
					clear_layer(4)
				elif Tile == null:
					clear_layer(4)
					var obj = spawn_obj.instantiate()
					obj.Initialize("Skeleton1") 
					obj.position = local_to_map(get_global_mouse_position()) * 16
					obj.name = "Minion" + str(Counter)
					Counter += 1
					add_child(obj)
					Map[possible_position.y][possible_position.x] = obj
					SelectedMinion = null
			else:
				if Map[possible_position.y][possible_position.x] == null:
					var obj = spawn_obs.instantiate()
					obj.position = local_to_map(get_global_mouse_position()) * 16
					add_child(obj)
					set_cell(0, possible_position, 1, Vector2i(0, 0), 0)
					print(get_cell_source_id(0, possible_position))	
					Map[possible_position.y][possible_position.x] = obj
