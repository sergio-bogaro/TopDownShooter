extends Area2D

signal take_hit

func _on_area_entered(area):
	var hitDamage = area.Damage
	var knockBackForce = area.KnockBackForce
	var areaPosition = area.position
	
	emit_signal("take_hit", hitDamage, knockBackForce, areaPosition)
