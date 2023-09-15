extends ProgressBar


func _on_Enemy_healthChanged(newHealth, maxHealth):
	max_value = maxHealth
	value = newHealth
