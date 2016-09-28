$fn=100;
translate([0,40,0]){
    trackBall(0.1);
translate([0,0,10]) color("red") smoothRing(3.75,5);
}
translate([-40,0,0]) rocker();
translate([-70,0,0]) rockerSmall();
translate([-90,0,0]) tactMini();
pushPenMecha(); //this costs a lot of computing power!
translate([40,0,0]) joyStick(0.1);
translate([0,-40,0]) screw15();



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
        if ($children) 
        difference(){
            children();
            translate([0,0,thick/2]) 
                cylinder(h=thick+fudge,r=holeRad+b,center=true);
        }

    }
}

module worryStone()
{
        scale([1,0.6,0.15]) sphere(12);
}

module trackBall(stencilFudge=0)
{
    fudge=0.1;
    
    color("lightgrey") sphere(d=5.5);//ball
    color("grey") rotate_extrude(convexity=10) //ring
        translate([0,0,5])
            polygon([[0,0],[3.75,0],[3.25,1],[0,1]]);
    difference(){
    union(){
        translate([0,0,-3.7/2]) cube([9+stencilFudge,9+stencilFudge,3.7+stencilFudge],true); //body
        
        //standoffs
        if (stencilFudge) {
            translate([-5+fudge/2,1.6,-1]) cube([1+fudge+stencilFudge,1+stencilFudge,2+stencilFudge],true);
            translate([-5+fudge/2,-1.6,-1]) cube([1+fudge+stencilFudge,1+stencilFudge,2+stencilFudge],true);
            translate([5+fudge/2,1.6,-1]) cube([1+fudge+stencilFudge,1+stencilFudge,2+stencilFudge],true);
            translate([5+fudge/2,-1.6,-1]) cube([1+fudge+stencilFudge,1+stencilFudge,2+stencilFudge],true);
        }
        else {
            translate([-5+fudge/2,1.6,-1.5]) cube([1+fudge,1,1],true);
            translate([-5+fudge/2,-1.6,-1.5]) cube([1+fudge,1,1],true);
            translate([5+fudge/2,1.6,-1.5]) cube([1+fudge,1,1],true);
            translate([5+fudge/2,-1.6,-1.5]) cube([1+fudge,1,1],true);
        }
    }
    translate([0,0,-3.7+0.5/2-fudge]) cube([6.9,6.9,0.5+fudge],true);
}
}

//PSP1000 like Joystick (19x19x9mm)
module joyStick(stencilFudge=0)
{
    fudge=0.1;
    
    union(){
        translate([0,0,-2.2])
            intersection(){ //body
                cube([18.6+stencilFudge,18.6+stencilFudge,4.4],true);
                rotate([0,0,45]) cube([20.7+stencilFudge,20.7+stencilFudge,4.4],true);
            }
        translate([0,0,0.5-fudge/2]) cylinder(h=1+fudge,d=18.2,center=true); //cylinder plate
        
        if (stencilFudge){
            
            difference(){ //left flange
                translate([-18.6/2+1,(18.6-3.4)/2,-(1.8+0.9)/2]) cube([8+stencilFudge,3.4+stencilFudge,0.9+1.8],true);
                translate([-(19.5+0.9)/2,(18.6-3.4)/2,-(1.8+0.9)/2]) cylinder(h=0.9+1.8+fudge,d=1.9-stencilFudge,center=true);
            }
             translate([18.6/2,18/2,-(1.8+0.9)/2]) 
            rotate([0,0,45])
                difference(){ //right flange
                    union(){
                        translate([-6/2,0,0]) cube([6+stencilFudge,4.1+stencilFudge,1.8+0.9],true);
                        cylinder(h=1.8+0.9,d=4.1+stencilFudge,center=true);
                    }
                    cylinder(h=1.8+0.9+fudge,d=1.9-stencilFudge,center=true); //drill
                }
        }
        else    {
        difference(){ //left flange
            translate([-18.6/2+1,(18.6-3.4)/2,-1.8-0.9/2]) cube([8,3.4,0.9],true);
            translate([-(19.5+0.9)/2,(18.6-3.4)/2,-1.8-0.9/2]) cylinder(h=0.9+fudge,d=1.9,center=true);
        }
         translate([18.6/2,18/2,-1.8-0.9/2]) 
            rotate([0,0,45])
                difference(){ //right flange
                    union(){
                        translate([-6/2,0,0]) cube([6,4.1,0.9],true);
                        cylinder(h=0.9,d=4.1,center=true);
                    }
                    cylinder(h=0.9+fudge,d=1.9,center=true); //drill
                }
    }
    
       
        translate([0,0,2.5])
            union(){ //TheKnob
                cylinder(h=1,d=11);
                translate([0,0,-2.5-fudge/2]) cylinder(h=2.5+fudge,d=4.9);
            }
    }    
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
    
