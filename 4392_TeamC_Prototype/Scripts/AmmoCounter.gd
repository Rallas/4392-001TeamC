extends Label

# Very basic ammo counter implementation, to later be replaced with prettier HUD
# Linked to the 'updateAmmo' signal emitted by the player. (Signal linked in Godot editor window)

var currentMag = 0
var magSize = 0
var reserveAmmo = 0

func _ready():
  currentMag = 0
  magSize = 0
  reserveAmmo = 0

func _on_DefaultWeapon_updateAmmo(m, s, r):
  currentMag = m
  magSize = s
  reserveAmmo = r
  updateLabel()
  
  
  
func updateLabel():
  text = "Ammo: [%d/%d] [+%d]" % [currentMag, magSize, reserveAmmo]
  
