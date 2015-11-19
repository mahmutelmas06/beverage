--------------------------------------------
--------------------------------------------
----------- Beverage Mod by Mahmutelmas06 --
--------------------------------------------
--------------------------------------------

-- Everything are  WTFPL except ;
      -- Beverage support by rubenwardy from food mod GPL license

	  
	
beverage = 	{
	version = 1.1,
			}	

-- Inllib support for localization

local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end



------------ Hot beverages

function register_hotbeverage(nodename,desc,liquidcolour, cuptexture, recipe)

		  -- Register Drinks

	minetest.register_node(":beverage:"..nodename, {
		description = desc,
		drawtype = "nodebox",
		use_texture_alpha = true,
		paramtype = "light",
		is_ground_content = false,
		walkable = false,
		--inventory_image = "(cup_inv.png^[mask:"..cuptexture..")^(inside.png^[colorize:"..liquidcolour..")",
		drop = "vessels:glass_fragments",
		groups = {dig_immediate=3,attached_node=1},
		sounds = default.node_sound_glass_defaults(),
		on_use = minetest.item_eat(2, "beverage:cup"),
		after_place_node = function(pos, placer, itemstack)
			if placer:is_player() then
			minetest.set_node(pos, {name="beverage:"..nodename, param2=1})
			end
		end,

		tiles = {
				{name= ''..cuptexture..'^(liquid.png^[colorize:'..liquidcolour..')'},
				{name= ''..cuptexture},
				},		

		node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.125, 0.125, -0.25, 0.1875}, -- bottom
			{-0.1875, -0.5, -0.125, 0.125, -0.1875, -0.0625}, -- left
			{-0.1875, -0.5, 0.125, 0.125, -0.1875, 0.1875}, -- right
			{0.0625, -0.5, -0.125, 0.125, -0.1875, 0.1875}, -- back
			{-0.1875, -0.5, -0.125, -0.125, -0.1875, 0.1875}, -- front
			{0.1875, -0.4375, 0, 0.249447, -0.25, 0.0649601}, -- hold
			{0.125, -0.3125, 0, 0.1875, -0.25, 0.0649601}, -- holdtop
			{0.125, -0.4375, 0, 0.1875, -0.372667, 0.06496}, -- holdbot

				}
		},
		
	})
	
	-- Crafting
	
	minetest.register_craft({
	output = 'beverage:'..nodename,
	recipe = {
		{'', '', ''},
		{''..recipe, ''..recipe, ''},
		{'beverage:cup', '', ''},
			 }
	})


	
	
	-- Steam animation for hot drinks
	-- From farming plusplus mod by MTDad

minetest.register_abm({
		nodenames = {
				"beverage:"..nodename
				},
	interval = 3,
	chance = 1,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == "air"
		then minetest.add_particlespawner({
			amount = 6,
			time = 1,
			minpos = {x=pos.x-0.0, y=pos.y-0.2, z=pos.z-0.0},
			maxpos = {x=pos.x+0.0, y=pos.y+0.2, z=pos.z+0.0},
			minvel = {x=-0.01, y=0.01, z=-0.01},
			maxvel = {x=0.01, y=0.02, z=-0.01},
			minacc = {x=0.0,y=-0.0,z=-0.0},
			maxacc = {x=0.0,y=0.01,z=-0.0},
			minexptime = 1,
			maxexptime = 4,
			minsize = 1,
			maxsize = 3,
			collisiondetection = true,
			texture = "farming_steam.png"
			})
		end
	end
})

end



-- Cold beverages

function register_coldbeverage(nodename,desc,liquidcolour, glassestexture, recipe)

		  -- Register Drinks

	minetest.register_node(":beverage:"..nodename, {
		description = desc,
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		use_texture_alpha = true,
		walkable = false,
		drop = "vessels:glass_fragments 3",
		groups = {dig_immediate=3,attached_node=1},
		sounds = default.node_sound_glass_defaults(),
		on_use = minetest.item_eat(2, "beverage:glasses"),
		after_place_node = function(pos, placer, itemstack)
			if placer:is_player() then
			minetest.set_node(pos, {name="beverage:"..nodename, param2=1})
			end
		end,
		
		node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.125, 0.125, 0, 0.1875}, -- bottom
			{-0.1875, -0.5, -0.125, 0.125, 0.0625, -0.0625}, -- left
			{-0.1875, -0.5, 0.125, 0.125, 0.0625, 0.1875}, -- right
			{0.0625, -0.5, -0.125, 0.125, 0.0625, 0.1875}, -- back
			{-0.1875, -0.5, -0.125, -0.125, 0.0625, 0.1875}, -- front
		}
	},
	
			tiles = {
				{name= 'liquid_cold_top.png^liquid_cold_bottom.png^(liquid.png^[colorize:'..liquidcolour..')'},
				{name= 'liquid_cold_top.png^('..glassestexture..'^[colorize:'..liquidcolour..')'},
				},	
		
		
		
	})
	
	-- Crafting
	
	minetest.register_craft({
	output = 'beverage:'..nodename,
	recipe = {
		{'', '', ''},
		{''..recipe, ''..recipe, ''},
		{'beverage:glasses', '', ''},
			 }
	})

------

end
------


----------------------------- Cup ------------------------
----------------------------------------------------------

