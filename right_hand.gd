extends Hand

var pointing := false
var grabbed

func _on_button_released(action_name: String) -> void:
	if action_name == "trigger_touch":
		$Area3D/RayCast3D.visible = false
		pointing = false
	if grabbed :
		grabbed.reparent(self.get_parent().get_parent())
			
func _on_button_pressed(action_name: String) -> void:
	if action_name == "trigger_touch":
		$Area3D/RayCast3D.visible = true
		pointing = true
		
func _physics_process(delta: float) -> void:
	if not pointing:
		return
	if $Area3D/RayCast3D.is_colliding() :
		var c = $Area3D/RayCast3D.get_collision_point()
		$Area3D/RayCast3D/Collision.global_position = c
		$Area3D/RayCast3D/Collision.visible = true
		if is_button_pressed("trigger"):
			var col = $Area3D/RayCast3D.get_collider()
			if col :
				if col.is_in_group("button"):
					col.clicked.emit()
				if col.is_in_group("pickable"):
					grabbed = col
					grabbed.reparent(self)
					if grabbed:
						var dir = get_vector2("primary")
						var axe = self.global_position - c
						grabbed.global_position += axe * dir.y * (-2) * delta
	else :
		$Area3D/RayCast3D/Collision.visible = false
