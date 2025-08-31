extends CharacterBody2D

var destance_touch: int = 10
var touch_pos = null
@export var HP_TXT: Label
var HP: int = 100
var hp: int:
	set(value):
		HP = value
		if HP < 0: HP = 0
		HP_TXT.text = "HP = " + str(HP)
		modulate = Color.RED
		if HP == 0: queue_free() # play some animtion
		await get_tree().create_timer(.1).timeout
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

var space_from_finger = 100

var player_sprite: AnimatedSprite2D

func _ready() -> void:
	player_sprite = get_node("player_sprite")

enum _move_action {
	left, right, center, non
}
enum _secend_frame {
	yes, no , non
}

@export var speed: float = 300
var drag_whit_touch: bool = false
func _input(event) -> void:
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		touch_pos = event.position + Vector2(0, -space_from_finger)
		if global_position.distance_to(touch_pos) < destance_touch:
			drag_whit_touch = true
		if drag_whit_touch == true:
			position = event.position + Vector2(0, -space_from_finger)
			touch_pos = null
	if event is InputEventScreenTouch and !event.pressed:
		drag_whit_touch = false
		touch_pos = null
	

func _process(delta: float) -> void:
	if touch_pos != null and global_position.distance_to(touch_pos) > destance_touch and drag_whit_touch == false:
		var direction = (touch_pos - global_position).normalized()
		var distance = global_position.distance_to(touch_pos)
		if distance > 1:
			global_position += direction * speed * delta
		else:
			global_position = touch_pos
