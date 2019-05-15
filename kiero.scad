use <modules_kiero.scad>

// キエーロのサイズを指定
boxwidth = 1000;    // 幅
boxheight = 400;    // 高さ
boxdepth = 600;     // 奥行き

// 各種パラメータ
thickness = 12;     // 使用したい板厚
leg = 100;          // 足の（杭）の長さ
pillar=40;          // 角材の太さ
backheight = 100;   // 背面の足の高さ


// 接地型キエーロ
//draw_kieiro(boxwidth, boxdepth, boxheight, thickness, leg, pillar, backheight);

// 移動型キエーロ
draw_beranda(boxwidth, boxdepth, boxheight, thickness, leg, pillar, backheight);


