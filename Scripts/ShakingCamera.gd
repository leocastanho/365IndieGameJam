tool
extends Camera2D

export(float) var amplitude = 6.0
export(float) var duration = 0.8 setget set_duration
export(float, EASE) var DAMP_EASING = 1.0
export(bool) var shake = false setget set_shake

onready var timer = $Timer

enum STATES {IDLE, SHAKING}
var state = IDLE

func _ready():
	self.duration = duration
	set_process(false)
	randomize()

	#call this function to set a different duration
func set_duration(value):
	duration = value
	if not timer:
		return
	timer.wait_time = duration
	#call this function to start the shake, if you don't set a duration using the function above, it will use the default duration
func set_shake(value):
	shake = value
	if shake:
		_change_state(SHAKING)
	else:
		_change_state(IDLE)

func _change_state(new_state):
	match new_state:
		IDLE:
			offset = Vector2()
			set_process(false)
		SHAKING:
			set_process(true)
			timer.start()
	state = new_state

func _process(delta):
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	offset = Vector2(
		rand_range(amplitude, -amplitude) * damping,
		rand_range(amplitude, -amplitude) * damping)

func _on_ShakeTimer_timeout():
	self.shake = false
