$fn=100;
trackBall();
joyStick();
color("red") smoothRing(3.75,5);
*minkowski(){
    cube(45,center=true);
    sphere(5);
}

module smoothRing(holeRad,bevelRad=2,thick=1,fudge=0.1){
//r²=(t-r)²+b²
b = sqrt(pow(bevelRad,2)-pow(bevelRad-thick,2));
echo(b);
    
//r²=(b/2)²+h²
echo(b);
h = sqrt(pow(bevelRad,2)-pow(b/2,2));
echo(h);
s = h-b/2;    
echo(s);



    
rotate_extrude(){
translate([-b-holeRad,0,0])
    union(){
        intersection(){
            square([b,1]);
            translate([0,-bevelRad+thick,0]) 
                circle(r=bevelRad);
        }
    translate([-fudge,0,0]) square([fudge,thick]);
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
