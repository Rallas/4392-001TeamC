extends ColorRect



# Temp script for tutorial text until we make a real pause menu


var shouldTimeout = true
var timeout

# Called when the node enters the scene tree for the first time.

func _ready():
	timeout = OS.get_ticks_msec() + 3000
	


func _process(delta):
	if shouldTimeout and OS.get_ticks_msec() > timeout:
		shouldTimeout = false
		visible = false
		
	if Input.is_action_just_pressed("ui_cancel"):
		shouldTimeout = false
		visible = not visible
