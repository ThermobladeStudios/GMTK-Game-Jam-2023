extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Mode/Obstacle.visible = false
	$Mode/Minion.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CoinCounter/Label.text = str(Global.Coins)
	if Input.is_action_just_pressed("Swap"):
		$Mode/Obstacle.visible = !$Mode/Obstacle.visible
		$Mode/Minion.visible = !$Mode/Minion.visible
	
	
