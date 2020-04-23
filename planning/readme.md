
切り出し計画作成ツール cutout_order.py の使い方

# 1
input.txtにOpenSCADの出力をコピペする。
3台作成するなら、それぞれの出力をコピペしていく。

	---- body ----
	板（ 厚さ:18mm, ヨコ:864mm, タテ:500mm )
	角材（長さ600mm, 一辺:40mm )
	角材（長さ600mm, 一辺:40mm )
	板（ 厚さ:18mm, ヨコ:864mm, タテ:500mm )
	角材（長さ750mm, 一辺:40mm )
	角材（長さ750mm, 一辺:40mm )
	板（ 厚さ:18mm, ヨコ:600mm, タテ:500mm )
	角材（長さ600mm, 一辺:40mm )
	角材（長さ600mm, 一辺:40mm )
	板（ 厚さ:18mm, ヨコ:600mm, タテ:500mm )
	角材（長さ600mm, 一辺:40mm )
	角材（長さ600mm, 一辺:40mm )
	---- hatch ----
	角材（長さ714mm, 一辺:40mm )
	角材（長さ714mm, 一辺:40mm )
	角材（長さ714mm, 一辺:40mm )
	角材（長さ864mm, 一辺:40mm )
	角材（長さ864mm, 一辺:40mm )
	屋根（ 厚さ:18mm, ヨコ:1037mm, タテ:857mm )

# 2

	$ python cutout_order.py input.txt

# 3

出力を参考に発注する

## 例：100cm x 50cm を2台分

柱パーツ
970 mm x 40 mm x 40 mm : 4 本
730 mm x 40 mm x 40 mm : 4 本
620 mm x 40 mm x 40 mm : 6 本
580 mm x 40 mm x 40 mm : 12 本
板材パーツ
970 mm x 240 mm x 18 mm : 8 枚
500 mm x 240 mm x 18 mm : 8 枚
屋根材ポリカ波板パーツ
屋根 横幅740, 縦幅:1160 : 2 枚


## 例：100cm x 50cm を3台分

角材(40mm x 40mm)
970 mm x 40 mm x 40 mm : 6 本
730 mm x 40 mm x 40 mm : 6 本
620 mm x 40 mm x 40 mm : 9 本
580 mm x 40 mm x 40 mm : 18 本

板材(18mm)
970 mm x 240 mm x 18 mm : 12 枚
500 mm x 240 mm x 18 mm : 12 枚


