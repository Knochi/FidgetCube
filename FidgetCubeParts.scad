$fn=100;
translate([0,40,0]){
    trackBall();
translate([0,0,10]) color("red") smoothRing(3.75,5);
}
translate([-40,0,0]) rocker();
translate([-70,0,0]) rockerSmall();
translate([-90,0,0]) tactMini();
pushPenMecha();


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
    difference(){
    union(){
        translate([0,0,-3.7/2]) cube([9,9,3.7],true);
        //standoffs
        translate([-5+fudge/2,1.6,-1.5]) cube([1+fudge,1,1],true);
        translate([-5+fudge/2,-1.6,-1.5]) cube([1+fudge,1,1],true);
        translate([5+fudge/2,1.6,-1.5]) cube([1+fudge,1,1],true);
        translate([5+fudge/2,-1.6,-1.5]) cube([1+fudge,1,1],true);
    }
    translate([0,0,-3.7+0.5/2-fudge]) cube([6.9,6.9,0.5+fudge],true);
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

module switchSmall()
{
    cube([14.5,10.5,17],true);
}

module rockerSmall()
{
    translate([0,0,-10.5/2]) cube([18.8,12.9,10.5],true);
    translate([0,0,1]) cube([21,15,2],true);
    intersection(){
        difference(){
            translate([0,0,4.5/2+2]) cube([15,10,4.5],true);
            translate([8.3,0,19.6]) rotate([90,0,0]) cylinder(h=11,r=35/2,center=true);
            }
        translate([4.5,0,-2.5]) rotate([90,0,0]) cylinder(h=11,r=12,center=true);
        }
}

module tactMini()
{
    translate([0,0,-2.6/2]) cube([6.2,6.2,2.6],true);
    translate([0,0,0.9/2]) cylinder(h=0.9,d=2.9,center=true);
}

module pushPenMecha()
{
    innerDia=2*2.54;
    outerDia=2*5.461;
    insideLen=2*19.05;
    cylinder(h=insideLen,d=innerDia,center=true);
    linear_extrude(height=9,center=false,convexity=10,twist=90,slices=100)
        #translate([outerDia/2,0,0]) square([outerDia-innerDia,1],true);
}
