var visitor = instance_nearest(x, y, obj_player);
if (instance_exists(visitor)) {
    if (depth != visitor.depth + 1) {
        depth = visitor.depth + 1;
    }
}

feed_cooldown_left = max(0, feed_cooldown_left - 1);

if (feeding) {
    feed_frame += feed_frame_step;
    if (feed_frame >= sprite_get_number(spr_abuelita_feed)) {
        feeding = false;
        feed_cooldown_left = feed_cooldown;
        sprite_index = spr_abuelita;
        image_index = 0;
    } else {
        image_index = floor(feed_frame);
    }
    exit;
}

if (feed_cooldown_left == 0 && instance_exists(visitor)) {
    if (abs(visitor.x - x) <= feed_range_x
        && abs(visitor.y - y) <= feed_range_y
        && collision_line(x, (bbox_top + bbox_bottom) / 2,
            visitor.x, (visitor.bbox_top + visitor.bbox_bottom) / 2,
            obj_solid, false, true) == noone) {
        feeding = true;
        feed_frame = 0;
        sprite_index = spr_abuelita_feed;
        image_index = 0;
    }
}
