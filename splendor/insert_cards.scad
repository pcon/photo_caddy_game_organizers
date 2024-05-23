use <../photo_base.scad>
use <../utilities.scad>

CARD_WIDTH = 64;
CARD_DEPTH = 89;
CARD_HEIGHT = 15;

TILE_WIDTH = 62;
TILE_DEPTH = 62;
TILE_HEIGHT = 9;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

tile_spacing = triple_width_offset(TILE_WIDTH);
card_spacing = triple_width_offset(CARD_WIDTH);

module card_cutout() {
    offset_y = center_depth_offset(CARD_DEPTH);
    offset_z = box_height() - CARD_HEIGHT;
    
    translate([card_spacing, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
    
    translate([card_spacing * 2 + CARD_WIDTH, offset_y, offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT);
}

module tile_cutout() {
    offset_y = center_depth_offset(TILE_DEPTH);
    offset_z = box_height() - TILE_HEIGHT - CARD_HEIGHT;
    
    translate([tile_spacing, offset_y, offset_z])
    card_slot(TILE_WIDTH, TILE_DEPTH, TILE_HEIGHT + CARD_HEIGHT + render_helper);
    
    translate([tile_spacing * 2 + TILE_WIDTH, offset_y, offset_z])
    card_slot(TILE_WIDTH, TILE_DEPTH, TILE_HEIGHT + CARD_HEIGHT + render_helper);
}

module thumb_cutout() {
    translate([0, thumb_slot_y(), box_height() - CARD_HEIGHT - TILE_HEIGHT])
    thumb_slot();
}

difference() {
    photo_base();
    
    thumb_cutout();
    card_cutout();
    tile_cutout();
}