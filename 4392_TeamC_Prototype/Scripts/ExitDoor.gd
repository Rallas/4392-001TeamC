extends Node

onready var Player = get_node("/root/RootNode/Player")

# Object set to not be instant, so this will be called repeatedly while interacting.
func Interact():
  if PlayerInventory.carryingKey:
    # Save global values for next level.
    Global.PlayerHealthAtLevelStart = Player.currentHealth
    
    # Reload scene
    # Once level generation done, this will generate a new (harder) level.
    Global.CurrentLevel += 1
    var _ret = get_tree().change_scene(Global.GetSceneForCurrentLevel())

