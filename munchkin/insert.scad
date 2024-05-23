use <../photo_base.scad>
use <../utilities.scad>
use <../roundedcube.scad>

CARD_WIDTH = 57;
CARD_DEPTH = 88;
CARD_HEIGHT = 25;

DIE_SIDE = 16.5;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

total_width = CARD_WIDTH * 2 + DIE_SIDE;
spacing = triple_width_offset_single(total_width);

module card_slots() {
    offset_y = center_depth_offset(CARD_DEPTH);
    offset_z = box_height() - CARD_HEIGHT;

    translate([spacing, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
    
    translate([spacing * 2 + CARD_WIDTH, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
    
    translate([0, thumb_slot_y(), offset_z])
    thumb_slot();
}

module die_cutout() {
    offset_x = box_width() - DIE_SIDE - spacing / 2;
    offset_y = center_depth_offset(CARD_DEPTH) + CARD_DEPTH - DIE_SIDE - 4;
    offset_z = box_height() - DIE_SIDE;
    
    translate([offset_x, offset_y, offset_z])
    union() {
        roundedcube(
            [DIE_SIDE, DIE_SIDE, DIE_SIDE + render_helper],
            radius = 2,
            apply_to = "z"
        );
        
        translate([DIE_SIDE / 2, 0, DIE_SIDE])
        sphere(d = DIE_SIDE);
        
        translate([DIE_SIDE / 2, DIE_SIDE, DIE_SIDE])
        sphere(d = DIE_SIDE);
    }
}

difference() {
    photo_base();
    
    card_slots();
    die_cutout();
}