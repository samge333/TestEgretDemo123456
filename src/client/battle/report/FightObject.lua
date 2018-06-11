
-- 战斗初始对象
-- @author xiaofeng
FightObject = class("FightObject")

function FightObject:ctor()
    --战斗标识
    self.battleTag =  0

    --对象id
    self.id =  0

    --对战名称
    self.fightName =  ""

    --对象模板id
    self.mouldId =  0

    --对象战船ID
    self.shipMould =  0

    --用户信息
    self.userInfo =  -1

    --名称
    self.name =  ""

    --动画标示
    self.picIndex =  ""

    --阵营
    self.campPreference =  0

    --性别
    self.gender =  0

    --品质
    self.quality =  0

    --统帅
    self.leader =  0

    --武力
    self.strength =  0

    --智慧
    self.wisdom =  0

    --生命
    self.healthPoint =  0

    --剩余血量
    self.lessHealthPoint =  0

    --技能槽
    self.skillPoint =  0

    --攻击
    self.attack =  0

    --物理防御
    self.physicalDefence =  0

    --技能防御
    self.skillDefence =  0

    --暴击
    self.critical =  0

    --暴击倍率
    self.critialMultiple =  1

    --抗暴
    self.criticalResist =  0

    --闪避
    self.evasion =  0

    --命中
    self.accuracy =  0

    --格挡
    self.retain =  0

    --破击
    self.retainBreak =  0

    --物理免伤
    self.physicalLessenDamage =  0

    --法术免伤
    self.skillLessenDamage =  0

    --普攻技能
    self.commonSkill =  nil

    --特殊技能
    self.specialSkill =  nil

    --最终伤害加成
    self.finalDamageAddition =  0

    --最终减伤加成
    self.finalSubDamageAddition =  0

    --治疗率
    self.cureOdds =  0

    --被治疗率
    self.byCureOdds =  0

    --初始怒气增加
    self.initialSPIncrease =  0

    --掉落卡片id
    self.rewardCard =  0

    --掉落卡片几率
    self.rewardRatio =  0

    --掉落道具
    self.rewardProp =  0

    --掉落道具几率
    self.rewardPropRatio =  0

    --掉落装备
    self.rewardEquipment =  0

    --掉落装备几率
    self.rewardEquipmentRatio =  0

    --对象坐标
    self.coordinate =  0
	
	--天赋列表
	self.talentMouldList = {}

    --最终伤害比例
    self.finalDamagePercent =  0

    --最终减伤比例
    self.finalLessenDamagePercent =  0

    --放大比例
    self.amplifyPercent =  "1"

    --怒气描述
    self.specialSkillDecribe =  0

    --物理攻击增加
    self.physicalAttackAdd =  0

    --法术攻击增加
    self.skillAttackAdd =  0

    --治疗值增加
    self.cureAdd =  0

    --被治疗值增加
    self.byCureAdd =  0

    --灼烧伤害增加
    self.firingAdd =  0

    --灼烧伤害免疫
    self.byFiringLes =  0

    --中毒伤害增加
    self.posionAdd =  0

    --中毒伤害免伤
    self.byPosionLes =  0

    --/
    --生命加成百分比
    self.powerAdditionalPercent =  0

    --攻击加成百分比
    self.courageAdditionalPercent =  0

    --物理防御加成百分比
    self.intellectAdditionalPercent =  0

    --法防加成百分比
    self.nimableAdditionalPercent =  0

    --暴击加成百分比
    self.criticalAdditionalPercent =  0

    --抗暴加成百分比
    self.criticalResistAdditionalPercent =  0

    --闪避加成百分比
    self.evasionAdditionalPercent =  0

    --命中加成百分比
    self.accuracyAdditionalPercent =  0

    --挡格加成百分比
    self.retainAdditionalPercent =  0

    --破击加成百分比
    self.retainBreakAdditionalPercent =  0

    --物理免伤加成百分比
    self.physicalLessenDamagePercent =  0

    --法术免伤加成百分比
    self.skillLessenDamagePercent =  0

    --治疗率加成百分比
    self.curePercent =  0

    --被治疗率加成百分比
    self.byCurePercent =  0

    --合体技
    self.zoarium =  0

    --合体对象
    self.zoariumCoordinate =  0

    --进阶等级
    self.advance =  1

    --战船类型
    self.capacity =  0

    --相克类型
    self.restrainMoulds =  {}
	
    self.zoariumSkillPoint = 0

    -- 38.每次出手增加的怒气
	self.everyAttackAddSp = 0
	-- 39.灼烧伤害% 
	self.firingDamagePercent = 0
	-- 40.吸血率%
	self.inhaleHpDamagePercent = 0
	-- 41.怒气
	self.addSpValue = 0
	-- 42.反弹%  
	self.reboundDamageValue = 0
	-- 43.暴伤加成%	   
	self.uniqueSkillDamagePercent = 0
	-- 44.免控率%  
	self.avoidControlPercent = 0
	-- 45.小技能触发概率%  
	self.normatinSkillTriggerPercent = 0
	-- 46.格挡强度% 
	self.uniqueSkillResistancePercent = 0
	-- 47.控制率%
	self.controlPercent = 0
	-- 48.治疗效果% 
	self.cureEffectPercent = 0
	-- 49.暴击强化% 
	self.criticalAdditionPercent = 0
    -- 50.数码兽类型克制伤害%   (可为负数)
    self.heroRestrainDamagePercent = 0
    -- 51.溅射伤害%
    self.sputteringAttackAddDamagePercent = 0
    -- 52.技能伤害%
    self.skillAttackAddDamagePercent = 0
    -- 53.被治疗减少%
    self.byCureLessenPercent = 0
    -- 54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
    self.ptvf54 = 0
	-- 55.必杀伤害率%
	self.ptvf55 = 0
	-- 56.增加必杀伤害%
	self.ptvf56 = 0
	-- 57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
	self.ptvf57 = 0
	-- 58.增加暴击伤害%
	self.ptvf58 = 0
	-- 59.减少暴击伤害%
	self.ptvf59 = 0
	-- 60.受到的必杀伤害增加%
	self.ptvf60 = 0
	-- 61.怒气回复速度%
	self.ptvf61 = 0
	-- 62.受到伤害降低%
	self.ptvf62 = 0
	-- 63.降低攻击(%)	
	self.ptvf63 = 0
	-- 64.降低防御
	self.ptvf64 = 0
    -- 65伤害加成提升%
    self.ptvf65 = 0
    -- 66降低必杀伤害率%
    self.ptvf66 = 0
    -- 67降低伤害减免%
    self.ptvf67 = 0
    -- 68降低防御（%）
    self.ptvf68 = 0
    -- 69降低怒气回复速度
    self.ptvf69 = 0
    -- 70数码兽类型克制伤害加成%   
    self.ptvf70 = 0
    -- 71数码兽类型克制伤害减免%   
    self.ptvf71 = 0
    -- 72.降低攻击
    self.ptvf72 = 0
    -- 73.增加必杀抗性%
    self.ptvf73 = 0
    -- 74.减少必杀抗性%
    self.ptvf74 = 0
    -- 75降低免控率%
    self.ptvf75 = 0
    -- 76复活概率%
    self.ptvf76 = 0
    -- 77被复活概率%
    self.ptvf77 = 0
    -- 78复活继承血量%	
    self.ptvf78 = 0
	-- 79复活继承怒气%	
    self.ptvf79 = 0
	-- 80被复活继承血量%	
    self.ptvf80 = 0
	-- 81被复活继承怒气%	
    self.ptvf81 = 0
    -- 82增加复活概率%
    self.ptvf82 = 0
    -- 83增加复活继承血量%
	self.ptvf83 = 0
    -- 84小技能伤害提升%
    self.ptvf84 = 0


    --模板兵力
    self.forceArray = {}

    -- 进化等级
    self.evolutionLevel = 1

    -- 资质
    self.ability = 13
