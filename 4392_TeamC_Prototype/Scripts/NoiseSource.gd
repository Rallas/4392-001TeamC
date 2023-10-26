extends Node2D

# Behavior script for a noise source node.
# When initialized, will tell any listening nodes current position and intensity
# Also shows a visualization of noise radius

# TODO: Improve picture used for noise source radius.
#		(tool I used to create it has a max brush size of 64px, so it is a very blocky image)

var timeout = 100 # timeout (msec) for how long visual will be displayed.
var spawnTime
var intensity

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func InitNoise(noisePosition, noiseIntensity):
  position = noisePosition
  intensity = noiseIntensity
  spawnTime = OS.get_ticks_msec()
  
  # Sprite attached to this is a circle with radius = {width/2} pixels
  # Scale it by (intensity/radius) to make it a circle with new radius = {intensity} pixels
  var spriteNode = get_child(0)
  scale  *= (intensity / (spriteNode.texture.get_width() / 2))
  
  # Any node belonging to the group "NoiseListener" will have its ReactToNoise() function called.
  get_tree().call_group("NoiseListener", "ReactToNoise", noisePosition, noiseIntensity)
  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  
  
  if OS.get_ticks_msec() - spawnTime > timeout:
    queue_free() # Delete this node after {timeout} msec.
