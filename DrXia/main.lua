local DrXia = RegisterMod("Dr.Xia And His Stuff", 1)

local DrXiaElements = include("registry")

DrXiaAPI = {}

function DrXiaAPI:GetDrXiaElements()
	return DrXiaElements
end

function DrXia:getVanillaTearsMultiplier(player)
	local multiplier = 1.0

	local playerType = player:GetPlayerType()
	if playerType == PlayerType.PLAYER_AZAZEL then
		multiplier = multiplier * 4 / 15
	elseif playerType == PlayerType.PLAYER_THEFORGOTTEN or playerType == PlayerType.PLAYER_THEFORGOTTEN_B then
		multiplier = multiplier * 0.5
	elseif playerType == PlayerType.PLAYER_EVE_B then
		multiplier = multiplier * 0.66
	elseif playerType == PlayerType.PLAYER_AZAZEL_B then
		multiplier = multiplier / 3
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_DROPS) then
		multiplier = multiplier * 1.2
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) then
		multiplier = multiplier * 0.42
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE) then
		multiplier = multiplier * 0.51
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
		multiplier = multiplier / 3 --直接当1/3算了
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) then
		multiplier = multiplier * 0.4
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE)
		or player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
		multiplier = multiplier / 3
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then
		multiplier = multiplier * 2 / 3
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) then
		multiplier = multiplier * 10 / 43
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
		multiplier = multiplier * 0.66
	end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then
		multiplier = multiplier * 4
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_SOY_MILK) then
		multiplier = multiplier * 5.5
	end

	return multiplier
end

function DrXia:getHealth(player)
	return player:GetHearts() + player:GetSoulHearts() - player:GetRottenHearts()
end

function DrXia:getHealthMultiplier(player)
	local health = DrXia:getHealth(player)
	return 3 ^ (health / 20 - 0.5)
end

function DrXia:getHealthMultiplier_B(player) --DrXia with birthright
	local health = DrXia:getHealth(player)
	return 3 ^ ((health + 4) / 20 - 0.5)
end

function DrXia:getHomingStorey(player)
	return player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SPOON_BENDER) +
		player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SACRED_HEART) +
		player:GetCollectibleNum(CollectibleType.COLLECTIBLE_GODHEAD) +
		player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) +
		player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SERAPHIM) +
		player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LITTLE_STEVEN) +
		player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_TELEPATHY_BOOK) + --[[The magician included]]
		player:GetTrinketMultiplier(TrinketType.TRINKET_BABY_BENDER) --[[Mom's Box included]]
end

function DrXia:addTearsModifier(player, amount)
	local originalTears = 30 / (player.MaxFireDelay + 1)
	local tears = originalTears + amount * DrXia:getVanillaTearsMultiplier(player)
	player.MaxFireDelay = 30 / tears - 1
end

function DrXia:updateCollectibles(player)
	if DrXia:getHealth(player) ~= player:GetData().lastHealth then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_CARDIOGRAPH) then
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
			player:GetData().lastHealth = DrXia:getHealth(player)
		end
	end
	if DrXia:getHomingStorey(player) ~= player:GetData().lastHomingStorey then
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		player:EvaluateItems()
		player:GetData().lastHomingStorey = DrXia:getHomingStorey(player)
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, DrXia.updateCollectibles)


