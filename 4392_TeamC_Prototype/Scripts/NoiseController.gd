extends Node2D

# Wrapper script to make it easier to standardize creating noise sources

# In any script that needs to produce noise, include this line at the top: (Name doesn't matter)
# onready var NC = get_node("/root/RootNode/NoiseController")

# Then you can spawn a noise with
# NC.CreateNoise({position}, {intensity})


var NoiseObject = preload("res://Scenes/NoiseSource.tscn")
onready var AudioSource = get_node("AudioStreamPlayer")

var bus_index = AudioServer.get_bus_index("SFX")

var FootstepAudio = [
  preload("res://Resources/Audio/Footsteps/Footstep-00.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-01.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-02.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-03.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-04.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-05.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-06.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-07.wav"),
  preload("res://Resources/Audio/Footsteps/Footstep-08.wav")
 ]

var DoorOpen = preload("res://Resources/Audio/dorm-door-opening-6038.mp3")
var UnlockDoor = preload("res://Resources/Audio/unlock-the-door-2-99745.mp3")

var rng = RandomNumberGenerator.new()

func _ready():
  rng.randomize()
  AudioSource.bus = AudioServer.get_bus_send(bus_index)

func CreateNoise(noisePosition, noiseIntensity, soundType = null):
    var newNoise = NoiseObject.instance()
    # Note: initNoise requires that the node already be in the scene tree, so add it first
    add_child(newNoise)
    newNoise.InitNoise(noisePosition, noiseIntensity)
    
    if soundType != null:
      match soundType:
        "footstep":
          AudioSource.stream = FootstepAudio[rng.randi_range(0, FootstepAudio.size() - 1)]
          AudioSource.play()
        "dooropen":
          AudioSource.stream = DoorOpen
          AudioSource.play()
        "unlockdoor":
          AudioSource.stream = UnlockDoor
          AudioSource.play()
      pass
