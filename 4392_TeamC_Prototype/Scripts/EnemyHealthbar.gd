extends ProgressBar

# Very basic code to support an enemy healthbar.
# In the godot editor, linked "HealthChanged" signal defined in Enemy.gd

func _on_Enemy_healthChanged(newHealth, maxHealth):
  if(newHealth < maxHealth):
    visible = true
    
  max_value = maxHealth
  value = newHealth
