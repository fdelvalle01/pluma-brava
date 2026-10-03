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

// Direccion inicial: el sprite mira a la derecha.
facing = 1;
image_xscale = facing;

sprite_set_offset(spr_player_pixellab, 16, 32);
sprite_set_offset(spr_player_fly_pixellab, 20, 36);
sprite_set_offset(spr_player_shoot_pixellab, 20, 36);
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

hp = 3;
hurt_duration = 60;
hurt_steps = 0;
