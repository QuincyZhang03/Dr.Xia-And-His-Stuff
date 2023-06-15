local DrXiaElements={}

local ItemTrsl = include("lib.ItemTranslate")
ItemTrsl("drxia and his stuff")
DrXiaElements.COLLECTIBLE_CARDIOGRAPH=Isaac.GetItemIdByName("Cardiograph")
DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER=Isaac.GetItemIdByName("Golden Spoon Bender")
DrXiaElements.COLLECTIBLE_MORNING_SCHEDULE=Isaac.GetItemIdByName("Morning Schedule")
DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST=Isaac.GetItemIdByName("Syndrome of Lost")
DrXiaElements.COLLECTIBLE_ADVANCED_MATHEMATICS=Isaac.GetItemIdByName("Advanced Mathematics")
DrXiaElements.COLLECTIBLE_CRYING_WHITE_FRUIT=Isaac.GetItemIdByName("Crying White Fruit")
DrXiaElements.COLLECTIBLE_TB_ANGER=Isaac.GetItemIdByName("TB Anger")
DrXiaElements.COLLECTIBLE_FAT_SHARK=Isaac.GetItemIdByName("Fat Shark")
DrXiaElements.COLLECTIBLE_TENSHI_DOLL=Isaac.GetItemIdByName("Tenshi Doll")
DrXiaElements.COLLECTIBLE_IDLE_DOG=Isaac.GetItemIdByName("Idle Dog")
DrXiaElements.COLLECTIBLE_PUSHEEN_CAT=Isaac.GetItemIdByName("Pusheen Cat")
DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD=Isaac.GetItemIdByName("Winter Flower Record")

DrXiaElements.TRINKET_LIL_PIGGY=Isaac.GetTrinketIdByName("Lil Piggy")

DrXiaElements.CHARACTER_DRXIA=Isaac.GetPlayerTypeByName("DrXia")
DrXiaElements.COSTUME_DRXIA_HAIR=Isaac.GetCostumeIdByPath("gfx/characters/character_drxia_accessories.anm2")

DrXiaElements.CARD_CARD_OF_DRXIA=Isaac.GetCardIdByName("Card of Dr.Xia")

DrXiaElements.PILL_APPETIZING=Isaac.GetPillEffectByName("Appetizing!")
DrXiaElements.SOUND_APPETIZING=Isaac.GetSoundIdByName("Pill_Appetizing")

DrXiaElements.CHALLENGE_EVERYTHING_SMASHED=Isaac.GetChallengeIdByName("Everything Smashed!")

local Collectibles = {
	[DrXiaElements.COLLECTIBLE_CARDIOGRAPH] = {   
		zh = {"心电图仪", "心跳的力量!"},
	},
	[DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER]={
		zh = {"黄金弯勺魔术", "这才叫手感"}
	},
	[DrXiaElements.COLLECTIBLE_MORNING_SCHEDULE]={
		zh = {"早八课程表", "草，又迟到了!"}
	},
	[DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST]={
		zh = {"路痴综合征", "我来过这吗...?"}
	},
	[DrXiaElements.COLLECTIBLE_ADVANCED_MATHEMATICS]={
		zh={"高等数学","狗都不学"}
	},
	[DrXiaElements.COLLECTIBLE_CRYING_WHITE_FRUIT]={
		zh={"哭泣的白果子","哇呜呜呜..."}
	},
	[DrXiaElements.COLLECTIBLE_TB_ANGER]={
		zh={"生气",'"这给的啥啊!"'}
	},
	[DrXiaElements.COLLECTIBLE_FAT_SHARK]={
		zh={"肥肥鲨","夏老师的最爱"}
	},
	[DrXiaElements.COLLECTIBLE_TENSHI_DOLL]={
		zh={"天子玩偶","可爱又强大!"}
	},
	[DrXiaElements.COLLECTIBLE_IDLE_DOG]={
		zh={"懒散柴犬","啊这..."}
	},
	[DrXiaElements.COLLECTIBLE_PUSHEEN_CAT]={
		zh={"胖吉猫","蹦蹦跳跳的"}
	},
	[DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD]={
		zh={"冬之花唱片","你要往哪移"}
	}
}
local Trinkets={
	[DrXiaElements.TRINKET_LIL_PIGGY]={
		zh={"猪猪","哦..."}
	}
}
local Pills={
	["Appetizing!"]={
		zh={"下饭!"}
	}
}
local Cards={
	["Card of Dr.Xia"]={
		zh={"夏老师运营卡","神级运营!"}
	}
}
local Birthrights ={
	[DrXiaElements.CHARACTER_DRXIA]={
		zh={"心跳加速"}
	}
}

local translation = {
	["Collectibles"] = Collectibles,
	["Trinkets"]=Trinkets,
	["Pills"]=Pills,
	["Cards"]=Cards,
	["Birthrights"]=Birthrights
}

ItemTranslate.AddModTranslation("drxia and his stuff",translation)

return DrXiaElements