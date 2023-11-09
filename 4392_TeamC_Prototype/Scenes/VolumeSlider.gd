extends Control

onready var bus_index = AudioServer.get_bus_index("Master")
onready var music = $Music

# Called when the node enters the scene tree for the first time.  
func ready():
  music.play()

func _on_MusicSlider_value_changed(value):
    AudioServer.set_bus_volume_db(bus_index, linear2db(value))
    AudioServer.set_bus_mute(bus_index, value < .05)
