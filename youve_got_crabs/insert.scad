use <../photo_base.scad>
use <../utilities.scad>

CARD_WIDTH = 63.5;
CARD_DEPTH = 88.5;
CARD_HEIGHT = 13;
CARD_RADIUS = 2;

THUMB_WIDTH = 25;

LICENSE_WIDTH = 64;
LICENSE_DEPTH = 84;
LICENSE_HEIGHT = 7;
LICENSE_RADIUS = 2;

CRAB_WIDTH = 37.5;
CRAB_DEPTH = 30.5;
CRAB_HEIGHT = 2.5;

CRAB_PER_STACK_LOWER = 5;
CRAB_PER_STACK_UPPER = 9;

lower_crab_height = CRAB_HEIGHT * CRAB_PER_STACK_LOWER;
upper_crab_height = CRAB_HEIGHT * CRAB_PER_STACK_UPPER;
crab_stack_lower = box_height() - CARD_HEIGHT - lower_crab_height;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

module crab_slot_upper() {
    spacing = (CARD_DEPTH - CRAB_WIDTH * 2) / 3;
    
    offset_x_left = box_width() - side_curve() - CARD_DEPTH - 1 + spacing;
    offset_x_right = box_width() - side_curve() - CRAB_WIDTH - 1 - spacing;
    offset_y = box_depth() - top_curve() - CRAB_DEPTH - 1;
    offset_z = box_height() - upper_crab_height;
    
    translate([offset_x_left, offset_y, offset_z])
    card_slot(CRAB_WIDTH, CRAB_DEPTH, upper_crab_height);
    
    translate([offset_x_right, offset_y, offset_z])
    card_slot(CRAB_WIDTH, CRAB_DEPTH, upper_crab_height);
}

module crab_thumb_slot() {
    spacing = (CARD_DEPTH - CRAB_WIDTH * 2) / 3;
    
    offset_z = crab_stack_lower;
    offset_x_left = box_width() - side_curve() - CARD_DEPTH - 1 + spacing + CRAB_WIDTH / 2;
    offset_x_right = box_width() - side_curve() - CRAB_WIDTH - 1 - spacing + CRAB_WIDTH / 2;
    offset_y = center_depth_offset(CARD_DEPTH) + CARD_WIDTH - 1;
    
    translate([offset_x_left, offset_y, offset_z])
    cylinder(d = THUMB_WIDTH, h = box_height());
    
    translate([offset_x_right, offset_y, offset_z])
    cylinder(d = THUMB_WIDTH, h = box_height());
}

module crab_slot_lower() {
    spacing = (CARD_DEPTH - CRAB_WIDTH * 2) / 3;
    
    offset_x_left = box_width() - side_curve() - CARD_DEPTH - 1 + spacing;
    offset_x_right = box_width() - side_curve() - CRAB_WIDTH - 1 - spacing;
    offset_y = center_depth_offset(CARD_DEPTH) + CARD_WIDTH - CRAB_DEPTH - 1;
    offset_z = box_height() - CARD_HEIGHT - lower_crab_height;
    
    translate([offset_x_left, offset_y, offset_z])
    card_slot(CRAB_WIDTH, CRAB_DEPTH, upper_crab_height);
    
    translate([offset_x_right, offset_y, offset_z])
    card_slot(CRAB_WIDTH, CRAB_DEPTH, upper_crab_height);
}
module crab_slots() {
    union() {
        crab_slot_upper();
        crab_slot_lower();        
        crab_thumb_slot();
    }
}

module license_slot() {
    offset_x = side_curve() + 1 + (CARD_WIDTH - LICENSE_WIDTH) / 2;
    offset_z = box_height() - CARD_HEIGHT - LICENSE_HEIGHT;

    translate([offset_x, center_depth_offset(LICENSE_DEPTH), offset_z])
    card_slot(LICENSE_WIDTH, LICENSE_DEPTH, LICENSE_HEIGHT);
}

module card_slots() {
    total_card_width = CARD_WIDTH + CARD_DEPTH + side_curve() * 2;
    offset_x = side_curve() + 1;
    offset_y = center_depth_offset(CARD_DEPTH);
    offset_z = box_height() - CARD_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
    
    translate([
        box_width() - side_curve() - CARD_DEPTH - 1,
        offset_y,
        offset_z
    ])    
    card_slot(CARD_DEPTH, CARD_WIDTH, CARD_HEIGHT);
    
    translate([0, thumb_slot_y(), offset_z])
    thumb_slot();
}

difference() {
    photo_base();
    
    card_slots();
    
    crab_slots();
    
    license_slot();
}