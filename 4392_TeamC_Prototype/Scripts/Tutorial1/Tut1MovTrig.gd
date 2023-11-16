extends Area2D

onready var anim = $AnimationPlayer
var firstTime = 1

func _ready():
    pass # Replace with function body.



func _on_Movement_body_entered(body):
    if body.is_in_group("Player"):
        if firstTime:
            anim.play("movement_text")
            firstTime = 0
        
