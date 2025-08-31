extends Area2D

var hp: int = 100
var corners: Dictionary
var speed: int = 300
var player = null
func _ready() -> void:
	World = get_tree().current_scene
	player = get_tree().current_scene.get_node("Player")
	path_follow_2d = get_parent()
	_fier(.7)
	
var path_follow_2d: PathFollow2D
func _process(delta : float) -> void:
	movement_path(delta)

func _on_area_entered(area: Area2D) -> void:
	if area.has_meta("bullet"):
		area.queue_free()
		hp -= 15
		modulate = Color.RED
		await get_tree().create_timer(.1).timeout
		modulate = Color("ffffff")
		if hp <= 0:
			player.score += 100
			queue_free()
			


func _on_body_entered(body:Node2D) -> void:
		if body.name =="Player":
			body.hp -= 10
			modulate = Color.RED
			await get_tree().create_timer(.1).timeout
			if player != null:
				player.score += 100
			queue_free()
			

var BulletScene = preload("res://Scenes/Bullet_enemy.tscn")
@export var World: Node2D
func _fier(time: float) -> void:
	while true:
		await get_tree().create_timer(time).timeout
		var bullet = BulletScene.instantiate()
		bullet.position = global_position + Vector2(0, 50)
		World.add_child(bullet)


func movement_path(delta: float) -> void:
	path_follow_2d.progress += speed * delta
	if path_follow_2d.progress_ratio >= 1.0 or path_follow_2d.progress_ratio <= 0.0:
		speed = - speed

#--------------------Ranom Movement---------------------------
#unused!
var new_pos = null
var direction = null

func movement(delta: float) -> void:
	if new_pos == null:
		new_pos = Vector2(randi_range(0, 480), randi_range(0, 500))
		direction = (new_pos - global_position).normalized()
	var distance = global_position.distance_to(new_pos)
	if distance >= 10:
		global_position += direction * speed * delta
	else:
		new_pos = null
#--------------------Ranom Movement---------------------------
