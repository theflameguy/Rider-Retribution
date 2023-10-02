extends RigidBody2D

const bullet_path = preload("res://Scenes/sword.tscn")
const angular_vel_lim = 4.5
var speed=80000
const player_rot_speed=180000
const max_speed=220

var wheels=[]
var tim=0

var x



# Called when the node enters the scene tree for the first time.
func _ready():
	wheels =get_tree().get_nodes_in_group("Wheel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_label_pressed(83):
		if(wheels[1].angular_velocity<max_speed):
			wheels[1].apply_torque_impulse(speed*delta*60)
		else:
			print("max")
		for wheel in wheels: ##breaks
			if(wheel.angular_velocity<0):
				wheel.apply_torque_impulse(speed*delta*60*3)
				
	if Input.is_key_label_pressed(65):
		if(angular_velocity>-angular_vel_lim):
			apply_torque_impulse(-player_rot_speed*delta*60) ##bike back rot'n

	if Input.is_key_label_pressed(68):
		for wheel in wheels:
			if(wheel.angular_velocity>0):
				wheel.apply_torque_impulse(-speed*delta*60*3)
				
		if(wheels[1].angular_velocity>-max_speed):
			wheels[1].apply_torque_impulse(-speed*delta*60)
	if Input.is_key_label_pressed(70):
		if(angular_velocity<angular_vel_lim):
			apply_torque_impulse(player_rot_speed*delta*60) ##bike front rot'n
			
		
	if Input.is_key_label_pressed(4194305): ##esc
		get_tree().reload_current_scene()
	if Input.is_key_label_pressed(4194309) and tim%2 == 0:
		shoot()
	tim%=20
	tim+=1
	
	get_child(6).look_at(get_global_mouse_position())
	
	
			
	
func shoot():
	var bullet = bullet_path.instantiate()
	get_parent().add_child(bullet)
	bullet.position=$BulletSpawnMarker.global_position
	bullet.vel= bullet.position - global_position
	
	


