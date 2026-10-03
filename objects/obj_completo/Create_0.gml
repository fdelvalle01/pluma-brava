food_state = "pickup";
holder = noone;
food_vsp = 0;
food_gravity = 0.3;
food_max_fall_speed = 6;
launch_speed = 8;
launch_direction = 1;
flight_steps_left = 180;
damage_amount = 1;

hit_enemy = function() {
    var enemy_hit = instance_place(x, y, obj_zombie_oficinista);
    if (!instance_exists(enemy_hit)) {
        return false;
    }
    enemy_hit.hp -= damage_amount;
    enemy_hit.hurt_steps = 10;
    if (enemy_hit.hp <= 0) {
        with (enemy_hit) {
            instance_destroy();
        }
    }
    return true;
};
