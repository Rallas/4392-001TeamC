extends Node2D



# Num hits to destroy
export var currentHealth = 4


func HitByEnemy():
  currentHealth -= 1
  if currentHealth <= 0:
    get_parent().queue_free()
