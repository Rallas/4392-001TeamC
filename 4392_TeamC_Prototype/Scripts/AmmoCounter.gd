extends Label

# Very basic ammo counter implementation, to later be replaced with prettier HUD
# Linked to the 'updateAmmo' signal emitted by the player. (Signal linked in Godot editor window)

func _on_DefaultWeapon_updateAmmo(currentMag, magSize):
    text = "Ammo: %d/%d" % [currentMag, magSize]
    pass # Replace with function body.
