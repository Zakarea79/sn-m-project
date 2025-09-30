extends Node2D

@export var path_2d: Array[Path2D]
@export var enmay: int = 1
var player_dide : bool = false
func _ready() -> void:
	if player_dide == false:
		while true:
			if len(path_2d) != 0:
				var temp : PackedScene = load("res://Scenes/enamy folder/enemay-" + str(randi_range(0, enmay - 1)) + ".tscn")
				var en = temp.instantiate()
				var temp_path_2d = path_2d[randi_range(0, len(path_2d) - 1)]
				en.position = temp_path_2d.position + Vector2(0, -50)
				temp_path_2d.add_child(en)
			await get_tree().create_timer(2).timeout
