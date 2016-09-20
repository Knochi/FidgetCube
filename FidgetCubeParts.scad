$fn=100;
trackBall();
joyStick();
color("red") smoothRing(3.75,5);
translate([-50,0,0]) rocker();


*minkowski(){
    cube(45,center=true);
    sphere(5);
}

module smoothRing(holeRad,bevelRad=2,thick=1,fudge=0.1)
{
    //r²=(t-r)²+b²

    b = sqrt(pow(bevelRad,2)-pow(bevelRad-thick,2));

    union(){
        rotate_extrude(){
            translate([-b-holeRad,0,0])
                union(){
                    intersection(){
                        square([b,1]);
                        translate([0,-bevelRad+thick,0]) 
                            circle(r=bevelRad);
                    }
                    translate([-fudge,0,0]) 
                        square([fudge,thick]);
                }
        }
        difference(){
            children();
            translate([0,0,thick/2]) 
                cylinder(h=thick+fudge,r=holeRad+b,center=true);
        }

    }
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

//Marquardt 1838.7203
module rocker()
{
    translate([0,0,(10.6-2-3.6)/2]) cube([28,11.4,10.6-2-3.6],true);
    translate([0,0,1]) cube([33.2,11.4,2],true);
    translate([0,0,-11.2/2]) cube([27.2,11,11.2],true);
}
