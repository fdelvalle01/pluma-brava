var feather_scale = health_icon_size / max(1,
    max(sprite_get_width(spr_vida_pluma), sprite_get_height(spr_vida_pluma)));
var feather_count = clamp(floor(hp), 0, max_hp);
for (var feather_index = 0; feather_index < feather_count; feather_index += 1) {
    var feather_x = health_hud_x + feather_index * (health_icon_size + health_icon_gap)
        + sprite_get_xoffset(spr_vida_pluma) * feather_scale;
    var feather_y = health_hud_y + sprite_get_yoffset(spr_vida_pluma) * feather_scale;
    draw_sprite_ext(spr_vida_pluma, 0, feather_x, feather_y,
        feather_scale, feather_scale, 0, c_white, 1);
}
