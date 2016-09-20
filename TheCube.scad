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
translate([0,0,30]){
    smoothRing(3.75) translate([0,0,0.5]) face();
    translate([0,0,-5])trackBall();
}

rotate([0,90,0]) translate([0,0,30]){
    rocker();
}

difference(){
    minkowski(){
        cube(cubeSize-cubeBevel,true);
        sphere(d=cubeBevel);
    }

    translate([0,0,(cubeSize-faceThick+fudge)/2]) face();
    translate([0,0,-(cubeSize-faceThick+fudge)/2]) rotate([180,0,0]) face();
    
    translate([0,-(cubeSize-faceThick+fudge)/2,0]) rotate([90,0,0]) face();
    translate([0,(cubeSize-faceThick+fudge)/2,0]) rotate([90,0,180]) face();
    
    translate([-(cubeSize-faceThick+fudge)/2,0,0]) rotate([0,90,180]) face();
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
