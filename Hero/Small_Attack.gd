extends Node2D

var attack = [0,0,0,0]


func _on_small_attack_up_area_entered(area):
	if(area.get_name() == "Minion"):
		attack[0] += 1
func _on_small_attack_up_area_exited(area):
	if(area.get_name() == "Minion"):
		attack[0] -= 1
func _on_small_attack_down_area_entered(area):
	if(area.get_name() == "Minion"):
		attack[1] += 1
func _on_small_attack_down_area_exited(area):
	if(area.get_name() == "Minion"):
		attack[1] -= 1
func _on_small_attack_left_area_entered(area):
	if(area.get_name() == "Minion"):
		attack[2] += 1
func _on_small_attack_left_area_exited(area):
	if(area.get_name() == "Minion"):
		attack[2] -= 1
func _on_small_attack_right_area_entered(area):
	if(area.get_name() == "Minion"):
		attack[3] += 1
func _on_small_attack_right_area_exited(area):
	print(area)
	if(area.get_name() == "Minion"):
		attack[3] -= 1
		
func _process(delta):
	print(attack)
	
