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
var space_held = keyboard_check(vk_space);
var space_pressed = keyboard_check_pressed(vk_space);
jump_tap_steps = max(0, jump_tap_steps - 1);
var dive_started = false;

if (air_action == "wing") {
    wing_frame += wing_frame_step;
    if (wing_frame >= sprite_get_number(spr_player_wing_attack_pixellab)) {
        air_action = "normal";
        image_speed = air_restore_speed;
        image_index = 0;
    }
}

if (!is_shooting && air_action == "normal" && keyboard_check_pressed(ord("X"))) {
    air_action = "wing";
    wing_frame = 0;
    wing_hit_used = false;
    wing_facing = facing;
    space_hold_steps = 0;
    jump_tap_steps = 0;
    air_restore_speed = image_speed;
    image_speed = 0;
}

if (!on_ground && !is_shooting && air_action == "normal"
    && !instance_exists(held_completo) && keyboard_check_pressed(ord("Z"))) {
    air_action = "dive";
    dive_started = true;
    dive_frame = 0;
    dive_facing = facing;
    space_hold_steps = 0;
    air_restore_speed = image_speed;
    image_speed = 0;
}

if (on_ground) {
    if (!was_on_ground) {
        burst_available = true;
    }
    if (air_action == "burst" && burst_launched) {
        air_action = "normal";
        burst_available = true;
        image_speed = air_restore_speed;
        image_index = 0;
    }
} else {
    jump_tap_steps = 0;
}

if (!is_shooting && air_action == "normal" && burst_available) {
    space_hold_steps = space_held ? space_hold_steps + 1 : 0;
    if (space_hold_steps >= charge_delay) {
        air_action = "charge";
        charge_steps = 0;
        charge_frame = 0;
        jump_tap_steps = 0;
        air_restore_speed = image_speed;
        image_speed = 0;
    }
} else {
    space_hold_steps = 0;
}

if (air_action == "charge") {
    if (space_held) {
        charge_steps = min(charge_steps + 1, charge_full_steps);
        charge_frame = (charge_frame + charge_frame_step)
            mod sprite_get_number(spr_player_charge_pixellab);
    } else {
        air_action = "burst";
        burst_available = false;
        burst_frame = 0;
        burst_launched = false;
        burst_facing = facing;
        burst_speed = lerp(burst_min_speed, burst_max_speed, charge_steps / charge_full_steps);
    }
} else if (air_action == "burst") {
    burst_frame += burst_frame_step;
    if (burst_frame >= sprite_get_number(spr_player_burst_pixellab)) {
        air_action = "normal";
        image_speed = air_restore_speed;
        image_index = 0;
    }
}

// Mantener el ascenso normal; limitar la caida en el aire.
if (on_ground || vsp < 0) {
    vsp += gravity_force;
} else {
    vsp = min(vsp + glide_gravity, glide_max_fall_speed);
}

if (space_pressed && air_action == "normal") {
    if (on_ground) {
        if (jump_tap_steps > 0) {
            vsp = jump_speed;
            jump_tap_steps = 0;
            space_hold_steps = 0;
        } else {
            jump_tap_steps = double_tap_window;
        }
    } else {
        vsp = max(vsp - flap_force, -flap_max_rise_speed);
    }
}

if (air_action == "charge" || (air_action == "burst" && !burst_launched)) {
    vsp = on_ground ? 0 : charge_fall_speed;
    if (on_ground) {
        hsp = 0;
    }
}

if (air_action == "burst") {
    facing = burst_facing;
    image_xscale = facing;
    if (!burst_launched && burst_frame >= burst_launch_frame) {
        vsp = -burst_speed;
        burst_launched = true;
    }
    if (burst_launched) {
        hsp += burst_horizontal_speed * burst_facing;
    }
}

// Colisión horizontal
if (air_action == "wing") {
    facing = wing_facing;
    image_xscale = facing;
    hsp = 0;
}

if (air_action == "dive") {
    if (!dive_started) {
        dive_frame = min(dive_frame + dive_frame_step,
            sprite_get_number(spr_player_dive_pixellab) - 1);
    }
    facing = dive_facing;
    image_xscale = facing;
    hsp = 0;
    vsp = dive_frame >= dive_drop_frame ? dive_speed : charge_fall_speed;
}

if (place_meeting(x + hsp, y, obj_solid)) {
    while (!place_meeting(x + sign(hsp), y, obj_solid)) {
        x += sign(hsp);
    }

    hsp = 0;
}

x += hsp;

// Colisión vertical
if (air_action == "dive") {
    var dive_remaining = vsp;
    while (dive_remaining > 0) {
        var dive_step = min(1, dive_remaining);
        if (place_meeting(x, y + dive_step, obj_solid)) {
            break;
        }
        y += dive_step;
        dive_remaining -= dive_step;
    }
    vsp = 0;
} else if (place_meeting(x, y + vsp, obj_solid)) {
    while (!place_meeting(x, y + sign(vsp), obj_solid)) {
        y += sign(vsp);
    }

    vsp = 0;
}

y += vsp;

var grounded_after_move = place_meeting(x, y + 1, obj_solid) && vsp >= 0;
if (grounded_after_move && !on_ground) {
    burst_available = true;
}
if (((air_action == "burst" && burst_launched) || air_action == "dive")
    && grounded_after_move) {
    if (air_action == "dive") {
        instance_create_depth(x, bbox_bottom + 1, depth - 1, obj_dive_impact);
    }
    air_action = "normal";
    burst_available = true;
    space_hold_steps = 0;
    image_speed = air_restore_speed;
    image_index = 0;
}
was_on_ground = grounded_after_move;

if (air_action == "wing" && !wing_hit_used && wing_frame >= wing_hit_frame) {
    wing_hit_used = true;
    var wing_left = x;
    var wing_right = bbox_right + wing_reach;
    if (wing_facing < 0) {
        wing_left = bbox_left - wing_reach;
        wing_right = x;
    }
    var wing_top = bbox_top;
    var wing_bottom = bbox_bottom;
    var wing_center_y = (wing_top + wing_bottom) / 2;
    with (obj_zombie_oficinista) {
        if (hp > 0 && bbox_right >= wing_left && bbox_left <= wing_right
            && bbox_bottom >= wing_top && bbox_top <= wing_bottom) {
            var contact_x = clamp(other.x, bbox_left, bbox_right);
            var contact_y = clamp(wing_center_y, bbox_top, bbox_bottom);
            if (collision_line(other.x, wing_center_y, contact_x, contact_y,
                obj_solid, false, true) == noone) {
                hp -= other.wing_damage;
                hurt_steps = 10;
                if (hp <= 0) {
                    instance_destroy();
                }
            }
        }
    }
}

if (!instance_exists(held_completo)) {
    held_completo = noone;
}

if (!is_shooting && air_action != "dive" && held_completo == noone) {
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

if (!dive_started && !is_shooting && air_action == "normal" && instance_exists(held_completo)
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
} else if (air_action == "charge") {
    sprite_index = spr_player_charge_pixellab;
    image_index = floor(charge_frame);
} else if (air_action == "burst") {
    sprite_index = spr_player_burst_pixellab;
    image_index = floor(burst_frame);
} else if (air_action == "dive") {
    sprite_index = spr_player_dive_pixellab;
    image_index = floor(dive_frame);
} else if (air_action == "wing") {
    sprite_index = spr_player_wing_attack_pixellab;
    image_index = floor(wing_frame);
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
