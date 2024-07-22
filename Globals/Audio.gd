extends Node
class_name Audio

@onready var music:= $Music
@onready var success:= $Success
@onready var failure:= $Failure
@onready var crunches:= [
	$Node/Crunch1,
	$Node/Crunch2,
	$Node/Crunch3,
	$Node/Crunch4,
]

func _ready():
	music.finished.connect(func(): music.play())

func play_music():
	music.play()

func start_song(song: AudioStreamPlayer):
	music.stop()
	song.play()

func play_crunch():
	randomize()
	crunches[randi_range(0, 3)].play()
