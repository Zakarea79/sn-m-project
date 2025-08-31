extends Area2D

var speed: int = 400

@export var is_player = true
func _ready():
	await get_tree().create_timer(3).timeout
	queue_free()

func _physics_process(delta):
	if is_player == true:
		position.y -= (delta * speed)
	else:
		position.y += (delta * speed)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hp -= 2
		queue_free()
