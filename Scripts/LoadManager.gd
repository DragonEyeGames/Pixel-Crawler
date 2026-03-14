extends Node

@onready var loading_scene = preload("res://load.tscn")

# Main async loader function
func load_scene(current_scene: Node, next_scene: String) -> void:
	# Add loading scene to the root
	var loading_scene_instance = loading_scene.instantiate()
	get_tree().get_root().call_deferred("add_child", loading_scene_instance)
	
	# Start threaded loading
	ResourceLoader.load_threaded_request(next_scene)
	
	# Free current scene
	current_scene.queue_free()
	
	# Small delay to let the loading screen appear
	await get_tree().create_timer(0.5).timeout
	
	# Poll until the scene is loaded
	while true:
		var status = ResourceLoader.load_threaded_get_status(next_scene)
		
		if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Update progress bar (Godot 4 does not give exact stage count, so approximate)
			# We'll use 'progress' returned by get_status as 0..1
			await get_tree().process_frame  # yield to next frame
			
		elif status == ResourceLoader.THREAD_LOAD_LOADED:
			# Finished loading, get the scene
			var scene_resource = ResourceLoader.load_threaded_get(next_scene)
			if scene_resource:
				var scene_instance = scene_resource.instantiate()
				get_tree().get_root().call_deferred("add_child", scene_instance)
			else:
				push_error("Failed to instantiate scene: %s" % next_scene)
			
			# Remove loading screen
			loading_scene_instance.queue_free()
			return
			
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Error occurred while loading scene: %s" % next_scene)
			loading_scene_instance.queue_free()
			return
