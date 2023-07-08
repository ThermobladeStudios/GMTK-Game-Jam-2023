extends Area2D


@export var HEALTH = 100
var Damage = 10
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)



var new_velocity : Vector2
@onready var currPos = self.position
@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D

var attacktype


func _ready():
	navigation_agent.path_desired_distance = 10.0
	navigation_agent.target_desired_distance = 50.0
	$movement.start(0.5)
	$ProgressBar.max_value = HEALTH

func _process(delta):
	$ProgressBar.value = HEALTH
	

func _physics_process(delta):
	actor_setup()
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	new_velocity = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity.round()

func movement(new_velocity):
	if(new_velocity[1] == -1): 
		#print("Up")
		currPos[1] -=16
	elif(new_velocity[1] == 1):
		#print("Down")
		currPos[1] +=16
	elif(new_velocity[0] == -1):
		#print("Left")
		currPos[0] -=16
	elif(new_velocity[0] == 1):
		#print("right")
		currPos[0] +=16
	self.position = Vector2(currPos[0], currPos[1])
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target.position)


func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point
	

func _on_movement_timeout():
	print(deciding_attack())
	if($Small_Attack.attack == [0,0,0,0]):
		movement(new_velocity)
	else:
		for x in 4:
			if($Small_Attack.attack[x] == 1):
				if (x == 0):
					pass
					#print("enemy Up")
				elif(x == 1):
					pass
					#print("enemy Down")
				elif(x == 2):
					pass
					#print("enemy Left")
				elif(x == 3):
					pass
					#print("enemy Right")


func deciding_attack():
	var satk :float = $Small_Attack.get_weight()
	var batk :float = $Beam_Attack.get_weight()
	var tot_minions = get_tree().get_nodes_in_group("minions").size()


	var sweight = (satk/tot_minions)*100
	var bweight = (batk/tot_minions)*100
	var attacktype = randi_range(1,100)
	if(attacktype < sweight):
		print(attacktype)
		return ("small attack")

	elif(attacktype > sweight):
		return("beam attack")
	
	
	


