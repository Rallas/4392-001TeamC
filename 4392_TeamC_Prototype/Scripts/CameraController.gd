extends Camera2D

# Script to handle camera movement
# This is attached to a camera node that is a child of the player node, so it will automatically follow the player.

# TODO: If we plan to ever support controllers, just offset the camera by a default distance while aiming.

# TODO: Set this number based on game window size/resolution.
# Max distance in pixels that the camera will move from the player. Will prevent aiming so far away that the player leaves the screen.
onready var VC = get_node("/root/RootNode/Player/Sprite/VisionCone")
onready var VCM = get_node("/root/RootNode/Player/Sprite/VisionConeMask")

var MaxDistanceFromPlayer = 500

func _ready():
	current = true # Should already be set in editor, but make this active camera just in case.

# If aiming, camera will focus on the point halfway between the player and the mouse.
# Otherwise, it will be centered on the player
# NOTE: This sets the local position. local position (0,0) is centered on the player
func _process(delta):
	if Input.is_action_pressed("aim"):
		var cameraTarget = 0.5 * (get_global_mouse_position() - get_parent().global_position)
		
		if cameraTarget.length() > MaxDistanceFromPlayer:
			cameraTarget = MaxDistanceFromPlayer * cameraTarget.normalized()
			
		
		position = cameraTarget
		VC.scale = Vector2(1, 1)
		VCM.scale = Vector2(1, 1)
	else:
		position = Vector2.ZERO
		VC.scale = Vector2(2, 1)
		VCM.scale = Vector2(2, 1)
	pass
