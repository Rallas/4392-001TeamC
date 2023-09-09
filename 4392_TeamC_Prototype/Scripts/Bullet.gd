extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2.ZERO
var initPosition = Vector2.ZERO

var bulletSpeed = 0
var bulletRange = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func InitBullet():
	initPosition = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * delta * bulletSpeed
	
	if position.distance_to(initPosition) > bulletRange:
		queue_free()
	
	pass

func _on_Bullet_body_entered(body):
	if body.has_method("HitByProjectile"):
		body.HitByProjectile()
	queue_free()
