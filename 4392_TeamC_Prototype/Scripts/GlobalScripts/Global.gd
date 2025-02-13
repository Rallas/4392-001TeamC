extends Node

var AlreadySeenControlPopup = false
var ShowNoiseCircles = false

# Singleton script to hold some global variables
var CurrentLevel = 1

var PlayerMaxHealth = 100
var PlayerHealthAtLevelStart = 100
var StartMenuAnimation = preload("res://Sprites/StartMenuAnimation.tres")

var PlayerInvincible = false;

var FullScreen = false;

# Player inventory in another global script, so it already persists between levels.


func GetSceneForLevel(level):
  match level:
    1:
      return "res://Scenes/Levels/Tutorial1.tscn"
    2:
      return "res://Scenes/Levels/Tutorial2.tscn"
    3:
      return "res://Scenes/Levels/LevelA.tscn"
    4:
      return "res://Scenes/Levels/levelD.tscn"
    _:
      return "res://Scenes/Levels/DefaultScene.tscn"


func GetSceneForCurrentLevel():
  return GetSceneForLevel(CurrentLevel)

func ToggleSoundDebug():
    if ShowNoiseCircles:
        ShowNoiseCircles = false
    else:
        ShowNoiseCircles = true


func Initialize():
  PlayerHealthAtLevelStart = 100
