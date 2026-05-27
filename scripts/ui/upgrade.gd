class_name Upgrade
extends TextureButton

var enabled : bool = false:
	set(value):
		enabled = value
		$Panel.show_behind_parent = value
