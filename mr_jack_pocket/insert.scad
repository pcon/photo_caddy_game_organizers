use <../photo_base.scad>
use <../utilities.scad>

TILE_HEIGHT = 1.75;

BOOK_HEIGHT = 3;

function tile_h(count) = count * TILE_HEIGHT;

AREA_WIDTH = 85.5;
AREA_DEPTH = 85.5;
AREA_COUNT = 9;
AREA_HEIGHT = tile_h(AREA_COUNT);

ACTION_TOKEN_DIAMETER = 41.5;
ACTION_TOKEN_RADIUS = ACTION_TOKEN_DIAMETER / 2;
ACTION_TOKEN_COUNT = 4;
ACTION_TOKEN_HEIGHT = tile_h(ACTION_TOKEN_COUNT);

DETECTIVE_TOKEN_DIAMETER = 33.5;
DETECTIVE_TOKEN_RADIUS = DETECTIVE_TOKEN_DIAMETER / 2;
DETECTIVE_TOKEN_COUNT = 3;
DETECTIVE_TOKEN_HEIGHT = tile_h(DETECTIVE_TOKEN_COUNT);

TIME_TOKEN_DIAMETER = 27.5;
TIME_TOKEN_RADIUS = TIME_TOKEN_DIAMETER / 2;
TIME_TOKEN_COUNT = 8;
TIME_TOKEN_HEIGHT = tile_h(TIME_TOKEN_COUNT);

ALIBI_DEPTH = 85.5;
ALIBI_WIDTH = 51.5;
ALIBI_COUNT = 9;
ALIBI_HEIGHT = tile_h(ALIBI_COUNT);

render_helper = 1; // Helps the quick render not have a "skin" on top of the hole
top_offset = triple_width_offset_single(AREA_WIDTH + ALIBI_WIDTH);
total_height = TIME_TOKEN_HEIGHT  + AREA_HEIGHT;

echo(total_height=total_height);
echo(TIME_TOKEN_HEIGHT=TIME_TOKEN_HEIGHT);

module alibi_slot() {
    offset_x = top_offset;
    offset_y = center_depth_offset(ALIBI_DEPTH);
    offset_z = box_height() - ALIBI_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    card_slot(ALIBI_WIDTH, ALIBI_DEPTH, ALIBI_HEIGHT);
}

module detective_slot() {
    offset_x = DETECTIVE_TOKEN_RADIUS;
    offset_y = DETECTIVE_TOKEN_RADIUS + DETECTIVE_TOKEN_RADIUS / 2;
    offset_z = box_height() - AREA_HEIGHT - DETECTIVE_TOKEN_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    union() {
        translate([0, -DETECTIVE_TOKEN_RADIUS, 3])
        union() {
            cylinder(
                h = DETECTIVE_TOKEN_HEIGHT + render_helper,
                d = ACTION_TOKEN_RADIUS
            );
            sphere(d = ACTION_TOKEN_RADIUS);
        }
        
        cylinder(
            h = DETECTIVE_TOKEN_HEIGHT + render_helper,
            d = DETECTIVE_TOKEN_DIAMETER
        );
        
        translate([0, DETECTIVE_TOKEN_RADIUS, 3])
        union() {
            cylinder(
                h = DETECTIVE_TOKEN_HEIGHT + render_helper,
                d = ACTION_TOKEN_RADIUS
            );
            sphere(d = ACTION_TOKEN_RADIUS);
        }
    }
}

module action_slot() {
    offset_x = ACTION_TOKEN_RADIUS;
    offset_y = ACTION_TOKEN_RADIUS + ACTION_TOKEN_RADIUS / 2;
    offset_z = box_height() - AREA_HEIGHT - ACTION_TOKEN_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    union() {
        translate([0, -ACTION_TOKEN_RADIUS, 3])
        union() {
            cylinder(
                h = ACTION_TOKEN_HEIGHT + render_helper,
                d = ACTION_TOKEN_RADIUS
            );
            sphere(d = ACTION_TOKEN_RADIUS);
        }
        
        cylinder(
            h = ACTION_TOKEN_HEIGHT + render_helper,
            d = ACTION_TOKEN_DIAMETER
        );
        
        translate([0, ACTION_TOKEN_RADIUS, 3])
        union() {
            cylinder(
                h = ACTION_TOKEN_HEIGHT + render_helper,
                d = ACTION_TOKEN_RADIUS
            );
            sphere(d = ACTION_TOKEN_RADIUS);
        }
    }
}

