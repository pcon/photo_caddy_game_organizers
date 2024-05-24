use <../photo_base.scad>
use <../utilities.scad>

TOKEN_DIAMETER = 41;
TOKEN_STACK_HEIGHT = 16;

CARD_WIDTH = 64;
CARD_DEPTH = 88.5;
CARD_HEIGHT = 9;

THUMB_CUTOUT_DEPTH = 14;

token_radius = TOKEN_DIAMETER / 2;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

offset_y_r1 = label_depth() + 1;
offset_y_r2 = box_depth() / 2 - token_radius;
offset_y_r3 = box_depth() - top_curve() - TOKEN_DIAMETER;

offset_x_c1 = side_curve();
offset_x_c2 = box_width() / 3 - token_radius - side_curve();
offset_x_c3 = box_width() / 2 - token_radius;
offset_x_c4 = (box_width() / 3) * 2 - token_radius + side_curve();
offset_x_c5 = box_width() - side_curve() - TOKEN_DIAMETER;

offset_z_token = box_height() - TOKEN_STACK_HEIGHT - CARD_HEIGHT;

module token_slot(offset_x, offset_y) {    
    translate([
        offset_x + token_radius,
        offset_y + token_radius,
        offset_z_token
    ])
    cylinder(h = TOKEN_STACK_HEIGHT + CARD_HEIGHT + render_helper, d = TOKEN_DIAMETER);
}

module token_cutouts() {
    translate([
        0,
        token_radius - THUMB_CUTOUT_DEPTH / 2 + label_depth(),
        offset_z_token
    ])
    thumb_slot(depth = THUMB_CUTOUT_DEPTH);
    token_slot(offset_x_c1, offset_y_r1);
    token_slot(offset_x_c1, offset_y_r3);
    
    token_slot(offset_x_c2, offset_y_r2);
    
    translate([
        0,
        box_depth() / 2 - THUMB_CUTOUT_DEPTH / 2,
        offset_z_token
    ])
    thumb_slot(depth = THUMB_CUTOUT_DEPTH);
    token_slot(offset_x_c3, offset_y_r1);
    token_slot(offset_x_c3, offset_y_r3);
    
    token_slot(offset_x_c4, offset_y_r2);
    
    translate([
        0,
        box_depth() - token_radius - THUMB_CUTOUT_DEPTH / 2 - side_curve(),
        offset_z_token
    ])
    thumb_slot(depth = THUMB_CUTOUT_DEPTH);
    token_slot(offset_x_c5, offset_y_r1);
    token_slot(offset_x_c5, offset_y_r3);
}

module card_cutouts() {
    offset_y = center_depth_offset(CARD_DEPTH);
    offset_z = box_height() - CARD_HEIGHT;

    translate([triple_width_offset(CARD_WIDTH), offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
    
    translate([triple_width_offset(CARD_WIDTH) * 2 + CARD_WIDTH, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
}

difference() {    
    photo_base();

    token_cutouts();
    card_cutouts();    
}