function DrXia:updateCache(player, flag)
	if flag == CacheFlag.CACHE_SPEED then
		if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA then
			player.MoveSpeed = player.MoveSpeed - 0.1
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_MORNING_SCHEDULE) then
			player.MoveSpeed = player.MoveSpeed +
				0.8 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_MORNING_SCHEDULE)
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST) then
			player.MoveSpeed = player.MoveSpeed +
				0.2 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST)
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD) then
			player.MoveSpeed = player.MoveSpeed +
				0.3 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD)
		end
	elseif flag == CacheFlag.CACHE_DAMAGE then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_CARDIOGRAPH) then
			if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA and
				player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				player.Damage = player.Damage * DrXia:getHealthMultiplier_B(player)
			else
				player.Damage = player.Damage * DrXia:getHealthMultiplier(player)
			end
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_FAT_SHARK) then
			player.Damage = player.Damage + 0.5 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_FAT_SHARK)
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD) then
			player.Damage = player.Damage + 1.14 *
				player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD)
		end
	elseif flag == CacheFlag.CACHE_FIREDELAY then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) then
			DrXia:addTearsModifier(player, 0.5 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER))
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_FAT_SHARK) then
			DrXia:addTearsModifier(player, 0.3 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_FAT_SHARK))
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_TENSHI_DOLL) then
			DrXia:addTearsModifier(player, 0.5 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_TENSHI_DOLL))
		end
		if player:HasTrinket(DrXiaElements.TRINKET_LIL_PIGGY) then
			DrXia:addTearsModifier(player, 1.0 * DrXia:getHomingStorey(player))
		end
	elseif flag == CacheFlag.CACHE_RANGE then
		if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA then
			player.TearRange = player.TearRange * 1.1
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) then
			player.TearRange = player.TearRange * (1 + 0.2 *
				player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER))
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_FAT_SHARK) then
			player.TearRange = player.TearRange *
				(1 + 0.1 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_FAT_SHARK))
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD) then
			player.TearRange = player.TearRange +
				3.0 * 40 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD)
		end
	elseif flag == CacheFlag.CACHE_SHOTSPEED then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_FAT_SHARK) then
			player.ShotSpeed = player.ShotSpeed - 0.1 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_FAT_SHARK)
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_TENSHI_DOLL) then
			player.ShotSpeed = player.ShotSpeed + 0.2 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_TENSHI_DOLL)
		end
	elseif flag == CacheFlag.CACHE_LUCK then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_PUSHEEN_CAT) then
			player.Luck = player.Luck + 1 * player:GetCollectibleNum(DrXiaElements.COLLECTIBLE_PUSHEEN_CAT)
		end
	elseif flag == CacheFlag.CACHE_TEARCOLOR then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) then
			player.TearColor = Color(1, 1, 0, 1, 0.3, 0.3, 0)
			player.LaserColor = Color(0.85, 1, 0, 1, 0, 0.3, 0)
		end
	elseif flag == CacheFlag.CACHE_TEARFLAG then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HOMING
		end
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD) then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_KNOCKBACK
		end
	elseif flag == CacheFlag.CACHE_FLYING then
		if player:HasCollectible(DrXiaElements.COLLECTIBLE_TENSHI_DOLL) then
			player.CanFly = true
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, DrXia.updateCache)

--Golden Spoon Bender special features start
local tears_fired = {}
function DrXia:onEnterNewRoom()
	tears_fired = {}
end

function DrXia:onTearFire(tear)
	if tear.SpawnerType == EntityType.ENTITY_PLAYER then
		local shooter = tear.SpawnerEntity:ToPlayer()
		if shooter:HasCollectible(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) then
			tears_fired[tear.TearIndex] = { t = tear, hit = false }
		end
	end
end

function DrXia:onTearCollide(tear, target)
	if tears_fired[tear.TearIndex] and target:IsEnemy() then
		tears_fired[tear.TearIndex].hit = true
	end
end

function DrXia:checkMissedTears(player)
	if player:HasCollectible(DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER) then
		for index, info in pairs(tears_fired) do
			local tear = info.t
			local hit = info.hit
			if not tear:Exists() and not hit then
				local chance = 0.2
				if player.Luck > 0 then
					chance = math.log(player.Luck + 1, 10)
				end
				if math.random() < chance then
					local room_entities = Isaac.GetRoomEntities()
					local enemies = {}
					for _, entity in ipairs(room_entities) do
						if entity:IsVulnerableEnemy() then
							enemies[#enemies + 1] = entity
						end
					end
					if #enemies > 0 then
						enemies[math.random(#enemies)]:TakeDamage(player.Damage * 1.0, 0, EntityRef(player), 0)
					end
				end
				tears_fired[index].hit = true
			end
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DrXia.onEnterNewRoom)
DrXia:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, DrXia.onTearFire)
DrXia:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, DrXia.onTearCollide)
DrXia:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, DrXia.checkMissedTears)
--Golden Spoon Bender end

