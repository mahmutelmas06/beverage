------------------------------------------------
------------------------------------------------
----------- Beverage Mod Api by Mahmutelmas06 --
------------------------------------------------
------------------------------------------------

-- Sounds CC0 Creative Commons
-- Beverage_boiling sound from bigsoundbank.com
-- Code  MIT


	  
	
beverage = 	{
version = 1.7,
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
	local liquidcolour = def.liquidcolour
	local recipe = def.recipe
	local recipe2 = def.recipe2 or def.recipe
	local heat = def.heat or "hot"
	local wherein = def.wherein or "cup"
    local tintile = def.tintile or "beverage_tinside.png"
    local tininv = def.tininv or "beverage_tininv.png^[colorize:"..liquidcolour
  
  
  local cuptexture
  
	if def.wherein == "cup" then 
	cuptexture = def.cuptexture or "cup.png^[colorize:#CD5C5C:90" 
  
	else if def.wherein == "glasses" then 
	cuptexture = def.cuptexture or "liquid_cold_bottom.png" 
  
	end end
	

	
  
  -- Nodebox for Cup, Glasses
  
  local node_box
  
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
		
    else
		
	
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
	
		
end end

-- Tiles for glasses, cup

local tiles


			if def.wherein == "glasses" then
	tiles = {
				{name= 'liquid_cold_top.png^liquid_cold_bottom.png^(liquid.png^[colorize:'..liquidcolour..')'},
				{name= 'liquid_cold_top.png^('..cuptexture..'^[colorize:'..liquidcolour..')'},
			}	
	
  else
  
  	if def.wherein == "cup" then			
	tiles = {
				{name= ''..cuptexture..'^(liquid.png^[colorize:'..liquidcolour..')'},
				{name= ''..cuptexture},
			}	

  
end end


-- Inventory images for beverages

local inventory_image

	if def.wherein == "cup" then  
	inventory_image = "cupinv.png^(invin.png^[colorize:"..liquidcolour..")"
  
	else 
	
	if def.wherein == "glasses" then 
	inventory_image = "glassesinv.png^(invin.png^[colorize:"..liquidcolour..")"
  
end end
	
  
  -- Node definition for beverages, cups, glasses, tin
  
	minetest.register_node("beverage:"..name, {
        
		description = description,
		drawtype = "nodebox",
		use_texture_alpha = true,
		paramtype = "light",
		is_ground_content = false,
		walkable = false,
		inventory_image = inventory_image,
		groups = {dig_immediate=3,attached_node=1},
		sounds = default.node_sound_glass_defaults(),
        stack_max = 20,
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
						minetest.item_eat(5)
					end
          
          itemstack:take_item()
          return itemstack
          
		end,

		after_place_node = function(pos, placer, itemstack)
			if placer:is_player() then
			minetest.set_node(pos, {name="beverage:"..name, param2=1})
			end
		end,

		tiles = tiles,
		node_box = node_box,
		
	})
	

-- Make tin versions of cold beverages. You can get them from vending machine

if def.heat == "cold" then 

  	minetest.register_node("beverage:"..name.."_tin", {
		description = description..S(" Tin"),
		drawtype = "nodebox",
		use_texture_alpha = true,
		paramtype = "light",
		inventory_image = tininv,
		is_ground_content = false,
		walkable = false,
		groups = {dig_immediate=3,attached_node=1},
		stack_max = 20,
		on_use =  function(itemstack, user, pointed_thing)
				minetest.sound_play("beverage_cold", {
				pos = pos, gain = 0.7, hear_distance = 5})
						   
			   	if minetest.get_modpath("thirsty") then
						thirsty.drink(user, 5, 20)
					else
						minetest.item_eat(5)
					end
          
          itemstack:take_item()
          return itemstack
		end,
		tiles = {
		"beverage_tintop.png",
		"default_steel_block.png",
		"(cup.png^[colorize:"..liquidcolour..")^"..tintile,
		"(cup.png^[colorize:"..liquidcolour..")^"..tintile,
		"(cup.png^[colorize:"..liquidcolour..")^"..tintile,
		"(cup.png^[colorize:"..liquidcolour..")^"..tintile
            },
		node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, -0.125, 0.125}, -- front
		}
	}
		
	})

	
	
-- Crafting for cold beverages ( You can cook hot beverages with Kettle )
	
	minetest.register_craft({
	output = 'beverage:'..name,
	recipe = {
		{'', recipe, ''},
		{'', recipe2, ''},
		{'', 'vessels:drinking_glass', ''},
			 }
	})
	
end
 
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


  --- Crafting for hot beverages
  
  minetest.register_craft({
	output = 'beverage:'..name,
	recipe = {
	{'vessels:glass_fragments', recipe, 'vessels:glass_fragments'},
	{'vessels:glass_fragments', recipe2, 'vessels:glass_fragments'},
	{'', 'default:torch', ''},
			 }
	                        })
	

end end
  
  ----------------------------
  ----------------------------
  ----------------------------
  ----------- Vending Machine
  ---------------------------
  ----------------------------
  ----------------------------


local beveragetin =  {"beverage:applejuice_tin",
                      "beverage:orangejuice_tin", 
                      "beverage:berryjuice_tin", 
                      "beverage:lemonade_tin"
								}

minetest.register_node("beverage:vending", {
  description = S("Vending Machine"),
  drawtype = "mesh",
  mesh = "homedecor_soda_machine.obj",
  inventory_image = "beverage_vendinginv.png",
  paramtype = "light",
  paramtype2 = "facedir",
  tiles = {"beverage_vending.png"},
  groups = {snappy=3},
  selection_box = {
		 type = "fixed",
     fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
	},
	expand = { top="placeholder" }, 
	sounds = default.node_sound_glass_defaults(),
	on_rotate = screwdriver.rotate_simple,
	on_punch = function(pos, node, puncher, pointed_thing)
		local wielditem = puncher:get_wielded_item()
		local wieldname = wielditem:get_name()
		local fdir_to_fwd = { {0, -1}, {-1, 0}, {0, 1}, {1, 0} }
		local fdir = node.param2
		local pos_drop = { x=pos.x+fdir_to_fwd[fdir+1][1], y=pos.y, z=pos.z+fdir_to_fwd[fdir+1][2] }
    
    if wieldname == "bitchange:minecoin" or 
       wieldname == "default:gold_lump" or 
       wieldname == "currency:minegeld" or
       wieldname == "currency:minegeld_5" or
       wieldname == "currency:minegeld_10" or
       wieldname == "mint:pences" or
       wieldname == "mint:shillings" or
       wieldname == "mint:pounds" or
       wieldname == "bitchange:mineninth" or
       wieldname == "homedecor:coin"
      then
      wielditem:take_item()
			puncher:set_wielded_item(wielditem)
      local beveragetins = beveragetin
      local RndChoice = beveragetins[math.random( #beveragetins )]
			minetest.spawn_item(pos_drop, RndChoice)
			minetest.sound_play("insert_coin", {
				pos=pos, max_hear_distance = 5
			})
		else
			minetest.chat_send_player(puncher:get_player_name(), S("Please insert a coin in the machine."))
		end
	end
})

		-- Crafting
	
	minetest.register_craft({
	output = 'beverage:vending',
	recipe = {
		{'', 'default:iron_lump', ''},
		{'', 'vessels:glass_fragments', ''},
		{'', 'default:iron_lump', ''},
			 }
	})

	
	


---------------------------
---------------------------	
--- Other Files to run -
			
dofile(minetest.get_modpath("beverage").."/beverages.lua")    -- Register custom beverages
