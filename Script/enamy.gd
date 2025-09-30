extends Area2D

var hp: int = 100
var corners: Dictionary
var speed: int = 300
var player = null

func _ready() -> void: 
	World = get_tree().current_scene
	if World.player_dide == false:
		player = get_tree().current_scene.get_node("Player")
		path_follow_2d = get_parent()
		_fier(.7)
	
var path_follow_2d: PathFollow2D
var Path_movement : bool = true
func _process(delta: float) -> void:
	if World.player_dide == false:
		if ex != null:
			ex.global_position = global_position
		if Path_movement == true:
			path_movement(delta)
		else :
			random_movement(delta)

var im_destroy: bool = false
var run_one_time: bool = false
func _on_area_entered(area: Area2D) -> void:
	if area.has_meta("bullet"):
		area.queue_free()
		hp -= 15
		modulate = Color.RED
		await get_tree().create_timer(.1).timeout
		modulate = Color("ffffff")
		if hp <= 0 and run_one_time == false:
			on_fier = false
			run_one_time = true
			if player != null:
				player.score += 100
			destroy()
			
func _on_body_entered(body: Node2D) -> void:
		if body.name == "Player":
			if player != null and run_one_time == false:
				body.hp -= 10
				run_one_time = true
				player.score += 100
				destroy()
			
var on_fier: bool = true
var BulletScene = preload("res://Scenes/Bullet_enemy.tscn")
@export var World: Node2D
func _fier(time: float) -> void:
	while on_fier == true:
		await get_tree().create_timer(time).timeout
		var bullet = BulletScene.instantiate()
		bullet.position = global_position + Vector2(0, 50)
		World.add_child(bullet)
var explosion: PackedScene = preload("res://Scenes/Explosion/explosion_type_one.tscn")
var ex
func destroy() -> void:
	ex = explosion.instantiate()
	World.add_child(ex)
	ex.global_position = global_position
	for item in range(ex.get_child_count()):
		var temp: AnimatedSprite2D = ex.get_child(item)
		temp.play("default")
		await get_tree().create_timer(.01).timeout
	await get_tree().create_timer(1).timeout
	ex.queue_free()
	queue_free()

func path_movement(delta: float) -> void:
	path_follow_2d.progress += speed * delta
	if path_follow_2d.progress_ratio >= 1.0 or path_follow_2d.progress_ratio <= 0.0:
		speed = - speed

#--------------------Ranom Movement---------------------------
#unused!
var new_pos = null
var direction = null

func random_movement(delta: float) -> void:
	if new_pos == null:
		new_pos = Vector2(randi_range(0, 480), randi_range(0, 500))
		direction = (new_pos - global_position).normalized()
	var distance = global_position.distance_to(new_pos)
	if distance >= 10:
		global_position += direction * speed * delta
	else:
		new_pos = null
#--------------------Ranom Movement---------------------------
