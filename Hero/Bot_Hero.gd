extends Area2D


@export var SPEED = 120
#@export var DMG = 20
@export var HEALTH = 100
#
#
#@onready var animation_tree = $AnimationTree
#@onready var state_machine = animation_tree.get("parameters/playback")
@onready var state = 0
#0 is idle 1 is walking 2 is attacking


@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 10.0
	navigation_agent.target_desired_distance = 50.0
	

	
	$ProgressBar.max_value = HEALTH
	


func _process(delta):
	$ProgressBar.value = HEALTH

func _physics_process(delta):
	actor_setup()
	if navigation_agent.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	position += new_velocity*16

#	pick_new_state()
#	update_animation_parameters(new_velocity)
	
	
func actor_setup():
	#await get_tree().physics_frame
	set_movement_target(movement_target.position)


func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point
	


#func update_animation_parameters(move_input : Vector2):	
#	if(move_input != Vector2.ZERO):
#		animation_tree.set("parameters/Walk/blend_position", move_input)
#	elif(state == 2):
#		velocity = Vector2.ZERO
#func pick_new_state():
#	if(state == 1):
#		state_machine.travel("Walk")
#	elif(state == 2):
#		state_machine.travel("Attack")




func _on_spawn_timeout():
	state = 1


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		state = 2


func _on_area_2d_body_exited(body):
	state = 1
