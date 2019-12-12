extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

export var walk_speed = 240
export var gravity_force = 32
export var jump_force = 640

# Animations
var current_animation = IDLE_ANIMATION
var current_animation_frame = 0

# State variables
var jumpsquat_frames = 6

func _process(delta):
    var accepting_input = true

    if FALL_ANIMATION == current_animation and not is_on_floor():
        return

    # Jump
    if accepting_input && can_do('JUMP_ANIMATION'):
        if Input.is_action_just_pressed("ui_up"):
            current_animation = JUMP_ANIMATION
            current_animation_frame = 0
            accepting_input = false

    # Dash Left
    if accepting_input && Input.is_action_pressed("ui_left"):
        if can_do('DASH_L_ANIMATION'):
            if Input.is_action_just_pressed("ui_left"):
                current_animation = DASH_L_ANIMATION
                current_animation_frame = 0
            else:
                current_animation = DASH_L_ANIMATION
            accepting_input = false

    # Dash Right
    if accepting_input && Input.is_action_pressed("ui_right"):
        if can_do('DASH_R_ANIMATION'):
            if Input.is_action_just_pressed("ui_right"):
                current_animation = DASH_R_ANIMATION
                current_animation_frame = 0
            else:
                current_animation = DASH_R_ANIMATION
            accepting_input = false

    # Advance animation frame
    $Sprite.set('frame', current_animation.frames[current_animation_frame])
    if current_animation.required_input: 
        if not Input.is_action_pressed(current_animation.required_input):
            current_animation = get_animation(current_animation.leads_to)
            current_animation_frame = 0
    if current_animation_frame == (current_animation.frames.size() - 1):
        current_animation = get_animation(current_animation.leads_to)
        current_animation_frame = 0
    else:
        current_animation_frame += 1	


func can_do(animation):
    return current_animation.cancels_into.has(animation)


func _physics_process(delta):

    # Gravity
    motion.y += gravity_force
    motion = move_and_slide(motion, UP)

    # Jump
    if current_animation == JUMP_ANIMATION:
        if current_animation_frame == jumpsquat_frames:
            motion.y = -jump_force

    # Horizontal Movement (Grounded)
    if current_animation == DASH_L_ANIMATION:
        motion.x = -walk_speed
    elif current_animation == DASH_R_ANIMATION:
        motion.x = walk_speed
    # Horizontal Movement (Airborne)
    elif Input.is_action_pressed("ui_left"):
        if not is_on_floor():
            motion.x = -walk_speed
    elif Input.is_action_pressed("ui_right"):
        if not is_on_floor():
            motion.x = walk_speed
    else:
        motion.x = 0

func get_animation(name):
    if name == "IDLE_ANIMATION":
        return IDLE_ANIMATION
    if name == "DASH_L_ANIMATION":
        return DASH_L_ANIMATION
    if name == "DASH_R_ANIMATION":
        return DASH_L_ANIMATION
    if name == "JUMP_ANIMATION":
        return JUMP_ANIMATION
    if name == "FALL_ANIMATION":
        return FALL_ANIMATION

const IDLE_ANIMATION = {
    "infinite": true,
    "cancels_into": [
        "DASH_L_ANIMATION",
        "DASH_R_ANIMATION",
        "JUMP_ANIMATION",
    ],
    "leads_to": "IDLE_ANIMATION",
    "required_input": null,
    "frames": [
        10,10,10,10,
        11,11,11,11,
        12,12,12,12,
        13,13,13,13,
        14,14,14,14,
        15,15,15,15,
        16,16,16,16,
        17,17,17,17,
        18,18,18,18,
        19,19,19,19,
    ]
}

const DASH_L_ANIMATION = {
    "infinite": false,
    "cancels_into": [
        "JUMP_ANIMATION",
    ],
    "leads_to": "IDLE_ANIMATION",
    "required_input": "ui_left",
    "frames": [
        0,0,0,0,
        1,1,1,1,
        2,2,2,2,
        3,3,3,3,
        4,4,4,4,
        5,5,5,5,
        6,6,6,6,
        7,7,7,7,
        8,8,8,8,
        9,9,9,9,
    ]
}

const DASH_R_ANIMATION = {
    "infinite": false,
    "cancels_into": [
        "JUMP_ANIMATION",
    ],
    "leads_to": "IDLE_ANIMATION",
    "required_input": "ui_right",
    "frames": [
        0,0,0,0,
        1,1,1,1,
        2,2,2,2,
        3,3,3,3,
        4,4,4,4,
        5,5,5,5,
        6,6,6,6,
        7,7,7,7,
        8,8,8,8,
        9,9,9,9,
    ]
}

const JUMP_ANIMATION = {
    "infinite": false,
    "cancels_into": [],
    "leads_to": "FALL_ANIMATION",
    "required_input": null,
    "frames": [
        20,20,20,20,20,20,
        21,21,21,21,
        22,22,22,22,
        23,23,23,23,
        24,24,24,24,
        25,25,25,25,
        26,26,26,26,
        27,27,27,27,
        28,28,28,28,
    ],
}

const FALL_ANIMATION = {
    "infinite": false,
    "cancels_into": [],
    "leads_to": "IDLE_ANIMATION",
    "required_input": null,
    "frames": [28],
}
