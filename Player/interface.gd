extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HeroBar/FullHealth.visible = false
	$CoinCounter/Label.text = str(Global.Coins)
	if Input.is_action_just_pressed("Swap"):
		$Mode/Obstacle.visible = !$Mode/Obstacle.visible
		$Mode/Minion.visible = !$Mode/Minion.visible
	if $HeroBar/Health.value == $HeroBar/Health.max_value:
		$HeroBar/FullHealth.visible = true
		
	
	
	


func _on_next_turn_pressed():
	var hero_turn = get_tree().get_root().get_child(1).get_node("Hero")
	hero_turn.nextTurn()
