use <./photo_base.scad>
use <./roundedcube.scad>

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole
max_height = box_height() - 1;
THUMB_WIDTH = 25;

function thumb_slot_y() = (box_depth() - THUMB_WIDTH) / 2;

module card_slot(
    width = 63.5,
    depth = 88.5,
    height = 17,
    radius = 2
) {
    roundedcube(
        [width, depth, height + render_helper],
        radius = radius,
        apply_to = "z"
    );
}

module thumb_slot(
    width = box_width(),
    depth = THUMB_WIDTH,
    height = box_height(),
    slot_depth = undef
) {
    
    translate_y = slot_depth == undef ? 0 : slot_depth / 2 - THUMB_WIDTH / 2;
    
    translate([0, translate_y, 0])
    union() {
        translate([0, 0, depth / 2])
        cube([width, depth, height - depth / 2 + render_helper]);
        
        translate([0, depth / 2, depth / 2])
        rotate([0, 90, 0])
        cylinder(h = width, d = depth);
    }
}

module booklet_slot(width, depth, height) {
    cube([width, depth, height + render_helper]);
}

module two_card_holder(
    width = 63.5,
    depth = 88.5,
    height = 17,
    radius = 2,
    booklet = undef
) {
    height = height > box_height() ? max_height : height;
    total_height = booklet == undef ? height : height + booklet[2];
     
    
    difference() {
        photo_base();
        
        offset_z = booklet == undef ? box_height() - height : box_height() - total_height;
        translate([0, center_depth_offset(depth), offset_z])
        union() {
            translate([triple_width_offset(width), 0, 0])
            card_slot(width, depth, total_height, radius);
            
            translate([triple_width_offset(width) * 2 + width, 0, 0])
            card_slot(width, depth, total_height, radius);
        }
        
        translate([0, center_depth_offset(THUMB_WIDTH), box_height() - total_height])
        thumb_slot(height = total_height);
        
        if (booklet != undef) {
            translate([center_width_offset(booklet[0]), center_depth_offset(booklet[1]), box_height() - booklet[2]])
            booklet_slot(booklet[0], booklet[1], booklet[2]);
        }
    }
}