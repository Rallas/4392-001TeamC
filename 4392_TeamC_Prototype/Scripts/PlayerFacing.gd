extends Sprite

# This script rotates the player sprite to face the camera.
# I didn't put this in the main player script because rotating the entire player and its hitbox was causing clipping issues.

# TODO: split this out to rotate [head/torso/legs] separately.

func _process(_delta):	
    look_at(get_global_mouse_position())