function DrXia:adjustCurse(curses)
	for i = 0, Game():GetNumPlayers() - 1 do
		if Game():GetPlayer(i):HasCollectible(DrXiaElements.COLLECTIBLE_SYNDROME_OF_LOST) then
			return curses == LevelCurse.CURSE_NONE and curses or LevelCurse.CURSE_OF_THE_LOST
		end
	end
	return curses
end

DrXia:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, DrXia.adjustCurse)

local DrXiaHasCostume = false
function DrXia:GiveDrXiaCostumes(player)
	if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA then
		if not DrXiaHasCostume then
			player:AddNullCostume(DrXiaElements.COSTUME_DRXIA_HAIR)
			DrXiaHasCostume = true
		end
	elseif DrXiaHasCostume then
		DrXiaHasCostume = false
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, DrXia.GiveDrXiaCostumes)

local RunContinued = false
local optionsdone = false
function DrXia:MoreOptions()
	local drxia_exist = false
	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Game():GetPlayer(i)
		if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA then
			drxia_exist = true
			break
		end
	end
	if RunContinued or
		optionsdone or
		not drxia_exist or
		Game():IsGreedMode() or
		Isaac.GetChallenge() ~= Challenge.CHALLENGE_NULL or
		Game():GetLevel():GetStage() ~= 1 then
		return
	end
	local room = Game():GetRoom()
	if room:GetType() ~= RoomType.ROOM_TREASURE then
		return
	end
	local entities = Isaac.GetRoomEntities()
	local roomTreasures = {}
	for _, ent in ipairs(entities) do
		if ent.Type == 5 and ent.Variant == 100 then
			roomTreasures[#roomTreasures + 1] = ent:ToPickup()
			ent:Remove()
		end
	end
	local lacks = 4 - #roomTreasures >= 0 and 4 - #roomTreasures or 0
	local pos = room:GetCenterPos()
	for _, col in ipairs(roomTreasures) do
		local spawnpos = room:FindFreePickupSpawnPosition(pos)
		local choice = Isaac.Spawn(5, 100, col.SubType, spawnpos, Vector(0, 0), nil):ToPickup()
		choice.OptionsPickupIndex = 10
	end
	for i = 1, lacks do
		local spawnpos = room:FindFreePickupSpawnPosition(pos)
		local selected_collectible = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE, true,
			Game():GetSeeds():GetStartSeed())
		local choice = Isaac.Spawn(5, 100, selected_collectible, spawnpos, Vector(0, 0), nil):ToPickup()
		choice.OptionsPickupIndex = 10
	end
	optionsdone = true
end

DrXia:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DrXia.MoreOptions)

function DrXia:InitDrXia(continued)
	if not continued then
		for i = 0, Game():GetNumPlayers() - 1 do
			local player = Game():GetPlayer(i)
			if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA then
				player:AddCollectible(DrXiaElements.COLLECTIBLE_CARDIOGRAPH)
				player:AddCollectible(CollectibleType.COLLECTIBLE_SPOON_BENDER)
				player:RemoveCostume(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_SPOON_BENDER))
			end
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DrXia.InitDrXia)

function DrXia:RedHeartDamage(target, amount, flags, source, countdown)
	local player = target:ToPlayer()
	if player:GetPlayerType() == DrXiaElements.CHARACTER_DRXIA then
		if (not (flags | DamageFlag.DAMAGE_NO_PENALTIES == flags or flags | DamageFlag.DAMAGE_RED_HEARTS == flags))
			and DrXia:getHealth(player) < 10 then
			Game():GetLevel():SetRedHeartDamage()
			Game():GetRoom():SetRedHeartDamage()
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, DrXia.RedHeartDamage, EntityType.ENTITY_PLAYER)

function DrXia:OnUseAdvancedMathematics(item, rng, player, flags, slot, data)
	local roomentities = Isaac.GetRoomEntities()
	for _, ent in ipairs(roomentities) do
		if ent:IsVulnerableEnemy() then
			ent:AddConfusion(EntityRef(player), 75, false)
		end
	end
	player:UsePill(PillEffect.PILLEFFECT_IM_DROWSY, PillColor.PILL_NULL,
		UseFlag.USE_NOANIM|UseFlag.USE_OWNED|UseFlag.USE_NOANNOUNCER|UseFlag.USE_NOHUD)
	return true
