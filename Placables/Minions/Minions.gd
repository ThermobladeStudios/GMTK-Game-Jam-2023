extends Area2D

var Name
var Health = 1
var Attack
var Defense
var Position
var Moved = false
var Attacked = false
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Initialize(Name):
	$AnimatedSprite2D.play(Name)
	self.Name = Name
	Name = Json[Name]
	Health = Name["Health"]
	Attack = Name["Attack"]
	#Defense = Name["Defense"]
	$ProgressBar.max_value = Health

func _process(delta):
	$ProgressBar.value = Health
	if(Health <= 0):
		Global.Map[position.y / 16][position.x / 16] = null
		self.queue_free()

func do_damage(damage):
	Health -= damage
	$Damage.text = str(damage)
	$Damage.visible = true
	$Damage.modulate = Color.WHITE
	$Damage.position = Vector2(3, -6)
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($Damage, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_property($Damage, "position", $Damage.position - Vector2(0, 5), 0.5)
