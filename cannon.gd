extends Area2D

# delta not used yet, so I had it be _delta for now. When/if we need it
# we can just take out the underscore (Juan)
func _physics_process(_delta):
		$Sprite2D.look_at(get_global_mouse_position()) 
