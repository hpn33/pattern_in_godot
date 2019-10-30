extends Control

onready var t1 = $TextEdit
onready var t2 = $TextEdit2
onready var t3 = $TextEdit3


func _ready() -> void:
	
	obs.register('input', t1.text)
	obs.register('input2', t1.text)
	obs.register('input3', t1.text)
	
	obs.suscribe('input', self, 'set_input_to_output')
	obs.unsuscribe('input', self, 'set_input_to_output')
	

func set_input_to_output(value):
	
	t2.text = value
	t3.text = value


func _on_TextEdit_text_changed() -> void:
	obs.set_value('input', t1.text)
