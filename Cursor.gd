extends Node2D

onready var cursor_tween := $Tween
onready var donut1 := $Donut1
onready var donut2 := $Donut2

func _ready():
    var big = Vector2(0.25, 0.25)
    var small = big / 4
    var circ = Tween.TRANS_CIRC
    var linear = Tween.TRANS_LINEAR
    var easing = Tween.EASE_OUT
    var duration = 1.0
    var transparent = Color(1,1,1,0)
    
    cursor_tween.interpolate_property(donut1, "scale", small, big, duration, circ, easing)
    cursor_tween.interpolate_property(donut1, "self_modulate", null, Color.white, duration / 3, linear, easing)
    cursor_tween.interpolate_property(donut1, "self_modulate", null, transparent, duration / 4, linear, easing, duration / 1.5)
    
    cursor_tween.interpolate_property(donut2, "scale", small, big, duration, circ, easing, 0.5)
    cursor_tween.interpolate_property(donut2, "self_modulate", null, Color.white, duration / 3, linear, easing, 0.5)
    cursor_tween.interpolate_property(donut2, "self_modulate", null, transparent, duration / 4, linear, easing, 0.5 + (duration / 1.5))
    cursor_tween.repeat = true
    cursor_tween.start()
    