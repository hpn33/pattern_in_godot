extends Node

class Employee:
	
	var name :String
	var position :String
	
	func _init(name: String, position: String) -> void:
		self.name = name
		self.position = position

class EmployeeTeamIterator:
	
	var position := 0
	var team_members := []
	
	func _init(employee: CompanyEmployeeTeam) -> void:
		add_team(employee)
		position = 0
	
	func add_team(employee: CompanyEmployeeTeam) -> void:
		for member in employee.get_subordinates():
			team_members.push_back(member)
			add_team(member)
	
	func current() -> CompanyEmployeeTeam:
		return team_members[position]
	
	func has_next() -> bool:
		return position < team_members.size()
	
	func next() -> void:
		position+=1
	
	func get_next() -> CompanyEmployeeTeam:
		next()
		return current()
	
	func key() -> int:
		return position
	
	func valid() -> bool:
		return team_members[position] != null
	
	func rewind() -> void:
		position = 0
	
	func count() -> int:
		return team_members.size()



class CompanyEmployeeTeam:
	
	var person : Employee
	var subordinates : Array
	
	func _init(person: Employee) -> void:
		subordinates = []
		self.person = person
	
	func add_subordinate(subordinate: CompanyEmployeeTeam) -> void:
		subordinates.append(subordinate)
		
	
	func remove_subrodinate(subordinate: CompanyEmployeeTeam) -> void:
		for s in subordinates:
			if s == subordinate:
				subordinates.remove(subordinates.find(subordinate))
	
	func get_subordinates() -> Array:
		return subordinates
	
	func get_iterator() -> EmployeeTeamIterator:
		return EmployeeTeamIterator.new(self)
	
	func count() -> int:
		return EmployeeTeamIterator.new(self).count()
	
	func get_name() -> String:
		return person.name
	
	func get_position() -> String:
		return person.position




func _ready() -> void:
	print('\n', self.name)
	var john = CompanyEmployeeTeam.new(Employee.new('john', 'director'))
	var tom = CompanyEmployeeTeam.new(Employee.new('tom', 'developer'))
	var johny = CompanyEmployeeTeam.new(Employee.new('johny', 'developer'))
	var ceo = CompanyEmployeeTeam.new(Employee.new('mark', 'ceo'))
	
	
	john.add_subordinate(tom)
	john.add_subordinate(johny)
	ceo.add_subordinate(john)
	
	show_team(ceo)
	
	var jan = CompanyEmployeeTeam.new(Employee.new('jan', 'Developer'))
	ceo.add_subordinate(jan)
	
	show_team(ceo)
	
	ceo.remove_subrodinate(jan)
	
	show_team(ceo)

func show_team(users_temp: CompanyEmployeeTeam):
	var users := users_temp.get_iterator()
	
	while users.has_next():
		var user := users.current()
		print(user.get_position(), ': ', user.get_name())
		users.next()
	
	print('number of subordinates of ', users_temp.get_name(), ': ', users_temp.count())












