Baverage Mod

This mod adds various drinks to minetest

License = WTFPL

-- Current Beverages

Coffee, Milk, Hot Chocolate
Tea, Green Tea , Orange Juice
Apple Juice, Cherry Juice, Lemonade
Coconut Milk

-- Dependecies
No external depentecies.Just the ones comes with default game engine
Default
Vessels

-- Hot drinks has steam animation



-- Drinks has support from theese mods
farming, farming_plus, mobs, animals_modpack, foodblock
moretrees, biomelib, mtfoods, foods, ethereal, flowers
bushes, food_sweet, kpgmobs, fruit, jkanimals, ironapple



You can add your own drinks by using that template

    register_beverage({
                   name = name of your drink,
                   recipe = "put fruit for drink"
                   description = "description of your drink",                 optional
                   liquidcolour = "colour of your liquids RGB code",          optional
                   wherein = "cup or glasses for now"                         optional
                   cuptexture = "cup texture",                                optional
                   heat = "hot or cold by default"                            optional
                  })

Changelog

    1.2 -
    Added drinking sounds
    Added support for thirsty mod
    Added better inventory images (taken from coffee mod )
    Improved Api

    1.1 -
    Better nodeboxes
    Better steam animation (from farmingplusplus)
    Glasses has texture option too
    
    1.0 -
    Initial Release
