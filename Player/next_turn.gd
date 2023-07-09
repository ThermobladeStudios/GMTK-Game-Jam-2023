extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _onTextureButton_mouse_entered():
	#$Animate.play("pressed")
	
func _onTextureButton_mouse_exited():
	$Animate.play("unpressed")

func _on_TextureButton_pressed():
	$Animate.play("pressed")
	#other stuff