    //dimensions lent from mega pen instructable (scaled to 20%)
    
    //common
    innerDia=0.2*25.4;
    outerDia=0.2*54.61;
    nudgeWdh=0.2*12.7;
    fudge=0.1;
    
    //inside (the inner part)
    insideLen=0.2*190.5;
    insideCamHgh=9;
    
    //pusher (the pusher knob)
    pusherLen=0.2*228.6;
    pusherCamHgh=0.2*85.781; echo("pCamh", pusherCamHgh);
    pusherDrillHgh=0.2*38.1;
    pusherNudgeAng=60; //60°
    
    
    cylinder(h=insideLen,d=innerDia); //shaft
    
    difference(){
        union(){
        for(i=[0:90:360]){ // four cams
        translate ([0,0,insideLen-1-insideCamHgh]) rotate([0,0,i])
            difference(){
                linear_extrude(height=insideCamHgh,center=false,convexity=10,twist=90,slices=100)
                //#translate([outerDia/2,0,0]) square([outerDia-innerDia,1],true);
                intersection(){
                    circle(d=outerDia);
                    square(outerDia/2+fudge);
                }   
                translate([0,0,-fudge/2]) rotate([0,0,-90]) cube([outerDia/2+fudge,outerDia/2+fudge,insideCamHgh+fudge]);    
            }
        }
        cylinder(h=insideLen-insideCamHgh-1,d=outerDia);//body
        }
        translate([0,0,(insideLen-fudge)/2]) cube([outerDia+fudge,nudgeWdh,insideLen],true);
    
    }
    
    //pusher
    color("red") translate([0,0,insideLen+pusherLen+fudge]) rotate([0,180,90])
        !union(){
            //cam Part
            translate([0,0,pusherLen-pusherCamHgh]){
                difference(){
                    camerator2(pusherCamHgh,outerDia);
                    translate([0,0,pusherCamHgh-pusherDrillHgh]) cylinder(h=pusherDrillHgh,d=innerDia+fudge);
                }
                cylinder(h=pusherCamHgh-pusherDrillHgh,d=innerDia+fudge); //the Drill
            }
            //body
            cylinder(h=pusherLen-pusherCamHgh,d=outerDia);
        }
        
    //shell
    translate() 
        %difference() {
            cylinder(h=pusherLen+insideLen,d=outerDia+2);
            translate([0,0,-fudge/2]) cylinder(h=pusherLen+insideLen+fudge,d=outerDia+fudge);
        }
    
}
module screw15()
{
    fudge=0.1;
    
    %translate([0,0,-5]) cylinder(h=5,d=1.5);//bolt
    %difference(){
        translate() cylinder(h=1.1,d=2.5);//head
        translate([0,0,0.35]) torx();
    }
    if ($children)
        difference(){
            children();
            cylinder(h=1.5,d=2.6); //cutout for head
            translate([0,0,-6]) cylinder(h=6,d=1);
        }
}

module torx()
{
    T=5;
    A=0.75;
    B=0.72*A; 
    re= 0.1*A*2;
    ri= 0.175*A*2;
    fudge=0.1;
    
difference(){
    cylinder(h=0.8,r=A);
    for(i=[0:60:360])
        rotate([0,0,i])translate([-B-ri,0,-fudge/2]) cylinder(h=0.8+fudge,r=ri);
        //intersection_for(n=[30:60:360])
            //  rotate([0,0,n]) translate([-A+re,0,0]) circle(re);
        }
              
}

module camerator2(camHgh, outerDia){
    fudge=0.1;
    
     for(i=[0:180:360]){ // two cams
        rotate([0,0,i])
            difference(){
                linear_extrude(height=camHgh,center=false,convexity=10,twist=180,$fn=400)
                //#translate([outerDia/2,0,0]) square([outerDia-innerDia,1],true);
        
                intersection(){ //half circle
                    circle(d=outerDia);
                    translate([-(outerDia)/2,0,0]) square(outerDia);
                }   
                
                translate([-(outerDia+fudge)/2,0,-fudge/2]) rotate([0,0,-90]) cube([outerDia/2,outerDia+fudge,camHgh+fudge]);    
            }
        }
}