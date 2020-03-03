extends Node

var item = {
	name = '',
	age = 0,
	children = []
}

class Iterator:
	
	var position := 0
	var items := []
	
	func _init(items) -> void:
		add_item(items)
		position = 0
	
	func add_item(items) -> void:
		for item in items.children:
			items.append(item)
			add_item(item)
	
	func current():
		return items[position]
	
	func has_next() -> bool:
		return position < items.size()
	
	func next() -> void:
		position += 1
	
	func get_next():
		next()
		return current()
	
#	func key() -> int:
#		return position
	
	func valid() -> bool:
		return items[position] != null
	
	func rewind() -> void:
		position = 0
	
	func size() -> int:
		return items.size()



func _ready() -> void:
	print('\n', name)
	var john = item.duplicate()
	john.name = 'john'
	john.age = 10
	var tom = item.duplicate()
	tom.name = 'tom'
	tom.age = 10
	var johny = item.duplicate()
	johny.name = 'johny'
	johny.age = 10
	var ceo = item.duplicate()
	ceo.name = 'ceo'
	ceo.age = 10
	
	
	john.children.append(tom)
	john.children.append(johny)
	ceo.children.append(john)
	
	show_items(ceo)
	
	var bb = item.duplicate()
	bb.name = 'bb'
	bb.age = 20
	
	ceo.children.append(bb)
	
	show_items(ceo)
	
	ceo.children.remove(ceo.children.find(john))
	
	show_items(ceo)

func show_items(item):
	
	show_list(item)
#	var items := item_view.get_iterator()
#
#	while items.has_next():
#		var item := items.current()
#		print(item.get_name())
#		items.next()
#
#	print('number of items of ', item_view.get_name(), ': ', item_view.size())
	
	print('==uniterator - tree view')
	
#	show_tree(items)
	
	print('==')

func show_list(item):
	print(item.name, ': ', item.age)
	
	if item.children.size() == 0:
		return
	
	for child in item.children:
#		print(child.name, ': ', child.age)
		print(child)
		show_list(child)

func show_tree(item, back = ''):
	if item.children.size() != 0:
		print(back, '-', item.name)
	else:
		print(back, item.name)
	
	back += ' '
	for item in item.children:
		show_tree(item, back)












