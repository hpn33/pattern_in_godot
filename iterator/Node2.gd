extends Node

class Item:
	
	var name :String
	
	func _init(name: String) -> void:
		self.name = name

class Iterator:
	
	var position := 0
	var items := []
	
	func _init(view: ItemView) -> void:
		add_item(view)
		position = 0
	
	func add_item(view: ItemView) -> void:
		for item in view.items:
			items.push_back(item)
			add_item(item)
	
	func current() -> ItemView:
		return items[position]
	
	func has_next() -> bool:
		return position < items.size()
	
	func next() -> void:
		position+=1
	
	func get_next() -> ItemView:
		next()
		return current()
	
	func key() -> int:
		return position
	
	func valid() -> bool:
		return items[position] != null
	
	func rewind() -> void:
		position = 0
	
	func count() -> int:
		return items.size()

class ItemView:
	
	var this : Item
	var items : Array
	
	func _init(this: Item) -> void:
		items = []
		self.this = this
	
	func add_item(item: ItemView) -> void:
		items.append(item)
		
	
	func remove_item(item: ItemView) -> void:
		for s in items:
			if s == item:
				items.remove(items.find(item))
				return
	
	func get_items() -> Array:
		return items
	
	func get_iterator() -> Iterator:
		return Iterator.new(self)
	
	func count() -> int:
		return Iterator.new(self).count()
	
	func get_name() -> String:
		return this.name




func _ready() -> void:
	print('\n', self.name)
	var john := ItemView.new(Item.new('john'))
	var tom := ItemView.new(Item.new('tom'))
	var johny := ItemView.new(Item.new('johny'))
	var ceo := ItemView.new(Item.new('mark'))
	
	
	john.add_item(tom)
	john.add_item(johny)
	ceo.add_item(john)
	
	show_team(ceo)
	
	var jan := ItemView.new(Item.new('jan'))
	ceo.add_item(jan)
	
	show_team(ceo)
	
	ceo.remove_item(jan)
	
	show_team(ceo)

func show_team(item_view: ItemView):
	var users := item_view.get_iterator()
	
	while users.has_next():
		var user := users.current()
		print(user.get_name())
		users.next()
	
	print('number of items of ', item_view.get_name(), ': ', item_view.count())












