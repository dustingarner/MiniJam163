extends Node2D
class_name TeleporterControl


@onready var tel1:= $Teleporter1
@onready var tel2:= $Teleporter2
@onready var tel1_pos:= $Teleporter1/Marker2D
@onready var tel2_pos:= $Teleporter2/Marker2D

func _ready():
	tel1.area_entered.connect(send_to_other.bind(tel1, tel2))
	tel2.area_entered.connect(send_to_other.bind(tel2, tel1))

func send_to_other(area: TeleportIndicator, start_teleporter: Teleporter, \
		end_teleporter: Teleporter):
	area.teleport(end_teleporter.location)


