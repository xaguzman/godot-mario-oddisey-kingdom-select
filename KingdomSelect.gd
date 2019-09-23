extends Spatial

var KINGDOM = preload("res://Pivot.tscn")
var BUTTON = preload("res://KingdomButton.tscn")

export (Array, Resource) var kingdoms

onready var world := $World
onready var camera_pivot := $CameraPivot
onready var camera := $CameraPivot/Camera
onready var camera_tween := camera.get_node("Tween")
onready var button_container := $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer
onready var cursor := $CanvasLayer/Cursor
onready var line_renderer := $LineRenderer

var rotation_offset : Vector3 = Vector3(13.864, 22.739, 0)


func _ready():    
    for k in kingdoms:
        _spawn_kingdom_point(k)
    _add_path_points()
    button_container.queue_sort()
    button_container.get_children()[0].grab_focus()

func _spawn_kingdom_point(k):
    var kingdom = KINGDOM.instance()
    world.add_child(kingdom)
    kingdom.rotation_degrees = Vector3( k.x, k.y, 0)
    k.world_point = kingdom.get_node("Marker").global_transform.origin
    _spawn_kingdom_button(k)

func _spawn_kingdom_button(k):
    var btn = BUTTON.instance()
    button_container.add_child(btn)
    btn.kingdom = k
    btn.connect("kingdom_selected", self, "_look_at_kingdom")
    
func _look_at_kingdom(k):
    cursor.hide()
    var rot = Vector3(k.x, k.y , 0) + rotation_offset
    camera_tween.interpolate_property(camera_pivot, "rotation_degrees", null, rot, 1, Tween.TRANS_CIRC, Tween.EASE_OUT)
    camera_tween.start()
    yield( get_tree().create_timer(1), "timeout")
    cursor.position = camera.unproject_position(k.world_point)
    cursor.show()

func _input(event):
    if Input.is_key_pressed(KEY_CONTROL) and Input.is_key_pressed(KEY_Z):
        _add_path_points()

func _add_path_points():
    var curve = Curve3D.new()
    line_renderer.clear_points()
    for i in range(kingdoms.size() - 1):
#    for i in range(1):
#        curve.clear_points()
        var k1 = kingdoms[i]
        var p1 = k1.world_point
        var k2 = kingdoms[i+1]       
        var p2 = k2.world_point
        
        var mid = Vector3( (p1.x + p2.x)/2, (p1.y + p2.y)/2, (p1.z + p2.z)/2)
        var distance = sqrt( pow(mid.x, 2) + pow(mid.y, 2) + pow(mid.z, 2))
        mid /= distance
        mid *= distance * 0.4
                     
        curve.add_point(p1, Vector3(0,0,0), mid)
#        curve.add_point(mid)
        curve.add_point(p2, mid)    
        
        var points = curve.tessellate()
        line_renderer.add_points(points)