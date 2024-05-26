use <../photo_base.scad>
use <../utilities.scad>
use <../roundedcube.scad>

CHARACTER_AND_PAD_WIDTH = 128;
CHARACTER_AND_PAD_DEPTH = 91;
CHARACTER_AND_PAD_HEIGHT = 7;

CARD_WIDTH = 64;
CARD_DEPTH = 89;
CARD_HEIGHT = 9.25;

DIE_SIDE = 13;
LEFT_DIE_COUNT_DEPTH = 6;
LEFT_DIE_COUNT_WIDTH = 5;
RIGHT_DIE_COUNT_DEPTH = 6;
RIGHT_DIE_COUNT_WIDTH = 1;

POTION_WIDTH = 50;
POTION_DEPTH = 20;
POTION_HEIGHT = 10;

DAMAGE_WIDTH = 50;
DAMAGE_DEPTH = 63;
DAMAGE_HEIGHT = 10;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole
insert_height = CHARACTER_AND_PAD_HEIGHT + CARD_HEIGHT + DIE_SIDE;

module dice_cutout() {
    left_die_width = DIE_SIDE * LEFT_DIE_COUNT_WIDTH;
    left_die_depth = DIE_SIDE * LEFT_DIE_COUNT_DEPTH;
    
    offset_x = triple_width_offset(CARD_WIDTH) + (CARD_WIDTH - left_die_width) / 2;
    offset_y = center_depth_offset(left_die_depth);
    
    translate([offset_x, offset_y, -render_helper])
    roundedcube(
        [
            left_die_width,
            left_die_depth,
            DIE_SIDE + render_helper * 2
        ],
        radius = 2,
        apply_to = "z"
    );
}

module damge_cutout() {
    offset_x = triple_width_offset(CARD_WIDTH) * 2 + CARD_WIDTH + (CARD_WIDTH - DAMAGE_WIDTH) / 2;
    offset_y = center_depth_offset(CARD_DEPTH) + 2;
    offset_z = insert_height - CHARACTER_AND_PAD_HEIGHT - CARD_HEIGHT - DAMAGE_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    roundedcube(
        [
            DAMAGE_WIDTH,
            DAMAGE_DEPTH,
            DAMAGE_HEIGHT + render_helper
        ],
        radius = 4,
        apply_to = "zmin"
    );
}

module potion_cutout() {
    offset_x = triple_width_offset(CARD_WIDTH) * 2 + CARD_WIDTH + (CARD_WIDTH - POTION_WIDTH) / 2;
    offset_y = box_depth() - center_depth_offset(CARD_DEPTH) - POTION_DEPTH - 2;
    offset_z = insert_height - CHARACTER_AND_PAD_HEIGHT - CARD_HEIGHT - POTION_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    roundedcube(
        [
            POTION_WIDTH,
            POTION_DEPTH,
            POTION_HEIGHT + render_helper
        ],
        radius = 4,
        apply_to = "zmin"
    );
}

module card_cutout() {
    slot_height = CHARACTER_AND_PAD_HEIGHT + CARD_HEIGHT;
    offset_x = triple_width_offset(CARD_WIDTH);
    offset_z = insert_height - slot_height;
    
    translate([offset_x, center_depth_offset(CARD_DEPTH), offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, slot_height + render_helper);
    
    translate([offset_x * 2 + CARD_WIDTH, center_depth_offset(CARD_DEPTH), offset_z])
    card_slot(CARD_WIDTH, CARD_DEPTH, slot_height + render_helper);
}

module thumb_cutout() { 
    translate([0, thumb_slot_y(), insert_height - CHARACTER_AND_PAD_HEIGHT - CARD_HEIGHT])
    thumb_slot();
}

module character_and_pad_cutout() {
    offset_x = center_width_offset(CHARACTER_AND_PAD_WIDTH);
    offset_y = center_depth_offset(CHARACTER_AND_PAD_DEPTH);
    offset_z = insert_height - CHARACTER_AND_PAD_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    card_slot(
        CHARACTER_AND_PAD_WIDTH,
        CHARACTER_AND_PAD_DEPTH,
        CHARACTER_AND_PAD_HEIGHT + render_helper
    );
}

difference() {    
    photo_base(insert_height);

    character_and_pad_cutout();
    card_cutout();
    thumb_cutout();
    dice_cutout();
    damge_cutout();
    potion_cutout();
}