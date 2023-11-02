extends Node2D

# Script to handle level generation.


# TODO: Randomly arrange instances of nodes from "res://Scenes/Rooms/"
# TODO: remove the test code in _ready() function.

func _ready():
    print("LEVEL %d" % [Global.CurrentLevel])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
