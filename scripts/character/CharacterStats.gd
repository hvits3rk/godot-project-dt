extends Node2D

# этот класс будет хранить всю инфу по характеристикам персонажа

export (float, 1, 200, 0.5) var move_speed = 50.0
export (float) var max_health = 100
export (float) var damage = 20
export (float) var attack_radius = 60
export (float, 0.1, 12.0, 0.1) var attack_speed = 1.5
export (float) var max_stamina = 100.0

var dead = false

var stamina
var health


func _ready():
	stamina = max_stamina
	health = max_health


func restore_stamina(amount):
	stamina += amount
	
	if stamina >= max_stamina:
		stamina = max_stamina


func decrease_stamina(amount):
	stamina -= amount
	
	if stamina < 0:
		stamina = 0


func restore_health(amount):
	health += amount
	
	if health >= max_health:
		health = max_health


func decrease_health(amount):
	health -= amount
	
	if health < 0:
		dead = true
		health = 0