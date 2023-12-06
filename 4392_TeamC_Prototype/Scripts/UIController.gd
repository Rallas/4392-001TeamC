extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var UIBulletSprites = [
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet1"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet2"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet3"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet4"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet5"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet6"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet7"),
  get_node("./HUD/HUD_BG/AmmoContainer/Bullet8"),
 ]


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

var displayedMag = 0
var displayedNumBullets = 0

func UpdateAmmo(currentMag = null, numBullets = null):
  if currentMag != null:
    displayedMag = currentMag
  if numBullets != null:
    displayedNumBullets = numBullets
  
  for i in range(0,8):
    if i < displayedMag:
      UIBulletSprites[i].visible = true
    else:
      UIBulletSprites[i].visible = false
      
  get_node("./HUD/HUD_BG/AmmoContainer/ReservesLabel").text = "+ %d" % [displayedNumBullets]

func UpdateHealth(current, maxHealth):
  get_node("./HUD/HUD_BG/HealthBar").value = current
  get_node("./HUD/HUD_BG/HealthBar").max_value = maxHealth
  pass
  #get_node("./HUD/HUD_BG/HealthLabel").text = "Health: %d/%d" % [current, maxHealth]
  
func GameOver():
  get_node("./GameOver").visible = true
  get_node("./HUD").visible = false
  print("game over")
  

func UpdateKeyHUD():
  get_node("./HUD/HUD_BG/KeyIcon").visible = PlayerInventory.carryingKey
