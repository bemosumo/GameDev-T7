extends Area3D

@export var sceneName: String = "WinScreen"
@export var is_win_zone: bool = true 
@export var coins_needed: int = 3

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		
		if is_win_zone == true:
			if body.coins >= coins_needed:
				print("Menang! Pindah ke Win Screen...")
				get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
			else:
				var sisa_koin = coins_needed - body.coins
				print("Koin belum cukup! Cari ", sisa_koin, " koin lagi.")
				
		else:
			print("Jatuh ke jurang! Reset level...")
			get_tree().change_scene_to_file("res://scenes/Level1.tscn")
