use <../photo_base.scad>
use <../roundedcube.scad>

BOOK_WIDTH = 130;
BOOK_DEPTH = 91;
BOOK_HEIGHT = 2;

CARD_WIDTH = 64;
CARD_DEPTH = 91;
CARD_HEIGHT = 8;
CARD_RADIUS = 2;

THUMB_WIDTH = 20;

CUBES_WIDTH = 50;
CUBES_DEPTH = 20;
CUBES_HEIGHT = 15;
CUBES_RADIUS = 2;
CUBES_OFFSET = 5;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

module book_cutout() {
    translate([center_width_offset(BOOK_WIDTH), center_depth_offset(BOOK_DEPTH), box_height() - BOOK_HEIGHT])
    cube([BOOK_WIDTH, BOOK_DEPTH, BOOK_HEIGHT + render_helper]);
}

module cubes_cutout() {
    offset_y = center_depth_offset(CARD_DEPTH) + CUBES_OFFSET;
    offset_z = box_height() - BOOK_HEIGHT - CARD_HEIGHT - CUBES_HEIGHT;
    
    translate([center_width_offset(CUBES_WIDTH), offset_y, offset_z])
    roundedcube(
        [CUBES_WIDTH, CUBES_DEPTH, CUBES_HEIGHT + render_helper],
        radius = CUBES_RADIUS,
        apply_to = "zmin"
    );
}

module thumb_cutout() {
    translate([-THUMB_WIDTH / 4, 0, 0])      
    union() {
        cylinder(h = box_height() + render_helper, d = THUMB_WIDTH);
        sphere(d = THUMB_WIDTH);
        
        rotate([0, 90, 0])
        cylinder(h = THUMB_WIDTH / 2, d = THUMB_WIDTH);
        
        translate([0, -THUMB_WIDTH / 2, 0])
        cube([THUMB_WIDTH / 2, THUMB_WIDTH, box_height() + render_helper]);
        
        translate([THUMB_WIDTH / 2, 0, 0])
        union() {
            cylinder(h = box_height() + render_helper, d = THUMB_WIDTH);
            sphere(d = THUMB_WIDTH);
        }
    }
}

module thumb_cutouts() {
    translate([0, CARD_DEPTH / 2, 0])
    thumb_cutout();
    
    translate([CARD_WIDTH, CARD_DEPTH / 2, 0])
    thumb_cutout();
}

module card_cutout() {
    offset_x = center_width_offset(CARD_WIDTH);
    offset_z = box_height() - BOOK_HEIGHT - CARD_HEIGHT;
    
    translate([offset_x, center_depth_offset(CARD_DEPTH), offset_z])
    union() {
        roundedcube(
            [CARD_WIDTH, CARD_DEPTH, CARD_HEIGHT + render_helper],
            radius = CARD_RADIUS,
            apply_to = "z"
        );
        thumb_cutouts();
    }
}

difference() {
    photo_base();
    book_cutout();
    card_cutout();
    cubes_cutout();
}