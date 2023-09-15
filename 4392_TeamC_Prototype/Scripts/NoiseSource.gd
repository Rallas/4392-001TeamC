extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timeout = 100
var spawnTime
var intensity
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func InitNoise(noisePosition, noiseIntensity):
	position = noisePosition
	intensity = noiseIntensity
	spawnTime = OS.get_ticks_msec()
	
	# TEMP: Image I am using is a circle with 32 radius.
	# scale the image by a factor of (intensity/32) -> new radius is [intensity] pixels.
	get_child(0).scale = Vector2(intensity/32, intensity/32)
	
	print("NOISE: I=[%d] P=(%d,%d)" %[noiseIntensity, noisePosition.x, noisePosition.y])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if OS.get_ticks_msec() - spawnTime > timeout:
		queue_free()
