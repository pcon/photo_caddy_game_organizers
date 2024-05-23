use <../photo_base.scad>
use <../utilities.scad>

TOKEN_DIAMETER = 44;
TOKEN_HEIGHT = 3.5;

STANDARD_TOKEN_COUNT = 7;
YELLOW_TOKEN_COUNT = 5;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

token_depth = STANDARD_TOKEN_COUNT * TOKEN_HEIGHT;
offset_z_thumb = box_height() - token_depth;

x_spacing = quad_width_offset_single(TOKEN_DIAMETER * 3);
y_spacing = triple_depth_offset_single(TOKEN_DIAMETER * 2);

offset_y_r1 = y_spacing;
offset_y_r2 = box_depth() - y_spacing - TOKEN_DIAMETER;

offset_x_c1 = x_spacing;
offset_x_c2 = x_spacing * 2 + TOKEN_DIAMETER;
offset_x_c3 = box_width() - x_spacing - TOKEN_DIAMETER;

function offset_z(count) = box_height() - count * TOKEN_HEIGHT;

module token_slot(count, offset_x, offset_y) {
    translate([
        offset_x + TOKEN_DIAMETER / 2,
        offset_y + TOKEN_DIAMETER / 2,
        offset_z(count)
    ])
    cylinder(h = count * TOKEN_HEIGHT + render_helper, d = TOKEN_DIAMETER);
}

difference() {
    photo_base();
    
    translate([
        0,
        TOKEN_DIAMETER / 2 - thumb_width() / 2 + y_spacing,
        offset_z_thumb
    ])
    thumb_slot(slot_depth = token_depth);
    
    token_slot(YELLOW_TOKEN_COUNT, offset_x_c1, offset_y_r1);
    token_slot(STANDARD_TOKEN_COUNT, offset_x_c2, offset_y_r1);
    token_slot(STANDARD_TOKEN_COUNT, offset_x_c3, offset_y_r1);
    
    translate([
        0,
        box_depth() - thumb_width() / 2 - TOKEN_DIAMETER / 2 - y_spacing,
        offset_z_thumb
    ])
    thumb_slot(slot_depth = STANDARD_TOKEN_COUNT * TOKEN_HEIGHT);
    token_slot(STANDARD_TOKEN_COUNT, offset_x_c1, offset_y_r2);
    token_slot(STANDARD_TOKEN_COUNT, offset_x_c2, offset_y_r2);
    token_slot(STANDARD_TOKEN_COUNT, offset_x_c3, offset_y_r2);
}