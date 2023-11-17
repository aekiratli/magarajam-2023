extends Node


func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Saved")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			continue
		if !node.has_method("save"):
			continue
		
		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		save_game.store_line(json_string)


func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_nodes = get_tree().get_nodes_in_group("Saved")
	for i in save_nodes:
		i.queue_free()

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			continue
		
		var node_data = json.get_data()
		
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
