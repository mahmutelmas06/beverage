------------------------------------------------
------------------------------------------------
----------- Beverage Mod Api by Mahmutelmas06 --
------------------------------------------------
------------------------------------------------

-- Sounds CC0 Creative Commons
-- Code  WTFPL


	  
	
beverage = 	{
	version = 1.2,
			}	
			
			
			
-- Inllib support for localization

local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
		

-- Register beverages

function register_beverage(def)
	local name = def.name
	local description = def.description or ""
	
	if def.wherein == "cup" then 
	cuptexture = def.cuptexture or "cup.png^[colorize:#CD5C5C:90" 
	else if def.wherein == "glasses" then 
	cuptexture = def.cuptexture or "liquid_cold_bottom.png" 
	end end
	
	local liquidcolour = def.liquidcolour or "#8B4513:190"
	local recipe = def.recipe
	local recipe2 = def.recipe2 or def.recipe
	local heat = def.heat or "cold"
	local wherein = def.wherein or "cup"
	
	if def.wherein == "cup" then
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
		}
		end
		
	if def.wherein == "cup" then			
	tiles = {
				{name= ''..cuptexture..'^(liquid.png^[colorize:'..liquidcolour..')'},
				{name= ''..cuptexture},
			}	
	end	
	
	if def.wherein == "glasses" then
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.125, 0.125, 0, 0.1875}, -- bottom
			{-0.1875, -0.5, -0.125, 0.125, 0.0625, -0.0625}, -- left
			{-0.1875, -0.5, 0.125, 0.125, 0.0625, 0.1875}, -- right
			{0.0625, -0.5, -0.125, 0.125, 0.0625, 0.1875}, -- back
			{-0.1875, -0.5, -0.125, -0.125, 0.0625, 0.1875}, -- front
		}
	}
	end
	
	if def.wherein == "glasses" then
	tiles = {
				{name= 'liquid_cold_top.png^liquid_cold_bottom.png^(liquid.png^[colorize:'..liquidcolour..')'},
				{name= 'liquid_cold_top.png^('..cuptexture..'^[colorize:'..liquidcolour..')'},
			}	
	end
	
	if def.wherein == "cup" then
	inventory_image = "cupinv.png^(invin.png^[colorize:"..liquidcolour..")"
	else if def.wherein == "glasses" then 
	inventory_image = "glassesinv.png^(invin.png^[colorize:"..liquidcolour..")"
	end end
	
	minetest.register_node("beverage:"..name, {
		description = description,
		drawtype = "nodebox",
		use_texture_alpha = true,
		paramtype = "light",
		is_ground_content = false,
		walkable = false,
		inventory_image = inventory_image,
		drop = "vessels:glass_fragments",
		groups = {dig_immediate=3,attached_node=1},
		sounds = default.node_sound_glass_defaults(),
		on_use =  function(itemstack, user, pointed_thing)
		if def.heat == "hot" then
						   minetest.sound_play("beverage_hot", {
						   pos = pos, gain = 0.7, hear_distance = 5})
						   else
						   minetest.sound_play("beverage_cold", {
						   pos = pos, gain = 0.7, hear_distance = 5})
						   
		end				   
					if minetest.get_modpath("thirsty") then
						thirsty.drink(user, 5, 20)
					else
						minetest.item_eat(5, "beverage:"..wherein)
					end
		end,

		after_place_node = function(pos, placer, itemstack)
			if placer:is_player() then
			minetest.set_node(pos, {name="beverage:"..name, param2=1})
			end
		end,

		tiles = tiles,
		node_box = node_box,
		
	})
	
	-- Crafting
	
	minetest.register_craft({
	output = 'beverage:'..name,
	recipe = {
		{recipe, '', ''},
		{recipe2, '', ''},
		{'beverage:cup', '', ''},
			 }
	})


	
	-- Steam animation for hot drinks
	-- From farming plusplus mod by MTDad

if def.heat == "hot" then 
	
minetest.register_abm({
		nodenames = {
				"beverage:"..name
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
end



------------ Empty cup

minetest.register_node("beverage:cup", {
	description = S("Cup"),
	drawtype = "nodebox",
	paramtype = "light",
	stack_max = 99,
	liquids_pointable = true,
	inventory_image = "cupinv.png",
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


	minetest.register_craft({
	output = 'beverage:cup',
	recipe = {
		{'', '', ''},
		{'vessels:glass_fragments', 'vessels:glass_fragments', ''},
		{'vessels:glass_fragments', 'vessels:glass_fragments', 'vessels:glass_fragments'},
			 }
	})

	
	
----------------- Empty Glasses
	
	minetest.register_node("beverage:glasses", {
	description = S("Glasses"),
	drawtype = "nodebox",
	paramtype = "light",
	stack_max = 99,
	liquids_pointable = true,
	use_texture_alpha = true,
	inventory_image = "glassesinv.png",
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

			
dofile(minetest.get_modpath("beverage").."/beverages.lua")
