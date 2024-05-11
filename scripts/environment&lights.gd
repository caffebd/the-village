extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.day_to_night.connect(_day_to_night)
	GlobalSignals.night_to_day.connect(_night_to_day)



func _night_to_day():
	var tween = create_tween().parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("1c4a53"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("aa6a4c"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("aa6a4c"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_albedo", Color("ffffff"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_emission", Color("77604a"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.0265, 2.0)
	tween.tween_property($sun, "light_energy", 0.17, 2.0)
	tween.tween_property($moon, "light_energy", 0.089, 2.0)

func _day_to_night():
	var tween = create_tween().parallel()
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_top_color", Color("327085"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:sky_horizon_color", Color("000000"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:sky:sky_material:ground_horizon_color", Color("000000"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_albedo", Color("3c3c3c"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_emission", Color("0f2722"), 2.0)
	tween.tween_property($WorldEnvironment, "environment:volumetric_fog_density", 0.05, 2.0)
	tween.tween_property($sun, "light_energy", 0.0, 2.0)
	tween.tween_property($moon, "light_energy", 0.08, 2.0)
