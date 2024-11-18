extends Area2D

func _physics_process(delta):
		$Sprite2D.look_at(get_global_mouse_position()) 
