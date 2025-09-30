extends CharacterBody2D

@export var HP_TXT: Label
var HP: int = 100
var hp: int:
	set(value):
		HP = value
		if HP < 0: HP = 0
		HP_TXT.text = "HP = " + str(HP)
		modulate = Color.RED
		if HP == 0:
			get_tree().current_scene.player_dide = true
			# queue_free() # play some animtion
			
		await get_tree().create_timer(.1).timeout
		if get_tree().current_scene.player_dide == true:
			get_tree().change_scene_to_file("res://game-scene/main_menue.tscn")
		modulate = Color("ffffff")
	get:
		return HP

@export var SCORE_TXT: Label
var SCORE: int
var score: int:
	set(value):
		SCORE = value
		SCORE_TXT.text = "SCORE : " + str(SCORE)
	get:
		return SCORE

var player_sprite: AnimatedSprite2D

func _ready() -> void:
	player_sprite = get_node("player_sprite")
	pos_move_action = get_tree().current_scene.get_node("move_action")
	
enum _move_action
{
	left, right, non
}

func move_ment(pos: Vector2, touch: bool) -> void:
	play_animtion()
	if touch == true:
		global_position = pos
	else:
		global_position += pos * speed

var before_distance = null
var current_distance = null


var first_time_get_directiton = true
func move_action() -> _move_action:
	if touch_pos == null:
		return _move_action.non
	current_distance = int(global_position.distance_to(pos_move_action.position))
	
	if first_time_get_directiton == true:
		first_time_get_directiton = false
		before_distance = current_distance
		return move_action()

	if current_distance > before_distance:
		before_distance = int(current_distance)
		return _move_action.right
	elif current_distance < before_distance:
		before_distance = int(current_distance)
		return _move_action.left
	else:
		return _move_action.non
		

var before_direction = null

func play_animtion() -> void:
	var current_direction: _move_action = move_action()
	if before_direction == null:
		before_direction = current_direction
		return
	if current_direction == _move_action.left and before_direction != current_direction:
		before_direction = current_direction
		player_sprite.flip_h = false
		player_sprite.play("rotate_animation")
	elif current_direction == _move_action.right and before_direction != current_direction:
		before_direction = current_direction
		player_sprite.flip_h = true
		player_sprite.play("rotate_animation")


@export var speed: float = 300
var drag_whit_touch: bool = false
var destance_touch: int = 10
var touch_pos = null
var space_from_finger = 100
var finger_on_scrine: bool = false

func _input(event) -> void:
	if event is InputEventScreenTouch and !event.pressed:
		drag_whit_touch = false
		finger_on_scrine = false
		touch_pos = null
		return

	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		touch_pos = event.position + Vector2(0, -space_from_finger)
		finger_on_scrine = true
		if global_position.distance_to(touch_pos) < destance_touch:
			drag_whit_touch = true
		if drag_whit_touch == true:
			move_ment(event.position + Vector2(0, -space_from_finger), true)
			touch_pos = null
	
var pos_move_action: Node2D

func _process(delta: float) -> void:
	if finger_on_scrine == false and player_sprite.animation != "Idel":
		player_sprite.play("Idel")
	# if finger_on_scrine == true and move_action() == _move_action.non:
	# 	print("dont move")
	# play_animtion();

	pos_move_action.position = Vector2(0, position.y)

	if touch_pos != null and global_position.distance_to(touch_pos) > destance_touch and drag_whit_touch == false:
		var direction = (touch_pos - global_position).normalized()
		var distance = global_position.distance_to(touch_pos)
		if distance > 1:
			move_ment(direction * delta, false)
