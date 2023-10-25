extends Node2D

# Wrapper script to make it easier to standardize creating noise sources

# In any script that needs to produce noise, include this line at the top: (Name doesn't matter)
# onready var NC = get_node("/root/RootNode/NoiseController")

# Then you can spawn a noise with
# NC.CreateNoise({position}, {intensity})


var NoiseObject = preload("res://Scenes/NoiseSource.tscn")

func CreateNoise(noisePosition, noiseIntensity):
    var newNoise = NoiseObject.instance()
    # Note: initNoise requires that the node already be in the scene tree, so add it first
    add_child(newNoise)
    newNoise.InitNoise(noisePosition, noiseIntensity)
    