end


--计算临时属性值
function FightObject:calculateShipProperty(ship,shipMould)
	--计算天赋属性加成
	self.talentMouldList = {}
	local talentStateArray = ship.talents
	for i, atkObj in pairs(talentStateArray) do
		if tonumber(atkObj.is_activited) == 1 then	--如果已经激活该天赋
			local talentMould = TalentMould:new()
			talentMould:init(dms.element(dms["talent_mould"], atkObj.talent_id) )
			local baseAdditional = talentMould.baseAdditional
			if talentMould.baseAdditional ~= "" and talentMould.baseAdditional ~= "-1" then		
				self:addPropertyByInfluenceValue(baseAdditional)
			end
			table.insert(self.talentMouldList, talentMould)
		end
	end

	-- --计算强化大师属性加成
	-- local weapon = ship.equipment[1]
	-- local helmet = ship.equipment[2]
	-- local belt = ship.equipment[3]
	-- local armor = ship.equipment[4]
	-- local attackTreasue = ship.equipment[5]
	-- local defenceTreasure = ship.equipment[6]
	-- if(tonumber(weapon.user_equiment_id) ~= 0 and tonumber(helmet.user_equiment_id) ~= 0 and tonumber(belt.user_equiment_id) ~= 0 and tonumber(armor.user_equiment_id) ~= 0
	-- 	and tonumber(weapon.ship_id) ~= 0 and tonumber(helmet.ship_id) ~= 0 and tonumber(belt.ship_id) ~= 0 and tonumber(armor.ship_id) ~= 0 )then
	-- 	local equipmentStrengthenLevelArray = {weapon.user_equiment_grade,helmet.user_equiment_grade,belt.user_equiment_grade,armor.user_equiment_grade}
	-- 	local  minEquipmentLevel = 0
	-- 	for i, equipmenLevel in pairs(equipmentStrengthenLevelArray) do
	-- 		minEquipmentLevel = equipmenLevel
	-- 		for j, tempEquipmentLevel in pairs(equipmentStrengthenLevelArray) do
	-- 			if minEquipmentLevel > tempEquipmentLevel then
	-- 				minEquipmentLevel = tempEquipmentLevel
	-- 			end
	-- 		end
	-- 		break
	-- 	end
	-- 	local lessLevel = minEquipmentLevel%10
	-- 	minEquipmentLevel = minEquipmentLevel - lessLevel
	-- 	-- 装备等级
	-- 	local strengthenMasterInfo = dms.searchs(dms["strengthen_master_info"], strengthen_master_info.need_level, minEquipmentLevel)
	-- 	if(strengthenMasterInfo ~= nil) then
	-- 		local additionalProperty = nil
	-- 		for j, obj in pairs(strengthenMasterInfo) do
	-- 			local masterType = dms.atoi(obj,strengthen_master_info.master_type)
	-- 			if tonumber(masterType) == 0 then
	-- 				additionalProperty =  dms.atos(obj,strengthen_master_info.additional_property)
	-- 				break
	-- 			end
	-- 		end
	-- 		if(additionalProperty ~= nil and additionalProperty ~= "-1") then
	-- 			self:addPropertyByInfluenceValue(additionalProperty)
	-- 		end
	-- 	end
	-- 	-- 装备精炼
	-- 	local equipmentRankLevelArray = {weapon.equiment_refine_level,helmet.equiment_refine_level,belt.equiment_refine_level,armor.equiment_refine_level}
	-- 	minEquipmentLevel = 0
	-- 	for i, equipmenLevel in pairs(equipmentRankLevelArray) do
	-- 		minEquipmentLevel = equipmenLevel
	-- 		for j, tempEquipmentLevel in pairs(equipmentRankLevelArray) do
	-- 			if minEquipmentLevel > tempEquipmentLevel then
	-- 				minEquipmentLevel = tempEquipmentLevel
	-- 			end
	-- 		end
	-- 		break
	-- 	end
	-- 	lessLevel = minEquipmentLevel%10
	-- 	minEquipmentLevel = minEquipmentLevel - lessLevel
	-- 	strengthenMasterInfo = dms.searchs(dms["strengthen_master_info"], strengthen_master_info.need_level, minEquipmentLevel)
	-- 	if(strengthenMasterInfo ~= nil) then
	-- 		local additionalProperty = nil
	-- 		for j, obj in pairs(strengthenMasterInfo) do
	-- 			local masterType = dms.atoi(obj,strengthen_master_info.master_type)
	-- 			if tonumber(masterType) == 1 then
	-- 				additionalProperty =  dms.atos(obj,strengthen_master_info.additional_property)
	-- 				break
	-- 			end
	-- 		end
	-- 		if(additionalProperty ~= nil and additionalProperty ~= "-1") then
	-- 			self:addPropertyByInfluenceValue(additionalProperty)
	-- 		end
	-- 	end
	-- end
	-- -- 宝物
	-- if(tonumber(attackTreasue.user_equiment_id) ~= 0 and tonumber(defenceTreasure.user_equiment_id) ~= 0
	-- 	and tonumber(attackTreasue.ship_id) ~= 0 and tonumber(defenceTreasure.ship_id) ~= 0)then
	-- 	local equipmentStrengthenLevelArray = {attackTreasue.user_equiment_grade,defenceTreasure.user_equiment_grade}
	-- 	local  minEquipmentLevel = 0
	-- 	for i, equipmenLevel in pairs(equipmentStrengthenLevelArray) do
	-- 		minEquipmentLevel = equipmenLevel
	-- 		for j, tempEquipmentLevel in pairs(equipmentStrengthenLevelArray) do
	-- 			if minEquipmentLevel > tempEquipmentLevel then
	-- 				minEquipmentLevel = tempEquipmentLevel
	-- 			end
	-- 		end
	-- 		break
	-- 	end
	-- 	local lessLevel = minEquipmentLevel%10
	-- 	minEquipmentLevel = minEquipmentLevel - lessLevel
	-- 	-- 装备等级
	-- 	local strengthenMasterInfo = dms.searchs(dms["strengthen_master_info"], strengthen_master_info.need_level, minEquipmentLevel)
	-- 	if(strengthenMasterInfo ~= nil) then
	-- 		local additionalProperty = nil
	-- 		for j, obj in pairs(strengthenMasterInfo) do
	-- 			local masterType = dms.atoi(obj,strengthen_master_info.master_type)
	-- 			if tonumber(masterType) == 2 then
	-- 				additionalProperty =  dms.atos(obj,strengthen_master_info.additional_property)
	-- 				break
	-- 			end
	-- 		end
	-- 		if(additionalProperty ~= nil and additionalProperty ~= "-1") then
	-- 			self:addPropertyByInfluenceValue(additionalProperty)
	-- 		end
	-- 	end
	-- 	-- 装备精炼
	-- 	local equipmentRankLevelArray = {attackTreasue.equiment_refine_level,defenceTreasure.equiment_refine_level}
	-- 	minEquipmentLevel = 0
	-- 	for i, equipmenLevel in pairs(equipmentRankLevelArray) do
	-- 		minEquipmentLevel = equipmenLevel
	-- 		for j, tempEquipmentLevel in pairs(equipmentRankLevelArray) do
	-- 			if minEquipmentLevel > tempEquipmentLevel then
	-- 				minEquipmentLevel = tempEquipmentLevel
	-- 			end
	-- 		end
	-- 		break
	-- 	end
	-- 	lessLevel = minEquipmentLevel%10
	-- 	minEquipmentLevel = minEquipmentLevel - lessLevel
	-- 	strengthenMasterInfo = dms.searchs(dms["strengthen_master_info"], strengthen_master_info.need_level, minEquipmentLevel)
	-- 	if(strengthenMasterInfo ~= nil) then
	-- 		local additionalProperty = nil
	-- 		for j, obj in pairs(strengthenMasterInfo) do
	-- 			local masterType = dms.atoi(obj,strengthen_master_info.master_type)
	-- 			if tonumber(masterType) == 3 then
	-- 				additionalProperty =  dms.atos(obj,strengthen_master_info.additional_property)
	-- 				break
	-- 			end
	-- 		end
	-- 		if(additionalProperty ~= nil and additionalProperty ~= "-1") then
	-- 			self:addPropertyByInfluenceValue(additionalProperty)
	-- 		end
	-- 	end
	-- end
