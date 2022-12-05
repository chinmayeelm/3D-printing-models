wallThickness = 4;
pfThickness = 4; //5;

//Scape specifications
scpOR = 50; //60;
scpIR = scpOR - wallThickness; //Inner radius
scpHeight = 35; //40;
scpHoleR = 2.5;
scpHoleTheta = 120;

//Pedicel specification
pdlOR = 28;
pdlIR = pdlOR - wallThickness;
pdlHeight = 30;
pdlTopIR = pdlOR -11;
NledHoles = 10;
pdlHoleTheta = 360/NledHoles;
ledHoleR = 1.6;
nPegs = 10;
pegR = 2;
pegTheta = pdlHoleTheta;
pegHoleR = 1;

//Flagellum specifications
flgBottomOR = 15;
flgBottomIR = flgBottomOR - wallThickness;
flgTopOR = flgBottomOR/5;
flgHeight = 100;
flgHoleTheta = 360/NledHoles;

//Head plate specifications
plateR = scpOR+10;
flapHeight = scpHeight-5;


//scape(wallThickness,pfThickness, scpOR, scpIR, scpHeight, scpHoleR, scpHoleTheta);
pedicel(wallThickness,pfThickness,pdlOR, pdlIR, pdlHeight, pdlTopIR, NledHoles, pdlHoleTheta, ledHoleR, nPegs, pegR, pegTheta, pegHoleR);
//flagellum(wallThickness,pfThickness,NledHoles,flgBottomOR,flgBottomIR,flgTopOR,flgHeight,flgHoleTheta,pegHoleR);
//head_plate(wallThickness,pfThickness, plateR, flapHeight);

//// Scape
module scape(wallThickness,pfThickness, scpOR, scpIR, scpHeight, scpHoleR, scpHoleTheta){




union(){
    difference(){
        sphere(r = scpOR, $fn=200);
        translate([-scpOR,-scpOR,-scpOR*2]) cube([scpOR*2,scpOR*2,scpOR*2]);
        
        sphere(r = scpIR, $fn=200);
        translate([-scpOR,-scpOR,-scpOR*2]) cube([scpOR*2,scpOR*2,scpOR*2]);
        
        translate([-scpOR,-scpOR,scpHeight]) cube([scpOR*2,scpOR*2,scpOR*2]);
       
        rotate([90,0,0]) translate([0,scpHeight-23,0]) for (i=[0:3])
        rotate([0,scpHoleTheta*i,0]) translate([0,0,scpOR-5]) cylinder(h=wallThickness+10, r=scpHoleR, center = true, $fn=100);
    }
    
difference(){
        translate([0, 0,(scpHeight/2)-2]) cylinder(h=pfThickness, r1= scpIR+0.5, r2 = scpIR-1, center = false, $fn=200);
        translate([0, 0,(scpHeight/2)-3]) cylinder(h=pfThickness+2, r=30, center = false, $fn=200);
    }
}
}


//// Pedicel
module pedicel(wallThickness,pfThickness,pdlOR, pdlIR, pdlHeight, pdlTopIR, NledHoles, pdlHoleTheta, ledHoleR, nPegs, pegR, pegTheta, pegHoleR){

        l=65; 
        w=6; 
        h=6;
    
// translate([0,0,64]) 
    rotate([0,180,0])
union(){
    difference(){
        cylinder(h=pdlHeight, r=pdlOR, center=false, $fn=200);
        translate([0,0,5]) cylinder(h=pdlHeight-4, r=pdlIR, center=false, $fn=200);
        translate([0,0,-2]) cylinder(h=8, r=pdlTopIR, center=false, $fn=200); 
    translate([0,0,2.5])
        
    // slots

    union(){
        cube([l,w,h], center=true);
        rotate(36) cube([l,w,h], center=true);
        rotate(72) cube([l,w,h], center=true);
        rotate(108) cube([l,w,h], center=true);
        rotate(144) cube([l,w,h], center=true);
        }
        
    // holes for LED

    rotate([90,0,0]) translate([0,3,0]) for (i=[0:NledHoles])
        rotate([0,pdlHoleTheta*i,0]) translate([0,0,pdlOR-5]) cylinder(h=wallThickness+10, r=ledHoleR, center = true, $fn=100);
    } 
    //platform for flagellum
    translate([0,0,pdlHeight-(pdlHeight/3)]) difference(){
    cylinder(h=pfThickness, r=pdlIR+0.5, center=true, $fn=200);
    cylinder(h=6, r=pdlOR-16, center=true, $fn=200);
}
// Pegs
difference(){
for (i=[0:nPegs])
        translate([(pdlTopIR+9)*cos(i*pdlHoleTheta+36), (pdlTopIR+9)*sin(i*pdlHoleTheta+36),3.5]) cylinder(h=wallThickness, r=pegR, center = true, $fn=100);
rotate([90,0,0]) translate([0,-4,0]) for (i=[0:NledHoles])
        rotate([0,(pdlHoleTheta*i)+18,0]) translate([0,7.5,pdlOR-5]) cylinder(h=wallThickness+10, r=pegHoleR, center = true, $fn=100);
}
}
}


  
////Flagellum
module flagellum(wallThickness,pfThickness,NledHoles,flgBottomOR,flgBottomIR,flgTopOR,flgHeight,flgHoleTheta,pegHoleR){

l=45;
w=3;
h=4;
//translate([0,0,110])
difference(){
union(){
    cylinder(h=flgHeight, r1=flgBottomOR, r2=5, center=true, $fn=200);
    translate([0,0,-48]) union(){
        cube([l,w,h], center=true);
        rotate(36) cube([l,w,h], center=true);
        rotate(72) cube([l,w,h], center=true);
        rotate(108) cube([l,w,h], center=true);
        rotate(144) cube([l,w,h], center=true);
    }
    translate([0,0,flgHeight/2]) sphere(r=5, $fn=100);
    }
    translate([0,0,-2]) cylinder(h=flgHeight-2, r1=flgBottomIR, r2=2, center=true, $fn=200);
    rotate([90,0,0]) translate([0,-44,0]) for (i=[0:NledHoles])
        rotate([0,flgHoleTheta*i,0]) translate([0,0,flgBottomOR]) cylinder(h=wallThickness+10, r=pegHoleR, center = true, $fn=100);
    
}
}

//
////Head plate
module head_plate(wallThickness,pfThickness, plateR, flapHeight){

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

