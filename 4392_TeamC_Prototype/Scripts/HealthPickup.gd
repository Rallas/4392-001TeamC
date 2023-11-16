extends Node

export var pickupHealth = 50
onready var UIController = get_node("/root/RootNode/UI")

func _on_Area2D_body_entered(body):
  if body.is_in_group("Player"):
    # Do not pick up if full health
    if body.currentHealth < body.totalHealth:
      
      # Add health up to max
      body.currentHealth += pickupHealth
      if body.currentHealth >= body.totalHealth:
        body.currentHealth  = body.totalHealth
      
      UIController.UpdateHealth(body.currentHealth, body.totalHealth)
      
      queue_free()
