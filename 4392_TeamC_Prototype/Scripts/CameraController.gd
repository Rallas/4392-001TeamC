extends Camera2D

func _ready():
	current = true # Should be set in editor, but make this active camera just in case.

# If aiming, camera will focus on the point halfway between the player and the mouse.
# Otherwise, it will be centered on the player
func _process(delta):
	if Input.is_action_pressed("aim"):
		position = 0.5 * (get_global_mouse_position() - get_parent().global_position)
	else:
		position = Vector2.ZERO # Local position of zero since it is a child of the player node.
	pass