module detective_action_slots() {
    token_offset = (AREA_WIDTH - ACTION_TOKEN_DIAMETER - DETECTIVE_TOKEN_DIAMETER) / 3;
    
    offset_x = top_offset * 2 + ALIBI_WIDTH;;
    offset_y = center_depth_offset(AREA_DEPTH) + (AREA_DEPTH - ACTION_TOKEN_DIAMETER - ACTION_TOKEN_RADIUS) / 2;
    offset_z = 0;
    
    translate([offset_x, offset_y, offset_z])
    union() {
        translate([
            token_offset,
            (ACTION_TOKEN_RADIUS + ACTION_TOKEN_DIAMETER - DETECTIVE_TOKEN_DIAMETER - DETECTIVE_TOKEN_RADIUS) / 2,
            0
        ])
        detective_slot();
        
        translate([token_offset * 2 + DETECTIVE_TOKEN_DIAMETER, 0, 0])
        action_slot();
    }
}

module time_slot() {
    time_slot_depth = TIME_TOKEN_DIAMETER * 2 + TIME_TOKEN_RADIUS;
    time_slot_height = TIME_TOKEN_HEIGHT / 2;
    
    offset_x = top_offset + (ALIBI_WIDTH - TIME_TOKEN_DIAMETER) / 2;
    offset_y = TIME_TOKEN_RADIUS / 2 + center_depth_offset(ALIBI_DEPTH) + (ALIBI_DEPTH - time_slot_depth) / 2;
    offset_z = box_height() - ALIBI_HEIGHT - time_slot_height;
    
    translate([offset_x, offset_y, offset_z])
    union() {
        translate([TIME_TOKEN_RADIUS, 0, 1])
        union() {
            cylinder(h = time_slot_height + render_helper, d = TIME_TOKEN_RADIUS);
            sphere(d = TIME_TOKEN_RADIUS);
        }
        
        translate([TIME_TOKEN_RADIUS, TIME_TOKEN_RADIUS, 0])
        cylinder(h = time_slot_height + render_helper, d = TIME_TOKEN_DIAMETER);
        
        
        translate([TIME_TOKEN_RADIUS, TIME_TOKEN_DIAMETER, 1])
        union() {
            cylinder(h = time_slot_height + render_helper, d = TIME_TOKEN_RADIUS);
            sphere(d = TIME_TOKEN_RADIUS);
        }
        
        translate([TIME_TOKEN_RADIUS, TIME_TOKEN_RADIUS + TIME_TOKEN_DIAMETER, 0])
        cylinder(h = time_slot_height + render_helper, d = TIME_TOKEN_DIAMETER);
        
        translate([TIME_TOKEN_RADIUS, TIME_TOKEN_DIAMETER * 2, 1])
        union() {
            cylinder(h = time_slot_height + render_helper, d = TIME_TOKEN_RADIUS);
            sphere(d = TIME_TOKEN_RADIUS);
        }
    }
}

module area_slot() {
    offset_x = top_offset * 2 + ALIBI_WIDTH;
    offset_y = center_depth_offset(AREA_DEPTH);
    offset_z = box_height() - AREA_HEIGHT;
    
    translate([offset_x, offset_y, offset_z])
    cube([AREA_WIDTH, AREA_DEPTH, AREA_HEIGHT + render_helper]);
}

module thumb_cutout() {
    translate([0, thumb_slot_y(), box_height() - AREA_HEIGHT])
    thumb_slot();
}

difference() {    
    photo_base();
    
    alibi_slot();
    area_slot();
    time_slot();
    
    detective_action_slots();
    
    thumb_cutout();
}