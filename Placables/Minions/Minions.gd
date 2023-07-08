extends Area2D

var Name
var Health
var Attack
var Defense
var Position
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Initialize(Name):
	print(Name)
	$AnimatedSprite2D.play(Name)
	self.Name = Name
	Name = Json[Name]
	Health = Name["Health"]
	Attack = Name["Attack"]
	#Defense = Name["Defense"]

func do_damage(damage):
	Health -= damage
