use <../utilities.scad>
use <../photo_base.scad>

CARD_WIDTH = 65;
CARD_DEPTH = 90;
CARD_HEIGHT = 8.5;

TOKEN_DIAMETER = 25;
TOKEN_STACK_HEIGHT = 13.5;
TOKEN_GAP = 5;

token_group_width = TOKEN_DIAMETER * 2 + TOKEN_GAP;
section_gap = (box_width() - token_group_width - CARD_WIDTH) / 3;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

module token_slot() {
    stack_offset_x = TOKEN_DIAMETER / 2;
    stack_offset_y = TOKEN_DIAMETER / 2;
    
    translate([stack_offset_x, stack_offset_y, 0])
    union() {
        thumb_width = (TOKEN_DIAMETER / 3) * 2;
        thumb_offset_x = 0;
        thumb_offset_y = -(box_depth() / 4);
        thumb_offset_z = box_height() - TOKEN_STACK_HEIGHT + thumb_width / 2;
        
        translate([thumb_offset_x, thumb_offset_y, thumb_offset_z])
        rotate([-90, 0, 0])
        cylinder(h = box_depth() / 2, d = thumb_width);
        
        stack_offset_z = box_height() - TOKEN_STACK_HEIGHT;
        
        translate([-thumb_width / 2, thumb_offset_y, stack_offset_z + thumb_width / 2])
        cube([thumb_width, box_depth() / 2, thumb_width / 2]);
        
        translate([0, 0, stack_offset_z])
        cylinder(h = TOKEN_STACK_HEIGHT, d = TOKEN_DIAMETER);
    }
}

module token_slot_group(offset_x, offset_y) {
    translate([offset_x, offset_y, 0])
    union() {
        token_slot();
        
        translate([TOKEN_DIAMETER + TOKEN_GAP, 0, 0])
        token_slot();
    }
}

module token_slot_upper() {
    offset_x = section_gap * 2 + CARD_WIDTH;
    offset_y = box_depth() - TOKEN_DIAMETER - (box_depth() / 2 - thumb_width() / 2 - TOKEN_DIAMETER) / 2;
    token_slot_group(offset_x, offset_y);
}

module token_slot_lower() {
    offset_x = section_gap * 2 + CARD_WIDTH;
    offset_y = (box_depth() / 2 - thumb_width() / 2 - TOKEN_DIAMETER) / 2;
    token_slot_group(offset_x, offset_y);
}

module token_slots() {
    token_slot_upper();
    token_slot_lower();
}

module cards() {
    offset_x = section_gap;
    offset_y = (box_depth() - CARD_DEPTH) / 2;
    offset_z = box_height() - CARD_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    card_slot(
        width = CARD_WIDTH,
        depth = CARD_DEPTH,
        height = CARD_HEIGHT + render_helper
    );
}

difference() {
    photo_base();
    
    translate([0, thumb_slot_y(), thumb_slot_z(CARD_HEIGHT)])
    thumb_slot(height = CARD_HEIGHT);
    
    cards();
    token_slots();
}