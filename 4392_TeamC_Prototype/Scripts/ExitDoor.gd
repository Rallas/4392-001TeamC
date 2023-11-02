extends Node

# Object set to not be instant, so this will be called repeatedly while interacting.
func Interact():
  if PlayerInventory.carryingKey:
    Global.CurrentLevel += 1
    var _ret = get_tree().reload_current_scene()

