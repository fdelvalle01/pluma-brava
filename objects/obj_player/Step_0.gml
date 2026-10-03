if (hp <= 0) {
    room_restart();
    exit;
}

hurt_steps = max(0, hurt_steps - 1);
image_blend = c_white;
if (hurt_steps > 0 && (hurt_steps div 5) mod 2 == 0) {
    image_blend = c_red;
}

// Input horizontal
var move = keyboard_check(vk_right) - keyboard_check(vk_left);
hsp = move * move_speed;

// Conservar la ultima direccion al detenerse.
if (move != 0) {
    facing = sign(move);
    image_xscale = facing;
}

var on_ground = place_meeting(x, y + 1, obj_solid);

// Mantener el ascenso normal; limitar la caida en el aire.
if (on_ground || vsp < 0) {
    vsp += gravity_force;
} else {
    vsp = min(vsp + glide_gravity, glide_max_fall_speed);
}

// Cada pulsacion nueva salta desde el suelo o aletea en el aire.
if (keyboard_check_pressed(vk_space)) {
    if (on_ground) {
        vsp = jump_speed;
    } else {
        vsp = max(vsp - flap_force, -flap_max_rise_speed);
    }
}

// Colisión horizontal
if (place_meeting(x + hsp, y, obj_solid)) {
    while (!place_meeting(x + sign(hsp), y, obj_solid)) {
        x += sign(hsp);
    }

    hsp = 0;
}

x += hsp;

// Colisión vertical
if (place_meeting(x, y + vsp, obj_solid)) {
    while (!place_meeting(x, y + sign(vsp), obj_solid)) {
        y += sign(vsp);
    }

    vsp = 0;
}

y += vsp;

if (!instance_exists(held_completo)) {
    held_completo = noone;
}

if (!is_shooting && held_completo == noone) {
    with (obj_completo) {
        if (food_state == "pickup" && other.held_completo == noone
            && place_meeting(x, y, other.id)) {
            food_state = "held";
            holder = other.id;
            food_vsp = 0;
            other.held_completo = id;
        }
    }
}

if (is_shooting) {
    shoot_frame += shoot_frame_step;
    if (shoot_frame >= sprite_get_number(spr_player_shoot_pixellab)) {
        is_shooting = false;
        image_speed = shoot_restore_speed;
        image_index = 0;
    }
}

if (!is_shooting && instance_exists(held_completo)
    && keyboard_check_pressed(ord("Z"))) {
    is_shooting = true;
    shoot_released = false;
    shoot_frame = 0;
    shoot_restore_speed = image_speed;
    image_speed = 0;
}

if (is_shooting) {
    sprite_index = spr_player_shoot_pixellab;
    image_index = floor(shoot_frame);
} else {
    if (place_meeting(x, y + 1, obj_solid)) {
        if (sprite_index != spr_player_pixellab) {
            sprite_index = spr_player_pixellab;
            image_index = 0;
        }
    } else {
        if (sprite_index != spr_player_fly_pixellab) {
            sprite_index = spr_player_fly_pixellab;
            image_index = 0;
        }
    }
}

if (instance_exists(held_completo)) {
    var mouth_x = beak_offset_x;
    var mouth_y = beak_offset_y;
    if (is_shooting) {
        var mouth_frame = clamp(floor(shoot_frame), 0, array_length(shoot_beak_x) - 1);
        mouth_x = shoot_beak_x[mouth_frame];
        mouth_y = shoot_beak_y[mouth_frame];
    }

    held_completo.image_xscale = facing;
    held_completo.x = x + mouth_x * facing
        + sprite_get_xoffset(spr_completo) * facing;
    held_completo.y = y + mouth_y
        + sprite_get_yoffset(spr_completo) - sprite_get_height(spr_completo) / 2;
    held_completo.depth = depth - 1;

    if (is_shooting && !shoot_released && shoot_frame >= shoot_release_frame) {
        held_completo.food_state = "flying";
        held_completo.launch_direction = facing;
        held_completo.holder = noone;
        held_completo = noone;
        shoot_released = true;
    }
}
