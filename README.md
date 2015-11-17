[b][size=200]Baverage Mod[/size][/b]
                                      [color=#404080]This mod adds various drinks to minetest[/color]
(My first mod)

License = WTFPL
                 Except beverage.support code from food mod by rubenwardy GPL

Coffee, Milk, Hot Chocolate 
Tea, Green Tea , Orange Juice 
Apple Juice, Cherry Juice, Lemonade 
Yoghurt, Ice Tea, Coconut Milk

[img]https://forum.minetest.net/download/file.php?id=4146[/img]

Hot drinks has steam animation
[img]https://forum.minetest.net/download/file.php?id=4147[/img]


All drinks has support to theese mods
farming, farming_plus, mobs, animals_modpack, foodblock
moretrees, biomelib, mtfoods, foods, ethereal, flowers
bushes, food_sweet, kpgmobs, fruit, jkanimals, ironapple

[b]You can add your own drinks by using that template[/b]

[code]-- Hot Beverage Name	          Description	            Liquid Colour              Cup Texture					 		      Recipe     

register_hotbeverage("coffee",    S("Coffee"),	    "#8B4513:190",    	"cup.png^[colorize:#CDC673:110", 	  "group:beverage_apple")[/code]


[code]-- Cold Beverage Name	             Description	              Liquid Colour        	 		      Recipe     

register_coldbeverage("applejuice",    S("Apple Juice"),	    "#8B4513:190",    	  "group:beverage_apple")[/code]
