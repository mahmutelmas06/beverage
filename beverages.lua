--[[
register_beverage({
				   name = name of your drink,
				   recipe = "put fruit for drink"
				   recipe2 = "put fruit for drink"				                Default = recipe 			       -optional
				   description = "description of your drink",             Default = None               -optional
				   liquidcolour = "colour of your liquids RGB code",      Default = White              -optional
				   wherein = "cup or glasses"                             Default = Cup                -optional
				   cuptexture = "cup texture",  			            	     	Default = Brown              -optional
				   heat = "hot or cold "                                  Default = Hot                -optional
				  })
--]]








--------------Internationalization-------
-----------------------------------------    

local S if minetest.get_modpath("intllib") 
then S = intllib.Getter() 
else S = function(s) return s end end 	     

-----------------------------------------
-----------------------------------------
-- Fruit definitions --------------------
-----------------------------------------	
----- Checks for external content, and adds support
----- Code is taken from Food mod by Rubenwardy

function beverage.support(group, item)
	if type(group) == "table" then
		for i = 1, #group do
			beverage.support(group[i], item)
		end
		return
	end
	if type(item) == "table" then
		for i = 1, #item do
			beverage.support(group, item[i])
		end
		return
	end

	local idx = string.find(item, ":")
	if idx <= 1 then
		error("[Beverage Error] beverage.support - error in item name ('" .. item .. "')")
	end
	local mod = string.sub(item, 1, idx - 1)

	if not minetest.get_modpath(mod) then
		if beverage.debug then
			print("[Beverage Debug] Mod '"..mod.."' is not installed")
		end
		return
	end

	local data = minetest.registered_items[item]
	if not data then
		print("[Beverage Warning] Item '"..item.."' not found")
		return
	end


	-- Add group
	local g = {}
	if data.groups then
		for k, v in pairs(data.groups) do
			g[k] = v
		end
	end
	g["beverage_"..group] = 1
	minetest.override_item(item, {groups = g})
end




beverage.support("apple", {
	"default:apple",
	"fruit:apple",
	"ethereal:golden_apple",
	"ironapple:apple_iron",
	"beverage:applejuice"
})



beverage.support("chocolate", {
	"farming_plus:cocoa_bean",
	"farming:cocoa_beans",
	"food:cocoa",
	"food:chocolate_powder",
	"mtfoods:chocolate",
	"farming:chocolate_dark",
	"foodblock:chocod_block",
	"food:dark_chocolate",
	"foodblock:chocod_block_slab",
	"foodblock:chocom_block",
	"food:milk_chocolate",
	"plants:cacao_wild",
	"beverage:hotchocolate"
})

beverage.support("orange", {
	"farming_plus:orange_item",
	"farming_plus:orange",
	"food:orange",
	"fruit:orange",
	"foodblock:orangeblock",
	"foodblock:orangeblock_slab",
	"beverage:orangejuice"
})

beverage.support("milk", {
	"jkanimals:beverage_milk",
	"animalmaterials:milk",
	"kpgmobs:beverage_milk",
	"my_mobs:milk_glass_cup",
	"mobs:beverage_milk",
	"food:milk",
	"foodblock:milkblock",
	"beverage:milk"
})

beverage.support("flower", {
	"farming:wheat",
	"flowers:flower_rose",
	"flowers:flower_dandelion_white",
	"flowers:flower_viola",
	"flowers:flower_tulip",
	"plants:aloe_wild",
	"plants:lavender_wild",
	"plants:grass_wild",
	"beverage:greentea"
})


beverage.support("lemon", {
	"food_sweet:lemon",
	"farming_plus:lemon_item",
	"beverage:lemonade"

})

beverage.support("coffee", {
	"farming:coffee_beans",
	"farming_plus:coffee_beans",
	"beverage:coffee"
})

beverage.support("coconut", {
	"foodblock:cocoblock",
	"foodblock:cocoblock_slab",
	"farming:cucumber",
	"moretrees:coconut_milk",
	"moretrees:raw_coconut",
	"docfarming:cucumber",
	"mtfoods:dandelion_milk",
	"ethereal:coconut_slice",
	"beverage:coconutmilk"
})

beverage.support("berry", {
	"farming_plus:strawberry_item",
	"plantlib:strawberry",
	"farming_plus:rhubarb_item",
	"bushes:strawberry",
	"beverage:berryjuice"
})
		

beverage.support("water", {
			"default:water_source",
			"default:water_flowing",
			"bucket:bucket_water",
			"default:river_water_source",
			"default:river_water_flowing",
			"bucket:bucket_river_water",
			"beverage:drinkingwater"
})		



------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------           Register drinks                    -----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------




--Coffee
register_beverage({
					name = "coffee",
					description = S("Coffee"),
					liquidcolour = "#8B4513:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#CD5C5C:90",
					recipe = "coffee"
				})
				
--Milk
register_beverage({
					name = "milk",
					description = S("Milk"),
					liquidcolour = "#F8F8FF:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#7171C6:90",
					recipe = "milk"
				})				
				

-- Hot Chocolate
register_beverage({
					name = "hotchocolate",
					description = S("Hot Chocolate"),
					liquidcolour = "#8B5A00:190",
					heat = "hot",
					wherein = "cup",
					recipe = "chocolate"
				})
				
				
-- Tea				
register_beverage({
					name = "tea",
					description = S("Tea"),
					liquidcolour = "#CD3700:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#CDB7B5:90",
					recipe = "tea"
				})				
				
-- Green Tea				
register_beverage({
					name = "greentea",
					description = S("Green Tea"),
					liquidcolour = "#9ACD32:190",
					heat = "hot",
					wherein = "cup",
					cuptexture = "cup.png^[colorize:#CD5C5C:90",
					recipe = "flower"
				})				
	
				
-- Orange Juice
register_beverage({
					name = "orangejuice",
					description = S("Orange Juice"),
					liquidcolour = "#FFA500:110",
					heat = "cold",
					wherein = "glasses",
					cuptexture = "liquid_cold_bottom.png",
					recipe = "orange"
				})

-- Apple Juice				
register_beverage({
					name = "applejuice",
					description = S("Apple Juice"),
					liquidcolour = "#EED5B7:110",
					heat = "cold",
					wherein = "glasses",
					cuptexture = "liquid_cold_bottom.png",
					recipe = "apple"
				})

-- Berry Juice				
register_beverage({
					name = "berryjuice",
					description = S("Berry Juice"),
					liquidcolour = "#EE4000:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "berry"
				})

-- Lemonade				
register_beverage({
					name = "lemonade",
					description = S("Lemonade"),
					liquidcolour = "#FFF68F:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "lemon"
				})

-- Coconut Milk				
register_beverage({
					name = "coconutmilk",
					description = S("Coconut Milk"),
					liquidcolour = "#E0E0E0:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "coconut"
				})
				
	-- Cold Water			
register_beverage({
					name = "drinkingwater",
					description = S("Drinking Water"),
					liquidcolour = "#518EF7:110",
					heat = "cold",
					wherein = "glasses",
					recipe = "water"
				})
				
	-- Hot Water		
register_beverage({
					name = "hotwater",
					description = S("Hot Water"),
					liquidcolour = "#518EF7:110",
					heat = "hot",
					wherein = "cup",
					recipe = "water"
				})
