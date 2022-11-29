wallThickness = 4;
pfThickness = 5;
scpOR = 60;

scape(wallThickness,pfThickness);
pedicel();
flagellum(wallThickness);
head_plate(scpOR,wallThickness,pfThickness);

//// Scape
module scape(wallThickness,pfThickness){

scpIR = scpOR - wallThickness; //Inner radius
scpHeight = 40;
scpHoleR = 2.5;
scpHoleTheta = 120;


union(){
    difference(){
        sphere(r = scpOR, $fn=200);
        translate([-scpOR,-scpOR,-scpOR*2]) cube([scpOR*2,scpOR*2,scpOR*2]);
        
        sphere(r = scpIR, $fn=200);
        translate([-scpOR,-scpOR,-scpOR*2]) cube([scpOR*2,scpOR*2,scpOR*2]);
        
        translate([-scpOR,-scpOR,scpHeight]) cube([scpOR*2,scpOR*2,scpOR*2]);
       
        rotate([90,0,0]) translate([0,scpHeight-30,0]) for (i=[0:3])
        rotate([0,scpHoleTheta*i,0]) translate([0,0,scpOR-5]) cylinder(h=wallThickness+10, r=scpHoleR, center = true, $fn=100);
    }
    
difference(){
        translate([0, 0,(scpHeight/2)-2]) cylinder(h=pfThickness, r1= scpIR+0.5, r2 = scpIR-1, center = false, $fn=200);
        translate([0, 0,(scpHeight/2)-3]) cylinder(h=pfThickness+2, r=30, center = false, $fn=200);
    }
}
}


//// Pedicel
module pedicel(){
pdlOR = 38;
pdlIR = pdlOR - wallThickness;
pdlHeight = 40;
pdlTopIR = pdlOR -11;
NledHoles = 10;
theta = 360/NledHoles;
ledHoleR = 1.6;
nPegs = 10;
pegR = 3;
pegTheta = theta;
pegHoleR = 1;

translate([0,0,64]) rotate([0,180,0])
union(){
    difference(){
        cylinder(h=pdlHeight, r=pdlOR, center=false, $fn=200);
        translate([0,0,5]) cylinder(h=pdlHeight-4, r=pdlIR, center=false, $fn=200);
        translate([0,0,-2]) cylinder(h=8, r=pdlTopIR, center=false, $fn=200); 
    translate([0,0,2.5])
        
    // slots
    union(){
        cube([65,8,6], center=true);
        rotate(36) cube([65,8,6], center=true);
        rotate(72) cube([65,8,6], center=true);
        rotate(108) cube([65,8,6], center=true);
        rotate(144) cube([65,8,6], center=true);
        }
        
    // holes for LED

    rotate([90,0,0]) translate([0,3,0]) for (i=[0:NledHoles])
        rotate([0,theta*i,0]) translate([0,0,pdlOR-5]) cylinder(h=wallThickness+10, r=ledHoleR, center = true, $fn=100);
    } 
    translate([0,0,15]) difference(){
    cylinder(h=5, r=pdlIR+0.5, center=true, $fn=200);
    cylinder(h=6, r=pdlOR-16, center=true, $fn=200);
}
difference(){
for (i=[0:nPegs])
        translate([(pdlTopIR+5)*cos(i*theta+18), (pdlTopIR+5)*sin(i*theta+18),-4]) cylinder(h=wallThickness+5, r=pegR, center = true, $fn=100);
rotate([90,0,0]) translate([0,-4,0]) for (i=[0:NledHoles])
        rotate([0,theta*i,0]) translate([0,0,pdlOR-5]) cylinder(h=wallThickness+10, r=pegHoleR, center = true, $fn=100);
}
}
}


  
////Flagellum
module flagellum(wallThickness){
NledHoles = 10;
flgBottomOR = 25;
flgBottomIR = flgBottomOR - wallThickness;
flgTopOR = flgBottomOR/5;
flgHeight = 120;
theta = 360/NledHoles;
pegHoleR = 1;

translate([0,0,120])
difference(){
union(){
    cylinder(h=flgHeight, r1=flgBottomOR, r2=5, center=true, $fn=200);
    translate([0,0,-58]) union(){
        cube([64,6,5], center=true);
        rotate(36) cube([64,6,5], center=true);
        rotate(72) cube([64,6,5], center=true);
        rotate(108) cube([64,6,5], center=true);
        rotate(144) cube([64,6,5], center=true);
    }
    
    }
    translate([0,0,-2]) cylinder(h=flgHeight-2, r1=20, r2=2, center=true, $fn=200);
    rotate([90,0,0]) translate([0,-50,0]) for (i=[0:NledHoles])
        rotate([0,theta*i,0]) translate([0,0,flgBottomOR]) cylinder(h=wallThickness+10, r=pegHoleR, center = true, $fn=100);
    
}
}

//
////Head plate
module head_plate(scpOR,wallThickness,pfThickness){
plateR = scpOR+10;
flapHeight = 40;
translate([0,0,-5]) union(){
    difference(){
    cylinder(h=pfThickness, r= plateR, center=true, $fn=200);
    rotate_extrude(convexity = 100)
        translate([scpOR-wallThickness/2, 3, 0])
        circle(r = wallThickness/2, $fn=300);
    }
    translate([0,0,flapHeight/2]) difference(){
intersection() {
	cylinder (h = flapHeight, r=plateR, center = true, $fn=100);
	sphere(r = plateR, $fn=200);
}
intersection() {
	cylinder (h = flapHeight+1, r=plateR-wallThickness, center = true, $fn=100);
	sphere(r = plateR-wallThickness, $fn=200);
}
union(){
translate([-plateR*cos(60),plateR*sin(60),0])rotate([0,0,120])  cube([flapHeight-5,flapHeight+40,flapHeight+1], center=true);
    translate([-plateR*cos(60),-plateR*sin(60),0])rotate([0,0,240]) cube([flapHeight-5,flapHeight+40,flapHeight+1], center=true);
translate([plateR,0,0])rotate([0,0,0]) cube([flapHeight-5,flapHeight+40,flapHeight+1], center=true);

}
}
}
}

