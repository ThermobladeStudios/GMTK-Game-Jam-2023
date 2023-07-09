extends Node2D

var attack = [0,0,0,0]
var tot_atk
var inarea = [[],[],[],[]]

func _physics_process(delta):
	tot_atk = 0
	for i in 4:
		tot_atk += attack[i]


func _on_beam_attack_up_area_entered(area):
	if("Minion" in area.get_name()):
		attack[0] += 1
		inarea[0].append(area)
func _on_beam_attack_up_area_exited(area):
	if("Minion" in area.get_name()):
		attack[0] -= 1
		inarea[0].erase(area)
func _on_beam_attack_down_area_entered(area):
	if("Minion" in area.get_name()):
		attack[1] += 1
		inarea[1].append(area)
func _on_beam_attack_down_area_exited(area):
	if("Minion" in area.get_name()):
		attack[1] -= 1
		inarea[1].erase(area)
func _on_beam_attack_left_area_entered(area):
	if("Minion" in area.get_name()):
		attack[2] += 1
		inarea[2].remove(area)
func _on_beam_attack_left_area_exited(area):
	if("Minion" in area.get_name()):
		attack[2] -= 1
		inarea[2].erase(area)
func _on_beam_attack_right_area_entered(area):
	if("Minion" in area.get_name()):
		attack[3] += 1
		inarea[3].append(area)
func _on_beam_attack_right_area_exited(area):
	if("Minion" in area.get_name()):
		attack[3] -= 1
		inarea[3].erase(area)
func get_weight():
	return tot_atk
