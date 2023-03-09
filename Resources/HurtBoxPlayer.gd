extends Area2D

signal take_hit

func _on_area_entered(area):
	GotHit(area)

func GotHit(area):
	var hitDamage: int = area.Damage
	var knockBackForce: int = area.KnockBackForce
	var areaPosition: Vector2 = area.global_position
	
	emit_signal("take_hit", hitDamage, knockBackForce, areaPosition)
