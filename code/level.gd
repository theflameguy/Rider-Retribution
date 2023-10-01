extends Node2D

const particle_path = preload("res://Scenes/particle.tscn")

var player_pos
var poly_shape = Array([Vector2(-1000, 500),
	Vector2(1000, 500),
	Vector2(1000, 1000),
	Vector2(-1000, 1000)])




# Called when the node enters the scene tree for the first time.
func _ready():
	var poly = CollisionPolygon2D.new()
	poly.set_polygon(poly_shape)
	poly.position.x+=50
	get_child(0).add_child(poly)
	
	print(get_child(2).get_child(1).get_polygon())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player_pos = get_child(1).position
	
#	if player_pos > get_child(0).get_child(2).position:
#		var new_poly = CollisionPolygon2D.new()
#		new_poly.set_polygon(poly_shape)
#		new_poly.position.x =1000+get_child(0).get_child(2).position.x
#		get_child(0).add_child(new_poly)
#		get_child(0).get_child(2).queue_free()
#		print(player_pos.x)
	
	
	
	
	
	
	


func _on_collision_area_body_entered(body):
	if(body.is_in_group("Sword")):
		var particle = particle_path.instantiate()
		add_child(particle)
		particle.position = body.position
		particle.get_child(0).emitting=true
		particle.get_child(0).one_shot=true
		body.queue_free()
