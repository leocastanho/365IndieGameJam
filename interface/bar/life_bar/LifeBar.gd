extends HBoxContainer

var maximun_value = 20
var current_health

func initialize(maximum):
	maximun_value = maximum
	current_health = maximum
	$BarsContainers/Container/TextureProgress.max_value = maximum

func _on_Interface_health_changed(health):
	animate_value(current_health, health)
	current_health = health

func animate_value(start, end):
	$BarsContainers/Tween.interpolate_property($BarsContainers/Container/TextureProgress, "value", start, end, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$BarsContainers/Tween.start()