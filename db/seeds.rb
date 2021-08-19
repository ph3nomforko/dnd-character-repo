# Create two users

codi = User.create(name: "Codi", email: "codi@codi.com", password: "password")
jordyn = User.create(name: "Jordyn", email: "jordyn@daughter.edu", password: "password")

# Create some characters
Character.create(character_name: "Eriator", character_class: "Fighter", species: "Human", level: 3, user: codi)
Character.create(character_name: "Immaril", character_class: "Wizard", species: "Half-Elf", level: 1, user_id: codi.id)

jordyn.characters.create(character_name: "Asha", character_class: "Rogue", species: "Halfling", level: 2)

jordyn_second_char = jordyn.characters.build(character_name: "Luna", character_class: "Cleric", species: "Dwarf", level: 1)
jordyn_second_char.save