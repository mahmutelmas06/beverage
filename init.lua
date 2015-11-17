--------------------------------------------
--------------------------------------------
----------- Beverage Mod by Mahmutelmas06 --
--------------------------------------------
--------------------------------------------

-- Everything are  WTFPL except ;
      -- Beverage support by rubenwardy from food mod GPL license

	  
	
beverage = 	{
	version = 1.0,
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
		paramtype = "light",
		is_ground_content = false,
		walkable = false,
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
		""..cuptexture.."^(liquid.png^[colorize:"..liquidcolour..")",
		''..cuptexture,
		''..cuptexture,
		''..cuptexture,
		''..cuptexture,
		''..cuptexture
				},		

		node_box = {
		type = "fixed",
		fixed = {
			{-0.12, -0.5, -0.12, 0.12, -0.224615, -0.12}, -- left
			{-0.12, -0.5, 0.12, 0.12, -0.224615, 0.12}, -- right
			{-0.12, -0.5, -0.12, -0.12, -0.224615, 0.12}, -- front
			{0.13, -0.5, -0.12, 0.12, -0.224615, 0.12}, -- behind
			{0.12, -0.5, -0.0295275, 0.310597, -0.438462, 0.0295275}, -- holdbot
			{0.12, -0.31073, -0.0354331, 0.310597, -0.249192, 0.0413386}, -- holdtop
			{0.271386, -0.468566, -0.0354331, 0.310597, -0.249192, 0.0413386}, -- hold
			{-0.12, -0.5, -0.12, 0.12, -0.257692, 0.12}, -- bottom

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

minetest.register_abm({
	nodenames = {
				"beverage:"..nodename
				},
	interval = 1,
	chance = 2,
	action = function(pos, node)
	     if
                minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == "air" and
                minetest.get_node({x=pos.x, y=pos.y+2.0, z=pos.z}).name == "air"
             then
		local image_number = math.random(4)
		minetest.add_particlespawner({
			amount = 5,
			time = 1,
			minpos = {x=pos.x, y=pos.y-1, z=pos.z},
			maxpos = {x=pos.x, y=pos.y+1, z=pos.z},
			minvel = {x=-0.2, y=0.3, z=-0.2},
			maxvel = {x=0.2, y=1, z=0.2},
			minacc = {x=0,y=0,z=0},
			maxacc = {x=0,y=0,z=0},
			minexptime = 0.2,
			maxexptime = 1,
			minsize = 0.3,
			maxsize = 2,
			collisiondetection = false,
			texture = "steam.png",
		})
	     end
	end
	
					})

end



-- Cold beverages

function register_coldbeverage(nodename,desc,liquidcolour, recipe)

		  -- Register Drinks

	minetest.register_node(":beverage:"..nodename, {
		description = desc,
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		use_texture_alpha = true,
		walkable = false,
		drop = "vessels:glass_fragments",
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
			{-0.12, -0.5, -0.12, 0.12, 0.015, -0.12}, -- left
			{-0.12, -0.5, 0.12, 0.12, 0.015, 0.12}, -- right
			{-0.12, -0.5, -0.12, -0.12, 0.015, 0.12}, -- front
			{0.12, -0.5, -0.12, 0.12, 0.015, 0.12}, -- behind
			{-0.12, -0.5, -0.12, 0.12, -0.07, 0.12}, -- bottom
		}
	},
	
	
		tiles = {
		'liquid.png^[colorize:'..liquidcolour,
		'liquid_cold_top.png^(liquid_cold_bottom.png^[colorize:'..liquidcolour..')',
		'liquid_cold_top.png^(liquid_cold_bottom.png^[colorize:'..liquidcolour..')',
		'liquid_cold_top.png^(liquid_cold_bottom.png^[colorize:'..liquidcolour..')',
		'liquid_cold_top.png^(liquid_cold_bottom.png^[colorize:'..liquidcolour..')',
		'liquid_cold_top.png^(liquid_cold_bottom.png^[colorize:'..liquidcolour..')'
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
			{-0.12, -0.5, -0.12, 0.12, -0.184615, -0.12}, -- left
			{-0.12, -0.5, 0.12, 0.12, -0.184615, 0.12}, -- right
			{-0.12, -0.5, -0.12, -0.12, -0.184615, 0.12}, -- front
			{0.10, -0.5, -0.12, 0.12, -0.224615, 0.12}, -- behind
			{0.12, -0.5, -0.0295275, 0.310597, -0.438462, 0.0295275}, -- holdbot
			{0.12, -0.31073, -0.0354331, 0.310597, -0.249192, 0.0413386}, -- holdtop
			{0.271386, -0.468566, -0.0354331, 0.310597, -0.249192, 0.0413386}, -- hold
			{-0.12, -0.5, -0.12, 0.12, -0.439096, 0.12}, -- bottom
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
			{-0.12, -0.5, -0.12, 0.12, 0.015, -0.12}, -- left
			{-0.12, -0.5, 0.12, 0.12, 0.015, 0.12}, -- right
			{-0.12, -0.5, -0.12, -0.12, 0.015, 0.12}, -- front
			{0.12, -0.5, -0.12, 0.12, 0.015, 0.12}, -- behind
			{-0.12, -0.5, -0.12, 0.12, -0.07, 0.12}, -- bottom
		}
	},
	
			tiles = {
					{name= 'glasses.png'}, 								
					{name= 'glasses.png'}
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


-- Beverage Name					 	Description	    	 Liquid Colour	     	Cup/Glasses Texture					 		 Recipe     

register_hotbeverage("coffee",			S("Coffee"),		 "#8B4513:190",    	"cup.png^[colorize:#CDC673:110", 	  "group:beverage_coffee")
register_hotbeverage("milk",			S("Milk"),			 "#F8F8FF:190",     "cup.png^[colorize:#CD919E:110",	  "group:beverage_milk")
register_hotbeverage("hotchocolate",	S("Hot Chocolate"),	 "#8B5A00:190", 	"cup.png^[colorize:#ADD8E6:110",	  "group:beverage_chocolate")
register_hotbeverage("tea",				S("Tea"),			 "#CD3700:190",     "cup.png^[colorize:#CD2626:110",  	  "group:beverage_tea")
register_hotbeverage("greentea",		S("Green Tea"),		 "#9ACD32:190",		"cup.png^[colorize:#EEC591:110", 	  "group:flower")



register_coldbeverage("orangejuice",	S("Orange Juice"),	 "#FFA500:110",    										  "group:beverage_orange")
register_coldbeverage("applejuice",		S("Apple Juice"),	 "#EED5B7:110",    										  "group:beverage_apple")
register_coldbeverage("cherryjuice",	S("Cherry Juice"),	 "#EE4000:110",     									  "group:beverage_berry")
register_coldbeverage("lemonade",		S("Lemonade"),		 "#FFF68F:110",    										  "group:beverage_lemon")
register_coldbeverage("yoghurt",		S("Yoghurt"),		 "#F5FFFA:110",    										  "group:beverage_milk")
register_coldbeverage("icetea",			S("Ice Tea"),		 "#E37F8B:110",    										  "group:beverage_tea")
register_coldbeverage("coconut",		S("Coconut Milk"),	 "#E0E0E0:110",    										  "group:beverage_coconut")