end

function FightObject:addPropertyByInfluenceValue(attributeValue)
	if (attributeValue == nil or "" == attributeValue) then
		return
	end
	local propertyTypeArray = zstring.split(attributeValue, "|")
	--for (local property ) then propertyTypeArray) {
	for _, property in pairs(propertyTypeArray) do
		local propertyType = tonumber(zstring.split(property, ",")[1])
		local propertyValue = tonumber(zstring.split(property, ",")[2])
		-- if (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL) then
		-- 	self.healthPoint = self.healthPoint + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL) then
		-- 	self.attack = self.attack + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL) then
		-- 	self.physicalDefence = self.physicalDefence + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL) then
		-- 	self.skillDefence = self.skillDefence + propertyValue
		-- 	--break
		-- else
		-- if (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL_PERCENTAGE) then
		-- 	if(propertyValue < 1) then
		-- 		propertyValue = propertyValue * 100
		-- 	end
		-- 	self.powerAdditionalPercent = self.powerAdditionalPercent + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL_PERCENTAGE) then
		-- 	if(propertyValue < 1) then
		-- 		propertyValue = propertyValue * 100
		-- 	end
		-- 	self.courageAdditionalPercent = self.courageAdditionalPercent + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL_PERCENTAGE) then
		-- 	if(propertyValue < 1) then
		-- 		propertyValue = propertyValue * 100
		-- 	end
		-- 	self.intellectAdditionalPercent = self.intellectAdditionalPercent + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL_PERCENTAGE) then
		-- 	if(propertyValue < 1) then
		-- 		propertyValue = propertyValue * 100
		-- 	end
		-- 	self.nimableAdditionalPercent = self.nimableAdditionalPercent + propertyValue
		-- 	--break
		-- else
		if (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS) then
			self.criticalAdditionalPercent = self.criticalAdditionalPercent + propertyValue
			--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS) then
			self.criticalResistAdditionalPercent = self.criticalResistAdditionalPercent + propertyValue
			--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS) then
		-- 	self.retainAdditionalPercent = self.retainAdditionalPercent + propertyValue
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS) then
		-- 	self.retainBreakAdditionalPercent  = self.retainBreakAdditionalPercent + propertyValue
		-- 	--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ACCURACY_ODDS) then
			self.accuracyAdditionalPercent  = self.accuracyAdditionalPercent + propertyValue
			--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVASION_ODDS) then
			self.evasionAdditionalPercent  = self.evasionAdditionalPercent + propertyValue
			--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_LESSEN_DAMAGE_PERCENTAGE) then
		-- 	self.physicalLessenDamagePercent  = self.physicalLessenDamagePercent + (propertyValue / 100)
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_LESSEN_DAMAGE_PERCENTAGE) then
		-- 	self.skillLessenDamagePercent  = self.skillLessenDamagePercent + (propertyValue / 100)
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ODDS) then
		-- 	self.curePercent  = self.curePercent + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ODDS) then
		-- 	self.byCurePercent  = self.byCurePercent + propertyValue
		-- 	--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE) then
			self.finalDamageAddition  = self.finalDamageAddition + propertyValue
			--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE) then
		-- 	self.finalSubDamageAddition  = self.finalSubDamageAddition + propertyValue
		-- 	--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_SP_INCREASE) then
			self.initialSPIncrease  = self.initialSPIncrease + propertyValue
			--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_HEAD) then
		-- 	self.leader  = self.leader + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_BODY) then
		-- 	self.strength  = self.strength + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_WISDOM) then
		-- 	self.wisdom  = self.wisdom + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_ATTACK_ADDITIONAL) then
		-- 	self.physicalAttackAdd  = self.physicalAttackAdd + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADDITIONAL) then
		-- 	self.skillAttackAdd  = self.skillAttackAdd + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ADDITIONAL) then
		-- 	self.cureAdd  = self.cureAdd + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ADDITIONAL) then
		-- 	self.byCureAdd  = self.byCureAdd + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_ADDITIONAL) then
		-- 	self.firingAdd  = self.firingAdd + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_ADDITIONAL) then
		-- 	self.posionAdd  = self.posionAdd + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_LESSEN) then
		-- 	self.byFiringLes  = self.byFiringLes + propertyValue
		-- 	--break
		-- elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_LESSEN) then
		-- 	self.byPosionLes  = self.byPosionLes + propertyValue
		-- 	--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT) then
			if(propertyValue < 1) then
				propertyValue = propertyValue * 100
			end
			self.finalDamagePercent  = self.finalDamagePercent + propertyValue
			--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT) then
			if(propertyValue < 1) then
				propertyValue = propertyValue * 100
			end
			self.finalLessenDamagePercent  = self.finalLessenDamagePercent + propertyValue
			--break
		elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_INIT_ZOMALSKILLPOINT) then
			self.zoariumSkillPoint = propertyValue
		else
		end
	end
end

function FightObject:addPropertyByTalentInfluencePriorValueResults(attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightModule)
	if nil ~= self.talentInfos then
		for i, v in pairs(self.talentInfos) do
			for p = 3, #v do
				local element = dms.element(dms["talent_mould"], v[p])
				local talentMould = TalentMould:new()
				talentMould:init(element)
				self:addPropertyByTalentInfluencePriorValueResult(talentMould, attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightMould)
			end
		end
	end
end

function FightObject:addPropertyByTalentInfluencePriorValueResult(talentMould, attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightModule)
	-- _crint("战前赋予效果：", talentMould.id, talentMould.influencePriorType, talentMould.influenceJudgeResult)
	if talentMould.influencePriorType < 0 then
		-- self:addPropertyValues(talentMould.influenceJudgeResult)
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_FORMATION_FRONT_ROW then -- 22影响我方全体 
		
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_FORMATION_FRONT_ROW then -- 28我方前排
		for i, v in pairs(attackerFormationObjects) do
			if v.coordinate <= 3 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_OTHER_SKILL_PROPERTY then -- 29影响对方技属性
		for i, v in pairs(defenderFormationObjects) do
			if v.campPreference == 3 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_OTHER_DEFEND_PROPERTY then -- 30影响对方防属性
		for i, v in pairs(defenderFormationObjects) do
			if v.campPreference == 2 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_OTHER_ATTACK_PROPERTY then -- 31影响对方攻属性
		for i, v in pairs(defenderFormationObjects) do
			if v.campPreference == 1 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_OTHER_ALL_TARGET then -- 32影响敌方全体
		for i, v in pairs(defenderFormationObjects) do
			v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_BACK_ROW then -- 33我方后排
		for i, v in pairs(attackerFormationObjects) do
			if v.coordinate > 3 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_DEFEND_PROPERTY then -- 34影响我方防属性
		for i, v in pairs(attackerFormationObjects) do
			if v.campPreference == 2 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_ATTACK_PROPERTY then -- 35影响我方攻属性
		for i, v in pairs(attackerFormationObjects) do
			if v.campPreference == 1 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_SKILL_PROPERTY then -- 36影响我方技属性
		for i, v in pairs(attackerFormationObjects) do
			if v.campPreference == 3 then
				v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
			end
		end
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_TARGET_SHIP_PROPERTY then -- 37影响我方特定数码兽（ship_mould ID 13,14,2,18,17,35）

	end
