extends Area2D

onready var anim = $AnimationPlayer
var firstTime = 1

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _on_Interact_body_entered(body):
    if body.is_in_group("Player"):
        if firstTime:
            anim.play("interact_text")
            firstTime = 0
