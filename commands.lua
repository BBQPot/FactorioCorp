/sc
apflu="apflu"
bbq="BoingBoingQ"
du="ChaosticMoon"
xiaowu="qipika"
weak="mhz123"
zz="jiushazaizhi"
LD="winterVII"


home={0.5,0.5}
rock={-109.5,89.5}
coppper={48.5,-126.5}
gas={-23.5,140.5}
ball={555.5,176.5}
stuff={89.5,-9.5}
u={445.90,-308.49} 

last_position={}

function tp(target)
    last_position[game.player.name]=game.player.position
    game.player.teleport(target)
end

function tpto(target)
    last_position[game.player.name]=game.player.position
    local position=game.players[target].position
    game.player.teleport({position.x+1, position.y+1})
end

function back()
    if(last_position[game.player.name] == nil) then
        tp(home)
    else
        tp(last_position[game.player.name])
    end
end

function give(item, amount)
    game.player.insert{name=item, count=amount}
    game.print({"", game.player.name, " ", "使用不光彩的手段获得了", "", amount,"", "个", " ", geticon(item), "", getname(item), "", "！"})
end

function getpos()
    local position = game.player.position
    game.print(game.player.name .. "位于[gps=" .. position.x .. "," .. position.y .. "," .. game.player.surface.name .. "]")
end

function geticon(item_id)
    return "[img=item." .. item_id .. "]"
end

function getname(item_id)
    return game.item_prototypes[item_id].localised_name
end

function findcorpse()
    local found_corpses = game.player.surface.find_entities_filtered{type="character-corpse"}
    for _,corpse in pairs(found_corpses) do
        local player = game.get_player(corpse.character_corpse_player_index)
        local name = player and player.name or "????"
        game.print(name .. " --> [gps=" .. corpse.position.x .. "," .. corpse.position.y .. "]")
    end
end

function speedup(factor)
    for _,player in pairs(game.players) do
        player.force.manual_crafting_speed_modifier=factor
        game.print(game.player.name .. "将手搓制造速度设置成了" .. factor .. "倍！")
    end
end

function reach(distance)
    for _,player in pairs(game.players) do
        player.force.character_build_distance_bonus = distance
        game.print(game.player.name .. "将触及距离设置成了" .. distance .. "倍！")
    end
end

function tree()
    math.randomseed(game.tick)
    local radius = 10
    local interval = 16
    local type = "tree-0"
    for y=-radius,radius do
	    for x=-radius,radius do
		    thisX = game.player.position.x+x*2+math.random(1,interval)
		    thisY = game.player.position.y+y*2+math.random(1,interval)
		    thistiletype = game.player.surface.get_tile(thisX, thisY).name
		    if thistiletype ~= "water" and thistiletype ~= "deepwater" then
			    game.surfaces.nauvis.create_entity({ name=type .. math.random(1,4), amount=1, position={thisX,thisY}})
		    end
	    end
    end
end

function clearinv()
    game.player.character.clear_items_inside()
    game.print(game.player.name .. "清空了自己的物品栏。")
end

game.print("初始化完成！")
