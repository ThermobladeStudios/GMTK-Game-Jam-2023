extends Node2D

var attack = [0,0,0,0]



func _on_beam_attack_up_area_entered(area):
	if("Minion" in area.get_name()):
		attack[0] += 1
func _on_beam_attack_up_area_exited(area):
	if("Minion" in area.get_name()):
		attack[0] -= 1
func _on_beam_attack_down_area_entered(area):
	if("Minion" in area.get_name()):
		attack[1] += 1
func _on_beam_attack_down_area_exited(area):
	if("Minion" in area.get_name()):
		attack[1] -= 1
func _on_beam_attack_left_area_entered(area):
	if("Minion" in area.get_name()):
		attack[2] += 1
func _on_beam_attack_left_area_exited(area):
	if("Minion" in area.get_name()):
		attack[2] -= 1
func _on_beam_attack_right_area_entered(area):
	if("Minion" in area.get_name()):
		attack[3] += 1
func _on_beam_attack_right_area_exited(area):
	if("Minion" in area.get_name()):
		attack[3] -= 1