end

DrXia:AddCallback(ModCallbacks.MC_USE_ITEM, DrXia.OnUseAdvancedMathematics,
	DrXiaElements.COLLECTIBLE_ADVANCED_MATHEMATICS)

function DrXia:OnUseCryingWhiteFruit(item, rng, player, flags, slot, data)
	if (DrXia:getHealth(player) <= 4) then
		return {
			Discharge = false,
			Remove = false,
			ShowAnim = false,
		}
	end
	player:TakeDamage(4, DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_IV_BAG,
		EntityRef(player), 0)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, UseFlag.USE_NOANIM)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, UseFlag.USE_NOANIM | UseFlag.USE_CARBATTERY)
	end
	return false
end

DrXia:AddCallback(ModCallbacks.MC_USE_ITEM, DrXia.OnUseCryingWhiteFruit, DrXiaElements.COLLECTIBLE_CRYING_WHITE_FRUIT)

function DrXia:OnUseAnger(item, rng, player, flags, slot, data)
	local anger_rng = player:GetCollectibleRNG(DrXiaElements.COLLECTIBLE_TB_ANGER)
	local collectiblesize = 732
	local config = Isaac.GetItemConfig()
	while ItemConfig.Config.IsValidCollectible(collectiblesize + 1) do
		collectiblesize = collectiblesize + 1
	end
	local security_exit = 0 --in case of infinite loop
	while security_exit < 1000 do
		security_exit = security_exit + 1
		local item_id = anger_rng:RandomInt(collectiblesize) + 1
		if ItemConfig.Config.IsValidCollectible(item_id) then
			local item_info = config:GetCollectible(item_id)
			if item_info.Quality == 0 and item_info:IsAvailable() and item_id ~= 59
				and item_info.Tags | ItemConfig.TAG_NO_EDEN ~= item_info.Tags then
				local pos = Isaac.GetFreeNearPosition(player.Position, 10)
				Isaac.Spawn(5, 100, item_id, pos, Vector(0, 0), player)
				break
			end
		end
	end
	return {
		Discharge = false,
		Remove = true,
		ShowAnim = true,
	}
end

DrXia:AddCallback(ModCallbacks.MC_USE_ITEM, DrXia.OnUseAnger, DrXiaElements.COLLECTIBLE_TB_ANGER)

function DrXia:FatSharkTears(tear)
	if tear.SpawnerType == EntityType.ENTITY_PLAYER then
		local shooter = tear.SpawnerEntity:ToPlayer()
		if shooter:HasCollectible(DrXiaElements.COLLECTIBLE_FAT_SHARK) then
			local chance = 1
			if shooter.Luck < 24 then
				chance = 1 / (25 - shooter.Luck)
			end
			if math.random() < chance then
				tear.TearFlags = tear.TearFlags | TearFlags.TEAR_CHARM
				local tmpcolor = tear.Color
				tmpcolor:SetOffset(0, -0.5, 0)
				tear.Color = tmpcolor
			end
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, DrXia.FatSharkTears)

function DrXia:TenshiTears(tear)
	local player = tear.SpawnerEntity:ToPlayer()
	if player:HasCollectible(DrXiaElements.COLLECTIBLE_TENSHI_DOLL) then
		tear:ChangeVariant(TearVariant.ROCK)
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, DrXia.TenshiTears)

function DrXia:TenshiCounter(tear)
	local player = tear.SpawnerEntity:ToPlayer()
	local data = player:GetData()
	if player:HasCollectible(DrXiaElements.COLLECTIBLE_TENSHI_DOLL) then
		if data.TenshiCounter == nil then
			data.TenshiCounter = 1
		elseif data.TenshiCounter >= 25 then
			Game():ShakeScreen(10)
			local rng = player:GetCollectibleRNG(DrXiaElements.COLLECTIBLE_TENSHI_DOLL)
			local event = rng:RandomInt(10)
			if event <= 1 then
				local room = Game():GetRoom()
				for i = 1, room:GetGridSize() do
					local grid_entity = room:GetGridEntity(i)
					if grid_entity then
						room:DestroyGrid(i, true)
					end
				end
				local entlist = Isaac.GetRoomEntities()
				for _, ent in ipairs(entlist) do
					if ent:IsVulnerableEnemy() then
						ent:AddConfusion(EntityRef(player), 60, false)
					end
				end
			else
				local entlist = Isaac.GetRoomEntities()
				for _, ent in ipairs(entlist) do
					if ent:IsVulnerableEnemy() then
						ent:TakeDamage(player.Damage * 1.25 + 5.0, 0, EntityRef(player), 0)
					end
				end
			end
			data.TenshiCounter = 1
		else
			data.TenshiCounter = data.TenshiCounter + 1
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, DrXia.TenshiCounter)

