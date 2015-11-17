Baverage Mod



This mod adds various drinks to minetest

License = WTFPL
Except beverage.support code from food mod by rubenwardy GPL

Coffee, Milk, Hot Chocolate 
Tea, Green Tea , Orange Juice 
Apple Juice, Cherry Juice, Lemonade 
Yoghurt, Ice Tea, Coconut Milk

https://forum.minetest.net/download/file.php?id=4146

Hot drinks has steam animation

https://forum.minetest.net/download/file.php?id=4147



You can add your own drinks by using that template


Hot Beverage Name-Description-Liquid Colour-Cup Texture-Recipe     

register_hotbeverage("coffee",  S("Coffee"),	"#8B4513:190",	"cup.png^[colorize:#CDC673:110", 	"group:beverage_apple")


Cold Beverage Name-Description-Liquid Colour-Recipe     

register_coldbeverage("applejuice",  S("Apple Juice"), "#8B4513:190",    "group:beverage_apple")
