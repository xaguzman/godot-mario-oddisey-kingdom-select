tool
extends Button

func _ready():
    grab_focus()

func _process(delta):
    set_rotation(deg2rad(305))
    
func _on_Button_focus_entered():
    set("custom_colors/font_color", Color.black)

func _on_Button_focus_exited():
    set("custom_colors/font_color", Color.white)