function DrXia:OnPlayerDamaged(ent, amount, flags, source, countdown)
	local player = ent:ToPlayer()
	if player:HasCollectible(DrXiaElements.COLLECTIBLE_IDLE_DOG) and flags & DamageFlag.DAMAGE_DEVIL == 0 then
		local entlist = Isaac.GetRoomEntities()
		for _, room_ent in ipairs(entlist) do
			if room_ent:IsVulnerableEnemy() then
				room_ent:AddFreeze(EntityRef(player), 30)
			end
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, DrXia.OnPlayerDamaged, EntityType.ENTITY_PLAYER)

local lastjumped = -30
function DrXia:PusheenJump(player)
	if Input.IsButtonPressed(Keyboard.KEY_J, player.ControllerIndex) and
		player:HasCollectible(DrXiaElements.COLLECTIBLE_PUSHEEN_CAT) then
		local currenttime = Game():GetFrameCount()
		if currenttime - lastjumped >= 30 then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_HOW_TO_JUMP, false, false, false)
			lastjumped = currenttime
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, DrXia.PusheenJump)

function DrXia:OnUseAppetizing(pill, player, flags)
	player:AnimateSad()
	SFXManager():Play(DrXiaElements.SOUND_APPETIZING, 5)
	local data = player:GetData()
	data.appetizing = true
	if player:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD) then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK,
			Game():GetRoom():FindFreePickupSpawnPosition(player.Position, 0, true), Vector(0, 0), nil)
	end
end

DrXia:AddCallback(ModCallbacks.MC_USE_PILL, DrXia.OnUseAppetizing, DrXiaElements.PILL_APPETIZING)

function DrXia:ConvertAppetizing(pillEffect, pillColor)
	if pillEffect == DrXiaElements.PILL_APPETIZING then
		local player_num = Game():GetNumPlayers()
		local shouldConvert = false
		for i = 0, player_num do
			local currentPlayer = Game():GetPlayer(i)
			if currentPlayer:HasCollectible(CollectibleType.COLLECTIBLE_FALSE_PHD) then
				return pillEffect
			end
			shouldConvert = shouldConvert or currentPlayer:HasCollectible(CollectibleType.COLLECTIBLE_PHD) or
				currentPlayer:HasCollectible(CollectibleType.COLLECTIBLE_LUCKY_FOOT) or
				currentPlayer:HasCollectible(CollectibleType.COLLECTIBLE_VIRGO)
		end
		if shouldConvert then
			return PillEffect.PILLEFFECT_SPEED_UP
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, DrXia.ConvertAppetizing)

function DrXia:ReverseControl(ent, hook, button_action)
	if ent then
		local player = ent:ToPlayer()
		if player and player:GetData().appetizing and hook == InputHook.GET_ACTION_VALUE then
			if button_action == ButtonAction.ACTION_LEFT then
				return Input.GetActionValue(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
			elseif button_action == ButtonAction.ACTION_RIGHT then
				return Input.GetActionValue(ButtonAction.ACTION_LEFT, player.ControllerIndex)
			elseif button_action == ButtonAction.ACTION_UP then
				return Input.GetActionValue(ButtonAction.ACTION_DOWN, player.ControllerIndex)
			elseif button_action == ButtonAction.ACTION_DOWN then
				return Input.GetActionValue(ButtonAction.ACTION_UP, player.ControllerIndex)
			end
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_INPUT_ACTION, DrXia.ReverseControl)

function DrXia:ClearAppetizing()
	for i = 0, Game():GetNumPlayers() - 1 do
		Game():GetPlayer(i):GetData().appetizing = nil
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DrXia.ClearAppetizing)

