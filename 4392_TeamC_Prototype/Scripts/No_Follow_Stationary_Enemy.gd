extends KinematicBody2D

# Script to handle enemy behavior.
# Might add the movement/attack logic here, or that may go in another script.
#warning-ignore:RETURN_VALUE_DISCARDED
var moveTarget

signal healthChanged(newHealth, maxHealth)

export var maxHealth = 4
var health

var moveSpeed = 100
var inertia = 100

var followingNoise = false
var lastRandomTargetTime = 0
var timeBetweenRandomTargets = 1000
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
  health = maxHealth
  emit_signal("healthChanged", health, maxHealth)
  moveTarget = global_position
  rng.randomize()


func HitByProjectile():
  health -= 1; #TODO: pass bullet damage via param
  emit_signal("healthChanged", health, maxHealth)
  if health == 0:
    queue_free()
    

# Note: Any node in the "NoiseListener" group needs to have this function defined with these parameters
func ReactToNoise(noisePosition, noiseIntensity):
  var distanceToNoise = global_position.distance_to(noisePosition)
  
  if distanceToNoise < noiseIntensity:
    followingNoise = true
    moveTarget = Vector2(0,0)
  

var lastAttackTime = 0
var attackSpeed = 500


var AttackableObjects = Array()
func _process(_delta):
  if AttackableObjects.size() > 0:
    
    if OS.get_ticks_msec() - attackSpeed > lastAttackTime:
      lastAttackTime = OS.get_ticks_msec()
      
      for Item in AttackableObjects:
        if Item.is_in_group("Player"):
          Item.HitByEnemy()
        else:
          # This is some terrible code, but it works i guess...
          get_node(str(Item.get_path()) + "/ObjectHealth").HitByEnemy()
    


func _on_AttackHitbox_body_entered(body):
  if body.is_in_group("Attackable"):
    AttackableObjects.append(body)


func _on_AttackHitbox_body_exited(body):
  if body.is_in_group("Attackable"):
    AttackableObjects.erase(body)
