extends StaticBody2D


onready var NC = get_node("/root/RootNode/NoiseController")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var radioIsOn = false
var lastNoiseTime = 0
var noiseInterval = 400
var noiseIntensity = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if radioIsOn and OS.get_ticks_msec() - lastNoiseTime > noiseInterval:
		lastNoiseTime = OS.get_ticks_msec()
		NC.CreateNoise(global_position, noiseIntensity)
		
	pass # Replace with function body.

func Interact():
	radioIsOn = not radioIsOn

