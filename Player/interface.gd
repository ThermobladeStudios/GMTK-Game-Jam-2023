extends Control
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)
var hturns = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.

func UpdateStats():
	$InventoryBar/Skeleton1/TextureRect/Label.text = str(Json["Skeleton1"]["Attack"])
	$InventoryBar/Skeleton1/TextureRect2/Label.text = str(Json["Skeleton1"]["Health"])
	$InventoryBar/Skeleton2/TextureRect/Label.text = str(Json["Skeleton2"]["Attack"])
	$InventoryBar/Skeleton2/TextureRect2/Label.text = str(Json["Skeleton2"]["Health"])
	$InventoryBar/Skull/TextureRect/Label.text = str(Json["Skull"]["Attack"])
	$InventoryBar/Skull/TextureRect2/Label.text = str(Json["Skull"]["Health"])
	$InventoryBar/Vampire/TextureRect/Label.text = str(Json["Vampire"]["Attack"])
	$InventoryBar/Vampire/TextureRect2/Label.text = str(Json["Vampire"]["Health"])
	
func _process(delta):
	UpdateStats()
	$HeroBar/FullHealth.visible = false
	$CoinCounter/Label.text = str(Global.Coins)
	if Input.is_action_just_pressed("Swap"):
		$Mode/Obstacle.visible = !$Mode/Obstacle.visible
		$Mode/Minion.visible = !$Mode/Minion.visible
	if $HeroBar/Health.value == $HeroBar/Health.max_value:
		$HeroBar/FullHealth.visible = true
	

func _on_next_turn_pressed():
	hturns = 0
	$Timer.start(0.5)

	for x in get_tree().get_nodes_in_group("Minions"):
		x.Moved = false
		x.Attacked = false


func _on_timer_timeout():
	var hero_turn = get_tree().get_root().get_child(1).get_node("Hero")
	hero_turn.nextTurn()
	hturns += 1
	if(hturns == 3):
		$Timer.stop()


func _on_skeleton_1_pressed():
	pass # Replace with function body.


func _on_skeleton_2_pressed():
	pass # Replace with function body.


func _on_skull_pressed():
	pass # Replace with function body.


func _on_vampire_pressed():
	pass # Replace with function body.
