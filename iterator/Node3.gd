extends Node

class Item:
	
	var name :String
	
	func _init(name: String) -> void:
		self.name = name

class Iterator:
	
	var position := 0
	var items := []
	
	func _init(view: ItemHolder) -> void:
		add_item(view)
		position = 0
	
	func add_item(view: ItemHolder) -> void:
		for item in view.items:
			items.append(item)
			add_item(item)
	
	func current() -> ItemHolder:
		return items[position]
	
	func has_next() -> bool:
		return position < items.size()
	
	func next() -> void:
		position += 1
	
	func get_next() -> ItemHolder:
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

class ItemHolder:
	
	var this : Item
	var items : Array
	
	func _init(this: Item) -> void:
		items = []
		self.this = this
	
	func add_subitem(item_holder: ItemHolder) -> void:
		items.append(item_holder)
	
	func remove_subitem(item_holder: ItemHolder) -> void:
		for item in items:
			if item == item_holder:
				items.remove(items.find(item))
				return
	
#	func get_items() -> Array:
#		return items
	
	func get_iterator() -> Iterator:
		return Iterator.new(self)
	
	func size() -> int:
		return Iterator.new(self).size()
	
	func has_children() -> bool:
		return items.size() != 0
	
	func get_name() -> String:
		return this.name




func _ready() -> void:
	print('\n', name)
	var john := ItemHolder.new(Item.new('john'))
	var tom := ItemHolder.new(Item.new('tom'))
	var johny := ItemHolder.new(Item.new('johny'))
	var ceo := ItemHolder.new(Item.new('mark'))
	
	
	john.add_subitem(tom)
	john.add_subitem(johny)
	ceo.add_subitem(john)
	
	show_items(ceo)
	
	var jan := ItemHolder.new(Item.new('jan'))
	var cj := ItemHolder.new(Item.new('cj'))
	var bb := ItemHolder.new(Item.new('bb'))
	
	bb.add_subitem(jan)
	bb.add_subitem(cj)
	ceo.add_subitem(bb)
	
	show_items(ceo)
	
	ceo.remove_subitem(bb)
	
	show_items(ceo)

func show_items(item_view: ItemHolder):
#	var items := item_view.get_iterator()
#
#	while items.has_next():
#		var item := items.current()
#		print(item.get_name())
#		items.next()
#
#	print('number of items of ', item_view.get_name(), ': ', item_view.size())
	
	print('==uniterator - tree view')
	
	show_names(item_view)
	
	print('==')

func show_names(item_holder: ItemHolder, back = ''):
	if item_holder.has_children():
		print(back, '-', item_holder.get_name())
	else:
		print(back, item_holder.get_name())
	
	back += ' '
	for item in item_holder.items:
		show_names(item, back)












