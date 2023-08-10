return function(DrXiaElements)
	local Collectibles={
		{
			DrXiaElements.COLLECTIBLE_CARDIOGRAPH,
			"血量越多，角色的{{Damage}}伤害越高#当角色仅有半颗心时，{{Damage}}伤害修正x61%# 当角色有5颗心时，伤害不变#当角色有12颗心时，{{Damage}}伤害修正x215.77%",
			"心电图仪",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER,
			"跟踪泪弹#↑ {{Tears}} +0.5射速修正#↑ {{Range}} 射程修正+20%#未命中的泪弹有概率对随机敌人造成伤害#{{Luck}} 运气10：100%概率",
			"黄金弯勺魔术",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_MORNING_SCHEDULE,
			"↑ {{Speed}} +0.8移速#{{Warning}} 不会超出移速上限",
			"早八课程表",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST,
			"所有的诅咒都变为{{CurseLost}}迷途诅咒#↑ {{Speed}} +0.2移速",
			"路痴综合征",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_ADVANCED_MATHEMATICS,
			"{{Confusion}} 使用后，房间内所有敌人混乱2.5秒 #{{Slow}} 触发一次\"好困...\"的效果",
			"高等数学",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_CRYING_WHITE_FRUIT,
			"↓ 使用后，角色受到两颗心的伤害#角色获得护盾效果，持续10秒#冷却时间15秒#{{Warning}} 优先伤害红心#{{Warning}} 不致死",
			"哭泣的白果子",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_TB_ANGER,
			"{{Warning}} 一次性#使用后，随机生成一个品质为{{Quality0}}的底座道具#与房间道具池互不影响",
			"生气",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_FAT_SHARK,
			"↑ {{Tears}} +0.3射速修正#↑ {{Damage}} +0.5伤害修正#↑ {{Range}} +10%射程修正#↓ {{Shotspeed}} -0.1弹速#{{Charm}} 4%概率发射魅惑泪弹#{{Luck}} 运气24：100%概率",
			"肥肥鲨",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_TENSHI_DOLL,
			"飞行#{{SoulHeart}} +2魂心#↑ {{Tears}} +0.5射速修正#↑ {{Shotspeed}} +0.2弹速#每发射25颗泪弹，产生一次小型地震，造成全图伤害{{ColorRed}}或{{ColorText}}全图摧毁",
			"天子玩偶",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_IDLE_DOG,
			"{{Freezing}} 受伤时使房间内的所有敌人石化1秒#主动伤害也可以触发效果",
			"懒散柴犬",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_PUSHEEN_CAT,
			"持有时按{{ColorLime}}J键{{ColorText}}向移动方向跳跃",
			"胖吉猫",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD,
			"↑ {{Speed}} +0.3移速#↑ {{Damage}} +1.14伤害#↑ {{Range}} +3.0射程#↑ 泪弹变大#↑ 击退增强#↑ 角色可以撞开敌人并造成伤害",
			"冬之花唱片",
			"zh_cn"
		},
		{
			DrXiaElements.COLLECTIBLE_CARDIOGRAPH,
			"More health, more {{Damage}}damage#When Isaac has only a half heart ,{{Damage}} Damage x61%# When Isaac has 5 hearts, the damage doesn't change#When Isaac has 12 hearts,{{Damage}} damage x215.77%"
		},
		{
			DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER,
			"Homing tears#↑ {{Tears}} +0.5 tears#↑ {{Range}} Range +20%#Missing tears are likely to deal damage to a random enemy in the room#{{Luck}} 10 Luck：100% chance",
		},
		{
			DrXiaElements.COLLECTIBLE_MORNING_SCHEDULE,
			"↑ {{Speed}} +0.8 Speed#{{Warning}} The limitation of the speed of 2.0 can't be transcended",
		},
		{
			DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST,
			"All the curses will be {{CurseLost}}Curse of the Lost#↑ {{Speed}} +0.2 Speed",
		},
		{
			DrXiaElements.COLLECTIBLE_ADVANCED_MATHEMATICS,
			"{{Confusion}} Apply confusion to all the enemies in the room for 2.5 seconds #{{Slow}} Raise the effect of \"I'm Drowsy\"",
		},
		{
			DrXiaElements.COLLECTIBLE_CRYING_WHITE_FRUIT,
			"↓ Deal a 2-heart damage to Isaac#Grant a shield effect to Isaac for 10 seconds#15-second cooldown#{{Warning}} Red hearts enjoy priority#{{Warning}} Won't cause death"
		},
		{
			DrXiaElements.COLLECTIBLE_TB_ANGER,
			"{{Warning}} One time use#Spawn a random collectible of quality {{Quality0}}#Not related to any Item Pools at all"
		},
		{
			DrXiaElements.COLLECTIBLE_FAT_SHARK,
			"↑ {{Tears}} +0.3 tears#↑ {{Damage}} +0.5 damage#↑ {{Range}} +10% range#↓ {{Shotspeed}} -0.1 shot speed#{{Charm}} 4% chance to fire charming tears#{{Luck}} 24 Luck: 100% chance"
		},
		{
			DrXiaElements.COLLECTIBLE_TENSHI_DOLL,
			"Flight#{{SoulHeart}} +2 soul hearts#↑ {{Tears}} +0.5 tears#↑ {{Shotspeed}} +0.2 shotspeed#Raise an earthquake every 25 tears, dealing damage to all the enemies or destroy obstacles in the current room"
		},
		{
			DrXiaElements.COLLECTIBLE_IDLE_DOG,
			"{{Freezing}} When hurt, freeze all the enemies in the current room for 1 second#Self damages also count"
		},
		{
			DrXiaElements.COLLECTIBLE_PUSHEEN_CAT,
			"Press {{ColorLime}}J{{ColorText}} to leap towards the moving direction"
		},
		{
			DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD,
			"↑ {{Speed}} +0.3 speed#↑ {{Damage}} +1.14 damage#↑ {{Range}} +3.0 range#↑ Tear size up#↑ Stronger knockbacks#↑ Isaac may knock enemies back and deal damage"
		}
	}
	local Trinkets={
		{
			DrXiaElements.TRINKET_LIL_PIGGY,
			"↑ {{Tears}} 每叠加一层{{ColorCyan}}稳定{{ColorText}}跟踪效果或拥有一个自身发射跟踪泪弹的跟班，+1射速修正",
			"猪猪",
			"zh_cn"
		},
		{
			DrXiaElements.TRINKET_XIAS_ROSARY_BEAD,
			"8%概率将道具替换为{{Collectible3}}弯勺魔术# 2%概率将道具替换为{{Collectible"..DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER.."}}黄金弯勺魔术",
			"夏之念珠段",
			"zh_cn"
		},
		{
			DrXiaElements.TRINKET_CRACKED_SPOON_BENDER,
			"每隔5秒钟获得1秒{{Collectible3}}弯勺魔术的效果",
			"断裂的弯勺魔术",
			"zh_cn"
		},
		{
			DrXiaElements.TRINKET_LIL_PIGGY,
			"↑ {{Tears}} +1 tears when a layer of {{ColorCyan}}stable{{ColorText}} homing effect is stacked, including familiars who fire their own homing tears"
		},
		{
			DrXiaElements.TRINKET_XIAS_ROSARY_BEAD,
			"Item has a 8% chance to alter to {{Collectible3}}Spoon Bender# 2% chance to alter to {{Collectible"..DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER.."}}Golden Spoon Bender",
		},
		{
			DrXiaElements.TRINKET_XIAS_ROSARY_BEAD,
			"Grant the effect of {{Collectible3}}Spoon Bender for 1 seconds after each 5-second interval"
		}

	}
	local Cards={
		{
			DrXiaElements.CARD_CARD_OF_DRXIA,
			"使用后，{{ColorRed}}先重置{{ColorText}}房间中的所有道具，{{ColorRed}}再复制{{ColorText}}房间中的所有道具和掉落物",
			"夏老师运营卡",
			"zh_cn"
		},
		{
			DrXiaElements.CARD_CARD_OF_DRXIA,
			"Upon use, reroll all the collectibles, {{ColorRed}}then{{ColorText}} duplicate all the collectibles and pickups in the current room"
		}
	}
	local Pills={
		{
			DrXiaElements.PILL_APPETIZING,
			"使用后，当前房间内玩家的移动操作反转，发射操作不变",
			"下饭!",
			"zh_cn"
		},
		{
			DrXiaElements.PILL_APPETIZING,
			"Upon use, the control of movement is reversed while that of firing remains unchanged"
		}
	}
	
	return Collectibles,Trinkets,Cards,Pills
end