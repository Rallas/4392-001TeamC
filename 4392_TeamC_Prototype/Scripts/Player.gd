extends KinematicBody2D

# This script handles player movement
# It is attached to the root node of the player

# TODO: Add code logic to make the player move slower while 'backpedaling'
# TODO: Setup player health, enemy damage, etc...
#warning-ignore:RETURN_VALUE_DISCARDED

onready var NC = get_node("/root/RootNode/NoiseController")
onready var UIController = get_node("/root/RootNode/UI")
onready var footstep = $Footsteps

var totalHealth #Left here for compatibility
var enemyDamage = 20

var moveSpeed = 200
var speedModifier = 1
var velocity = Vector2.ZERO
var inertia = 100
var movementDirection = Vector2.ZERO
var facingDirection = Vector2.ZERO
var isBackpedaling = 0
var backpedalingModifier = 0.6
var moveAndSlideVel

var noiseIntensity = 100

var lastFootstepTime = 0
var timeBetweenFootsteps = 350
var baseFootstepIntensity = 0.75 # Multiplier for larger number

var lastHeartbeatTime = 0
var timeBetweenheartbeats = 400
var baseHeartbeatIntensity = 40 # Pixel radius


var currentHealth

func _ready():
  currentHealth = Global.PlayerHealthAtLevelStart;
  totalHealth = Global.PlayerMaxHealth
  UIController.UpdateHealth(currentHealth, totalHealth)
  pass # Replace with function body.



func _physics_process(_delta):
  velocity = Vector2.ZERO
  
  #refactored to position instead of velocity
  if Input.is_action_pressed("move_down"):
    velocity.y += 1
  if Input.is_action_pressed("move_up"):
    velocity.y -= 1
  if Input.is_action_pressed("move_right"):
    velocity.x += 1
  if Input.is_action_pressed("move_left"):
    velocity.x -= 1

  # Matthew: Commenting out for now.
  # I added a different way of doing sounds in the NoiseController.gd script
  
  #if Input.is_action_just_pressed("move_down"):
  #  footstep.play()
  #if Input.is_action_just_pressed("move_up"):
  #  footstep.play()
  #if Input.is_action_just_pressed("move_left"):
  #  footstep.play()
  #if Input.is_action_just_pressed("move_right"):
  #  footstep.play()
    
  #if Input.is_action_just_released("move_down"):
  #  footstep.stop()
  #if Input.is_action_just_released("move_up"):
  #  footstep.stop()
  #if Input.is_action_just_released("move_left"):
  #  footstep.stop()
  #if Input.is_action_just_released("move_right"):
  #  footstep.stop()
    
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
  
  # Every set time interval, make a footstep noise if moving.
  if velocity != Vector2.ZERO and OS.get_ticks_msec() - lastFootstepTime > timeBetweenFootsteps:
    lastFootstepTime = OS.get_ticks_msec()
    NC.CreateNoise(global_position, baseFootstepIntensity*moveSpeed*speedModifier, "footstep")
  
  moveAndSlideVel = move_and_slide(velocity*moveSpeed*speedModifier, Vector2(0,0), false, 4, PI/4, false)

  # Every set time interval, make a 'heartbeat' noise
  # This prevents a motionless player from being invincible.
  if OS.get_ticks_msec() - lastHeartbeatTime > timeBetweenheartbeats:
    lastHeartbeatTime = OS.get_ticks_msec()
    NC.CreateNoise(global_position, baseHeartbeatIntensity)
  

  for i in get_slide_count():
    var collision = get_slide_collision(i)
    if collision.collider.is_in_group("movableObject"):
        if velocity != Vector2.ZERO:
            if moveAndSlideVel != Vector2.ZERO:
                NC.CreateNoise(collision.collider.global_position, collision.collider.weight*30)
        collision.collider.apply_central_impulse(-collision.normal*inertia*speedModifier)

var lastHitTime = 0
var timeBetweenHits = 500

func HitByEnemy():
  if OS.get_ticks_msec() - lastHitTime > timeBetweenHits:
    lastHitTime = OS.get_ticks_msec()
    if (currentHealth - enemyDamage > 0):
      NC.CreateNoise(global_position, noiseIntensity)
      currentHealth -= enemyDamage
      UIController.UpdateHealth(currentHealth, totalHealth)
    else:
      # TODO: Connect to player death screen
      UIController.UpdateHealth(0, totalHealth)
      UIController.GameOver()
      
      # Delete all current bullets
      for node in get_tree().get_nodes_in_group("Bullet"):
        node.queue_free()
        
      # Pause game and wait for a second
      get_tree().paused = true
      yield(get_tree().create_timer(2.5), "timeout")
      
      # After time resumes, go back to main menu
      var _opt = get_tree().change_scene("res://Scenes/StartMenu.tscn")
      
      
      get_tree().paused = false
      
    
    
