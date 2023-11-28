extends Control


func _on_AnimatedSprite_ready():
    $AnimatedSprite.play("Begin")
    $BeginAudio.play()

func _on_Timer_timeout():
    $AnimatedSprite.frame = 0
    $AnimatedSprite.play("Flicker")
    $FlickerAudio.play()
