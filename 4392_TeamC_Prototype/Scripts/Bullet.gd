extends Area2D

# Script to handle behaviors of a default bullet.

# TODO: pass damage value in from weapon during InitBullet()
# TODO: pass damage value to HitByProjectile() so that object can react as needed.


var direction
var initPosition
var bulletSpeed 
var bulletRange

onready var NC = get_node("/root/RootNode/NoiseController")

# Params: target(Vector2), position(Vector2), speed(int), range(int)
func InitBullet(t, p, s, r):
	direction = (t - p).normalized()
	global_position = p
	bulletSpeed = s
	bulletRange = r
	initPosition = global_position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * delta * bulletSpeed
	
	if position.distance_to(initPosition) > bulletRange:
		queue_free()
	
	pass

# When this collides with another object, call the HitByProjectile() method if it has one. 
# Otherwise, make a noise.
# Afterwards, delete this node.
func _on_Bullet_body_entered(body):
	if body.has_method("HitByProjectile"):
		body.HitByProjectile()
		
	else: 
		NC.CreateNoise(global_position, 100)
		
	queue_free()
