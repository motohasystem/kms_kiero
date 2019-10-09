
module draw_kieiro(width, depth, height, thickness, leg, pillar, backheight){
    
    // 本体部分
    kieiro_body(width, depth, height, thickness, leg, pillar, backheight);

    // フタ部分
    kieiro_hatch_bolt(width - thickness*2, depth, height, thickness, leg, pillar, backheight);
}

module draw_beranda(width, depth, height, thickness, leg, pillar, backheight){

    beranda_body(width, depth, height, thickness, leg, pillar, backheight);
    beranda_hatch(width-thickness*2, depth+pillar+pillar+thickness, height+leg, pillar, thickness, backheight);

}


module draw_enhanced(width, depth, height, thickness, leg, pillar, backheight){

    enhanced_body(width, depth, height, thickness, leg, pillar, backheight);
    beranda_hatch(width-thickness*2, depth+pillar+pillar+thickness, height+leg, pillar, thickness, backheight);

}



// キエーロ本体
module kieiro_body(width, depth, height, thickness, leg, pillar, backheight){
    echo("---- body ----");
    tk = thickness;
    p = pillar;
    
    // 正面側板
    translate([0, tk, leg])
    rotate([90, 0, 0])
    board([width, height, tk]);

    // 側面側板L
    translate([0, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    // 背面側板
    translate([0, tk*2 + depth, leg])
    rotate([90, 0, 0])
    board([width, height,tk]);

    // 側面側板R
    translate([width - tk, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    // 脚 左奥
    translate([tk, tk+depth-p, 0])
    pillar(p, leg + height + backheight);

    // 脚 右奥
    translate([width-tk-p, depth - tk - tk, 0])
    pillar(p, leg + height + backheight);

    // 脚 左手前
    translate([tk, tk, 0])
    pillar(p, leg + height);

    // 脚 右手前
    translate([width-tk-p, tk, 0])
    pillar(p, leg + height);

}

module kieiro_hatch_bolt(width, depth, height, thickness, leg, pillar, backheight){
    p = pillar;
    tk = thickness;
    hd = sqrt(pow(backheight,2) + pow(depth,2));   // hatch depth


    motion_range = 180 - atan((depth-pillar)/(backheight)); // 蓋の可動域

    echo("---- roof ----");

    translate([width + tk, depth - tk*2, height+leg+backheight])
    rotate([ vibrate($t, motion_range), 0, 180])
    translate([0, 0, 0]){
        rotate([-90, 0, 0]){
            // フタ 左右の梁
           translate([0, 0, -p*2]){
               translate([p, 0, 0])
               pillar(p, hd + p*2);
               
               translate([width-p-p, 0, 0])
               pillar(p, hd+ p*2);
           }
           
           // フタ 中央のハリ
           translate([(width-p)/2, 0, 0])
           pillar(p, hd);
               
           
        }
        
        // フタ 前奥のハリ
        rotate([0, 90, 0]){
            translate([-p, 0, 0]){
                // 奥
                translate([0, 0, 0])
                pillar(p, width);

                // 手前
                translate([0, hd-p, 0])
                pillar(p, width);
            }
        }

        // 天板波板
        margin = 0.2;
        color("snow", 0.8)
        translate([-width*margin/2, -hd*margin/2, p])
        roof([width*(1+margin), hd*(1+margin), tk]);
    }
}


module kieiro_hatch(width, depth, height, thickness, leg, pillar, backheight){
    p = pillar;
    tk = thickness;
    hd = sqrt(pow(backheight,2) + pow(depth,2));   // hatch depth


    motion_range = 180 - atan((depth-pillar)/(backheight)); // 蓋の可動域

    //echo(motion_range=motion_range);
    //echo(vibrate($t, motion_range));
    echo("---- roof ----");

    translate([width + tk, depth - tk*2, height+leg+backheight])
    rotate([ vibrate($t, motion_range), 0, 180])
    translate([0, 0, p]){
        rotate([-90, 0, 0]){
           translate([0, -p, 0]){
               pillar(p, hd);
               
               translate([(width-p)/2, 0, 0])
               pillar(p, hd);
               
               translate([width-p, 0, 0])
               pillar(p, hd);
           }
           
        }
        
        rotate([0, 90, 0]){
            translate([0, 0, 0])
            pillar(p, width);

            translate([0, hd-p, 0])
            pillar(p, width);
        }

        margin = 0.2;
        color("snow", 0.8)
        translate([-width*margin/2, -hd*margin/2, p])
        roof([width*(1+margin), hd*(1+margin), tk]);
    }
}


module beranda_body(width, depth, height, thickness, leg, pillar, backheight){
    echo("---- body ----");
    
    tk = thickness;
    p = pillar;
    
    // front side board
    translate([tk, tk+tk+p, leg])
    rotate([90, 0, 0])
    board([width-tk*2, height, tk]);

    translate([tk+p, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p-p, tk, 0])
    pillar(p, leg + height);

    translate([tk, tk+tk+p, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);


    // back side board
    translate([tk, depth-pillar+tk, leg])
    rotate([90, 0, 0])
    board([width-tk*2, height,tk]);

    translate([tk+p, tk+depth-p, 0])
    pillar(p, leg + height + backheight);

    translate([width-tk-p-p, depth - tk - tk, 0])
    pillar(p, leg + height + backheight);

    translate([tk, depth-p-p, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);


    // left side board
    translate([0, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([tk, tk+depth-p, 0])
    pillar(p, leg + height);

    translate([tk, tk, 0])
    pillar(p, leg + height);


    // right side board
    translate([width - tk, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([width-tk-p, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p, depth - tk - tk, 0])
    pillar(p, leg + height);


    // bottom board
    translate([tk, p+tk*2, leg+p])
    board([width-tk*2, depth-tk*2-p*2, tk]);

    translate([tk, depth/3*2, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);

    translate([tk, depth/3, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);

}


module beranda_hatch(width, depth, height, pillar, thickness, backheight){
    echo("---- hatch ----");
    p = pillar;
    tk = thickness;
    
    motion_range = 180 - atan((depth-pillar)/(backheight-pillar)); // 蓋の可動域

    hd = sqrt(pow(backheight,2) + pow(depth,2));   // hatch depth
    
    translate([width+tk, depth-p*2, height+backheight]){
        rotate([ vibrate($t, motion_range), 0, 180]){
            translate([0, tk-p*2, 0]){

                rotate([-90, 0, 0]){
                   translate([0, 0, 0]){
                       pillar(p, hd);
                       
                       translate([(width-p)/2, 0, 0])
                       pillar(p, hd);
                       
                       translate([width-p, 0, 0])
                       pillar(p, hd);
                   }
                   
                }
                
                rotate([0, 90, 0]){
                    translate([p, p*4, 0])
                    pillar(p, width);

                    translate([p, hd-p*2, 0])
                    pillar(p, width);
                }

                margin = 0.2;
                color("snow", 0.8)
                translate([-width*margin/2, -hd*margin/2, p])
                roof([width*(1+margin), hd*(1+margin), tk]);
            }
        }
    }
}


module enhanced_body(width, depth, height, thickness, leg, pillar, backheight){
    echo("---- body ----");
    
    tk = thickness;
    p = pillar;


    // front side board
    translate([tk, tk+tk+p, leg])
    rotate([90, 0, 0])
    board([width-tk*2, height, tk]);

    translate([tk+p, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p-p, tk, 0])
    pillar(p, leg + height);

    //translate([tk, tk+tk+p, leg])
    //rotate([90, 0, 90])
    //pillar(p, width-tk*2);


    // back side board
    translate([tk, depth-pillar+tk, leg])
    rotate([90, 0, 0])
    board([width-tk*2, height,tk]);

    translate([tk+p, tk+depth-p, 0])
    pillar(p, leg + height + backheight);

    translate([width-tk-p-p, depth - tk - tk, 0])
    pillar(p, leg + height + backheight);

    //translate([tk, depth-p-p, leg])
    //rotate([90, 0, 90])
    //pillar(p, width-tk*2);


    // left side board
		rotate([0, 0, 0])

    translate([0, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([tk, tk+depth-p, 0])
    pillar(p, leg + height);

    translate([tk, tk, 0])
    pillar(p, leg + height);

    // right side board
    translate([width - tk, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([width-tk-p, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p, depth - tk - tk, 0])
    pillar(p, leg + height);
}



module board(array){
    echo(str("板（ 厚さ:" , round(array[2]),  "mm, ヨコ:" ,  round(array[0]), "mm, タテ:", round(array[1]), "mm ）"));
    cube(array);
    
    translate([-200, 0, 100])
    rotate([0, 270, 270])
    color("black") text(array[1], size=100);

}

module pillar(width, height){
    echo(str("角材（長さ", round(height),  "mm, 一辺:", round(width), "mm ）"));
    cube([width, width, height]);
}

module roof(array){
    echo(str("屋根（ 厚さ:" , round(array[2]),  "mm, ヨコ:" ,  round(array[0]), "mm, タテ:", round(array[1]), "mm ）"));
    cube(array);
}


function vibrate(t, motion_range) = -sin(t*360)*motion_range/2 + (90 - motion_range/2);
