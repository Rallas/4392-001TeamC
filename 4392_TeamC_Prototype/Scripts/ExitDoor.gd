extends Node

onready var Player = get_node("/root/RootNode/Player")
onready var overlay = get_node("/root/RootNode/UI/DarknessOverlay/FadePlayer")

# Object set to not be instant, so this will be called repeatedly while interacting.
func Interact():
  if PlayerInventory.carryingKey:
    # Save global values for next level.
    Global.PlayerHealthAtLevelStart = Player.currentHealth
    
    # Lose key when going into next level
    PlayerInventory.carryingKey = false
    
    Global.PlayerInvincible = true
    get_tree().paused = true
    
    # Clear all enemies before level end
    for enemy in get_tree().get_nodes_in_group("Enemy"):
      enemy.queue_free()
    
    # Animate fade out on level transition:
    overlay.play("fade")
    yield(overlay, "animation_finished")
    
    get_tree().paused = false
    Global.PlayerInvincible = false
    
    
    # Reload scene
    # Once level generation done, this will generate a new (harder) level.
    Global.CurrentLevel += 1
    var _ret = get_tree().change_scene(Global.GetSceneForCurrentLevel())
    

