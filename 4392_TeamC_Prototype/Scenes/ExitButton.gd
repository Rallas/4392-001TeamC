extends Control

onready var AP = get_node("/root/TitleScreen/AnimatedSprite")
onready var HA = get_node("/root/TitleScreen/HoverAudio")
onready var CA = get_node("/root/TitleScreen/ClickAudio")
onready var EA = get_node("/root/TitleScreen/EndAudio")

func _on_Quit_pressed():
    CA.play()
    AP.play("End")
    EA.play()
    yield(get_tree().create_timer(.7), "timeout")
    get_tree().quit()


func _on_Quit_mouse_entered():
    HA.play()