end

function FightObject:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
	-- _crint("战前赋予效果校验：", talentMould.influencePriorType)
	if talentMould.influenceJudgeOpportunity == TalentConstant.JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE then
		-- _crint("添加战前赋予效果：", talentMould.influenceJudgeResult)
		if talentMould.influenceJudgeType1 == TalentConstant.JUDGE_TYPE1_OPPONENT_CRUEL then
			-- _crint("只在竞技场生效")
			if fightModule.fightType == _enum_fight_type._fight_type_11 then
				self:addPropertyValues(talentMould.influenceJudgeResult)
			end
		else
			self:addPropertyValues(talentMould.influenceJudgeResult)
		end
		-- self:addPropertyValues(talentMould.influencePriorValue)
	end
end

function FightObject:addPropertyByTalentInfluenceJudgeResult(talentMould)
	-- local propertyTypeArray = zstring.split(talentMould.influenceJudgeResult, "|")
	-- -- for (local property ) then propertyTypeArray) {
	-- for _, property in pairs(propertyTypeArray) do
	-- 	local propertyType = tonumber(zstring.split(property, ",")[1])
	-- 	local propertyValue = tonumber(zstring.split(property, ",")[2])
	-- 	self:addPropertyValue(propertyType, propertyValue)
	-- end
	self:addPropertyValues(talentMould.influenceJudgeResult)
end

function FightObject:addPropertyValues(propertyInfos)
	local propertyTypeArray = zstring.split(propertyInfos, "|")
	-- for (local property ) then propertyTypeArray) {
	for _, property in pairs(propertyTypeArray) do
		local propertyInfo = zstring.split(property, ",")
		if #propertyInfo > 1 then
			local propertyType = tonumber(propertyInfo[1])
			local propertyValue = tonumber(propertyInfo[2])
			self:addPropertyValue(propertyType, propertyValue)
		end
	end
end

function FightObject:addPropertyValue(propertyType, propertyValue)
	-- print("战场初始化,属性增加：", propertyType, propertyValue)
	if (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL) then
		self.healthPoint = self.healthPoint + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL) then
		self.attack = self.attack + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL) then
        local physicalDefence = self.physicalDefence
		self.physicalDefence = self.physicalDefence + propertyValue
		-- _crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL .. "】：", self.physicalDefence, propertyValue, physicalDefence)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL) then
		self.skillDefence = self.skillDefence + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.powerAdditionalPercent = self.powerAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.courageAdditionalPercent = self.courageAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.intellectAdditionalPercent = self.intellectAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.nimableAdditionalPercent = self.nimableAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS) then
		self.criticalAdditionalPercent = self.criticalAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS) then
		self.criticalResistAdditionalPercent = self.criticalResistAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS) then
		self.retainAdditionalPercent = self.retainAdditionalPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS) then
		self.retainBreakAdditionalPercent  = self.retainBreakAdditionalPercent + propertyValue
	-- 	--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ACCURACY_ODDS) then
		self.accuracyAdditionalPercent  = self.accuracyAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVASION_ODDS) then
		self.evasionAdditionalPercent  = self.evasionAdditionalPercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_LESSEN_DAMAGE_PERCENTAGE) then
		self.physicalLessenDamagePercent  = self.physicalLessenDamagePercent + (propertyValue / 100)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_LESSEN_DAMAGE_PERCENTAGE) then
		self.skillLessenDamagePercent  = self.skillLessenDamagePercent + (propertyValue / 100)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ODDS) then
		self.curePercent  = self.curePercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ODDS) then
		self.byCurePercent  = self.byCurePercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE) then
		self.finalDamageAddition  = self.finalDamageAddition + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE) then
		self.finalSubDamageAddition  = self.finalSubDamageAddition + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_SP_INCREASE) then
		self.initialSPIncrease  = self.initialSPIncrease + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_HEAD) then
		self.leader  = self.leader + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_BODY) then
		self.strength  = self.strength + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_WISDOM) then
		self.wisdom  = self.wisdom + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_ATTACK_ADDITIONAL) then
		self.physicalAttackAdd  = self.physicalAttackAdd + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADDITIONAL) then
		self.skillAttackAdd  = self.skillAttackAdd + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ADDITIONAL) then
		self.cureAdd  = self.cureAdd + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ADDITIONAL) then
		self.byCureAdd  = self.byCureAdd + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_ADDITIONAL) then
		self.firingAdd  = self.firingAdd + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_ADDITIONAL) then
		self.posionAdd  = self.posionAdd + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_LESSEN) then
		self.byFiringLes  = self.byFiringLes + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_LESSEN) then
		self.byPosionLes  = self.byPosionLes + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.finalDamagePercent  = self.finalDamagePercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.finalLessenDamagePercent  = self.finalLessenDamagePercent + propertyValue
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_INIT_ZOMALSKILLPOINT) then
		self.zoariumSkillPoint = propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVERY_ATTACK_ADD_SP) then -- 38.每次出手增加的怒气
		self.everyAttackAddSp = self.everyAttackAddSp + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_DAMAGE_PERCENT) then -- 39.灼烧伤害% 
		self.firingDamagePercent = self.firingDamagePercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT) then -- 40.吸血率%
		self.inhaleHpDamagePercent = self.inhaleHpDamagePercent + propertyValue
		print("设置吸血率为999 " .. self.inhaleHpDamagePercent)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADD_SP_VALUE) then -- 41.怒气
		self.addSpValue = self.addSpValue + propertyValue
		self.skillPoint = self.skillPoint + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_REBOUND_DAMAGE_VALUE) then -- 42.反弹%  
		self.reboundDamageValue = self.reboundDamageValue + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_DAMAGE_PERCENT) then -- 43.暴伤加成%	   
		self.uniqueSkillDamagePercent = self.uniqueSkillDamagePercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_AVOID_CONTROL_PERCENT) then -- 44.免控率%  
		self.avoidControlPercent = self.avoidControlPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT) then -- 45.小技能触发概率%  
		self.normatinSkillTriggerPercent = self.normatinSkillTriggerPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_RESISTANCE_PERCENT) then -- 46.格挡强度% 
		self.uniqueSkillResistancePercent = self.uniqueSkillResistancePercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CONTROL_PERCENT) then -- 47.控制率%
		self.controlPercent = self.controlPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_EFFECT_PERCENT) then -- 48.治疗效果% 
		self.cureEffectPercent = self.cureEffectPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ADDITION_PERCENT) then -- 49.暴击强化% 
		self.criticalAdditionPercent = self.criticalAdditionPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_HERO_RESTRAIN_DAMAGEPERCENT) then -- 50.数码兽类型克制伤害%
		self.heroRestrainDamagePercent = self.heroRestrainDamagePercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SPUTTERING_ATTACK_ADD_DAMAGE_PERCENT) then -- 51.溅射伤害%
		self.sputteringAttackAddDamagePercent = self.sputteringAttackAddDamagePercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADD_DAMAGE_PERCENT) then -- 52.技能伤害%
		self.skillAttackAddDamagePercent = self.skillAttackAddDamagePercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT) then -- 53.被治疗减少%
		self.byCureLessenPercent = self.byCureLessenPercent + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_54) then -- 54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
		self.ptvf54 = self.ptvf54 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_ODDS_FOR_55) then -- 55.必杀伤害率%
		self.ptvf55 = self.ptvf55 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_56) then -- 56.增加必杀伤害%
		self.ptvf56 = self.ptvf56 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_57) then -- 57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
		self.ptvf57 = self.ptvf57 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_58) then -- 58.增加暴击伤害%
		self.ptvf58 = self.ptvf58 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_59) then -- 59.减少暴击伤害%
		self.ptvf59 = self.ptvf59 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_60) then -- 60.受到的必杀伤害增加%
		self.ptvf60 = self.ptvf60 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_PWER_ADD_SPEED_FOR_61) then -- 61.怒气回复速度%
		self.ptvf61 = self.ptvf61 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_PERCENT_FOR_62) then -- 62.受到伤害降低%
		self.ptvf62 = self.ptvf62 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_ATTACK_PERCENT_FOR_63) then -- 63.降低攻击(%)	
		self.ptvf63 = self.ptvf63 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_64) then -- 64.降低防御
		self.ptvf64 = self.ptvf64 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_65) then -- 65.伤害加成提升%
		self.ptvf65 = self.ptvf65 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_66) then -- 66.降低必杀伤害率%	
		self.ptvf66 = self.ptvf66 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_67) then -- 67.降低伤害减免%
		self.ptvf67 = self.ptvf67 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_68) then -- 68.降低防御（%）
		self.ptvf68 = self.ptvf68 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_69) then -- 69.降低怒气回复速度
		self.ptvf69 = self.ptvf69 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_70) then -- 70.数码兽类型克制伤害加成%
        self.ptvf70 = self.ptvf70 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_71) then -- 71.数码兽类型克制伤害减免%
        self.ptvf71 = self.ptvf71 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_72) then -- 72.降低攻击
        self.ptvf72 = self.ptvf72 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_73) then -- 73.增加必杀抗性%
        self.ptvf73 = self.ptvf73 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74) then -- 74.减少必杀抗性%
        self.ptvf74 = self.ptvf74 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74) then -- 74.减少必杀抗性%
        self.ptvf74 = self.ptvf74 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_75) then -- 75.降低免控率%
        self.ptvf75 = self.ptvf75 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_76) then -- 76.复活概率%
        self.ptvf76 = self.ptvf76 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_77) then -- 77.被复活概率%
        self.ptvf77 = self.ptvf77 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_78) then -- 78复活继承血量%
        self.ptvf78 = self.ptvf78 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_79) then -- 79复活继承怒气%
        self.ptvf79 = self.ptvf79 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_80) then -- 80被复活继承血量%
        self.ptvf80 = self.ptvf80 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_81) then -- 81被复活继承怒气%
        self.ptvf81 = self.ptvf81 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_82) then -- 82增加复活概率%
		self.ptvf82 = self.ptvf82 + propertyValue
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_83) then -- 83增加复活继承血量%
        self.ptvf83 = self.ptvf83 + propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_84) then -- 84小技能伤害提升%
        self.ptvf84 = self.ptvf84 + propertyValue
	else
	
	end
