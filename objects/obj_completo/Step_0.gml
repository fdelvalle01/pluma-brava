if (food_state == "held") {
    if (!instance_exists(holder)) {
        instance_destroy();
    }
    exit;
}

if (food_state == "flying") {
    if (place_meeting(x, y, obj_solid)) {
        instance_destroy();
        exit;
    }

    if (hit_enemy()) {
        instance_destroy();
        exit;
    }

    var remaining_distance = launch_speed;
    while (remaining_distance > 0) {
        var travel_step = min(1, remaining_distance) * launch_direction;
        if (place_meeting(x + travel_step, y, obj_solid)) {
            instance_destroy();
            exit;
        }
        x += travel_step;
        if (hit_enemy()) {
            instance_destroy();
            exit;
        }
        remaining_distance -= abs(travel_step);
    }

    flight_steps_left -= 1;
    if (flight_steps_left <= 0 || bbox_right < 0 || bbox_left > room_width
        || bbox_bottom < 0 || bbox_top > room_height) {
        instance_destroy();
    }
    exit;
}

food_vsp = min(food_vsp + food_gravity, food_max_fall_speed);
var remaining_fall = food_vsp;
while (remaining_fall > 0) {
    var fall_step = min(1, remaining_fall);
    if (place_meeting(x, y + fall_step, obj_solid)) {
        food_vsp = 0;
        break;
    }
    y += fall_step;
    remaining_fall -= fall_step;
}

if (bbox_top > room_height) {
    instance_destroy();
}
