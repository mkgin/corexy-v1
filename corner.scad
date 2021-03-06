// Bare corner parts for 'bottom' corners.
// Print 4
// (c) 2014, Christopher "ScribbleJ" Jansen
include <common.scad>

corner();

module display_corner()
{
  corner();
  translate([0,0,corner_thick])
  {
    // Display T-slot Reference
    // logic to determine what is vertical or
    // arguments to display corner...
    #cube([tslot_w,tslot_h,printer_l]);
    %cube([tslot_w,printer_l,tslot_h]);
    %cube([printer_l,tslot_w,tslot_h]);
  }
}

module corner()
{
  translate([0,0,corner_thick]) 
  {
    translate([0,0,-corner_thick]) linear_extrude(height=corner_thick) corner_part();
    mirror([0,1,0]) rotate([90,0,0])   translate([0,0,-corner_thick]) linear_extrude(height=corner_thick) corner_part();
    mirror([1,0,0]) rotate([0,-90,0])   translate([0,0,-corner_thick]) linear_extrude(height=corner_thick) corner_part();

  }
}

module corner_part()
{
  difference()
  {
    translate([-corner_thick,-corner_thick]) square([corner_thick+corner_length,corner_thick+corner_length]);
    translate([corner_length,tslot_w]) rotate(45) square([huge,huge]);
    for(d=[tslot_w*1.5:tslot_w:corner_length])
    {
      translate([d,tslot_w/2]) polycircle(r=tslot_bolt_r);
      translate([tslot_w/2,d]) polycircle(r=tslot_bolt_r);
    }


  }
}

module y_holder()
{
  z_rotation_y_holder = motor_mount_with_corner ? 30 : 0 ;
  part_width = bushing_r*2+bushing_material_thick*2;
//  if ( motor_mount_with_corner == true ) {z_rotation_y_holder = 30;}
//      else
//      z_rotation_y_holder = 0;
  difference()
  {
    union()
    {
      translate([-part_width/2,0,tslot_w+2]) cube([part_width,calc_corner_from_y_rod+corner_thick,tslot_w-2]);
      if ( motor_mount_with_corner )
      {
	   translate([0,part_width/2,tslot_w*2])//part_width/2])
	   rotate([0,0,90])	
	   #cube([part_width,calc_corner_from_y_rod+corner_thick,tslot_w-2]);

      }

      rotate ([0,0,z_rotation_y_holder])
      cylinder(r=part_width/2, h=tslot_w*2, $fn=6);
      translate([0,0,-corner_thick])
      rotate ([0,0,z_rotation_y_holder])
      cylinder(r=part_width/2, h=corner_thick, $fn=6);
    }
    
    translate([-huge/2,calc_corner_above_x + x_rod_sep/2 -tslot_w,-1]) cube([huge,tslot_w+1,tslot_w+1]);
    translate([calc_corner_from_y_rod - tslot_w,-huge/2,-1]) cube([tslot_w+1,huge,tslot_w+1]);
    translate([0,0,-1]) polyhole(r=rod_r,h=tslot_w*2+2,v=8,a=360/16);
  }
}
