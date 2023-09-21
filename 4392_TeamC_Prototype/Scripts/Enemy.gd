extends KinematicBody2D

# Script to handle enemy behavior.
# Might add the movement/attack logic here, or that may go in another script.


var moveTarget

signal healthChanged(newHealth, maxHealth)

export var maxHealth = 4
var health

var moveSpeed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	emit_signal("healthChanged", health, maxHealth)
	moveTarget = global_position


func HitByProjectile():
	health -= 1; #TODO: pass bullet damage via param
	emit_signal("healthChanged", health, maxHealth)
	if health == 0:
		queue_free()

func _physics_process(_delta):
	var velocity = Vector2.ZERO
	if global_position.distance_to(moveTarget) > 10:
		velocity = (moveTarget - global_position).normalized()
		move_and_slide(velocity*moveSpeed)
# Note: Any node in the "NoiseListener" group needs to have this function defined with these parameters
func ReactToNoise(noisePosition, noiseIntensity):
	var distanceToNoise = global_position.distance_to(noisePosition)
	
	if distanceToNoise < noiseIntensity:
		print("(t=%d) | %s | I HEARD THAT!" % [OS.get_ticks_msec(), name])
		moveTarget = noisePosition
	
