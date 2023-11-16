extends Area2D

onready var anim = $AnimationPlayer
var firstTime = 1


func _on_Key_body_entered(body):
    if body.is_in_group("Player"):
        if firstTime:
            anim.play("key_text")
            firstTime = 0
