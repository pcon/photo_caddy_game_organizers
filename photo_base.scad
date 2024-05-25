use <./roundedcube.scad>

BOX_WIDTH = 161;
BOX_DEPTH = 108;
BOX_HEIGHT = 26;

BOX_RADIUS = 2.25;

LABEL_WIDTH = BOX_WIDTH - BOX_RADIUS * 2;
LABEL_DEPTH = 2.5;

SIDE_CURVE_DEPTH = 20;
SIDE_CURVE_DIAMETER = 5;
SIDE_INNER_DEPTH = 37.5;

// total = 48.5
TOP_CURVE_WIDTH = 15;
TOP_CURVE_DIAMETER = 5;
TOP_INNER_WIDTH = 46;

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole

function box_width() = BOX_WIDTH;
function box_depth() = BOX_DEPTH;
function box_height() = BOX_HEIGHT;
function side_curve() = SIDE_CURVE_DIAMETER / 2;
function top_curve() = TOP_CURVE_DIAMETER / 2;
function label_depth() = LABEL_DEPTH;
function center_width_offset(width) = (BOX_WIDTH - width) / 2;
function triple_width_offset(width) = (BOX_WIDTH - width * 2) / 3;
function triple_width_offset_single(width) = (BOX_WIDTH - width) / 3;
function quad_width_offset_single(width) = (BOX_WIDTH - width) / 4;
function center_depth_offset(depth) = (BOX_DEPTH - depth) / 2;
function triple_depth_offset(depth) = (BOX_DEPTH - depth * 2) / 3;
function triple_depth_offset_single(depth) = (BOX_DEPTH - depth) / 3;
function quad_depth_offset(depth) = (BOX_DEPTH - depth * 3) / 4;
function quad_depth_offset_single(depth) = (BOX_DEPTH - depth) / 4;

module base_block(height) {
    roundedcube(
        [BOX_WIDTH, BOX_DEPTH, height],
        radius = BOX_RADIUS,
        apply_to = "zmax"
    );
}

module label_cutout(height) {
    offset_x = (BOX_WIDTH - LABEL_WIDTH) / 2;
    translate([offset_x, -render_helper, -render_helper])
    cube([LABEL_WIDTH, LABEL_DEPTH + render_helper, height + render_helper * 2]);
}

module side_cutout(height) {
    height = height + render_helper * 2;
    half_side = SIDE_INNER_DEPTH / 2;
    
    translate([0, half_side, -render_helper])
    linear_extrude(height)
    resize([SIDE_CURVE_DIAMETER, SIDE_CURVE_DEPTH])
    circle(SIDE_CURVE_DIAMETER, $fn = 40);
    
    translate([-SIDE_CURVE_DIAMETER / 2, -half_side, -render_helper])
    cube([SIDE_CURVE_DIAMETER, SIDE_INNER_DEPTH, height]);
    
    translate([0, -half_side, -render_helper])
    linear_extrude(height)
    resize([SIDE_CURVE_DIAMETER, SIDE_CURVE_DEPTH])
    circle(SIDE_CURVE_DIAMETER, $fn = 40);
}

module side_cutouts(height) {
    translate([0, BOX_DEPTH / 2, 0])
    side_cutout(height);
    
    translate([BOX_WIDTH, BOX_DEPTH / 2, 0])
    side_cutout(height);
}

module top_cutout(height) {
    height = height + render_helper * 2;
    half_side = TOP_INNER_WIDTH / 2;
    
    translate([BOX_WIDTH / 2, BOX_DEPTH, 0])
    union() {
        translate([half_side, 0, -render_helper])
        linear_extrude(height)
        rotate([0, 0, 90])
        resize([TOP_CURVE_DIAMETER, TOP_CURVE_WIDTH])
        circle(TOP_CURVE_DIAMETER, $fn = 40);
        
        translate([-half_side, -TOP_CURVE_DIAMETER / 2, -render_helper])
        cube([TOP_INNER_WIDTH, TOP_CURVE_DIAMETER, height]);
        
        translate([-half_side, 0, -render_helper])
        linear_extrude(height)
        rotate([0, 0, 90])
        resize([TOP_CURVE_DIAMETER, TOP_CURVE_WIDTH])
        circle(TOP_CURVE_DIAMETER, $fn = 40);
    }
}

module photo_base(height = BOX_HEIGHT) {
    difference() {
        base_block(height);
        label_cutout(height);
        side_cutouts(height);
        top_cutout(height);
    }
}

photo_base();
