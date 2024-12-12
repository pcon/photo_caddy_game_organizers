use <../utilities.scad>
use <../photo_base.scad>

TILE_WIDTH = 19;
TILE_DEPTH = 5;
TILE_PER_ROW = 18;
TOTAL_COLUMNS = 8;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

offset_z = box_height() - TILE_WIDTH;

module tile_slot() {
    slot_depth = TILE_DEPTH * TILE_PER_ROW;
    slot_width = TILE_WIDTH * TOTAL_COLUMNS;
    offset_x = (box_width() - slot_width) / 2;
    
    translate([offset_x, 0, offset_z])
    union() {
        translate([slot_width / 2, 0, TILE_WIDTH])
        rotate([-90, 0, 0])
        cylinder(h = box_depth(), d = TILE_WIDTH);
        
        translate([0, (box_depth() - slot_depth) / 2, 0])
        cube([slot_width, slot_depth, TILE_WIDTH + render_helper]);
    }
}

difference() {
    photo_base();
    tile_slot();
}