end

function FightObject:initWithNpc(npc, difficulty, coordinate, environmentShipId, fakeLevel, isFake) 
	----_crint ("Call initialize function: ") 
	self.userInfo = npc.id
	self.battleTag = 1
	self.coordinate = coordinate

	self:initWithEnvironmentShip(environmentShipId, fakeLevel, isFake)

	-- --local npcDifficultArray = zstring.split(npc.difficultyAdditional, "|")[difficulty]
	-- local difficultyAdditionalArray = {1, 1, 1, 1, 1, 1} --zstring.split(npcDifficultArray, IniUtil.comma)
	-- ----_crint ("npc.difficultyAdditional: " .. npc.difficultyAdditional)
	-- ----_crint ("npcDifficultArray: " .. npcDifficultArray)
	-- --local environmentShip = EnvironmentShip:new()
	-- --Transformers.environmentShipDAOProxy().load(environmentShipId);
	-- if (fakeLevel == nil) then
	-- 	fakeLevel = 1
	-- end	
	-- environmentShip = ConfigDB.load("environment_ship", environmentShipId)
	

	-- if(isFake) then
	-- 	environmentShip.power = environmentShip.power + ((fakeLevel - 1) * environmentShip.growPower)
	-- 	environmentShip.courage = environmentShip.courage + ((fakeLevel - 1) * environmentShip.growCourage)
	-- 	environmentShip.intellect = environmentShip.intellect + ((fakeLevel - 1) * environmentShip.growIntellect)
	-- 	environmentShip.nimable = environmentShip.nimable + ((fakeLevel - 1) * environmentShip.growNimable)
	-- end
	-- environmentShip:calculateShipProperty()
	-- self.fightName = environmentShip.shipName
	-- self.name = environmentShip.shipName
	-- self.id = environmentShipId;
	-- self.mouldId = environmentShipId;
	-- self.userInfo = npc.id
	-- self.picIndex = environmentShip.bustIndex .. "";
	-- self.campPreference = environmentShip.campPreference
	-- self.gender = environmentShip.gender
	-- self.quality = environmentShip.shipType
	-- self.healthPoint =  environmentShip.power * tonumber(difficultyAdditionalArray[1])
	-- self.lessHealthPoint =  environmentShip.power * tonumber(difficultyAdditionalArray[1])
	-- -- self.skillPoint = 1
	-- self.skillPoint = environmentShip.haveDeadly
	-- ----_crint( "environmentShip.courage: " .. environmentShip.courage)
	-- self.attack =  environmentShip.courage * tonumber(difficultyAdditionalArray[2])
	-- ----_crint ("self.attack = " .. self.attack)
	-- self.physicalDefence =  environmentShip.intellect * tonumber(difficultyAdditionalArray[3])
	-- self.skillDefence =  environmentShip.nimable * tonumber(difficultyAdditionalArray[4])
	-- self.critical = environmentShip.critical
	-- self.criticalResist = environmentShip.criticalResist + environmentShip.criticalResistAdditionalPercent
	-- self.evasion = environmentShip.jink
	-- self.accuracy = environmentShip.accuracy + environmentShip.accuracyAdditionalPercent
	-- self.retain = environmentShip.retain + environmentShip.retainAdditionalPercent
	-- self.retainBreak = environmentShip.retainBreak + environmentShip.retainBreakAdditionalPercent
	-- self.physicalLessenDamage = environmentShip.physicalLessenDamagePercent
	-- self.skillLessenDamage = environmentShip.skillLessenDamagePercent
	-- self.commonSkill = ConfigDB.load("skill_mould", environmentShip.commonSkillMould)
	-- self.specialSkill = ConfigDB.load("skill_mould", environmentShip.skillMould)


	-- local nsmArr = zstring.split(environmentShip.physicsAttackEffect, ",")
	-- self.normalSkillMould = tonumber(nsmArr[1])
	-- self.normalSkillMouldRate = tonumber(nsmArr[2])
	
	-- ----_crint ("FightObject:initWithNpc coordinate: " .. coordinate .. ", shipid: " .. environmentShipId)
	-- ----_crint ("Common skillid: " .. self.commonSkill.id .. ", effect: " .. self.commonSkill.healthAffect)
	-- ----_crint ("Special skillid: " .. self.specialSkill.id .. ", effect: " .. self.specialSkill.healthAffect)	
	
	-- self.finalDamageAddition = 0
	-- self.finalSubDamageAddition = 0
	-- --设置掉落物品信息
	-- self.rewardCard = environmentShip.rewardCard
	-- self.rewardRatio = environmentShip.rewardCardRatio
	-- self.rewardProp = environmentShip.dropProp;
	-- self.rewardPropRatio = environmentShip.dropPropRatio;
	-- self.rewardEquipment = environmentShip.dropEquipment;
	-- self.rewardEquipmentRatio = environmentShip.dropEquipmentRatio;

	-- self.cureOdds = environmentShip.curePercent
	-- self.byCureOdds = environmentShip.byCurePercent
	-- self.skillPoint = self.skillPoint + environmentShip.initialSPIncrease
	-- self.talentMouldList = environmentShip.talentMouldList
	-- self.shipMould = environmentShip.directing
	-- ----_crint ("environmentShip.directing : " .. environmentShip.directing)
	-- self.specialSkillDecribe = 0
	-- self.capacity= environmentShip.capacity
	-- self.restrainMoulds = {ConfigDB.load("restrain_mould", self.capacity + 1)}
	-- self.zoariumSkillPoint = environmentShip.zoariumSkillPoint
	-- self.signType = environmentShip.signType
	-- ----_crint ("self.restrainMoulds = " .. self.restrainMoulds.id)
	-- --os.exit()
