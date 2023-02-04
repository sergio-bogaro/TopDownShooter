extends Area2D

signal take_damage

func _on_area_entered(area):
	var hitDamage = area.Damage
	emit_signal("take_damage", hitDamage)
