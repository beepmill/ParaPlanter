resolution_high = 96;
resolution_low = 32;
epsilon = 0.01;
count_columns = 4;
count_rows = 4;
thickness_unit_wall = 2;
thickness_reservoir_wall = 3;
thickness_floor = 2;
thickness_unit_wall_spacer = 2; //Between pot and reservoir
width_unit_top = 60;
width_unit_base = 25;
height_unit_base = 20;
height_unit_funnel = 20;
height_unit_top = 40;
width_seep_hole = 2;
height_seep_hole = height_unit_base - thickness_floor - 4;
height_reservoir = height_unit_base + height_unit_funnel + height_unit_top; //Pot will be raised by floor of reservoir.
height_max_fill = height_unit_base + height_unit_funnel/2;

echo("X dim: ", count_columns * width_unit_top - thickness_unit_wall);
echo("Y dim: ", count_rows * width_unit_top - thickness_unit_wall);

radius_chamfer_unit_outer_bottom = 3;
radius_chamfer_unit_outer_top = radius_chamfer_unit_outer_bottom * width_unit_top/width_unit_base;
radius_chamfer_unit_inner_bottom = radius_chamfer_unit_outer_bottom - thickness_unit_wall/2;
radius_chamfer_unit_inner_top = radius_chamfer_unit_outer_top - thickness_unit_wall/2;
radius_chamfer_reservoir_outer = radius_chamfer_unit_outer_top + thickness_unit_wall_spacer + thickness_reservoir_wall;
radius_chamfer_reservoir_inner = radius_chamfer_unit_outer_top + thickness_unit_wall_spacer;

radius_drain_tube_outer = 4;
radius_drain_tube_inner = 2;

translate([0,0, thickness_floor])
    MultiUnit();
Reservoir();

