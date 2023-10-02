extends Node2D

const particle_path = preload("res://Scenes/particle.tscn")

var player_pos
var poly_shape = Array([Vector2(-1000, 500),
	Vector2(1000, 500),
	Vector2(1000, 5000),
	Vector2(-1000, 5000)])
var poly
	
var _noise = FastNoiseLite.new()

var timer=1000



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	poly = CollisionPolygon2D.new()
	poly.set_polygon(poly_shape)
	get_child(0).add_child(poly)
	
	_noise.noise_type = FastNoiseLite.NoiseType.TYPE_SIMPLEX_SMOOTH
	_noise.seed = randi()
	_noise.fractal_octaves = 4
	_noise.frequency = 20.0
	
	
	
	print(len(get_child(0).get_child(2).get_polygon()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player_pos = get_child(1).position.x
	$TestControlls/Button.text = str($TestControlls/HSlider.value)
	get_child(3).position = get_global_mouse_position()
		
#	timer+=100
#
#	if player_pos+1000 > poly_shape[len(poly_shape)-3][0]:
#		var y_coor = ( 500+500*_noise.get_noise_1d(timer) )
#		var vect=Vector2(timer,y_coor)
#		poly_shape.pop_back()
#		poly_shape.pop_back()
#		poly_shape.append(vect)
#		poly_shape.append(Vector2(timer,5000))
#		poly_shape.append(Vector2(-1000,5000))
#		poly.set_polygon(poly_shape)


func _on_collision_area_body_entered(body):
	if(body.is_in_group("Sword")):
		var particle = particle_path.instantiate()
		add_child(particle)
		particle.position = body.position
		particle.get_child(0).emitting=true
		particle.get_child(0).one_shot=true
		body.queue_free()
