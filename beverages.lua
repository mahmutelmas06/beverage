            local S if minetest.get_modpath("intllib") then S = intllib.Getter() else S = function(s) return s end end
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------			
------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------           Register drinks                    -----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------


--[[
register_beverage({
				   name = name of your drink,
				   recipe = "put fruit for drink"
				   description = "description of your drink",                 optional
				   liquidcolour = "colour of your liquids RGB code",          optional
				   wherein = "cup or glasses for now"                         optional
				   cuptexture = "cup texture",                                optional
				   heat = "hot or cold by default"                            optional
				  })
--]]



--Coffee
register_beverage({
					name = "coffee",
					description = S("Coffee"),
					liquidcolour = "#8B4513:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#CD5C5C:90",
					recipe = "group:beverage_coffee"
				})
				
--Milk
register_beverage({
					name = "milk",
					description = S("Milk"),
					liquidcolour = "#F8F8FF:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#7171C6:90",
					recipe = "group:beverage_milk"
				})				
				

-- Hot Chocolate
register_beverage({
					name = "hotchocolate",
					description = S("Hot Chocolate"),
					liquidcolour = "#8B5A00:190",
					heat = "hot",
					wherein = "cup",
					recipe = "group:beverage_chocolate"
				})
				
				
-- Tea				
register_beverage({
					name = "tea",
					description = S("Tea"),
					liquidcolour = "#CD3700:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#CDB7B5:90",
					recipe = "group:beverage_tea"
				})				
				
-- Green Tea				
register_beverage({
					name = "greentea",
					description = S("Green Tea"),
					liquidcolour = "#9ACD32:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#CD5C5C:90",
					recipe = "group:flower"
				})				
	
				
-- Orange Juice
register_beverage({
					name = "orangejuice",
					description = S("Orange Juice"),
					liquidcolour = "#FFA500:110",
					heat = "cold",
					wherein = "glasses",
					cuptexture = "liquid_cold_bottom.png",
					recipe = "group:beverage_orange"
				})

-- Apple Juice				
register_beverage({
					name = "applejuice",
					description = S("Apple Juice"),
					liquidcolour = "#EED5B7:110",
					heat = "cold",
					wherein = "glasses",
					cuptexture = "liquid_cold_bottom.png",
					recipe = "group:beverage_apple"
				})

-- Berry Juice				
register_beverage({
					name = "berryjuice",
					description = S("Berry Juice"),
					liquidcolour = "#EE4000:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "group:beverage_berry"
				})

-- Lemonade				
register_beverage({
					name = "lemonade",
					description = S("Lemonade"),
					liquidcolour = "#FFF68F:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "group:beverage_lemon"
				})

-- Coconut Milk				
register_beverage({
					name = "coconutmilk",
					description = S("Coconut Milk"),
					liquidcolour = "#E0E0E0:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "group:beverage_coconut"
				})