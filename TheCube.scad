$fn=100;

use <FidgetCubeParts.scad>

cubeSize=1.3*25.4; //original is 1.3" --> in mm
echo(cubeSize/2);
cubeBevel=5;

faceSize=cubeSize*0.8;
echo(faceSize/2);
faceBevel=cubeBevel*0.8;
faceThick=1;

fudge=0.1;

// Top
translate([0,0,30]){
    translate([ -10.61, -10.39, 0 ])
        screw15()
            translate([ 10.61, 10.39, -0.2 ])
                smoothRing(3.75) 
                    translate([0,0,0.5]) face();
    
    translate([0,0,-3]) trackBall();
    translate([0,0,-9]) tactMini();
    
}

//bottom
translate([0,0,-30]){
    worryStone();
}

// right
rotate([0,90,0]) translate([0,0,30]){
    rockerSmall();
    translate([0,0,10]) difference(){
        face();
        cube([21+fudge,15+fudge,faceThick+fudge],true); 
    }
}

// left
rotate([0,-90,0]) translate([0,0,30]){
    color ("grey") rotate([0,0,180]) joyStick();
    translate([0,0,+5])
    difference(){
        face();
        cylinder(h=1+fudge,d=18.2+fudge,center=true);
    }
}


difference(){
    //body
    minkowski(){
        cube(cubeSize-cubeBevel,true);
        sphere(d=cubeBevel);
    }
    
    //top and bottom
    translate([0,0,(cubeSize-faceThick+fudge)/2]){
        face();
        translate([0,0,-0.4]) trackBall(0.1);
    }
    translate([0,0,-cubeSize/2-fudge*2]) worryStone();
    
    //front and back
    translate([0,-(cubeSize-faceThick+fudge)/2,0]) rotate([90,0,0]) face();
    translate([0,(cubeSize-faceThick+fudge)/2,0]) rotate([90,0,180]) face();
    
    //left and right
    translate([-(cubeSize-faceThick+fudge)/2,0,0]) rotate([0,90,180]) {
        face();
        translate([0,0,-0.4]) joyStick(0.1);
    }
    
    
    translate([(cubeSize-faceThick+fudge)/2,0,0]) rotate([0,90,0]) face();
    
    //cube(7,true);
}

module face(thick=1)
{
    extrHeight=cubeSize/2-faceThick*2;
    
    //union(){
        minkowski(){
            cube([faceSize-faceBevel,faceSize-faceBevel,faceThick/2],true);
            cylinder(h=faceThick/2,d=faceBevel,center=true);
        }
        *translate([0,0,(-extrHeight-faceThick)/2]) rotate([180,0,0])
            linear_extrude(height=extrHeight,center=true,scale=0.06) 
                minkowski(){
                    square(faceSize-faceBevel-2, center=true);
                    circle(d=faceBevel/2);
                }
         //   }
}
