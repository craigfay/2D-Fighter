extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

export var walk_speed = 96
export var gravity_force = 32
export var jump_force = 640

func _physics_process(delta):
    # Gravity
    motion.y += gravity_force
    motion = move_and_slide(motion, UP)

    # Left/Right motion
    if Input.is_action_pressed("ui_left"):
        motion.x = -walk_speed
    elif Input.is_action_pressed("ui_right"):
        motion.x = walk_speed
    else:
        motion.x = 0

    # Jump
    if is_on_floor():
        if Input.is_action_just_pressed("ui_up"):
            motion.y = -jump_force

func _ready():
	var jump_animation = Animation.new()
	jump_animation.add_track(0)
	jump_animation.length = .8
	var path = String(self.get_path()) + ":frame"
	jump_animation.track_set_path(0, path)