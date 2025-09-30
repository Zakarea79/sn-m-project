extends Control

@export var setting : TextureRect
@export var main_menue : VBoxContainer

func _on_btnstart_button_up() -> void:
	get_tree().change_scene_to_file("res://game-scene/main.tscn")


func _on_btnoption_button_up() -> void:
	if setting.visible == false:
		setting.visible = true
		main_menue.visible = false
	else :
		setting.visible = false
		main_menue.visible = true


func _on_btnexit_button_up() -> void:
	get_tree().quit()

func _on_btnsound_button_up() -> void:
	print("SOUND")


func _on_btnmusic_button_up() -> void:
	print("MUSIC")


func _on_btnstave_button_up() -> void:
	if setting.visible == true:
		setting.visible = false
		main_menue.visible = true
	else :
		setting.visible = true
		main_menue.visible = false
