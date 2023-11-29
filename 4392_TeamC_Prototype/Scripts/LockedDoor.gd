extends StaticBody2D

onready var NC = get_node("/root/RootNode/NoiseController")
onready var UIProgressBar = get_node("./UnlockProgressUI/ProgressBar")
var doorNode = preload("res://Scenes/InteractibleObjects/Door.tscn")

export var resetProgress = false

var lastNoiseTime = 0
var noiseInterval = 400
var noiseIntensity = 100

var totalTimeToUnlock = 100
var timeToUnlock = 100

var lastInteractTime = 0
var inactiveInterval = 100

# Called when the node enters the scene tree for the first time.
func _ready():
  UIProgressBar.max_value = totalTimeToUnlock
  UIProgressBar.visible = false
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  # If resetProgress, clear any progress made after small interval of no Interact() calls.
  if resetProgress and timeToUnlock < totalTimeToUnlock:
    if OS.get_ticks_msec() - lastInteractTime > inactiveInterval:
      timeToUnlock = totalTimeToUnlock
      UIProgressBar.value = timeToUnlock
      UIProgressBar.visible = false
      

# Object set to not be instant, so this will be called repeatedly while interacting.
func Interact():
  if(timeToUnlock < totalTimeToUnlock):
    UIProgressBar.visible = true
    
  UIProgressBar.value = timeToUnlock
  timeToUnlock -= 1
  
  lastInteractTime = OS.get_ticks_msec()
  
  if OS.get_ticks_msec() - lastNoiseTime > noiseInterval:
    lastNoiseTime = OS.get_ticks_msec()
    NC.CreateNoise(global_position, noiseIntensity, "unlockdoor")
  
  if timeToUnlock <= 0:
    
    # Spawn in a normal door to replace this one
    var newDoor = doorNode.instance()
    newDoor.isClosed = false
    newDoor.position = position
    get_parent().add_child(newDoor)
    
    # Remove the locked door now that script is done placing a normal door.
    queue_free()
