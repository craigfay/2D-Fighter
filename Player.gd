extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

var state_machine
var is_actionable = true

export var walk_speed = 96
export var gravity_force = 32
export var jump_force = 640


func _physics_process(delta):

    for child in $States.get_children():
        child.visible = false


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

    # Crouch
    if Input.is_action_pressed("ui_down"):
        if is_actionable:
            if is_on_floor():
                $States.get_node("CROUCH_0").visible = true
                return

    if is_actionable:
        $States.get_node("IDLE_0").visible = true
        return