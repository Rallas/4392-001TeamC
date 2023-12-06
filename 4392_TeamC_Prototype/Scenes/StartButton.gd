extends Control

onready var AP = get_node("/root/TitleScreen/AnimatedSprite")
onready var EA = get_node("/root/TitleScreen/EndAudio")
onready var HA = get_node("/root/TitleScreen/HoverAudio")
onready var CA = get_node("/root/TitleScreen/ClickAudio")

func _on_Start_pressed():
    CA.play()
    AP.play("End")
    EA.play()
    yield(get_tree().create_timer(.7), "timeout")
    Global.CurrentLevel = 1
    PlayerInventory.Initialize()
    var _ret = get_tree().change_scene(Global.GetSceneForLevel(1)) 

func _on_Start_mouse_entered():
    HA.play()
