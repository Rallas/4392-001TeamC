extends Node2D

var NoiseObject = preload("res://Scenes/NoiseSource.tscn")

func CreateNoise(noisePosition, noiseIntensity):
	var newNoise = NoiseObject.instance()
	newNoise.InitNoise(noisePosition, noiseIntensity)
	add_child(newNoise)
	
