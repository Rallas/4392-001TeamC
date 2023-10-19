extends StaticBody2D


onready var NC = get_node("/root/RootNode/NoiseController")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var lastNoiseTime = 0
var noiseInterval = 400
var noiseIntensity = 100

var timeToUnlock = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Interact():
	print("%d percent remaining" % [timeToUnlock])
	timeToUnlock -= 1
	
	if OS.get_ticks_msec() - lastNoiseTime > noiseInterval:
		lastNoiseTime = OS.get_ticks_msec()
		NC.CreateNoise(global_position, noiseIntensity)
	
	if timeToUnlock <= 0:
		queue_free()