local GiantBook = Sprite()
GiantBook:Load("gfx/ui/giantbook/giantbook.anm2", true)
GiantBook.PlaybackSpeed = 0.5
function DrXia:OnUseCardOfDrXia(card, player, flags)
	GiantBook:Play("Appear", true)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, UseFlag.USE_NOANIM)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_DIPLOPIA, UseFlag.USE_NOANIM)
end

DrXia:AddCallback(ModCallbacks.MC_USE_CARD, DrXia.OnUseCardOfDrXia, DrXiaElements.CARD_CARD_OF_DRXIA)

function DrXia:RenderGiantBook()
	if not GiantBook:IsFinished("Appear") then
		GiantBook:Render(Isaac.WorldToRenderPosition(Vector(320, 280)))
		GiantBook:Update()
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_RENDER, DrXia.RenderGiantBook)

function DrXia:InitEverythingSmashed(isContinued)
	if Isaac.GetChallenge() == DrXiaElements.CHALLENGE_EVERYTHING_SMASHED and not isContinued then
		local player = Isaac.GetPlayer(0)
		player:AddCollectible(DrXiaElements.COLLECTIBLE_TENSHI_DOLL)
		player:AddCollectible(CollectibleType.COLLECTIBLE_SOY_MILK)
		player:AddCollectible(CollectibleType.COLLECTIBLE_4_5_VOLT)
		player:AddCollectible(CollectibleType.COLLECTIBLE_9_VOLT or CollectibleType.COLLECTIBLE_NINR_VOLT) --Discrepancy between rep and ab+
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DrXia.InitEverythingSmashed)

--v1.7 start
function DrXia:RecordModify(tear)
	local player = tear.SpawnerEntity:ToPlayer()
	if player:HasCollectible(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD) then
		tear.Scale = tear.Scale * 1.5
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, DrXia.RecordModify)

function DrXia:PlayerCollides(player, collider, low)
	if player:HasCollectible(DrXiaElements.COLLECTIBLE_WINTER_FLOWER_RECORD)
		and collider:IsVulnerableEnemy()
		and low
		and collider:GetEntityFlags() & EntityFlag.FLAG_FRIENDLY == 0 then
		local player_position = player.Position
		local enemy_position = collider.Position
		local linear_vector = enemy_position - player_position
		linear_vector:Normalize() --linear_vector is divided by sqrt(x^2+y^2)
		local last_collide = collider:GetData().last_collide or -10
		if Game():GetFrameCount() - last_collide >= 10 then
			collider.Velocity = linear_vector * 60
			collider:TakeDamage(5.0 * player.Damage, 0, EntityRef(player), 0)
			collider:GetData().last_collide = Game():GetFrameCount()
			return true --ignore vanilla collision?
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, DrXia.PlayerCollides, 0) --0 for player while 1 for co-op baby.

local alterRNG = RNG()
--v1.8.0 starts
function DrXia:AlterSpoonBender(origin, pool, decrease, seed)
	local originInfo = Isaac.GetItemConfig():GetCollectible(origin)
	if not originInfo:HasTags(ItemConfig.TAG_QUEST) then
		local player_num = Game():GetNumPlayers()
		local shouldAlter = false
		for i = 0, player_num do
			local currentPlayer = Game():GetPlayer(i)
			if currentPlayer:HasTrinket(DrXiaElements.TRINKET_XIAS_ROSARY_BEAD) then
				shouldAlter = true
			end
		end

		if shouldAlter then
			local alterRNG = RNG()
			alterRNG:SetSeed(seed, 35) --35 is officially recommended
			local diceResult = alterRNG:RandomFloat()
			if diceResult < 0.08 then
				return CollectibleType.COLLECTIBLE_SPOON_BENDER
			elseif diceResult < 0.1 then
				return DrXiaElements.COLLECTIBLE_GOLDEN_SPOON_BENDER
			end
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, DrXia.AlterSpoonBender)

