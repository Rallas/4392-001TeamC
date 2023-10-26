extends Node2D

# This script handles function of a weapon.


# TODO: Should probably change accuracy penalty logic to be based on angles, not position offsets. \
#   (If we want to ever support controllers, those can only aim towards an angle, not a position)

# TODO: Add a numBulletsPerShot variable, to support a shotgun-type weapon that fires a spread of shots.

# TODO: Add a variable to configure amount of noise a shot makes
# TODO: Make noise on reload

signal updateAmmo(currentMag, magSize, reserveAmmo)

##############################################
# Configurable Weapon properties
export var bulletSpeed = 500		# (I think pixels/second)
export var fireRate = 100 			# Milliseconds between shots
export var fullAuto = false		# Hold fire button or click each shot
export var bulletRange = 1000		# Pixels traveled before delete
export var magSize = 8				# Num shots before reloading
export var reloadTime = 1000		# milliseconds to reload

# Accuracy penalty:
# I coded this the easy way for now without dealing with trigonometry.
# A value of (P) means the bullet will target a random point within 
export var hipfireAccuracyPenalty = 50
export var aimingAccuracyPenalty = 10
##############################################


var currentMag
var nextShotTime
var reloading
var doneReloadTime

var bulletNode = preload("res://Scenes/Bullet.tscn")

onready var NC = get_node("/root/RootNode/NoiseController")
onready var PlayerInventory = get_node("../Inventory")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    currentMag = magSize
    nextShotTime = OS.get_ticks_msec()
    reloading = false
    emit_signal("updateAmmo", currentMag, magSize, PlayerInventory.numBullets)
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    
    # Press a keybind to manually start reloading
    if Input.is_action_just_pressed("reload") and currentMag < magSize:
        StartReload()
    # Check if done reloading
    if reloading and OS.get_ticks_msec() > doneReloadTime:
        StopReload()
        
    if CheckIfShooting() and not reloading:
        if currentMag <= 0:
            StartReload()
            
        else:
            # Fire a shot
            currentMag -= 1
            emit_signal("updateAmmo", currentMag, magSize, PlayerInventory.numBullets)
            nextShotTime = OS.get_ticks_msec() + fireRate
        
            # Instantiate a new bullet in the scene
            var newBullet = bulletNode.instance()
            get_node(@"/root").add_child(newBullet)
            
            # Random vector offset. x and y both floats in range [-1,1]
            var accuracyPenalty = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
            
            # Scale accuracy penalty based on aim/hipfire
            if Input.is_action_pressed("aim"):
                accuracyPenalty *= aimingAccuracyPenalty
            else:
                accuracyPenalty *= hipfireAccuracyPenalty
            
            
            var shotTarget = get_global_mouse_position() + accuracyPenalty
            newBullet.InitBullet(shotTarget, global_position, bulletSpeed, bulletRange)
            
            NC.CreateNoise(newBullet.position, 300)


func StartReload():
    if PlayerInventory.numBullets <= 0:
      return
      
    reloading = true
    doneReloadTime = OS.get_ticks_msec() + reloadTime
    get_node(@"/root/RootNode/UI Container/ReloadText").visible = true
    

func StopReload():
    reloading = false
    
    var numToLoad = min(magSize - currentMag, PlayerInventory.numBullets)
    
    currentMag += numToLoad
    PlayerInventory.numBullets -= numToLoad
    
    emit_signal("updateAmmo", currentMag, magSize, PlayerInventory.numBullets)
    get_node(@"/root/RootNode/UI Container/ReloadText").visible = false
    


func CheckIfShooting():
    if fullAuto:
        if Input.is_action_pressed("shoot") and (OS.get_ticks_msec()  > nextShotTime):
            return true
    if not fullAuto:
        if Input.is_action_just_pressed("shoot") and (OS.get_ticks_msec() > nextShotTime):
            return true
    return false		
            
