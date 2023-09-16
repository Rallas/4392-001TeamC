extends KinematicBody2D

# Script to handle enemy behavior.
# Might add the movement/attack logic here, or that may go in another script.


signal healthChanged(newHealth, maxHealth)

export var maxHealth = 4
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	emit_signal("healthChanged", health, maxHealth)
	pass # Replace with function body.


func HitByProjectile():
	health -= 1; #TODO: pass bullet damage via param
	emit_signal("healthChanged", health, maxHealth)
	if health == 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Note: Any node in the "NoiseListener" group needs to have this function defined with these parameters
func ReactToNoise(noisePosition, noiseIntensity):
	var distanceToNoise = global_position.distance_to(noisePosition)
	
	if distanceToNoise < noiseIntensity:
		print("%s | I HEARD THAT!" % name)
	
