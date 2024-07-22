extends Area2D
#class_name ReceiveRadius

signal send_toggle(toggle: bool)

func toggle_reception(toggle: bool): 
	send_toggle.emit(toggle)


