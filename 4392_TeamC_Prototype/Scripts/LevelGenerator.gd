extends Node2D

# Script to handle level generation.


# TODO: Randomly arrange instances of nodes from "res://Scenes/Rooms/"
# TODO: remove the test code in _ready() function.

func _ready():
    
    # -----------------------------------------------------------------------
    # TODO: Remove this temp code! Using unique enemy names in testing.
    # This only works because enemies are already in the scene on launch. Once we are generating the level at runtime, it will not work.
    var enemies = get_tree().get_nodes_in_group("Enemy")
    var i = 1
    for enemy in enemies:
        enemy.name = "Enemy %d" % i
        enemy.get_node("./Label").text = "Enemy %d" % i
        i += 1
    # -----------------------------------------------------------------------

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
