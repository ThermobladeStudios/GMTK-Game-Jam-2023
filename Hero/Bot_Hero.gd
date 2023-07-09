extends Area2D

var Damage = 10
var File = FileAccess.get_file_as_string("res://Placables/Minions/Minions.json")
var Json = JSON.parse_string(File)

var Name = "Hero"

var new_velocity : Vector2
@onready var currPos = self.position
@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D

var attacktype

var beam_cd = 5
var dir

func _ready():
	navigation_agent.path_desired_distance = 10.0
	navigation_agent.target_desired_distance = 50.0
	

func _physics_process(delta):
	actor_setup()
	
	var current_agent_position: Vector2 = global_position
	
	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	new_velocity = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity.round()
	Global.Map[position.y / 16][position.x / 16] = self

func movement(new_velocity):
	$Small_Attack/Node2D/Up.visible = false
	$Small_Attack/Node2D/Down.visible = false
	$Small_Attack/Node2D/Left.visible = false
	$Small_Attack/Node2D/Right.visible = false
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
	

func nextTurn():
	if(beam_cd > 0):
		beam_cd -=1
	if($Small_Attack.attack == [0,0,0,0]):
		movement(new_velocity)
		
	else:
		if(deciding_attack() == 1 && beam_cd == 0):
			dir = $Beam_Attack.attack.find($Beam_Attack.attack.max())
			if(dir == 0):
				$Small_Attack/Node2D/Up.visible = true
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(50)
			elif(dir == 1):
				$Small_Attack/Node2D/Down.visible = true
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(50)
			elif(dir == 2):
				$Small_Attack/Node2D/Left.visible = true
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(50)
			elif(dir == 3):
				$Small_Attack/Node2D/Right.visible = true
				for x in $Beam_Attack.inarea[dir]:
					x.do_damage(50)
			$AnimatedSprite2D2.play()
			beam_cd = 5
		elif (deciding_attack() == 0):
			var dirs = $Small_Attack.attack.find($Small_Attack.attack.max())
			if(dirs == 3):
				$Small_Attack/Small_attack_Right/Smol_Right.play()
				for x in $Small_Attack.inarea[dirs]:
					x.do_damage(20)
			elif(dirs == 2):
				$Small_Attack/Small_attack_Left/Smol_Left.play()
				for x in $Small_Attack.inarea[dirs]:
					x.do_damage(20)
			elif(dirs == 0):
				$Small_Attack/Small_attack_Up/Smol_up.play()
				for x in $Small_Attack.inarea[dirs]:
					x.do_damage(20)
			elif(dirs == 1):
				$Small_Attack/Small_attack_Down/Smol_Down.play()
				for x in $Small_Attack.inarea[dirs]:
					x.do_damage(20)

			
			
			
			

func deciding_attack():
	var satk :float = $Small_Attack.get_weight()
	var batk :float = $Beam_Attack.get_weight()
	var tot_minions = get_tree().get_nodes_in_group("Minions").size()

	var sweight = ((satk/tot_minions)*100) + 20
	var bweight = (batk/tot_minions)*100
	var attacktype = randi_range(1,100)
	if(attacktype < sweight):
		return (0)

	elif(attacktype > sweight):
		return(1)
	
	
	




func _on_animated_sprite_2d_2_animation_looped():
	play_anim()
	
	
func play_anim():
	if(dir == 0):

		if($AnimatedSprite2D2.global_position.y > 32):
			$AnimatedSprite2D2.position.y -= 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
			$Small_Attack/Node2D/Up.visible = false
	elif(dir == 1):
		
		if($AnimatedSprite2D2.global_position.y < 128):
			$AnimatedSprite2D2.position.y += 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
			$Small_Attack/Node2D/Down.visible = false
	elif(dir == 2):
		
		if($AnimatedSprite2D2.global_position.x > 32):
			$AnimatedSprite2D2.position.x -= 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
			$Small_Attack/Node2D/Left.visible = false
	elif(dir == 3):
		
		if($AnimatedSprite2D2.global_position.x < 272):
			$AnimatedSprite2D2.position.x += 16
		else:
			$AnimatedSprite2D2.position = Vector2(0,0)
			$AnimatedSprite2D2.stop()
			$Small_Attack/Node2D/Right.visible = false
			
func do_damage(damage):
	Global.Health -= damage