end

function FightObject:initWithEnvironmentShip(environmentShipId, fakeLevel, isFake)
	self.roleType = 1
	local difficultyAdditionalArray = {1, 1, 1, 1, 1, 1}

	if (fakeLevel == nil) then
		fakeLevel = 1
	end	

	local environmentShip = ConfigDB.load("environment_ship", environmentShipId)
	
	if(isFake) then
		environmentShip.power = environmentShip.power + ((fakeLevel - 1) * environmentShip.growPower)
		environmentShip.courage = environmentShip.courage + ((fakeLevel - 1) * environmentShip.growCourage)
		environmentShip.intellect = environmentShip.intellect + ((fakeLevel - 1) * environmentShip.growIntellect)
		environmentShip.nimable = environmentShip.nimable + ((fakeLevel - 1) * environmentShip.growNimable)
	end
	
	environmentShip:calculateShipProperty()
	self.fightName = environmentShip.shipName
	self.name = environmentShip.shipName
	self.id = environmentShipId;
	self.mouldId = environmentShipId;
	-- self.userInfo = npc.id
	self.picIndex = environmentShip.bustIndex .. "";
	self.campPreference = environmentShip.campPreference
	self.gender = environmentShip.gender
	self.quality = environmentShip.shipType
	self.healthPoint =  environmentShip.power * tonumber(difficultyAdditionalArray[1])
	self.lessHealthPoint =  environmentShip.power * tonumber(difficultyAdditionalArray[1])
	-- self.skillPoint = 1
	self.skillPoint = environmentShip.haveDeadly
	----_crint( "environmentShip.courage: " .. environmentShip.courage)
	self.attack =  environmentShip.courage * tonumber(difficultyAdditionalArray[2])
	----_crint ("self.attack = " .. self.attack)
	self.physicalDefence =  environmentShip.intellect * tonumber(difficultyAdditionalArray[3])
	self.skillDefence =  environmentShip.nimable * tonumber(difficultyAdditionalArray[4])
	self.critical = environmentShip.critical
	self.criticalResist = environmentShip.criticalResist + environmentShip.criticalResistAdditionalPercent
	self.evasion = environmentShip.jink
	self.accuracy = environmentShip.accuracy + environmentShip.accuracyAdditionalPercent
	self.retain = environmentShip.retain + environmentShip.retainAdditionalPercent
	self.retainBreak = environmentShip.retainBreak + environmentShip.retainBreakAdditionalPercent
	self.physicalLessenDamage = environmentShip.physicalLessenDamagePercent
	self.skillLessenDamage = environmentShip.skillLessenDamagePercent
	self.commonSkill = ConfigDB.load("skill_mould", environmentShip.commonSkillMould)
	self.specialSkill = nil
	if environmentShip.skillMould > 0 then
		self.specialSkill = ConfigDB.load("skill_mould", environmentShip.skillMould)
	end

	local nsmArr = zstring.split(environmentShip.physicsAttackEffect, ",")
	self.normalSkillMould = tonumber(nsmArr[1])
	self.normalSkillMouldRate = tonumber(nsmArr[2])
	self.normalSkillMouldRates = {tonumber(nsmArr[2]), tonumber(nsmArr[3]), tonumber(nsmArr[4])}
	self.normalSkillMouldRateIndex = 1
	
	----_crint ("FightObject:initWithNpc coordinate: " .. coordinate .. ", shipid: " .. environmentShipId)
	----_crint ("Common skillid: " .. self.commonSkill.id .. ", effect: " .. self.commonSkill.healthAffect)
	----_crint ("Special skillid: " .. self.specialSkill.id .. ", effect: " .. self.specialSkill.healthAffect)	
	
	self.finalDamageAddition = 0
	self.finalSubDamageAddition = 0
	--设置掉落物品信息
	self.rewardCard = environmentShip.rewardCard
	self.rewardRatio = environmentShip.rewardCardRatio
	self.rewardProp = environmentShip.dropProp;
	self.rewardPropRatio = environmentShip.dropPropRatio;
	self.rewardEquipment = environmentShip.dropEquipment;
	self.rewardEquipmentRatio = environmentShip.dropEquipmentRatio;

	self.cureOdds = environmentShip.curePercent
	self.byCureOdds = environmentShip.byCurePercent
	self.skillPoint = self.skillPoint + environmentShip.initialSPIncrease
	self.talentMouldList = environmentShip.talentMouldList
	self.shipMould = environmentShip.directing
	----_crint ("environmentShip.directing : " .. environmentShip.directing)
	self.specialSkillDecribe = 0
	self.capacity= environmentShip.capacity
	self.restrainMoulds = {ConfigDB.load("restrain_mould", self.capacity + 1)}
	self.zoariumSkillPoint = environmentShip.zoariumSkillPoint
	self.signType = environmentShip.signType
	----_crint ("self.restrainMoulds = " .. self.restrainMoulds.id)
	--os.exit()

    -- 8号属性
    self.criticalAdditionalPercent = self.critical
    -- 9号属性
    self.criticalResistAdditionalPercent = self.criticalResist
    -- 10号属性
    self.retainAdditionalPercent = self.retain
    -- 11号属性
    self.retainBreakAdditionalPercent = self.retainBreak

	--进化模板id
	self.evolutionLevel = dms.int(dms["ship_mould"], self.shipMould, ship_mould.captain_name) or self.evolutionLevel
	-- print("self.evolutionLevel", self.evolutionLevel)
end

