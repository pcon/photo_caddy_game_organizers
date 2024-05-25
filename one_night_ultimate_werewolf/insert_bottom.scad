use <../photo_base.scad>
use <../utilities.scad>

CHARACTER_WIDTH = 57;
CHARACTER_DEPTH = 78;
CHARACTER_HEIGHT = 2;

CHARACTER_STACK_COUNT = 14;

TOKEN_DIAMETER = 31;
TOKEN_HEIGHT = 2;

TOKEN_STACK_COUNT = 12;

THUMB_WIDTH = 18;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

total_character_height = CHARACTER_HEIGHT * CHARACTER_STACK_COUNT;
total_token_height = TOKEN_HEIGHT * TOKEN_STACK_COUNT;
insert_height = total_character_height + 1;

module token_cutout() {
    translate([0, TOKEN_DIAMETER / 2, insert_height - total_token_height])
    cylinder(h = total_token_height + render_helper, d = TOKEN_DIAMETER);
}

module token_cutouts() {
    offset_x = box_width() / 2;
    offset_y = quad_depth_offset(TOKEN_DIAMETER);
    
    translate([offset_x, offset_y, 0])
    token_cutout();
    
    translate([offset_x, offset_y * 2 + TOKEN_DIAMETER, 0])
    token_cutout();
    
    translate([offset_x, offset_y * 3 + TOKEN_DIAMETER * 2, 0])
    token_cutout();
    
    translate([
        box_width() / 2 + THUMB_WIDTH / 2,
        0,
        box_height() - total_token_height + 3
    ])
    rotate([0, 0, 90])
    thumb_slot(depth = THUMB_WIDTH);
}

module card_cutout() {
    translate([
        0,
        center_depth_offset(CHARACTER_DEPTH),
        insert_height - total_character_height
    ])
    card_slot(CHARACTER_WIDTH, CHARACTER_DEPTH, total_character_height);
}

module card_cutouts() {
    side_space = (box_width() - side_curve() * 2 - TOKEN_DIAMETER - CHARACTER_WIDTH * 2) / 4;
    
    translate([side_space + side_curve(), 0, 0])
    card_cutout();
    
    translate([box_width() - side_space - side_curve() - CHARACTER_WIDTH, 0, 0])
    card_cutout();
    
    translate([
        0,
        (box_depth() - THUMB_WIDTH) / 2,
        insert_height - total_character_height
    ])
    thumb_slot(height = insert_height, depth = THUMB_WIDTH);
}

difference() {    
    photo_base(insert_height);
    
    token_cutouts();
    card_cutouts();
}