--v2.0.0 starts
function DrXia:InitCrackedSpoonBender()
	local player_num = Game():GetNumPlayers()
	for i = 0, player_num do
		local currentPlayer = Game():GetPlayer(i)
		if currentPlayer:HasTrinket(DrXiaElements.TRINKET_CRACKED_SPOON_BENDER) then
			currentPlayer:GetData().CrackedSpoonBenderTier = false
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, DrXia.InitCrackedSpoonBender)

function DrXia:ApplyCrackedSpoonBender(player)
	if player:HasTrinket(DrXiaElements.TRINKET_CRACKED_SPOON_BENDER) then
		if (Game():GetFrameCount() // 30) % 7 < player:GetTrinketMultiplier(DrXiaElements.TRINKET_CRACKED_SPOON_BENDER) then
			if not player:GetData().CrackedSpoonBenderTier then
				player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_SPOON_BENDER, false, 1)
				player:GetData().CrackedSpoonBenderTier = true
			end
		elseif player:GetData().CrackedSpoonBenderTier then
			player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_SPOON_BENDER, 1)
			player:GetData().CrackedSpoonBenderTier = false
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, DrXia.ApplyCrackedSpoonBender)

local TaintedDrXiaHasCostume = false
function DrXia:GiveTaintedDrXiaCostumes(player)
	if player:GetPlayerType() == DrXiaElements.CHARACTER_TAINTED_DRXIA then
		if not TaintedDrXiaHasCostume then
			player:AddNullCostume(DrXiaElements.COSTUME_TAINTED_DRXIA_HAIR)
			TaintedDrXiaHasCostume = true
		end
	elseif TaintedDrXiaHasCostume then
		TaintedDrXiaHasCostume = false
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, DrXia.GiveTaintedDrXiaCostumes)

DrXia:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(self, player, flag)
	if player:GetPlayerType() == DrXiaElements.CHARACTER_TAINTED_DRXIA then
		DrXia:addTearsModifier(player, 0.7)
	end
end, CacheFlag.CACHE_FIREDELAY)

DrXia:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(self, continued)
	local player = Isaac.GetPlayer(0)
	if not continued and player:GetPlayerType() == DrXiaElements.CHARACTER_TAINTED_DRXIA then
		player:AddTrinket(DrXiaElements.TRINKET_CRACKED_SPOON_BENDER)
	end
end)

local TaintedAlterRNG = RNG()
DrXia:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	TaintedAlterRNG = RNG()
	TaintedAlterRNG:SetSeed(Game():GetSeeds():GetStartSeed(), 35)
end)

function DrXia:TaintedAlterSpoonBender(origin, pool, decrease, seed)
	local player_num = Game():GetNumPlayers()
	local shouldAlter = false
	for i = 0, player_num do
		local currentPlayer = Game():GetPlayer(i)
		if currentPlayer:GetPlayerType() == DrXiaElements.CHARACTER_TAINTED_DRXIA then
			shouldAlter = true
		end
	end
	if shouldAlter then
		local diceResult = TaintedAlterRNG:RandomFloat()
		if diceResult < 0.2 then
			return CollectibleType.COLLECTIBLE_SPOON_BENDER
		end
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, DrXia.TaintedAlterSpoonBender)

local ItemPools = { ItemPoolType.POOL_TREASURE, ItemPoolType.POOL_TREASURE, ItemPoolType.POOL_TREASURE,
	ItemPoolType.POOL_SHOP, ItemPoolType.POOL_BOSS, ItemPoolType.POOL_DEVIL, ItemPoolType.POOL_ANGEL,
	ItemPoolType.POOL_SECRET, ItemPoolType.POOL_LIBRARY, ItemPoolType.POOL_DEMON_BEGGAR, ItemPoolType.POOL_CURSE,
	ItemPoolType.POOL_KEY_MASTER, ItemPoolType.POOL_ULTRA_SECRET, ItemPoolType.POOL_PLANETARIUM }

