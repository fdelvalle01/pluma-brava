hsp = 0;
vsp = 0;

move_speed = 2.5;
jump_speed = -6;
gravity_force = 0.3;

// Aleteo y descenso en el aire.
flap_force = 3.0;
flap_max_rise_speed = 9.0;
glide_gravity = 0.12;
glide_max_fall_speed = 2.2;

air_action = "normal";
space_hold_steps = 0;
double_tap_window = 15;
jump_tap_steps = 0;
was_on_ground = false;
charge_delay = 12;
charge_full_steps = 36;
charge_steps = 0;
charge_frame = 0;
charge_frame_step = 0.15;
charge_fall_speed = 0.8;
burst_available = true;
burst_frame = 0;
burst_frame_step = 0.25;
burst_launch_frame = 2;
burst_launched = false;
burst_min_speed = 7;
burst_max_speed = 11;
burst_speed = 0;
burst_horizontal_speed = 1.5;
burst_facing = 1;
air_restore_speed = image_speed;
dive_frame = 0;
dive_frame_step = 0.3;
dive_drop_frame = 2;
dive_speed = 10;
dive_facing = 1;
wing_frame = 0;
wing_frame_step = 0.35;
wing_hit_frame = 4;
wing_hit_used = false;
wing_facing = 1;
wing_reach = 24;
wing_damage = 1;

// Direccion inicial: el sprite mira a la derecha.
facing = 1;
image_xscale = facing;

sprite_set_offset(spr_player_pixellab, 16, 32);
sprite_set_offset(spr_player_fly_pixellab, 20, 36);
sprite_set_offset(spr_player_shoot_pixellab, 20, 36);
sprite_set_offset(spr_player_charge_pixellab, 20, 36);
sprite_set_offset(spr_player_burst_pixellab, 20, 36);
sprite_set_offset(spr_player_dive_pixellab, 18, 34);
sprite_set_offset(spr_player_wing_attack_pixellab, 18, 34);
sprite_set_speed(spr_player_fly_pixellab, 10, spritespeed_framespersecond);
sprite_index = spr_player_pixellab;

is_shooting = false;
shoot_frame = 0;
shoot_frame_step = 0.2;
shoot_restore_speed = image_speed;

held_completo = noone;
shoot_released = false;
shoot_release_frame = 2;
beak_offset_x = 9;
beak_offset_y = -24;
shoot_beak_x = [9, 2, 15, 9, 9];
shoot_beak_y = [-24, -28, -22, -24, -24];

max_hp = 3;
hp = max_hp;
hurt_duration = 60;
hurt_steps = 0;

health_hud_x = 16;
health_hud_y = 16;
health_icon_size = 32;
health_icon_gap = 6;
