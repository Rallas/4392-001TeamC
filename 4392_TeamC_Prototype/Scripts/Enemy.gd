extends KinematicBody2D

# Script to handle enemy behavior.
# Might add the movement/attack logic here, or that may go in another script.
#warning-ignore:RETURN_VALUE_DISCARDED
var moveTarget

signal healthChanged(newHealth, maxHealth)

export var maxHealth = 4
var health

var moveSpeed = 100

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

func _physics_process(_delta):
  var velocity = Vector2.ZERO
  
  if not followingNoise and OS.get_ticks_msec() - lastRandomTargetTime > timeBetweenRandomTargets:
    lastRandomTargetTime = OS.get_ticks_msec() + rng.randi_range(0, timeBetweenRandomTargets)
    moveTarget = global_position + Vector2(rng.randi_range(-250, 250), rng.randi_range(-250, 250))
    
  if global_position.distance_to(moveTarget) > 10:
    velocity = (moveTarget - global_position).normalized()
    
    if followingNoise:
      velocity *= 3.5
    
    move_and_slide(velocity*moveSpeed)
  else:
    followingNoise = false


# Note: Any node in the "NoiseListener" group needs to have this function defined with these parameters
func ReactToNoise(noisePosition, noiseIntensity):
  var distanceToNoise = global_position.distance_to(noisePosition)
  
  if distanceToNoise < noiseIntensity:
    print("(t=%d) | %s | I HEARD THAT!" % [OS.get_ticks_msec(), name])
    followingNoise = true
    moveTarget = noisePosition
  


var playerBeingHit = null
func _process(_delta):
  if playerBeingHit != null:
    playerBeingHit.HitByEnemy()
    


func _on_AttackHitbox_body_entered(body):
  if body.is_in_group("Player"):
    playerBeingHit = body


func _on_AttackHitbox_body_exited(body):
  if body.is_in_group("Player"):
    playerBeingHit = null
