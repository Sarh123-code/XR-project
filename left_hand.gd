extends Hand

func _physics_process(delta: float) -> void:
	var player := self.get_parent()
	var dir = get_vector2("primary")
	player.global_position.x += dir.x * (-5) * delta
