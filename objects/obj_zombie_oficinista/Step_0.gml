if (hp <= 0) {
    instance_destroy();
    exit;
}

hurt_steps = max(0, hurt_steps - 1);
vsp = min(vsp + gravity_force, max_fall_speed);
var remaining_fall = vsp;
while (remaining_fall > 0) {
    var fall_step = min(1, remaining_fall);
    if (place_meeting(x, y + fall_step, obj_solid)) {
        vsp = 0;
        break;
    }
    y += fall_step;
    remaining_fall -= fall_step;
}

if (bbox_top > room_height) {
    instance_destroy();
    exit;
}

var grounded = place_meeting(x, y + 1, obj_solid);
var target_player = instance_nearest(x, y, obj_player);

if (enemy_state != "patrol") {
    state_steps -= 1;
    if (state_steps <= 0) {
        switch (enemy_state) {
            case "windup":
                enemy_state = "strike";
                state_steps = strike_steps;
                break;
            case "strike":
                enemy_state = "recovery";
                state_steps = recovery_steps;
                break;
            case "recovery":
                enemy_state = "patrol";
                break;
        }
    }
}

switch (enemy_state) {
    case "patrol":
        var can_attack = false;
        if (grounded && instance_exists(target_player)) {
            can_attack = abs(target_player.x - x) <= detection_range
                && target_player.bbox_bottom >= bbox_top
                && target_player.bbox_top <= bbox_bottom
                && collision_line(x, (bbox_top + bbox_bottom) / 2,
                    target_player.x, (target_player.bbox_top + target_player.bbox_bottom) / 2,
                    obj_solid, false, true) == noone;
        }

        if (can_attack) {
            if (target_player.x != x) {
                facing = sign(target_player.x - x);
            }
            enemy_state = "windup";
            state_steps = windup_steps;
            attack_used = false;
        } else if (grounded) {
            var patrol_move = facing * patrol_speed;
            if (abs(x + patrol_move - patrol_origin_x) > patrol_radius
                || place_meeting(x + patrol_move, y, obj_solid)
                || !place_meeting(x + patrol_move + facing * 8, y + 1, obj_solid)
                || bbox_left + patrol_move < 0 || bbox_right + patrol_move >= room_width) {
                facing = -facing;
            } else {
                x += patrol_move;
            }
        }
        break;

    case "windup":
        break;

    case "strike":
        if (!attack_used && grounded) {
            var attack_left = x;
            var attack_right = bbox_right + attack_reach;
            if (facing < 0) {
                attack_left = bbox_left - attack_reach;
                attack_right = x;
            }
            var attack_top = bbox_top + (bbox_bottom - bbox_top) * 0.35;
            var victim = collision_rectangle(attack_left, attack_top,
                attack_right, bbox_bottom, obj_player, false, true);
            if (instance_exists(victim)) {
                if (victim.hurt_steps <= 0
                    && collision_line(x, attack_top, victim.x,
                        (victim.bbox_top + victim.bbox_bottom) / 2,
                        obj_solid, false, true) == noone) {
                    victim.hp = max(0, victim.hp - attack_damage);
                    victim.hurt_steps = victim.hurt_duration;
                    attack_used = true;
                }
            }
        }
        break;

    case "recovery":
        break;
}

image_xscale = facing;
sprite_index = spr_zombie_oficinista;
image_index = 0;
image_blend = c_white;
if (enemy_state == "windup") {
    sprite_index = spr_zombie_oficinista_attack;
    image_index = clamp(floor((windup_steps - state_steps)
        * attack_hit_frame / max(1, windup_steps)), 0, attack_hit_frame - 1);
} else if (enemy_state == "strike") {
    sprite_index = spr_zombie_oficinista_attack;
    image_index = attack_hit_frame;
} else if (enemy_state == "recovery"
    && recovery_steps - state_steps < recovery_pose_steps) {
    sprite_index = spr_zombie_oficinista_attack;
    image_index = attack_recovery_frame;
}
if (hurt_steps > 0) {
    image_blend = c_red;
}
