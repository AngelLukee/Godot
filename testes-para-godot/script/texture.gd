extends Button



func _on_pressed() -> void:
	RenderingServer.canvas_texture_set_texture_filter(RenderingServer, RenderingServer.CANVAS_ITEM_TEXTURE_FILTER_DEFAULT)
