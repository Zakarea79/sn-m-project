extends Timer

var BulletScene = preload("res://Scenes/Bullet.tscn")
@export var player: Node2D
@export var World: Node2D

func _on_timeout() -> void:
	if player != null:
		var bullet = BulletScene.instantiate()
		bullet.position = player.position + Vector2(0, -50)
		World.add_child(bullet)
	else :
		queue_free()
