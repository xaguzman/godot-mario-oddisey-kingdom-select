extends VBoxContainer

signal kingdom_selected(kingdom)

onready var button : Button = $MarginContainer/Button
onready var color_rect := $ColorRect

var kingdom : Resource setget set_kingdom

func grab_focus():
    button.grab_focus()

func set_kingdom(value):
    kingdom = value
    if button:
        button.text = kingdom.name

func get_kingdom_name()->String:
    return kingdom.name

func _on_Button_focus_entered():
    emit_signal("kingdom_selected", kingdom)
    color_rect.color = Color.red

func _on_Button_focus_exited():
    color_rect.color = Color.white
