extends Area3D

@export var day_to_night: bool = true
@export var night_to_day: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if  day_to_night == false and night_to_day == false:
		day_to_night = true
		night_to_day = false
	elif day_to_night == true and night_to_day == true:
		day_to_night = true
		night_to_day = false
	




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if day_to_night:
			GlobalSignals.emit_signal("day_to_night")
		elif night_to_day:
			GlobalSignals.emit_signal("night_to_day")
