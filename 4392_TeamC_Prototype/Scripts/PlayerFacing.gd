extends Sprite


# Moved look_at() function here to prevent an issue where
# rotating the player while touching a wall could get the player's
# hitbox stuck inside the wall.
# This script now only rotates the players sprite, not the hitbox.
func _process(_delta):	
	look_at(get_global_mouse_position())

