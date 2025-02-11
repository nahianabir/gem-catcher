extends Node2D

@export var gem_scene: PackedScene

const EXPLODE = preload("res://assets/explode.wav")

@onready var label: Label = $Label

@onready var timer: Timer = $Timer

@onready var label_2: Label = $Label2

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer





var _score: int=0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_gem() -> void:
	var new_gem= gem_scene.instantiate()
	var xpos: float = randf_range(70,1050)
	new_gem.on_gem_offscreen.connect(game_over)
	new_gem.position = Vector2(xpos,-50) 
	add_child(new_gem)
	

func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func play_dead()-> void:
	audio_stream_player.stop() 
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play() 

func game_over() -> void:
	stop_all()
	play_dead()
	label_2.text = "Game Over Bitch!"
	label_2.show()  # Ensure the label is visible
	


func _on_timer_timeout() -> void:
	spawn_gem() # Replace with function body.


func _on_paddle_area_entered(area: Area2D) -> void:
	_score +=1 
	label.text = "Score- %d" % _score
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	area.queue_free()
