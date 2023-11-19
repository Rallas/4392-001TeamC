extends Area2D

onready var anim = $AnimationPlayer
var firstTime = 1

func _on_3_body_entered(body):
    if body.is_in_group("Player"):
        if firstTime:
            anim.play("trigger_3")
            firstTime = 0