module Reservoir()
    {
     color("OliveDrab")
     difference()
        {
         union()
            {
             hull() //Outside wall and floor
                {
                 //bottom left
                 translate([-(width_unit_top/2 - radius_chamfer_unit_outer_top),-(width_unit_top/2 - radius_chamfer_unit_outer_top),0])
                    cylinder(r = radius_chamfer_reservoir_outer, h = height_reservoir, $fn = resolution_high);
                 //top left
                 translate([-(width_unit_top/2 - radius_chamfer_unit_outer_top),
                    (width_unit_top * 0.5) + (count_rows - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    0])
                        cylinder(r = radius_chamfer_reservoir_outer, h = height_reservoir, $fn = resolution_high);
                 //top right
                 translate([
                    (width_unit_top * 0.5) + (count_columns - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    (width_unit_top * 0.5) + (count_rows - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    0])
                        cylinder(r = radius_chamfer_reservoir_outer, h = height_reservoir, $fn = resolution_high);
                 //bottom right
                 translate([
                    (width_unit_top * 0.5) + (count_columns - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    -(width_unit_top/2 - radius_chamfer_unit_outer_top),0])
                        cylinder(r = radius_chamfer_reservoir_outer, h = height_reservoir, $fn = resolution_high);
                }
             //Water funnel
             hull()
                {
                 translate([-width_unit_top * .85, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_reservoir, $fn = resolution_high);
                 translate([-width_unit_top * .85, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_reservoir, $fn = resolution_high);
                 translate([0, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_reservoir, $fn = resolution_high);
                 translate([0, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_reservoir, $fn = resolution_high);
                }
             //Water trap
             rotate([0,0,90])
             hull()
                {
                 translate([-width_unit_top * .85, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                 translate([-width_unit_top * .85, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                 translate([0, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                 translate([0, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                }
             //Drain tube
             translate([0,-(width_unit_top/2 + thickness_unit_wall),height_max_fill + radius_drain_tube_outer])
             rotate([90,0,0])
             cylinder(r = radius_drain_tube_outer, h = 7, $fn = resolution_low);
            }
         //Inside
         translate([0,0,thickness_floor])
            {
             hull()
                {
                 //bottom left
                 translate([-(width_unit_top/2 - radius_chamfer_unit_outer_top),-(width_unit_top/2 - radius_chamfer_unit_outer_top),0])
                    cylinder(r = radius_chamfer_reservoir_inner, h = height_reservoir, $fn = resolution_high);
                 //top left
                 translate([-(width_unit_top/2 - radius_chamfer_unit_outer_top),
                    (width_unit_top * 0.5) + (count_rows - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    0])
                        cylinder(r = radius_chamfer_reservoir_inner, h = height_reservoir, $fn = resolution_high);
                 //top right
                 translate([
                    (width_unit_top * 0.5) + (count_columns - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    (width_unit_top * 0.5) + (count_rows - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    0])
                        cylinder(r = radius_chamfer_reservoir_inner, h = height_reservoir, $fn = resolution_high);
                 //bottom right
                 translate([
                    (width_unit_top * 0.5) + (count_columns - 1) * (width_unit_top - thickness_unit_wall) - radius_chamfer_unit_outer_top,
                    -(width_unit_top/2 - radius_chamfer_unit_outer_top),0])
                        cylinder(r = radius_chamfer_reservoir_inner, h = height_reservoir, $fn = resolution_high);
                }
             //Water funnel
             hull()
                {
                 translate([-width_unit_top * .85, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_reservoir, $fn = resolution_high);
                 translate([-width_unit_top * .85, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_reservoir, $fn = resolution_high);
                 translate([-width_unit_top/2 - radius_chamfer_unit_outer_top - thickness_reservoir_wall, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_reservoir, $fn = resolution_high);
                 translate([-width_unit_top/2 - radius_chamfer_unit_outer_top - thickness_reservoir_wall, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_reservoir, $fn = resolution_high);
                }
             //Water funnel fill hole
             translate([-width_unit_top/2, 0, height_max_fill/2])
             rotate([0,-90,0])
                cylinder(r = min(height_max_fill*0.50, width_unit_top * .25), h = thickness_reservoir_wall*2.5, $fn = resolution_low);

             //Water trap
             rotate([0,0,90])
             hull()
                {
                 translate([-width_unit_top * .85, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                 translate([-width_unit_top * .85, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                 translate([-width_unit_top/2 - radius_chamfer_unit_outer_top - thickness_reservoir_wall, -width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                 translate([-width_unit_top/2 - radius_chamfer_unit_outer_top - thickness_reservoir_wall, +width_unit_top * 0.25,0])
                    cylinder(r = radius_chamfer_unit_outer_top - thickness_reservoir_wall, h = height_max_fill - radius_drain_tube_outer, $fn = resolution_high);
                }
             //Drain tube
             translate([0,-(width_unit_top/2 + thickness_unit_wall) +epsilon,height_max_fill + radius_drain_tube_inner])
             rotate([90,0,0])
             cylinder(r = radius_drain_tube_inner, h = 7 + 2*epsilon, $fn = resolution_low);
            }
        }
    }

module MultiUnit()
    {
     color("DarkSeaGreen")
     difference()
        {
         for (current_column = [1:1:count_columns])
            {
             for (current_row = [1:1:count_rows])
                {
                 translate([(current_column - 1)*(width_unit_top - thickness_unit_wall),
                    (current_row - 1)*(width_unit_top - thickness_unit_wall), 0])
                    {
                     Round_Pot_Unit();
                     //Fill spaces between units. "if ((b<5)&&(a>8))"
                     if ((current_column < count_columns)&&(current_row < count_rows))
                        {
                         translate([width_unit_top/2 - thickness_unit_wall/2,
                            width_unit_top/2 - thickness_unit_wall/2,
                            height_unit_base + height_unit_funnel])
                            cylinder(r = radius_chamfer_unit_outer_top/2, h = thickness_floor);
                        }
                    }
                }
            }
         translate([-width_unit_top/2 + radius_chamfer_unit_outer_top,
            -width_unit_top/2 + radius_chamfer_unit_outer_top,
            height_unit_base + height_unit_funnel + thickness_floor])
            cube([(count_columns * (width_unit_top - thickness_unit_wall)) - 2*radius_chamfer_unit_outer_top + thickness_unit_wall,
                (count_rows * (width_unit_top - thickness_unit_wall)) - 2*radius_chamfer_unit_outer_top + thickness_unit_wall,
                height_unit_top + epsilon]);
        }
    }

module Round_Pot_Unit()
    {
     difference()
        {
         union() //Outside of unit
            {
             //Base
             hull()
                {
                 translate([width_unit_base/2 - radius_chamfer_unit_outer_bottom, width_unit_base/2 - radius_chamfer_unit_outer_bottom, 0])
                    cylinder(r = radius_chamfer_unit_outer_bottom, h = height_unit_base, $fn = resolution_low);
                 translate([- (width_unit_base/2 - radius_chamfer_unit_outer_bottom), width_unit_base/2 - radius_chamfer_unit_outer_bottom, 0])
                    cylinder(r = radius_chamfer_unit_outer_bottom, h = height_unit_base, $fn = resolution_low);
                 translate([-(width_unit_base/2 - radius_chamfer_unit_outer_bottom), -(width_unit_base/2 - radius_chamfer_unit_outer_bottom), 0])
                    cylinder(r = radius_chamfer_unit_outer_bottom, h = height_unit_base, $fn = resolution_low);
                 translate([width_unit_base/2 - radius_chamfer_unit_outer_bottom, -(width_unit_base/2 - radius_chamfer_unit_outer_bottom), 0])
                    cylinder(r = radius_chamfer_unit_outer_bottom, h = height_unit_base, $fn = resolution_low);
                }
             //Funnel
             translate([0,0,height_unit_base])
             linear_extrude(height = height_unit_funnel, scale = width_unit_top/width_unit_base)
             hull()
                {
                 translate([width_unit_base/2 - radius_chamfer_unit_outer_bottom, width_unit_base/2 - radius_chamfer_unit_outer_bottom, 0])
                    circle(r = radius_chamfer_unit_outer_bottom, $fn = resolution_low);
                 translate([- (width_unit_base/2 - radius_chamfer_unit_outer_bottom), width_unit_base/2 - radius_chamfer_unit_outer_bottom, 0])
                    circle(r = radius_chamfer_unit_outer_bottom, $fn = resolution_low);
                 translate([-(width_unit_base/2 - radius_chamfer_unit_outer_bottom), -(width_unit_base/2 - radius_chamfer_unit_outer_bottom), 0])
                    circle(r = radius_chamfer_unit_outer_bottom, $fn = resolution_low);
                 translate([width_unit_base/2 - radius_chamfer_unit_outer_bottom, -(width_unit_base/2 - radius_chamfer_unit_outer_bottom), 0])
                    circle(r = radius_chamfer_unit_outer_bottom, $fn = resolution_low);
                }
             //Top
             translate([0,0, height_unit_base + height_unit_funnel])
             hull()
                {
                 translate([width_unit_top/2 - radius_chamfer_unit_outer_top, width_unit_top/2 - radius_chamfer_unit_outer_top, 0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_unit_top, $fn = resolution_low);
                 translate([- (width_unit_top/2 - radius_chamfer_unit_outer_top), width_unit_top/2 - radius_chamfer_unit_outer_top, 0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_unit_top, $fn = resolution_low);
                 translate([-(width_unit_top/2 - radius_chamfer_unit_outer_top), -(width_unit_top/2 - radius_chamfer_unit_outer_top), 0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_unit_top, $fn = resolution_low);
                 translate([width_unit_top/2 - radius_chamfer_unit_outer_top, -(width_unit_top/2 - radius_chamfer_unit_outer_top), 0])
                    cylinder(r = radius_chamfer_unit_outer_top, h = height_unit_top, $fn = resolution_low);
                }
            }
         translate([0,0,epsilon]) //Inside of unit___________________________________________________
         union()
            {
             //Base
             translate([0,0,thickness_floor])
             hull()
                {
                 translate([width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, 0])
                    cylinder(r = radius_chamfer_unit_inner_bottom, h = height_unit_base, $fn = resolution_low);
                 translate([- (width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, 0])
                    cylinder(r = radius_chamfer_unit_inner_bottom, h = height_unit_base, $fn = resolution_low);
                 translate([-(width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), -(width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), 0])
                    cylinder(r = radius_chamfer_unit_inner_bottom, h = height_unit_base, $fn = resolution_low);
                 translate([width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, -(width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), 0])
                    cylinder(r = radius_chamfer_unit_inner_bottom, h = height_unit_base, $fn = resolution_low);
                }
             //Funnel
             translate([0,0,height_unit_base])
             linear_extrude(height = height_unit_funnel + epsilon, scale = (width_unit_top - 2*thickness_unit_wall)/(width_unit_base - 2*thickness_unit_wall))
             hull()
                {
                 translate([width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, 0])
                    circle(r = radius_chamfer_unit_inner_bottom, $fn = resolution_low);
                 translate([- (width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, 0])
                    circle(r = radius_chamfer_unit_inner_bottom, $fn = resolution_low);
                 translate([-(width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), -(width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), 0])
                    circle(r = radius_chamfer_unit_inner_bottom, $fn = resolution_low);
                 translate([width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall, -(width_unit_base/2 - radius_chamfer_unit_inner_bottom - thickness_unit_wall), 0])
                    circle(r = radius_chamfer_unit_inner_bottom, $fn = resolution_low);
                }
             //Top
             translate([0,0, height_unit_base + height_unit_funnel])
             hull()
                {
                 translate([width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall, width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall, 0])
                    cylinder(r = radius_chamfer_unit_inner_top, h = height_unit_top + epsilon, $fn = resolution_low);
                 translate([- (width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall), width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall, 0])
                    cylinder(r = radius_chamfer_unit_inner_top, h = height_unit_top + epsilon, $fn = resolution_low);
                 translate([-(width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall), -(width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall), 0])
                    cylinder(r = radius_chamfer_unit_inner_top, h = height_unit_top + epsilon, $fn = resolution_low);
                 translate([width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall, -(width_unit_top/2 - radius_chamfer_unit_inner_top - thickness_unit_wall), 0])
                    cylinder(r = radius_chamfer_unit_inner_top, h = height_unit_top + epsilon, $fn = resolution_low);
                }
            }

        //Seep holes____________________________________________________________________
         translate([-width_unit_base,-width_seep_hole/2,thickness_floor + 2])
            cube([2*width_unit_base,width_seep_hole,height_seep_hole]);
         rotate([0,0,90])
         translate([-width_unit_base,-width_seep_hole/2,thickness_floor + 2])
            cube([2*width_unit_base,width_seep_hole,height_seep_hole]);

        //Air holes_____________________________________________________________________
         //translate([0,0,height_unit_base + height_unit_funnel - 5]) //height_max_fill
         translate([0,0,height_max_fill + 2.5]) //height_max_fill
            {
             rotate([0,90,0])
             translate([0,0,-width_unit_top/2])
                {
                 cylinder(r = 1.5, h = width_unit_top, $fn = 16);
                 translate([0, width_unit_top/4,0])
                    cylinder(r = 1.5, h = width_unit_top, $fn = 16);
                 translate([0, -width_unit_top/4,0])
                    cylinder(r = 1.5, h = width_unit_top, $fn = 16);
                }
             rotate([0,90,90])
             translate([0,0,-width_unit_top/2])
                {
                 cylinder(r = 1.5, h = width_unit_top, $fn = 16);
                 translate([0, width_unit_top/4,0])
                    cylinder(r = 1.5, h = width_unit_top, $fn = 16);
                 translate([0, -width_unit_top/4,0])
                    cylinder(r = 1.5, h = width_unit_top, $fn = 16);
                }
            }
        }
    }


