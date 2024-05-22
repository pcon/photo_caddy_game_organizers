use <../photo_base.scad>
use <../utilities.scad>
use <../roundedcube.scad>

CARD_WIDTH = 71;
CARD_DEPTH = 96;
CARD_HEIGHT = 10;

BOOKLET_WIDTH = 71;
BOOKLET_DEPTH = 96;
BOOKLET_HEIGHT = 6;

DICE_LIP = 2;

D6_SIDE = 16.5;

D10_WIDTH = 28;
D10_DEPTH = 23;
D10_HEIGHT = 21;

TOKEN_LIP = 2;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

token_width = CARD_WIDTH - TOKEN_LIP * 2;
token_depth = CARD_DEPTH - TOKEN_LIP * 2;
token_height = box_height() - 1 - CARD_HEIGHT;

total_width = D6_SIDE * 4 + CARD_WIDTH;
spacing = triple_width_offset_single(total_width);

module card_spot() {
    offset_x = spacing;
    offset_y = center_depth_offset(CARD_DEPTH);
    offset_z = box_height() - CARD_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
    
    translate([0, thumb_slot_y(), box_height() - CARD_HEIGHT])
    thumb_slot(height = CARD_HEIGHT);
}

module d6_slot() {
    dice_total_width = D6_SIDE * 4;
    booklet_diff = BOOKLET_WIDTH - dice_total_width;
    offset_x = box_width() - spacing - BOOKLET_WIDTH + booklet_diff / 2;
    offset_y = center_depth_offset(BOOKLET_DEPTH) + DICE_LIP;
    offset_z = box_height() - BOOKLET_HEIGHT - D6_SIDE;
    
    translate([offset_x, offset_y, offset_z])
    union() {
        translate([0, dice_total_width - render_helper, 0])
        cube([D6_SIDE, D6_SIDE + render_helper, D6_SIDE + render_helper]);
        cube([dice_total_width, dice_total_width, D6_SIDE + render_helper]);
    }
}

module d10_slot() {
    offset_x = box_width() - spacing - DICE_LIP - D10_WIDTH;
    offset_y = box_depth() - center_depth_offset(BOOKLET_DEPTH) - DICE_LIP - D10_DEPTH;
    offset_z = box_height() - BOOKLET_HEIGHT - D10_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    cube([D10_WIDTH, D10_DEPTH, D10_HEIGHT + render_helper]);
}

module token_slot() {
    offset_x = spacing + TOKEN_LIP;
    offset_y = center_depth_offset(token_depth);
    offset_z = box_height() - CARD_HEIGHT - token_height;
    
    translate([offset_x, offset_y, offset_z])
    roundedcube(
        [token_width, token_depth, token_height + render_helper],
        radius = 4,
        apply_to = "zmin"
    );
}

module booklet_slot() {
    offset_x = box_width() - spacing - BOOKLET_WIDTH;
    offset_y = center_depth_offset(BOOKLET_DEPTH);
    offset_z = box_height() - BOOKLET_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    cube([BOOKLET_WIDTH, BOOKLET_DEPTH, BOOKLET_HEIGHT]);
}

difference() {
    photo_base(); 
    
    booklet_slot();
    d6_slot();
    d10_slot();
    
    card_spot();
    token_slot();
}