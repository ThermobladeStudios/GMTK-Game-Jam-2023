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

var beam_cd = 5


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
	if(beam_cd > 0):
		beam_cd -=1
	if($Small_Attack.attack == [0,0,0,0]):
		movement(new_velocity)
	else:
		if(deciding_attack() == 0):
			for x in 4:
				if($Small_Attack.attack[x] == 1):
					if (x == 0):
						$Small_Attack/Node2D/Up.visible = true
						continue
						#print("enemy Up")
					elif(x == 1):
						$Small_Attack/Node2D/Down.visible = true
						continue
						#print("enemy Down")s
					elif(x == 2):
						$Small_Attack/Node2D/Left.visible = true
						continue
						#print("enemy Left")
					elif(x == 3):
						$Small_Attack/Node2D/Right.visible = true
						continue
						#print("enemy Right")
		if(deciding_attack() == 1 && beam_cd == 0):
			var dir = $Beam_Attack.attack.find($Beam_Attack.attack.max())
			if(dir == 0):
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(10)
			elif(dir == 1):
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(10)
			elif(dir == 2):
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(10)
			elif(dir == 3):
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(10)
			$AnimatedSprite2D2.play()
			beam_cd = 5
			


func deciding_attack():
	var satk :float = $Small_Attack.get_weight()
	var batk :float = $Beam_Attack.get_weight()
	var tot_minions = get_tree().get_nodes_in_group("minions").size()


	var sweight = ((satk/tot_minions)*100) + 20
	var bweight = (batk/tot_minions)*100
	var attacktype = randi_range(1,100)
	if(attacktype < sweight):
		return (0)

	elif(attacktype > sweight):
		return(1)
	
	
	




func _on_animated_sprite_2d_2_animation_looped():
	var dir = $Beam_Attack.attack.find($Beam_Attack.attack.max())
	if(dir == 0):
		if($AnimatedSprite2D2.global_position.y > 32):
			$AnimatedSprite2D2.position.y -= 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
	elif(dir == 1):
		if($AnimatedSprite2D2.global_position.y < 128):
			$AnimatedSprite2D2.position.y += 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
	elif(dir == 2):
		if($AnimatedSprite2D2.global_position.x > 32):
			$AnimatedSprite2D2.position.x -= 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
	elif(dir == 3):
		if($AnimatedSprite2D2.global_position.x < 272):
			$AnimatedSprite2D2.position.x += 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
