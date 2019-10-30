extends Node

var variable := PoolStringArray()
var value := []

var variable_ref := PoolIntArray()
var objects := [] 
var methods := PoolStringArray()

func register(variable: String, value):
	self.variable.append(variable)
	self.value.append(value)

func set_value(variable: String, value):
	
	for i in self.variable.size():
		
		if self.variable[i] == variable:
			self.value[i] = value
			listener(i)
			return
		

func get_value(variable: String):
	for i in self.variable.size():
		if self.variable[i] == variable:
			return value[i]
	
	return null

func suscribe(variable: String, object: Object, method: String):
	
	var index = find_var_index(variable)
	
	if index != null:
		variable_ref.append(index)
		
		objects.append(object)
		methods.append(method)


func unsuscribe(variable: String, object, method):
	
	var index = find_var_index(variable)
	
	if index !=null:
		
		var var_refs = find_var_ref_indexs(index)
		
		for i in var_refs:
			objects.remove(index)
			methods.remove(index)
	


func listener(index):
	var var_refs = find_var_ref_indexs(index)
	
	for i in var_refs:
		get_fun_ref(i).call_func(value[index])
	




func get_fun_ref(index: int)-> FuncRef:
	var obj = objects[index]
	var mth = methods[index]
	
	return funcref(obj, mth)

func find_var_ref_indexs(variable_index: int) -> Array:
	var refs := []
	
	for index in variable_ref:
		if index == variable_index:
			refs.append(index)
	
	return refs

func find_var_index(variable: String):
	for i in self.variable.size():
		if self.variable[i] == variable:
			return i
	return null
#	return find_index(variable, self.variable)

#func find_index(value, list):
#	for i in list.size():
#		if list[i] == value:
#			return i
#	return null
