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
		
	
	
	