function FightObject:initWithUserData(coordinate, ship, battleTag, userId)
	self.roleType = 0
	self.battleTag = battleTag
	self.coordinate = coordinate
	local shipMould = ConfigDB.load("ship_mould", ship.ship_template_id)

	local tempCommonSkill = ConfigDB.load("skill_mould", shipMould.skillMould);
	local tempSpecialSkill = nil
	if shipMould.deadlySkillMould > 0 then
		tempSpecialSkill = ConfigDB.load("skill_mould", shipMould.deadlySkillMould)
	end
	local fashionImg =  0
	local weaponAwakening = false
	local weaponAwakenTalentInfo = nil
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		--进化形象
		local evo_image = dms.string(dms["ship_mould"], ship.ship_template_id, ship_mould.fitSkillTwo)
		local evo_info = zstring.split(evo_image, ",")
		--进化模板id
		local ship_evo = zstring.split(ship.evolution_status, "|")
		local evo_level = tonumber(ship_evo[1])
		local evo_mould_id = smGetSkinEvoIdChange(ship)
		if zstring.tonumber(ship.skin_id) ~= 0 then
	    	evo_mould_id = dms.int(dms["ship_skin_mould"], ship.skin_id, ship_skin_mould.ship_evo_id)
	    end

		self.evolutionLevel = tonumber(ship_evo[1])

		self.amplifyPercent = dms.string(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.spx_scale)

		--新的形象编号
		fashionImg = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)

		-- 技能信息
		local skillInfos = zstring.splits(dms.string(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.attack), "|", ",")
		tempCommonSkill = ConfigDB.load("skill_mould", skillInfos[1][1])
		-- tempSpecialSkill = ConfigDB.load("skill_mould", skillInfos[3][1])
		self.skillInfos = skillInfos

		local talentInfos = zstring.splits(dms.string(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.talent_index), "|", ",")
		-- debug.print_r(talentInfos)
		-- tempCommonSkill = ConfigDB.load("skill_mould", dms.int(dms["talent_mould"], talentInfos[1][3], talent_mould.skill_mould_id))
		local tempSpecialSkillId = dms.int(dms["talent_mould"], talentInfos[2][3], talent_mould.skill_mould_id)
		if tempSpecialSkillId > 0 then
			tempSpecialSkill = ConfigDB.load("skill_mould", tempSpecialSkillId)
		end
		self.talentInfos = talentInfos

		self.normalSkillMould = dms.int(dms["talent_mould"], talentInfos[1][3], talent_mould.skill_mould_id)
		-- self.normalSkillMouldRate = tonumber(nsmArr[2])
		-- self.normalSkillMouldRate = tonumber(dms.int(dms["talent_mould"], talentInfos[1][3], talent_mould.initial_triggered_probability)) or 35
		self.normalSkillMouldRate = FightModule.nsrs[1]
		self.normalSkillMouldRates = FightModule.nsrs
		self.normalSkillMouldRateIndex = 1

		-- self.normalSkillTalents = {}
		-- for p = 3, #talentInfos[1] do
		-- 	local element = dms.element(dms["talent_mould"], talentInfos[1][p])
		-- 	local talentMould = TalentMould:new()
		-- 	talentMould:init(element)
		-- 	-- self:addPropertyByTalentInfluenceJudgeResult(talentMould)
		-- 	-- self:addPropertyByTalentInfluencePriorValueResult(talentMould)
		-- 	table.insert(self.normalSkillTalents, talentMould)
		-- end

		-- self.specialSkillTalents = {}
		-- for p = 3, #talentInfos[2] do
		-- 	local element = dms.element(dms["talent_mould"], talentInfos[2][p])
		-- 	local talentMould = TalentMould:new()
		-- 	talentMould:init(element)
		-- 	-- self:addPropertyByTalentInfluenceJudgeResult(talentMould)
		-- 	-- self:addPropertyByTalentInfluencePriorValueResult(talentMould)
		-- 	table.insert(self.specialSkillTalents, talentMould)
		-- end

		-- 武器觉醒后，将绝技给替换成武将的技能信息
		if ship.relationship then
			for i, v in pairs(ship.relationship) do
				if tonumber(v.is_activited) == 1 then
					local zoarium_skill = dms.int(dms["fate_relationship_mould"], v.relationship_id, fate_relationship_mould.zoarium_skill)
					-- print("进行绝技替换 zoarium_skill:", zoarium_skill, v.relationship_id)
					-- debug.print_r(v)
					if zoarium_skill == 1 then
						local weaponAwakenTalentInfos = zstring.splits(shipMould.talentId, "|", ",")
						weaponAwakenTalentInfo = weaponAwakenTalentInfos[evo_level]

						--有皮肤直接取皮肤的觉醒技能id
						local current_skin_id = 0
						if ship.ship_skin_info and ship.ship_skin_info ~= "" then
					        local skin_info = zstring.splits(ship.ship_skin_info, "|", ":")
					        local temp = zstring.split(skin_info[1][1], ",")
					        current_skin_id = zstring.tonumber(temp[1])
					    end
					    if current_skin_id ~= 0 then
					    	local zoarium_skill_ids = dms.string(dms["ship_skin_mould"], current_skin_id, ship_skin_mould.zoarium_skill_id)
					    	weaponAwakenTalentInfo = zstring.split(zoarium_skill_ids, ",")
					    end

						tempSpecialSkillId = dms.int(dms["talent_mould"], weaponAwakenTalentInfo[3], talent_mould.skill_mould_id)
						-- print("tempSpecialSkillId:", tempSpecialSkillId)
						if tempSpecialSkillId > 0 then
							tempSpecialSkill = ConfigDB.load("skill_mould", tempSpecialSkillId)
							weaponAwakening = true
						end
					end
				end
			end
		end

		self.skillLevels = zstring.split(ship.skillLevel, ",")
	else
		fashionImg =  shipMould.bustIndex	
	end
	
	if(tonumber(ship.captain_type) == 0) then
		--学艺技能
		for i , v in pairs(_ED.user_skill_equipment) do
		   if tonumber(v.equip_state) == 1 then
		   		local skillEquipment = dms.element(dms['skill_equipment_mould'],v.skill_equipment_base_mould)
		   		local studySkill = dms.atoi(skillEquipment,skill_equipment_mould.skill_equipment_base_mould)
		   		tempSpecialSkill = ConfigDB.load("skill_mould", studySkill)
		   		break
		   end
		end
	end
	--_crint ("FightObject:initWithUserData coordinate: " .. coordinate .. ", shipid: " .. ship.ship_id)
	--_crint ("shipMould id: " .. shipMould.id)
	--_crint ("Common skillid: " .. tempCommonSkill.id .. ", effect: " .. tempCommonSkill.healthAffect)
	--_crint ("Special skillid: " .. tempSpecialSkill.id .. ", effect: " .. tempSpecialSkill.healthAffect)
	
	if(shipMould.captainType == 0) then
		self.fightName = _ED.user_info.user_name
	end
	self.id = ship.ship_id
	self.mouldId = ship.ship_template_id
	self.shipMould =shipMould.baseMould 
	self.userInfo = userId
	self.picIndex = fashionImg .. ""
	self.attackSpeed = ship.ship_wisdom
	self.campPreference = shipMould.campPreference
	self.gender = shipMould.heroGender
	self.quality = shipMould.shipType
	self.leader = ship.ship_leader                               -- 统帅
	self.strength = ship.ship_courage                            -- 武力 [1]
	self.wisdom = ship.ship_wisdom                               -- 智慧
	self.healthPoint = tonumber(ship.ship_health)                -- 血量
	self.lessHealthPoint = tonumber(ship.ship_health)  
	self.skillPoint = self.initialSPIncrease
	self.attack = ship.ship_courage                              -- 攻击
	self.physicalDefence = tonumber(ship.ship_intellect)         -- 物防 [2]
	self.skillDefence = tonumber( ship.ship_quick)               -- 法防
	self.critical = shipMould.initialCritical
	self.criticalResist = shipMould.initialCriticalResist
	self.evasion = shipMould.initialJink
	self.accuracy = shipMould.initialAccuracy
	self.retain = shipMould.initialRetain
	self.retainBreak = shipMould.initialRetainBreak

	self.ability = shipMould.ability

	self.commonSkill = tempCommonSkill
	self.specialSkill = tempSpecialSkill

	-- local nsmArr = zstring.split(shipMould.skillName, ",")
	-- self.normalSkillMould = tonumber(nsmArr[1])
	-- -- self.normalSkillMouldRate = tonumber(nsmArr[2])
	-- self.normalSkillMouldRate = tonumber(nsmArr[2]) or 35

	-- self.normalSkillMould = tonumber(self.skillInfos[2][1])
	-- -- self.normalSkillMouldRate = tonumber(nsmArr[2])
	-- self.normalSkillMouldRate = tonumber(self.skillInfos[2][2]) or 35
	
	--self.finalDamageAddition = ship.getFinalDamageAdditional();
	--self.finalSubDamageAddition = ship.getFinalLessenDamageAdditional();
	--self.cureOdds = ship.getCurePercent();
	--self.byCureOdds = ship.getByCurePercent();
	
	--self.talentMouldList = ship.getTalentMouldList();
	--self.specialSkillDecribe = specialSkillDecribe;
	--self.physicalAttackAdd = ship.getPhysicalAttackAdd();
	--self.skillAttackAdd = ship.getSkillAttackAdd();
	--self.cureAdd = ship.getCureAdd();
	--self.byCureAdd = ship.getByCureAdd();
	--self.firingAdd = ship.getFiringAdd();
	--self.byFiringLes = ship.getByFiringLes();
	--self.posionAdd = ship.getPosionAdd();
	--self.byPosionLes = ship.getByPosionLes();
	--self.advance = shipMould.getInitialRankLevel();
	--self.finalDamagePercent = ship.getFinalDamageAdditionalPercent();
	--self.finalLessenDamagePercent = ship.getFinalLessenDamageAdditionalPercent();
	self.capacity = shipMould.capacity
	self.restrainMoulds = {ConfigDB.load("restraint_mould", self.capacity + 1)}
	-- 合体技的发动者是自身
	if(shipMould.primeMover == shipMould.baseMould) then
		self.zoarium = shipMould.zoariumSkill
	end
	-- if zstring.tonumber(ship.battle_m_types) == 53 then
	-- else
	-- 	self:calculateShipProperty(ship,shipMould)
	-- end

	-- 修整数据
	self.uniqueSkillDamagePercent = shipMould.initialJink * 100 -- [43]
	self.uniqueSkillResistancePercent = shipMould.initialAccuracy * 100 -- [46]

	local property_values = zstring.splits(ship.property_values, "|", ":", function ( value )
		return tonumber(value)
	end)
	for i, v in pairs(property_values) do
		local propertyType = v[1]
		local propertyValue = v[2]
		if propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS 
			or propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS 
			or propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS 
			or propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS then
			propertyValue = propertyValue / 100
		end
		self:addPropertyValue(propertyType, propertyValue)
	end

	self.skillPoint = self.skillPoint + ship.initial_sp_increase

	if nil ~= self.talentInfos then
		local lvs = zstring.split(dms.string(dms["ship_config"], 2, ship_config.param), ",")
		for i, v in pairs(self.talentInfos) do
			-- print(i, ship.StarRating, lvs[i])
			if tonumber(ship.StarRating) >= tonumber(lvs[i]) then
				if weaponAwakening and i == 2 then
					v = weaponAwakenTalentInfo
					-- debug.print_r(v)
				end
				for p = 3, #v do
					local element = dms.element(dms["talent_mould"], v[p])
					local talentMould = TalentMould:new()
					if nil ~= self.skillLevels then
						talentMould.level = self.skillLevels[i]
					end
					talentMould:init(element)
					table.insert(self.talentMouldList, talentMould)
				end
			end
		end
	end

	local soul_data = zstring.split(ship.ship_fighting_spirit,"|")
	local faction_ids = zstring.split(dms.string(dms["ship_mould"], ship.ship_template_id, ship_mould.faction_id), ",")
	for i, v in pairs(faction_ids) do
		local unlock_condition = dms.int(dms["ship_soul_mould"], faction_ids[i], ship_soul_mould.unlock_condition)
		if unlock_condition <= zstring.tonumber(ship.Order) then
    		local soul_lv = tonumber(zstring.split(soul_data[i],",")[1])
			local talent_ids = zstring.split(dms.string(dms["ship_soul_mould"], faction_ids[i], ship_soul_mould.talent_id), ",")
			for p = 1, #talent_ids do
				local element = dms.element(dms["talent_mould"], talent_ids[p])
				local talentMould = TalentMould:new()
				talentMould:init(element)
				talentMould.level = soul_lv
				table.insert(self.talentMouldList, talentMould)
				--> __crint("添加斗魂天赋：", talent_ids[p], faction_ids[i], soul_lv)
			end
		end
	end

	local usership = ship
	local isVerity = true
	if isVerity == true and usership ~= nil and usership.history_info ~= nil then
		local history_info = aeslua.decrypt("jar-world", usership.history_info, aeslua.AES128, aeslua.ECBMODE)
		local old_history_info = usership.ship_health 
			.. usership.ship_wisdom 
			.. usership.ship_leader 
			.. usership.ship_courage
			.. usership.ship_intellect
			.. usership.ship_quick
		if history_info ~= old_history_info then
			isVerity = false
		end

		if isVerity == false then
			_ED._fightModule._error = true
			fwin:addService({
				callback = function ( params )
					if fwin:find("ReconnectViewClass") == nil then
						fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
					end
				end,
				delay = 5,
				params = self
			})
			return false
		end
	end
