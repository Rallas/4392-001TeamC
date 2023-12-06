extends Control

onready var music_index = AudioServer.get_bus_index("Music")
onready var sfx_index = AudioServer.get_bus_index("SFX")
onready var master_index = AudioServer.get_bus_index("Master")

onready var MasterSlider = get_node("/root/Control/VBoxContainer/VBoxContainer/MasterSlider")
onready var MusicSlider = get_node("/root/Control/VBoxContainer/VBoxContainer3/MusicSlider")
onready var SFXSlider = get_node("/root/Control/VBoxContainer/VBoxContainer2/SFXSlider")
onready var FullscreenCheck = get_node("/root/Control/VBoxContainer/HBoxContainer/Fullscreen")

onready var Click = get_node("%ClickAudio")

# Called when the node enters the scene tree for the first time.  
func _ready():
    MasterSlider.value = SoundData.get_master_value()
    SFXSlider.value = SoundData.get_sfx_value()
    MusicSlider.value = SoundData.get_music_value()
    FullscreenCheck.pressed = Global.FullScreen
    $VBoxContainer.add_constant_override("separation", 20)
    
func _on_MusicSlider_value_changed(value):
    AudioServer.set_bus_volume_db(music_index, linear2db(value))
    AudioServer.set_bus_mute(music_index, music_index < .05)
    SoundData.set_music_value(value)

func _on_SFXSlider_value_changed(value):
    AudioServer.set_bus_volume_db(sfx_index, linear2db(value))
    AudioServer.set_bus_mute(sfx_index, sfx_index < .05)
    SoundData.set_sfx_value(value)

func _on_MasterSlider_value_changed(value):
    AudioServer.set_bus_volume_db(master_index, linear2db(value))
    AudioServer.set_bus_mute(master_index, sfx_index < .05)
    SoundData.set_master_value(value)


func _on_SFXSlider_drag_ended(_value_changed):
  Click.play()

func _on_MasterSlider_drag_ended(_value_changed):
  Click.play()

func _on_MusicSlider2_drag_ended(_value_changed):
  Click.play()

func _on_Fullscreen_toggled(button_pressed):
    Click.play()
    OS.set_window_fullscreen(button_pressed)
    if button_pressed:
        Global.FullScreen = true
    if button_pressed == false:
        Global.FullScreen = false