function DrXia:TaintedSpawnNewItems(pickup, entity, low)
	if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE and pickup.SubType == CollectibleType.COLLECTIBLE_SPOON_BENDER and entity.Type == EntityType.ENTITY_PLAYER and entity:ToPlayer():GetPlayerType() == DrXiaElements.CHARACTER_TAINTED_DRXIA
	then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
		local player = entity:ToPlayer()
		player:AnimateSad()
		pickup:Remove()
		local alterRNG = RNG()
		local seed = Game():GetRoom():GetSpawnSeed()
		alterRNG:SetSeed(seed, 35) --35 is officially recommended
		local diceResult = alterRNG:RandomInt(#ItemPools) + 1

		local ExistCollectibles = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
		local index = pickup.OptionsPickupIndex
		if index == 0 then
			index = 66
			while true do
				local found = true
				for _, item in ipairs(ExistCollectibles) do
					if item:ToPickup().OptionsPickupIndex == index then
						index = index + 1
						found = false
						break
					end
				end
				if found then
					break
				end
			end
		end
		local option1 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
			Game():GetItemPool():GetCollectible(ItemPools[diceResult], true, seed, CollectibleType.COLLECTIBLE_BREAKFAST),
			Isaac.GetFreeNearPosition(player.Position, 100), Vector.Zero, nil):ToPickup()
		local PoolForOption2 = Game():GetItemPool():GetPoolForRoom(Game():GetRoom():GetType(),seed)
		if Game():GetRoom():GetType() == RoomType.ROOM_CHALLENGE and Game():GetLevel():HasBossChallenge() then
			PoolForOption2 = ItemPoolType.POOL_BOSS
		end
		local option2 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
			Game():GetItemPool():GetCollectible(PoolForOption2, true, seed, CollectibleType.COLLECTIBLE_BREAKFAST),
			Isaac.GetFreeNearPosition(player.Position, 100), Vector.Zero, nil):ToPickup()
		option1.OptionsPickupIndex = index
		option2.OptionsPickupIndex = index
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			local option3 = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,
				Game():GetItemPool():GetCollectible(
					Game():GetItemPool():GetPoolForRoom(Game():GetRoom():GetType(), seed),
					true,
					seed, CollectibleType.COLLECTIBLE_BREAKFAST), Isaac.GetFreeNearPosition(player.Position, 100),
				Vector.Zero, nil):ToPickup()
			option3.OptionsPickupIndex = index
		end
		if Game():GetRoom():GetType() == RoomType.ROOM_DEVIL or Game():GetRoom():GetType() == RoomType.ROOM_BLACK_MARKET and pickup.Price == -1 then
			player:TakeDamage(4, DamageFlag.DAMAGE_INVINCIBLE  | DamageFlag.DAMAGE_NO_PENALTIES,
				EntityRef(player), 0)
		else
			player:TakeDamage(2, DamageFlag.DAMAGE_INVINCIBLE  | DamageFlag.DAMAGE_NO_PENALTIES,
				EntityRef(player), 0)
		end
		return false
	end
end

DrXia:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, DrXia.TaintedSpawnNewItems, 100)


-- global initialization starts
function DrXia:InitVariables(continued)
	RunContinued = continued
	if not continued then
		lastjumped = -30
		optionsdone = false
		DrXiaHasCostume = false
		TaintedDrXiaHasCostume = false
	end
end

DrXia:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, DrXia.InitVariables)


local eid_support = include("eid_support")
local eid_collectibles, eid_trinkets, eid_cards, eid_pills = eid_support(DrXiaElements)

if EID then
	for _, entry in ipairs(eid_collectibles) do
		EID:addCollectible(entry[1], entry[2], entry[3], entry[4])
	end
	for _, entry in ipairs(eid_trinkets) do
		EID:addTrinket(entry[1], entry[2], entry[3], entry[4])
	end
	for _, entry in ipairs(eid_cards) do
		EID:addCard(entry[1], entry[2], entry[3], entry[4])
	end
	for _, entry in ipairs(eid_pills) do
		EID:addPill(entry[1], entry[2], entry[3], entry[4])
	end
	EID:addBirthright(DrXiaElements.CHARACTER_DRXIA,
		"{{Collectible" .. DrXiaElements.COLLECTIBLE_CARDIOGRAPH .. "}}心电图仪提供的伤害修正更高", "夏老师",
		"zh_cn")
	EID:addBirthright(DrXiaElements.CHARACTER_TAINTED_DRXIA,
		"{{Collectible3}}弯勺魔术分解时，额外增加一个当前房间道具池的选项", "堕化夏老师",
		"zh_cn")
end
