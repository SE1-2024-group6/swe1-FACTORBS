extends Node

# Save/Load Functionality
func save_high_score():
	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	var save_data: Dictionary = {"high_score": Global.high_score}
	var jstr1 = JSON.stringify(save_data)
	file.store_line(jstr1)
	
func load_high_score():
	if FileAccess.file_exists("user://save_game.json"):
		var file = FileAccess.open("user://save_game.json", FileAccess.READ)
		if FileAccess.file_exists("user://save_game.json") == true:
			if not file.eof_reached():
				var current_line = JSON.parse_string(file.get_line())
				if current_line:
					Global.high_score = current_line["high_score"]

func save_settings():
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	var settings_data: Dictionary = {
		"sfx_volume": Global.sfx_volume,
		"music_volume": Global.music_volume,
		"master_volume": Global.master_volume
	}
	var jstr2 = JSON.stringify(settings_data)
	file.store_line(jstr2)
	
func load_settings():
	if FileAccess.file_exists("user://settings.json"):
		var file = FileAccess.open("user://settings.json", FileAccess.READ)
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Global.sfx_volume = current_line["sfx_volume"]
				Global.music_volume = current_line["music_volume"]
				Global.master_volume = current_line["master_volume"]