end

function FightObject:getTalentMouldList()
	return talentMouldList
end

function FightObject:setTalentMouldList(talentMouldList)
	self.talentMouldList = talentMouldList
end

function FightObject:fightObject(forceMould,userId)
	local shipMould = ConfigDB.load("ship_mould", dms.atoi(forceMould,ship_force_mould.force_mould))
	local propertyPercent = dms.atoi(forceMould,ship_force_mould.property_percent)/100
	local fightObject = FightObject:new()
	fightObject.id = 0
	fightObject.fightName = self.fightName
	fightObject.mouldId = dms.atoi(forceMould,ship_force_mould.force_mould)
	fightObject.shipMould = dms.atoi(forceMould,ship_force_mould.force_mould)
	fightObject.userInfo = userId
	fightObject.picIndex = shipMould.bustIndex..""
	fightObject.campPreference = shipMould.campPreference
	fightObject.gender = shipMould.gender
	fightObject.quality = shipMould.shipType
	fightObject.leader = shipMould.ship_leader               -- 统帅
	fightObject.strength = shipMould.ship_courage                           -- 武力
	fightObject.wisdom = shipMould.ship_wisdom                               -- 智慧
	fightObject.healthPoint = tonumber(self.healthPoint)*propertyPercent                -- 血量
	fightObject.lessHealthPoint = tonumber(self.lessHealthPoint)*propertyPercent
	fightObject.attack = self.attack*propertyPercent                              -- 攻击
	fightObject.physicalDefence = tonumber(self.physicalDefence)*propertyPercent         -- 物防
	fightObject.skillDefence = tonumber(self.skillDefence)*propertyPercent               -- 法防
	fightObject.critical = self.critical
	fightObject.criticalResist = self.criticalResist

	fightObject.evasion = self.evasion
	fightObject.accuracy = self.accuracy
	fightObject.retain = self.retain
	fightObject.retainBreak = self.retainBreak

	fightObject.commonSkill = self.commonSkill
	fightObject.specialSkill = self.specialSkill
	fightObject.capacity = self.capacity
	fightObject.skillPoint = self.skillPoint

	return fightObject
end

local obj = FightObject:new()


