extends Control

onready var music_index = AudioServer.get_bus_index("Music")
onready var sfx_index = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.  
func ready():
    pass
    
func _on_MusicSlider_value_changed(value):
    AudioServer.set_bus_volume_db(music_index, linear2db(value))
    AudioServer.set_bus_mute(music_index, music_index < .05)


func _on_SFXSlider_value_changed(value):
    AudioServer.set_bus_volume_db(sfx_index, linear2db(value))
    AudioServer.set_bus_mute(sfx_index, sfx_index < .05)
