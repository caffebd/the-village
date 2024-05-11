extends CharacterBody3D

@export var check_points:Array[Marker3D]
@export var player: CharacterBody3D


var target_position: Vector3 #set this to the target coordinate
var speed: float = 2.0

var check_index:int = 0

var walking: = false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var anim_tree = %AnimationTree

var turn_value :float = 0

var can_turn: bool = true

enum {WALK, TURN}

var curr_anim = WALK

var blend_speed :float = 2.0
var blend_speed_two :float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("mixamo_com")
	$AnimationPlayer.pause()
	get_tree().create_timer(4.0).timeout
	_next_position()
	_update_tree()

func _update_tree():
	anim_tree["parameters/BlendTurn/blend_amount"] = turn_value

func _handle_animation(delta):
	match curr_anim:
		
		WALK:
			turn_value = lerp(turn_value, 0.0, blend_speed_two*delta)
			_update_tree()
		TURN:
			turn_value = lerp(turn_value, 1.0, blend_speed*delta)
			_update_tree()

func _physics_process(delta: float) -> void:
	
	_handle_animation(delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if walking:
		var direction = global_position.direction_to(target_position)
		

		if global_position.distance_to(target_position) > 5.0:
			var player_dist: float = global_position.distance_to(player.global_position)
			if player_dist < 7.0:
				if not can_turn:
					$WalkTimer.start()
					
				#print ("walking")
				rotation.y=lerp_angle(rotation.y,atan2(velocity.x,velocity.z),.1)
				speed = lerp(speed, 4.0, 0.5)
				velocity = direction * speed
				curr_anim = WALK
				if not is_on_floor():
					velocity.y -= gravity * delta
				move_and_slide()
			else:
				if can_turn:
					#print ("turn")
					can_turn = false
					curr_anim = TURN
					speed = lerp(speed, 0.0, 1.0)
					velocity = direction * speed
					if not is_on_floor():
						velocity.y -= gravity * delta
					move_and_slide()
					#$AnimationPlayer.play("turn")
		else:
			#$AnimationPlayer.pause()
			#$AnimationPlayer2.play("mixamo_com")
			walking = false
			_next_position()

func _next_position():
	if check_index < check_points.size():
		target_position = check_points[check_index].global_position
		#get_tree().create_timer(0.2).timeout
		walking = true
		curr_anim = WALK
		#$AnimationPlayer.play("mixamo_com")
		print ("new CHEC")
		check_index += 1


func _on_walk_timer_timeout() -> void:
	can_turn = true
