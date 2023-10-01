extends CharacterBody2D

const particle_path = preload("res://Scenes/particle.tscn")


var vel = Vector2(0,0)
var speed = 10000.0

func _physics_process(delta):
	var collision_info = move_and_collide(vel.normalized()*speed*delta)
	look_at(vel)


func _on_area_2d_body_entered(body):
	var particle = particle_path.instantiate()
	add_child(particle)
	particle.position=position
	print(get_tree().get_nodes_in_group("Player"))
	particle.get_child(0).emitting=true
	particle.get_child(0).one_shot=true
	##queue_free()
