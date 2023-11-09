extends Camera2D

# Script to handle camera movement
# This is attached to a camera node that is a child of the player node, so it will automatically follow the player.

# TODO: If we plan to ever support controllers, just offset the camera by a default distance while aiming.

# TODO: Set this number based on game window size/resolution.
# Max distance in pixels that the camera will move from the player. Will prevent aiming so far away that the player leaves the screen.
onready var VC = get_node("/root/RootNode/Player/Sprite/VisionCone")
onready var VCM = get_node("/root/RootNode/Player/Sprite/VisionConeMask")

var MaxDistanceFromPlayer = 500
var normalScale = Vector2(2,1)
var targetScale = Vector2(.3,1)
var lerpSpeedAim = 0.01 # adjust this value to change the speed of interpolation when aiming
var lerpSpeedHip = 0.02 # adjust this value to change the speed of interpolation when no longer aiming

func _ready():
    current = true # Should already be set in editor, but make this active camera just in case.

# If aiming, camera will focus on the point halfway between the player and the mouse.
# Otherwise, it will be centered on the player
# NOTE: This sets the local position. local position (0,0) is centered on the player
func _process(_delta):
    if Input.is_action_pressed("aim"):
        var cameraTarget = 0.5 * (get_global_mouse_position() - get_parent().global_position)
        
        if cameraTarget.length() > MaxDistanceFromPlayer:
            cameraTarget = MaxDistanceFromPlayer * cameraTarget.normalized()
            
        position = cameraTarget
        VC.scale = VC.scale.linear_interpolate(targetScale, lerpSpeedAim)
        VCM.scale = VCM.scale.linear_interpolate(targetScale, lerpSpeedAim)
    else:
        position = Vector2.ZERO
        VC.scale = VC.scale.linear_interpolate(normalScale, lerpSpeedHip)
        VCM.scale = VCM.scale.linear_interpolate(normalScale, lerpSpeedHip)
    pass