minetest.register_node("beverage:cup", {
	description = S("Cup"),
	drawtype = "nodebox",
	paramtype = "light",
	stack_max = 99,
	liquids_pointable = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.125, 0.125, -0.4375, 0.1875}, -- bottom
			{-0.1875, -0.5, -0.125, 0.125, -0.1875, -0.0625}, -- left
			{-0.1875, -0.5, 0.125, 0.125, -0.1875, 0.1875}, -- right
			{0.0625, -0.5, -0.125, 0.125, -0.1875, 0.1875}, -- back
			{-0.1875, -0.5, -0.125, -0.125, -0.1875, 0.1875}, -- front
			{0.1875, -0.4375, 0, 0.249447, -0.25, 0.0649601}, -- hold
			{0.125, -0.3125, 0, 0.1875, -0.25, 0.0649601}, -- holdtop
			{0.125, -0.4375, 0, 0.1875, -0.372667, 0.06496}, -- holdbot
					}
	},
	tiles = {
		"cup.png"
			},
	sunlight_propagates = true,
	walkable = false,
	drop = "vessels:glass_fragments",
	groups = {dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="beverage:cup", param2=1})
		end
	end,
})



	-- Crafting
	
	minetest.register_craft({
	output = 'beverage:cup',
	recipe = {
		{'', '', ''},
		{'vessels:glass_fragments', 'vessels:glass_fragments', ''},
		{'vessels:glass_fragments', 'vessels:glass_fragments', 'vessels:glass_fragments'},
			 }
	})

	
	
	
	------------------Glasses
	
	minetest.register_node("beverage:glasses", {
	description = S("Glasses"),
	drawtype = "nodebox",
	paramtype = "light",
	stack_max = 99,
	liquids_pointable = true,
	use_texture_alpha = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.125, 0.125, -0.4375, 0.1875}, -- bottom
			{-0.1875, -0.5, -0.125, 0.125, 0.0625, -0.0625}, -- left
			{-0.1875, -0.5, 0.125, 0.125, 0.0625, 0.1875}, -- right
			{0.0625, -0.5, -0.125, 0.125, 0.0625, 0.1875}, -- back
			{-0.1875, -0.5, -0.125, -0.125, 0.0625, 0.1875}, -- front
		}
	},
	
			tiles = {
					{name= 'liquid_cold_top.png^liquid_cold_bottom.png'}, 								
					{name= 'liquid_cold_top.png^liquid_cold_bottom.png'}
				},

	sunlight_propagates = true,
	walkable = false,
	drop = "vessels:glass_fragments",
	groups = {dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="beverage:glasses", param2=1})
		end
	end,
})
	
		-- Crafting
	
	minetest.register_craft({
	output = 'beverage:glasses',
	recipe = {
		{'', 'vessels:glass_fragments', 'vessels:glass_fragments'},
		{'', 'vessels:glass_fragments', 'vessels:glass_fragments'},
		{'', 'vessels:glass_fragments', 'vessels:glass_fragments'},
			 }
	})
	
	

	
	


----- Checks for external content, and adds support
----- The code is GPL license
----- Taken from Food mod by Rubenwardy

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
	

})

beverage.support("orange", {
	"farming_plus:orange_item",
	"farming_plus:orange",
	"food:orange",
	"fruit:orange",
	"foodblock:orangeblock",
	"foodblock:orangeblock_slab",

})

beverage.support("milk", {
	"jkanimals:bucket_milk",
	"animalmaterials:milk",
	"kpgmobs:bucket_milk",
	"my_mobs:milk_glass_cup",
	"mobs:bucket_milk",
	"food:milk",
	"foodblock:milkblock",
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
	
	
	
})


beverage.support("lemon", {
	"food_sweet:lemon",
	"farming_plus:lemon_item",

})

beverage.support("coffee", {
	"farming:coffee_beans",
	"farming_plus:coffee_beans",

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

})

beverage.support("berry", {
	"farming_plus:strawberry_item",
	"plantlib:strawberry",
	"farming_plus:rhubarb_item",
	"bushes:strawberry",

})


-------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------           Register drinks                    -----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------

-- Beverage Name					 	Description	    	 Liquid Colour	     	Cup Texture					 		 Recipe     

register_hotbeverage("coffee",			S("Coffee"),		 "#8B4513:190",    	"cup.png^[colorize:#CD5C5C:90", 	  "group:beverage_coffee")
register_hotbeverage("milk",			S("Milk"),			 "#F8F8FF:190",     "cup.png^[colorize:#7171C6:90",	  	  "group:beverage_milk")
register_hotbeverage("hotchocolate",	S("Hot Chocolate"),	 "#8B5A00:190", 	"cup.png^[colorize:#ADD8E6:90",	      "group:beverage_chocolate")
register_hotbeverage("tea",				S("Tea"),			 "#CD3700:190",     "cup.png^[colorize:#CDB7B5:90",  	  "group:beverage_tea")
register_hotbeverage("greentea",		S("Green Tea"),		 "#9ACD32:190",		"cup.png^[colorize:#EEC591:90", 	  "group:flower")



register_coldbeverage("orangejuice",	S("Orange Juice"),	 "#FFA500:110",    	"liquid_cold_bottom.png",			  "group:beverage_orange")
register_coldbeverage("applejuice",		S("Apple Juice"),	 "#EED5B7:110",    	"liquid_cold_bottom.png",			  "group:beverage_apple")
register_coldbeverage("cherryjuice",	S("Cherry Juice"),	 "#EE4000:110",     "liquid_cold_bottom.png",			  "group:beverage_berry")
register_coldbeverage("lemonade",		S("Lemonade"),		 "#FFF68F:110",    	"liquid_cold_bottom.png",			  "group:beverage_lemon")
register_coldbeverage("yoghurt",		S("Yoghurt"),		 "#F5FFFA:110",    	"liquid_cold_bottom.png",			  "group:beverage_milk")
register_coldbeverage("icetea",			S("Ice Tea"),		 "#E37F8B:110",    	"liquid_cold_bottom.png",			  "group:beverage_tea")
register_coldbeverage("coconut",		S("Coconut Milk"),	 "#E0E0E0:110",    	"liquid_cold_bottom.png",			  "group:beverage_coconut")
