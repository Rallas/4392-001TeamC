extends KinematicBody2D

# This script handles player movement
# It is attached to the root node of the player

# TODO: Add code logic to make the player move slower while 'backpedaling'
# TODO: Setup player health, enemy damage, etc...
#warning-ignore:RETURN_VALUE_DISCARDED
signal updateHealth(currentHealth, totalHealth)

onready var NC = get_node("/root/RootNode/NoiseController")

export var totalHealth = 100;
export var enemyDamage = 20;

export var moveSpeed = 200
var speedModifier = 1
var velocity = Vector2.ZERO
var inertia = 100
var movementDirection = Vector2.ZERO
var facingDirection = Vector2.ZERO
var isBackpedaling = 0;
var backpedalingModifier = 0.6;

var lastFootstepTime = 0
var timeBetweenFootsteps = 350
var baseFootstepIntensity = 0.75

var currentHealth;

func _ready():
  currentHealth = totalHealth;
  emit_signal("updateHealth", currentHealth, totalHealth)
  pass # Replace with function body.

func _physics_process(_delta):
  velocity = Vector2.ZERO
  
  if Input.is_action_pressed("move_down"):
    velocity.y += 1
  if Input.is_action_pressed("move_up"):
    velocity.y -= 1
  if Input.is_action_pressed("move_right"):
    velocity.x += 1
  if Input.is_action_pressed("move_left"):
    velocity.x -= 1
  
  # Calculate facing direction
  facingDirection = (get_global_mouse_position() - global_position).normalized()
  # Calculate the player's movement direction
  movementDirection = Vector2(int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")), int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))).normalized()
  # Determining if player is backpedaling
  isBackpedaling = movementDirection.dot(facingDirection) < -0.7
  #print(movementDirection.dot(facingDirection))
  
  if Input.is_action_pressed("sneak") or Input.is_action_pressed("aim"):
    speedModifier = 0.5
    if isBackpedaling:
      speedModifier *= backpedalingModifier
  elif Input.is_action_pressed("sprint"):
    speedModifier = 2
    if isBackpedaling:
      speedModifier *= backpedalingModifier 
  else:
    speedModifier = 1
    if isBackpedaling:
      speedModifier *= backpedalingModifier 
  
  if velocity != Vector2.ZERO and OS.get_ticks_msec() - lastFootstepTime > timeBetweenFootsteps:
    lastFootstepTime = OS.get_ticks_msec()
    NC.CreateNoise(global_position, baseFootstepIntensity*moveSpeed*speedModifier)
  
  move_and_slide(velocity*moveSpeed*speedModifier, Vector2(0,0), false, 4, PI/4, false)

  for i in get_slide_count():
    var collision = get_slide_collision(i)
    if collision.collider.is_in_group("movableObject"):
        NC.CreateNoise(collision.collider.global_position, collision.collider.weight*20)
        collision.collider.apply_central_impulse(-collision.normal*inertia*speedModifier)

var lastHitTime = 0
var timeBetweenHits = 500

func HitByEnemy():
  if OS.get_ticks_msec() - lastHitTime > timeBetweenHits:
    lastHitTime = OS.get_ticks_msec()
    if (currentHealth - enemyDamage > 0):
      currentHealth -= enemyDamage
      print("(t=%d) | OUCH!!!" % OS.get_ticks_msec())
      emit_signal("updateHealth", currentHealth, totalHealth)
    else:
      # TODO: Connect to player death screen
      emit_signal("updateHealth", 0, totalHealth)
      print("(t=%d) | Player is Dead" % OS.get_ticks_msec())
    
    
