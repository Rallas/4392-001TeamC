extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal healthChanged(newHealth, maxHealth)

export var maxHealth = 4
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	emit_signal("healthChanged", health, maxHealth)
	pass # Replace with function body.


func HitByProjectile():
	health -= 1; #TODO: pass bullet damage via param
	emit_signal("healthChanged", health, maxHealth)
	if health == 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
