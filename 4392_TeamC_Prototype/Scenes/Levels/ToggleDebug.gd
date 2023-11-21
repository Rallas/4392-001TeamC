extends Area2D
var firstTime = 1

func _on_Toggle_Debug_body_entered(body):
    if body.is_in_group("Player"):
        if firstTime:
            Global.ToggleSoundDebug()
            firstTime = 0
