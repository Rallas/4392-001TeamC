extends Node2D


var masterValue = 0.5
var sfxValue = 0.5
var musicValue = 0.5

# Getter and setter for the slider value
func set_master_value(value):
    masterValue = value

func get_master_value():
    return masterValue
    
func set_sfx_value(value):
    sfxValue = value

func get_sfx_value():
    return sfxValue
    
func set_music_value(value):
    musicValue = value

func get_music_value():
    return musicValue
