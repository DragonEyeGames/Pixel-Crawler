extends Node

# Main async loader function
func load_scene(current_scene: Node, next_scene: String) -> void:
	
	# Start threaded loading
	ResourceLoader.load_threaded_request(next_scene)
	
	# Free current scene (optional delay so loading screen shows)
	await get_tree().create_timer(0.2).timeout
	current_scene.queue_free()
	
	# Poll until the scene is loaded
	while true:
		var status = ResourceLoader.load_threaded_get_status(next_scene)
		
		if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Optionally update progress bar here
			# Example: loading_scene_instance.get_node("ProgressBar").value = approximate_value
			await get_tree().process_frame  # yield to next frame
			
		elif status == ResourceLoader.THREAD_LOAD_LOADED:
			# Scene is fully loaded; now switch properly
			get_tree().change_scene_to_file(next_scene)
			return
			
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Error occurred while loading scene: %s" % next_scene)
			return
