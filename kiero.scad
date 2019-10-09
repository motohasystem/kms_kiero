use <modules_kiero.scad>

// カメラ位置の初期化（アニメーションする際はコメントアウト）
$vpr = [45, 0, 45];
$vpd = 4000;

// モデルを指定 (0:バクテリア、 1:ベランダ, 2:強化型バクテリア)
modelNumber = 2;

// キエーロのサイズを指定

// 本体の横幅
boxwidth = 900;

// 本体の高さ
boxheight = 500;

// 本体の奥行き
boxdepth = 600;     


// ***** その他のパラメータ *****

// 使用する板厚
thickness = 18;

// 足の（杭）の長さ
leg = 100;

// 角材の太さ
pillar=40;

// 背面の足の高さ
backheight = 150;


if(modelNumber==0){
    // 接地型キエーロを作る
    translate([0,0,-leg])
    draw_kieiro(boxwidth, boxdepth, boxheight, thickness, leg, pillar, backheight);
}
else if(modelNumber == 1){
    // 可搬型キエーロを作る
    draw_beranda(boxwidth, boxdepth, boxheight, thickness, leg, pillar, backheight);
}
else if(modelNumber == 2){
    // 設置型キエーロ強化タイプを作る
    draw_enhanced(boxwidth, boxdepth, boxheight, thickness, leg, pillar, backheight);
}

