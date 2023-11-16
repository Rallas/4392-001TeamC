extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

var displayedMag = 0
var displayedMagSize = 0
var displayedNumBullets = 0

func UpdateAmmo(currentMag = null, magSize = null, numBullets = null):
  if currentMag != null:
    displayedMag = currentMag
  if magSize != null:
    displayedMagSize = magSize
  if numBullets != null:
    displayedNumBullets = numBullets
  
  get_node("./HUD/AmmoLabel").text = "Ammo: [%d/%d] [+%d]" % [displayedMag, displayedMagSize, displayedNumBullets]

func UpdateHealth(current, maxHealth):
  get_node("./HUD/HealthLabel").text = "Health: %d/%d" % [current, maxHealth]
