$fn=100;
trackBall();
joyStick();

minkowski(){
    cube(45,center=true);
    sphere(5);
}

module trackBall()
{
    fudge=0.1;
    
    color("lightgrey") sphere(d=5.5);//ball
    color("grey") rotate_extrude(convexity=10) //ring
        translate([0,0,5])
            polygon([[0,0],[3.75,0],[3.25,1],[0,1]]);
    union(){
        translate([0,0,-1.5]) cube([9,9,3],true);
        //standoffs
        translate([-5+fudge/2,1.6,-1.5]) cube([1+fudge,1,1],true);
        translate([-5+fudge/2,-1.6,-1.5]) cube([1+fudge,1,1],true);
        translate([5+fudge/2,1.6,-1.5]) cube([1+fudge,1,1],true);
        translate([5+fudge/2,-1.6,-1.5]) cube([1+fudge,1,1],true);
    }
}

//PSP1000 like Joystick (19x19x9mm)
module joyStick()
{
    import("nub_base.stl");
    /*cylinder(h=2,d=11.3,center=true);
    cylinder(h=2,d=14.15,center=true);
    cylinder(h=2,d=18.1,center=true);
    */
}
