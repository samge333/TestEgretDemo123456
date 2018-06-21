-- 战斗中对象
-- @author xiaofeng
BattleObject = class("BattleObject")

function BattleObject:ctor()
    print("创建BattleObject")
    -- print(debug.traceback())
    --攻击标识
    self.battleTag =  0

    --对象坐标
    self.coordinate =  0

    --对象id
    self.id =  0

    --战船模板ID
    self.shipMould =  0

    --用户信息
    self.userInfo =  -1

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
    self.historyHealthPoint =  nil

    --最大生命
    self.healthMaxPoint =  0

    --技能槽(怒气点数)
    self.skillPoint =  0
    self.historySkillPoint = nil

    --合体技能槽(怒气点数)
    self.zomlllSkillPoint =  0

    --攻击力(物攻 法攻);
    self.attack =  0

    --额外攻击力加成
    self.addAttack =  0

	-- 额外攻击力加成比率
	self.addAttackPercent = 0
	-- 额外降低攻击比率
	self.decAttackPercent = 0

    --物理攻击增加
    self.physicalAttackAdd =  0

    --法术攻击增加
    self.skillAttackAdd =  0

    --额外加成攻击%
    self.extraAttack =  0

    --最终伤害加成
    self.finalDamageAddition =  0

    --最终减伤加成
    self.finalSubDamageAddition =  0

    --最终伤害比例
    self.finalDamagePercent =  0

    --最终伤害比例加成
    self.addFinalDamagePercent =  0

    -- 受到伤害加成比率
    self.addBruiseDamagePercent =  0
    -- 受到伤害削弱比率
	self.decBruiseDamagePercent = 0
	-- 增加物防比率
	self.addPhysicalDefPercent = 0
	-- 削弱物防比率
	self.decPhysicalDefPercent = 0
	-- 增加技能防御比率
	self.addSkillDefPercent = 0
	-- 削弱技能防御比率
	self.decSkillDefPercent = 0

    --物理防御
    self.physicalDefence =  0

    --技能防御
    self.skillDefence =  0

    --增加技能防御
    self.addSkillDefence =  0

    --暴击
    self.critical =  0

    --暴击倍率
    self.critialMultiple =  1

    --增加暴击倍率
    self.addCritialMultiple =  0

    --减少暴击倍率
    self.subCritialMultiple =  0

    --初始抗暴
    self.criticalResist =  0

    --增加抗暴
    self.addCriticalResist =  0

    --闪避
    self.evasion =  0

    --增加闪避
    self.addEvasion =  0

    --减少闪避
    self.subEvasion =  0

    --命中
    self.accuracy =  0

    --增加命中
    self.addAccuracy =  0

    --减少命中增加
    self.subAccuracy =  0

    --格挡
    self.retain =  0

    --破击
    self.retainBreak =  0

    --是否死亡
    self.isDead =  false

    --物理减伤
    self.physicalSubDamage =  0

    --技能减伤
    self.specialSubDatamage =  0

    --治疗加成
    self.cureAdditional =  0

    self.curePercent = 0

    --被治疗率
    self.byCurePercent =  0

    --最终减伤比例
    self.finalLessenDamagePercent =  0

    --续航值
    self.enduranceHPoint =  0

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

    --天赋列表
    self.talentMouldList = {}

    --buff影响
    self.buffEffect = {}

    --普通技能模板
    self.commonSkillMould =  nil

    --普通攻击效用
    self.commonBattleSkill = {}

    --怒气技能模板
    self.specialSkillMould =  nil

    --自身怒气技能效用
    self.oneselfBattleSkill = {}

    --合体怒气技能效用
    self.zoariumBattleSkill = {}

    --释放合体技能
    self.releaseSkill = {}

    --反击技能模板
    self.counterSkillMould =  nil

    --反击技能效用
    self.counterBattleSkill = {}

    --天赋光环列表
    self.talentAuraList = {}

    --联动技能列表
    self.talentUniteSkillList = {}

    --天赋免疫列表
    self.talentImmunityList = {}

    --天赋结果列表
    self.talentJudgeResultList = {}

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

    --是否暴击
    self.isCritical =  false

    --是否闪避
    self.isEvasion =  false

    --是否挡格
    self.isRetain =  false

    --是否禁怒
    self.isSpDisable =  false

    --是否眩晕
    self.isDizzy =  false

    --是否麻痹
    self.isParalysis =  false

    --是否封技
    self.isDisSp =  false

    --是否灼烧
    self.isFiring =  false

    --是否爆裂
    self.isExplode =  false

    --是否禁疗
    self.isBearHP =  false

    --致盲
    self.isBlind =  false

    --残废
    self.isCripple =  false

    --爆裂次数
    self.explodeCount =  0

    --挡格附加值
    self.retainAdditional =  0

    --中毒伤害值
    self.posionDamage =  0

    --灼烧伤害值
    self.firingDamage =  0

    --是否无敌
    self.isNoDamage =  false

    --是否可以反击
    self.canReAttack =  true

    --是否已经出过手
    self.isAction =  false

    --是否必闪
    self.isEvasionSurely =  false

    --造成的伤害
    self.effectDamage =  0

    --技能造成总伤害
    self.totalEffectDamage =  0

    --作用对象数量
    self.coordinateCount =  0

    --怒气点数
    self.totalSkillPoint =  0

    --合击技能模板
    self.zoariumSkillMould =  {}

    --合体技
    self.zoarium =  0

    --合体对象坐标
    self.zoariumSeat =  0

    --进阶等级
    self.advance =  1

    --合体技能释放类型 true:一起 false:依次
    self.seriatim =  false

    --合体技攻击列表
    self.fitBattleObjects = {}

    --合体技模板
    self.releaseSKillMould =  nil

    --发动者
    self.fitBuffer =  nil

    --合击数量
    self.figSkillCount =  0

    --技能效用
    self.fitSkillInflushBuffer =  nil

    --战船标识
    self.capacity =  0

    --相克类型
    self.restrainMoulds =  {}

    --相克属性
    self.restrainObject =  RestrainObject:new()

    --重置合体技状态
    self.hasZoariumSkill =  false


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
	-- 61.受到伤害降低%
	self.ptvf62 = 0
    -- 63.降低攻击(%)	
    self.ptvf63 = 0
    -- 64.降低防御
    self.ptvf64 = 0
    -- 65降低必杀伤害率%	
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

    -- 效用结果属性信息
    self.additionInfluenceJudgeResult = {}

	--评分伤害加成
	self.grade_attack = 1
    self.total_grade_attack = 1

	self.isNeedAddSkillPoint = false

	self.normalSkillMould = nil

	self.normalSkillMouldRate = 0

	self.normalSkillMouldOpened = false

	self.normalBattleSkill = {}

	self.skipSuperSkillMould = false

	self.soulTypes = {} -- 半魂类型列表

    self.normalSkillUseCount = 0 -- 在一场战斗中，释放小技能的次数

    self.powerSkillUseCount = 0 -- 在一场战斗中，释放绝技的次数

    self.reviveCount = 0 -- 复活次数

    self.reboundDamageValueResult = 0 -- 反弹的总伤害记录

    self.lastByAttackTarget = nil -- 最后攻击的目标

    -- 攻击时附加怒气
    self.attackAdditionSpValue = 0
    -- 击杀时是否增加怒气
    self.killTargetAddSp = 1
    -- 被击时是否增加怒气
    self.byAttackDamageAddSp = 1
    -- 负面BUFF免疫
    self.buffNegativeImmunityStatus = false
    -- 强制攻击目录
    self.lockAttackTargetPos = -1
end

function BattleObject:addAttackValue(addAttack)
	self.addAttack = self.addAttack + addAttack
end

function BattleObject:subAttack(addAttack)
	self.addAttack = self.addAttack - addAttack
end

function BattleObject:restoreFitStatus()
	self.fitBuffer = nil
	self.figSkillCount = 0
	self.fitSkillInflushBuffer = nil
end

function BattleObject:pushitSkillInflushBuffer(fitSkillInflushBuffer)
	if (self.fitSkillInflushBuffer == nil) then
		self.fitSkillInflushBuffer = {}
	end
	table.insert(self.fitSkillInflushBuffer, fitSkillInflushBuffer)
end

function BattleObject:addFigSkillCount(figSkillCount)
	self.figSkillCount = self.figSkillCount + figSkillCount
end

function BattleObject:addCriticalResistValue(addCriticalResist)
	self.addCriticalResist = addCriticalResist
end

function BattleObject:addExtraAttack(extraAttack)
	self.extraAttack = self.extraAttack + extraAttack
end

function BattleObject:subExtraAttack(extraAttack)
	self.extraAttack = self.extraAttack - extraAttack
end

function BattleObject:addReleaseSkill(releaseSkill)
	self.releaseSkill = releaseSkill
end

function BattleObject:addBruiseDamagePercentValue(addBruiseDamagePercent)
	self.addBruiseDamagePercent = addBruiseDamagePercent
end

function BattleObject:subBruiseDamagePercent(addBruiseDamagePercent)
	self.addBruiseDamagePercent = addBruiseDamagePercent
end

function BattleObject:addTotalEffectDamage(totalEffectDamage)
	self.totalEffectDamage = self.totalEffectDamage + totalEffectDamage
end

function BattleObject:resetProperty(fightObject)
	local hp = self.healthPoint
	local sp = self.skillPoint
	self:initProperty(self.fightObject)

	self:setHealthPoint(hp)
	self:setSkillPoint(sp)
end

function BattleObject:initProperty(fightObject)
    --> __crint("设置基础属性")
	self.fightObject = fightObject
	self.battleTag = fightObject.battleTag
	self.coordinate = fightObject.coordinate
	self.id = fightObject.id
	self.userInfo = fightObject.userInfo
	self.picIndex = fightObject.picIndex
	self.campPreference = fightObject.campPreference
	self.gender = fightObject.gender
	self.quality = fightObject.quality
	self.leader = fightObject.leader
	self.strength = fightObject.strength
	self.wisdom = fightObject.wisdom
	self:setHealthPoint(fightObject.healthPoint)

    if fightObject.healthPoint_from_try then
        -- 新增一个变量专门为了处理试炼回血bug068，只有数码试炼走到这里
        self:setHealthPoint(fightObject.healthPoint_from_try)
    else
        self:setHealthPoint(fightObject.healthPoint)
    end
	self.healthMaxPoint = fightObject.healthPoint
	self:setSkillPoint(fightObject.skillPoint)
	self.attack = fightObject.attack
	self.physicalDefence = fightObject.physicalDefence
	self.skillDefence = fightObject.skillDefence
	self.critical = fightObject.critical
	self.critialMultiple = fightObject.critialMultiple
	self.criticalResist = fightObject.criticalResist
	self.evasion = fightObject.evasion
	self.accuracy = fightObject.accuracy
	self.retain = fightObject.retain
	self.retainBreak = fightObject.retainBreak
	self.physicalSubDamage = fightObject.physicalLessenDamage
	self.specialSubDatamage = fightObject.skillLessenDamage
	self.finalDamageAddition = fightObject.finalDamageAddition
	self.finalSubDamageAddition = fightObject.finalSubDamageAddition
	self.finalDamagePercent = fightObject.finalDamagePercent / 100
	self.finalLessenDamagePercent = fightObject.finalLessenDamagePercent / 100
	self.rewardCard = fightObject.rewardCard
	self.rewardRatio = fightObject.rewardRatio
	self.rewardProp = fightObject.rewardProp
	self.rewardPropRatio = fightObject.rewardPropRatio
	self.rewardEquipment = fightObject.rewardEquipment
	self.rewardEquipmentRatio = fightObject.rewardEquipmentRatio
	self.commonSkillMould = fightObject.commonSkill

    -- 对象的必杀技
	self.specialSkillMould = fightObject.specialSkill

	self.cureAdditional = fightObject.cureOdds
    -- self.curePercent = fightObject.curePercent
	self.byCurePercent = fightObject.byCureOdds
    self.talentMouldList = {}
    table.merge(self.talentMouldList, fightObject.talentMouldList)
	self.physicalAttackAdd = fightObject.physicalAttackAdd
	self.skillAttackAdd = fightObject.skillAttackAdd
	self.cureAdd = fightObject.cureAdd
	self.byCureAdd = fightObject.byCureAdd
	self.firingAdd = fightObject.firingAdd
	self.byFiringLes = fightObject.byFiringLes
	self.posionAdd = fightObject.posionAdd
	self.byPosionLes = fightObject.byPosionLes
	self.signType = fightObject.signType

    --/
    --生命加成百分比
    self.powerAdditionalPercent =  fightObject.powerAdditionalPercent

    -- --攻击加成百分比
    self.courageAdditionalPercent =  fightObject.courageAdditionalPercent

    -- --物理防御加成百分比
    self.intellectAdditionalPercent =  fightObject.intellectAdditionalPercent

    --法防加成百分比
    self.nimableAdditionalPercent =  fightObject.nimableAdditionalPercent

    --暴击加成百分比
    self.criticalAdditionalPercent =  fightObject.criticalAdditionalPercent

    --抗暴加成百分比
    self.criticalResistAdditionalPercent =  fightObject.criticalResistAdditionalPercent

    --闪避加成百分比
    self.evasionAdditionalPercent =  fightObject.evasionAdditionalPercent

    --命中加成百分比
    self.accuracyAdditionalPercent =  fightObject.accuracyAdditionalPercent

    --挡格加成百分比
    self.retainAdditionalPercent =  fightObject.retainAdditionalPercent

    --破击加成百分比
    self.retainBreakAdditionalPercent =  fightObject.retainBreakAdditionalPercent

    --物理免伤加成百分比
    self.physicalLessenDamagePercent =  fightObject.physicalLessenDamagePercent

    --法术免伤加成百分比
    self.skillLessenDamagePercent =  fightObject.skillLessenDamagePercent


	self.advance = fightObject.advance
	self.shipMould = fightObject.shipMould
    print("打印BattleObject的shipMould: " .. self.shipMould)
    print(debug.traceback())
    
	self.capacity = fightObject.capacity

    if nil ~= _ED.user_ship[self.id] then
        self.skillLevels = zstring.split(_ED.user_ship[self.id].skillLevel, ",")
    end

	self.attackSpeed = fightObject.attackSpeed
	-- 38.每次出手增加的怒气
	self.everyAttackAddSp = fightObject.everyAttackAddSp
	-- 39.灼烧伤害% 
	self.firingDamagePercent = fightObject.firingDamagePercent
	-- 40.吸血率%
	self.inhaleHpDamagePercent = fightObject.inhaleHpDamagePercent
    print("设置吸血率为3 " .. self.inhaleHpDamagePercent)
	-- 41.怒气
	self.addSpValue = fightObject.addSpValue
	-- 42.反弹%  
	self.reboundDamageValue = fightObject.reboundDamageValue
	-- 43.暴伤加成%	   
	self.uniqueSkillDamagePercent = fightObject.uniqueSkillDamagePercent / 100
	-- 44.免控率%  
	self.avoidControlPercent = fightObject.avoidControlPercent
	-- 45.小技能触发概率%  
	self.normatinSkillTriggerPercent = fightObject.normatinSkillTriggerPercent
	-- 46.格挡强度% 
	self.uniqueSkillResistancePercent = fightObject.uniqueSkillResistancePercent / 100
	-- 47.控制率%
	self.controlPercent = fightObject.controlPercent
	-- 48.治疗效果% 
	self.cureEffectPercent = fightObject.cureEffectPercent
	-- 49.暴击强化% 
	self.criticalAdditionPercent = fightObject.criticalAdditionPercent
    -- 50.数码兽类型克制伤害%   (可为负数)
    self.heroRestrainDamagePercent = fightObject.heroRestrainDamagePercent
    -- 51.溅射伤害%
    self.sputteringAttackAddDamagePercent = fightObject.sputteringAttackAddDamagePercent
    -- 52.技能伤害%
    self.skillAttackAddDamagePercent = fightObject.skillAttackAddDamagePercent
    -- 53.被治疗减少%
    self.byCureLessenPercent = fightObject.byCureLessenPercent
    -- 54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
    self.ptvf54 = fightObject.ptvf54
	-- -- 55.必杀伤害率%
	self.ptvf55 = fightObject.ptvf55
	-- -- 56.增加必杀伤害%
	self.ptvf56 = fightObject.ptvf56
	-- 57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
	self.ptvf57 = fightObject.ptvf57
	-- 58.增加暴击伤害%
	self.ptvf58 = fightObject.ptvf58
	-- 59.减少暴击伤害%
	self.ptvf59 = fightObject.ptvf59
	-- 60.受到的必杀伤害增加%
	self.ptvf60 = fightObject.ptvf60
	-- 61.怒气回复速度%
	self.ptvf61 = fightObject.ptvf61
	-- 62.受到伤害降低%
	self.ptvf62 = fightObject.ptvf62
	-- 63.降低攻击(%)	
	self.ptvf63 = fightObject.ptvf63
	-- 64.降低防御
	self.ptvf64 = fightObject.ptvf64
	-- 65降低必杀伤害率%	
	self.ptvf65 = fightObject.ptvf65
	-- 66降低必杀伤害率%
	self.ptvf66 = fightObject.ptvf66
	-- 67降低伤害减免%
	self.ptvf67 = fightObject.ptvf67
	-- 68降低防御（%）
	self.ptvf68 = fightObject.ptvf68
	-- 69降低怒气回复速度
	self.ptvf69 = fightObject.ptvf69
	-- -- 70数码兽类型克制伤害加成%	
	self.ptvf70 = fightObject.ptvf70
	-- -- 71数码兽类型克制伤害减免%	
	self.ptvf71 = fightObject.ptvf71
    -- 72.降低攻击
    self.ptvf72 = fightObject.ptvf72
    -- -- 73.增加必杀抗性%
    self.ptvf73 = fightObject.ptvf73
    -- 74.减少必杀抗性%
    self.ptvf74 = fightObject.ptvf74
    -- 75降低免控率%
    self.ptvf75 = fightObject.ptvf75
    -- 76复活概率%
    self.ptvf76 = fightObject.ptvf76
    -- 77被复活概率%
    self.ptvf77 = fightObject.ptvf77
    -- 78复活继承血量%    
    self.ptvf78 = fightObject.ptvf78
    -- 79复活继承怒气%    
    self.ptvf79 = fightObject.ptvf79
    -- 80被复活继承血量%   
    self.ptvf80 = fightObject.ptvf80
    -- 81被复活继承怒气%   
    self.ptvf81 = fightObject.ptvf81
    -- 82增加复活概率%   
    self.ptvf82 = fightObject.ptvf82
    -- 83增加复活继承血量% 
    self.ptvf83 = fightObject.ptvf83
    -- 84小技能伤害提升% 
    self.ptvf84 = fightObject.ptvf84


    -- 0   生命  
    -- 1   攻击  
    -- 2   防御  
    -- 8   暴击率 
    -- 9   抗暴率 
    -- 10  格挡率 
    -- 11  破格挡率    
    -- 16  治疗率 
    -- 17  被治疗率    
    -- 20  初始怒气    
    -- 33  伤害加成    
    -- 34  伤害减免    
    -- 38  每次出手增加的怒气   
    -- 40  吸血率 
    -- 42  反弹率 
    -- 43  暴伤加成    
    -- 44  免控率 
    -- 45  小技能触发概率 
    -- 46  格挡强度    
    -- 47  控制率 
    -- 55  必杀伤害率   
    -- 61  怒气回复速度  
    -- 70  数码兽类型克制伤害加成 
    -- 71  数码兽类型克制伤害减免 
    -- 73  增加必杀抗性  

    -- _rint("战斗初始属性：", 
    --     self.battleTag,
    --     self.coordinate,
    --     self.healthPoint,
    --     self.attack,
    --     self.physicalDefence,
    --     self.criticalAdditionalPercent,
    --     self.criticalResistAdditionalPercent,
    --     self.retainAdditionalPercent,
    --     self.retainBreakAdditionalPercent,
    --     self.curePercent,
    --     self.byCurePercent,
    --     self.initialSPIncrease,
    --     self.finalDamagePercent,
    --     self.finalLessenDamagePercent,
    --     self.everyAttackAddSp,
    --     self.inhaleHpDamagePercent,
    --     self.reboundDamageValue,
    --     self.uniqueSkillDamagePercent,
    --     self.avoidControlPercent,
    --     self.normatinSkillTriggerPercent,
    --     self.uniqueSkillResistancePercent,
    --     self.controlPercent,
    --     self.ptvf55,
    --     self.ptvf61,
    --     self.ptvf70,
    --     self.ptvf71,
    --     self.ptvf73

    --     )
end

function BattleObject:nextBattleInfo( ... )
    self.battleObjectList = nil
    
    self:resetSkillAndTalentInfo()

    self:nextBattleClearBuff()

    self:initSkillAndTalentInfo()

    -- 效用结果属性信息
    self.additionInfluenceJudgeResult = {}

    self._open_isNoDamage = nil
end

function BattleObject:nextBattleClearBuff(clearAll)
    --> __crint("清理buff:", self.battleTag, self.coordinate, clearAll)
    -- 清理buff
    for idx,  fightBuff in pairs(self.buffEffect)  do     
        local skillInfluence = fightBuff.skillInfluence
        --> __crint("波次Buff清除类型：", skillInfluence.buffRoundType)
        if skillInfluence.buffRoundType ~= 1 or true == clearAll then
            FightBuff.clearBuff(skillInfluence.skillCategory, self, skillInfluence)
            self.buffEffect[idx] = nil
        else
            -- if nil ~= skillInfluence.propertyValue then
            --     self:addPropertyValue(skillInfluence.propertyType, skillInfluence.propertyValue)
            -- end
        end
    end
end

-- 清理指定buff
function BattleObject:clearBuffBySkilCategory(skillCategory)
    for idx,  fightBuff in pairs(self.buffEffect)  do     
        local skillInfluence = fightBuff.skillInfluence
        if skillInfluence.skillCategory == skillCategory then
            FightBuff.clearBuff(skillInfluence.skillCategory, self, skillInfluence)
            self.buffEffect[idx] = nil
        end
    end
end

function BattleObject:clearBuffByTypeInhaleHp()
    for idx, fightBuff in pairs(self.buffEffect)  do     
        local skillInfluence = fightBuff.skillInfluence
        if nil ~= skillInfluence and nil ~= skillInfluence.propertyValue and skillInfluence.propertyType == EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT then
            self:addPropertyValue(skillInfluence.propertyType, -1 * skillInfluence.propertyValue)
            skillInfluence.propertyValue = nil
        end
    end
end

function BattleObject:resetSkillAndTalentInfo( ... )
    --天赋列表
    self.talentMouldList = {}
    --普通攻击效用
    self.commonBattleSkill = {}
    --自身怒气技能效用
    self.oneselfBattleSkill = {}
    --合体怒气技能效用
    self.zoariumBattleSkill = {}
    --反击技能效用
    self.counterBattleSkill = {}
    --天赋光环列表
    self.talentAuraList = {}
    --联动技能列表
    self.talentUniteSkillList = {}
    --天赋免疫列表
    self.talentImmunityList = {}
    --天赋结果列表
    self.talentJudgeResultList = {}
    --合击技能模板
    self.zoariumSkillMould =  {}
    --合体技攻击列表
    self.fitBattleObjects = {}
    --相克类型
    self.restrainMoulds =  {}
    
    self.normalBattleSkill = {}

    self.soulTypes = {} -- 半魂类型列表
    
end

function BattleObject:initSkillAndTalentInfo( ... )
    local fightObject = self.fightObject
    -- 斗魂相关
    if zstring.tonumber(self.shipMould) > 0 then
        local faction_id = zstring.split(dms.string(dms["ship_mould"], self.shipMould, ship_mould.faction_id), ",")
        for i, id in pairs(faction_id) do
            local soulType = dms.int(dms["ship_soul_mould"], id, ship_soul_mould.soul_type)
            table.insert(self.soulTypes, soulType)
        end
    end
    -- -- 技能相关
    -- self.talentInfos = fightObject.talentInfos
    -- if nil ~= self.talentInfos then
    --     for i, v in pairs(self.talentInfos) do
    --         for p = 3, #v do
    --             local element = dms.element(dms["talent_mould"], v[p])
    --             local talentMould = TalentMould:new()
    --             talentMould:init(element)
    --             table.insert(self.talentMouldList, talentMould)
    --         end
    --     end
    -- end
    self.talentMouldList = {}
    table.merge(self.talentMouldList, fightObject.talentMouldList)

    if fightObject.zoarium ~= nil then
        self.zoarium = fightObject.zoarium
    else
        self.zoarium = 0
    end
    self.zoariumSeat = fightObject.zoariumCoordinate
    self.counterSkillMould = ConfigDB.load("skill_mould", 1)
    self.restrainMoulds = fightObject.restrainMoulds
    self.zomlllSkillPoint = fightObject.zoariumSkillPoint

    if(self.zoarium > 0) then
        local skillMould = ConfigDB.load("skill_mould", fightObject.zoarium)
        self.zoariumSkillMould = skillMould
    end
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        -- 小技能
        self.normalSkillMould = ConfigDB.load("skill_mould", fightObject.normalSkillMould)
        self.normalSkillMouldRate = fightObject.normalSkillMouldRate
        self.normalSkillMouldRates = fightObject.normalSkillMouldRates
        self.normalSkillMouldRateIndex = 1
    end

    -- 取消天赋攻击
    -- for key, talentMould in pairs(self.talentMouldList) do
    --     talentMould.talentBattleSkill = {}
    --     if(talentMould.influenceImmunity ~= "-1") then
    --         local immunityArray = zstring.split(talentMould.influenceImmunity, "|")
    --         for i, val in pairs(immunityArray) do
    --             local talentImmunity = TalentImmunity:new()
    --             local immunityArrayParams = zstring.split(immunityArray[i], IniUtil.comma)
    --             local immunityType = tonumber(immunityArrayParams[1]) -- tonumber(zstring.split(immunityArray[i], IniUtil.comma)[1])
    --             if(immunityType == TalentConstant.IMMUNITY_TYPE_STATUS) then                    
    --                 talentImmunity.immunityStatus=tonumber(immunityArrayParams[2]) -- tonumber(immunityArray[i].split(IniUtil.comma)[2])
    --             end
    --             if(immunityType == TalentConstant.IMMUNITY_TYPE_TALENT) then
    --                 talentImmunity.immunityTalent=tonumber(immunityArrayParams[2]) -- tonumber(immunityArray[i].split(IniUtil.comma)[2])
    --             end
    --             self:pushTalentImmunityList(talentImmunity)
    --         end
    --     end
    --     local judgeResultArray = zstring.split(talentMould.influenceJudgeResult, IniUtil.comma)
    --     -- if(judgeResultArray.length > 1) then
    --     if(table.nums(judgeResultArray) > 1) then
    --         local resultValue = tonumber(judgeResultArray[2])
    --         if(tonumber(judgeResultArray[1]) == 7) then
    --             local _skillMould = ConfigDB.load("skill_mould", resultValue)
    --             if(talentMould.influenceJudgeType2 == TalentConstant.JUDGE_TYPE2_SELF_RETAIN and
    --                 talentMould.influenceJudgeOpportunity == TalentConstant.JUDGE_OPPORTUNITY_BY_ATTACK) then
    --                 self.counterSkillMould = _skillMould
    --             else
    --                 local skillArray = zstring.split(_skillMould.healthAffect, "|")
    --                 for i, val in pairs(skillArray) do
    --                     local skillInfluence = ConfigDB.load("skill_influence", skillArray[i])
    --                     local battleSkill = BattleSkill:new()
    --                     battleSkill.attackerTag = self.battleTag
    --                     battleSkill.attacterCoordinate = self.coordinate
    --                     battleSkill.skillMould = _skillMould
    --                     battleSkill.skillInfluence = skillInfluence
    --                     if(self.battleTag == 0) then
    --                         if (skillInfluence.influenceGroup == 0) then
    --                             battleSkill.byAttackerTag = 0
    --                         else
    --                             battleSkill.byAttackerTag = 1
    --                         end                         
    --                     else
    --                         if (skillInfluence.influenceGroup == 0) then
    --                             battleSkill.byAttackerTag = 1
    --                         else
    --                             battleSkill.byAttackerTag = 0
    --                         end 
    --                     end
    --                     battleSkill.effectType = skillInfluence.skillCategory
    --                     battleSkill.effectRound = skillInfluence.influenceDuration
    --                     battleSkill.formulaInfo = skillInfluence.formulaInfo
    --                     table.insert(talentMould.talentBattleSkill, battleSkill)
    --                 end                 
    --             end
    --         end
    --     end
    -- end
    
    ----_crint ("self.counterSkillMould: " .. self.counterSkillMould)
    --os.exit()
    -- if (fightObject.commonSkill.healthAffect == nil) then
        -- --_crint ("" .. fightObject.commonSkill.id)
    -- end
    local commonSkillArray = {}
    if nil ~= fightObject.commonSkill then
        commonSkillArray = zstring.split(string.gsub(fightObject.commonSkill.healthAffect, "|", IniUtil.comma), IniUtil.comma)
    end
    local specialSkillArray = {}
    if nil ~= fightObject.specialSkill then
        specialSkillArray = zstring.split(string.gsub(fightObject.specialSkill.healthAffect, "|", IniUtil.comma), IniUtil.comma)
    end
    local counterSkillArray = {}
    if nil ~= self.counterSkillMould then
        counterSkillArray = zstring.split(string.gsub(self.counterSkillMould.healthAffect, "|", IniUtil.comma), IniUtil.comma)
    end
    local normalSkillArray = {}
    if nil ~= self.normalSkillMould then
        normalSkillArray = zstring.split(string.gsub(self.normalSkillMould.healthAffect, "|", IniUtil.comma), IniUtil.comma)
    end
    --for (int i = 0; i < commonSkillArray.length; i++) do
    ----_crint ("commonSkillArray size: " .. commonSkillArray[1])

    -- for i = 1, #commonSkillArray do
    for i, v in pairs(commonSkillArray) do
        local skillInfluence = ConfigDB.load("skill_influence", commonSkillArray[i])
        local battleSkill = BattleSkill:new()
        battleSkill.attackerTag = self.battleTag
        battleSkill.attacterCoordinate = self.coordinate
        battleSkill.skillMould = fightObject.commonSkill
        battleSkill.skillInfluence = skillInfluence
        if(self.battleTag == 0) then
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 0
            else
                battleSkill.byAttackerTag = 1
            end             
        else
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 1
            else
                battleSkill.byAttackerTag = 0
            end 
        end
        battleSkill.effectType = skillInfluence.skillCategory
        battleSkill.effectRound = skillInfluence.influenceDuration
        table.insert(self.commonBattleSkill, battleSkill)
    end
    --for (int i = 0; i < specialSkillArray.length; i++) {
    -- for i = 1, #specialSkillArray do
    for i, v in pairs(specialSkillArray) do
        local skillInfluence = ConfigDB.load("skill_influence", specialSkillArray[i])
        local battleSkill = BattleSkill:new()
        battleSkill.attackerTag = self.battleTag
        battleSkill.attacterCoordinate = self.coordinate
        battleSkill.skillMould = fightObject.specialSkill
        battleSkill.skillInfluence = skillInfluence
        if nil ~= self.skillLevels then
            skillInfluence.level = tonumber(self.skillLevels[2])
        end
        if(self.battleTag == 0) then                
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 0
            else
                battleSkill.byAttackerTag = 1
            end
        else
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 1
            else
                battleSkill.byAttackerTag = 0
            end 
        end
        battleSkill.effectType = skillInfluence.skillCategory
        battleSkill.effectRound = skillInfluence.influenceDuration
        table.insert(self.oneselfBattleSkill, battleSkill)
    end
    --for (int i = 0; i < counterSkillArray.length; i++) {
    -- for i = 1, #counterSkillArray do
    for i, v in pairs(counterSkillArray) do
        local skillInfluence = ConfigDB.load("skill_influence", counterSkillArray[i])
        local battleSkill = BattleSkill:new()
        battleSkill.attackerTag = self.battleTag
        battleSkill.attacterCoordinate = self.coordinate
        battleSkill.skillMould = self.counterSkillMould
        battleSkill.skillInfluence = skillInfluence
        if(self.battleTag == 0)then
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 0
            else
                battleSkill.byAttackerTag = 1
            end
        else
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 1
            else
                battleSkill.byAttackerTag = 0
            end
        end
        battleSkill.effectType=skillInfluence.skillCategory
        battleSkill.effectRound=skillInfluence.influenceDuration
        table.insert(self.counterBattleSkill, battleSkill)
    end 

    for i, v in pairs(normalSkillArray) do
        local skillInfluence = ConfigDB.load("skill_influence", normalSkillArray[i])
        local battleSkill = BattleSkill:new()
        battleSkill.attackerTag = self.battleTag
        battleSkill.attacterCoordinate = self.coordinate
        battleSkill.skillMould = self.normalSkillMould
        battleSkill.skillInfluence = skillInfluence
        if nil ~= self.skillLevels then
            skillInfluence.level = tonumber(self.skillLevels[1])
        end
        if(self.battleTag == 0)then
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 0
            else
                battleSkill.byAttackerTag = 1
            end
        else
            if (skillInfluence.influenceGroup == 0) then
                battleSkill.byAttackerTag = 1
            else
                battleSkill.byAttackerTag = 0
            end
        end
        battleSkill.effectType=skillInfluence.skillCategory
        battleSkill.effectRound=skillInfluence.influenceDuration
        table.insert(self.normalBattleSkill, battleSkill)
    end 

    -- local forceArray = fightObject.forceArray
    -- for k,fceObj in pairs(forceArray) do
    --  local forceObject = BattleObject:new()
    --  forceObject:initWithAttackObject(forceArray[k])
    --  -- debug.print_r(forceObject)
    --  table.insert(self.forceObjects,forceObject)
    -- end
end

function BattleObject:initWithAttackObject(fightObject)
    self:resetSkillAndTalentInfo()

	self:initProperty(fightObject)

    self:initSkillAndTalentInfo()
end


function BattleObject:checkBattleObject(attackObjects)
	if(self.zoariumSkillMould ~= nil and self.zoariumSkillMould.id ~= nil) then
		local zomariumShipMoulds = zstring.split(self.zoariumSkillMould.releaseMould, ",")
		--检查是否能够是否合体技
		local release = self:checkCanRelease(attackObjects, zomariumShipMoulds)
		if(false == release)then
			return
		end
		if(self.zoariumSkillMould.releasSkill == nil or  
			self.zoariumSkillMould.releasSkill == "" or  
			self.zoariumSkillMould.releasSkill == "-1")then
			return
		end
		
		local seriatim = self.zoariumSkillMould.seriatim == 0  --是否逐一释放
		
		local skill = zstring.split(self.zoariumSkillMould.releasSkill, "|")  --合体技能效用1,2|3,4|5,6
		
		--for (int i = 0; i < zomariumShipMoulds.length; i++) {
		-- for i = 1, table.maxn(zomariumShipMoulds) do
		local maxI = 0
		for i, v in pairs(zomariumShipMoulds) do
			local tempBattleObject = self:findByShipMould(attackObjects, tonumber(zomariumShipMoulds[i]))
			tempBattleObject.seriatim = seriatim
			tempBattleObject.releaseSKillMould = self.zoariumSkillMould
			if(#skill > maxI) then
				local skillInfushs = zstring.split(skill[i], ",")
				local zomaruimSkills = {}
				--for (int j = 0; j < skillInfushs.length; j++) {
				for j = 1, table.maxn(skillInfushs)  do
					if(skillInfushs[j] == "-1") then
						--continue;
					else
						local skillInfluence = ConfigDB.load("skill_influence", skillInfushs[j])
						local battleSkill = BattleSkill:new()
						battleSkill.attackerTag = self.battleTag
						battleSkill.attacterCoordinate  = self.coordinate
						battleSkill.skillMould = self.counterSkillMould
						battleSkill.skillInfluence = skillInfluence
						if(self.battleTag == 0) then
							if (skillInfluence.influenceGroup == 0) then
								battleSkill.byAttackerTag = 0
							else
								battleSkill.byAttackerTag = 1
							end
						else
							if (skillInfluence.influenceGroup == 0) then
								battleSkill.byAttackerTag = 1
							else
								battleSkill.byAttackerTag = 0
							end							
						end
						battleSkill.effectType = skillInfluence.skillCategory
						battleSkill.effectRound = skillInfluence.influenceDuration
						table.insert(zomaruimSkills, battleSkill)
					end
				end
				tempBattleObject.releaseSkill = zomaruimSkills
				table.insert(self.fitBattleObjects, tempBattleObject)
			end
			maxI = maxI + 1
		end
	end
end

function BattleObject:checkCanRelease(attackObjects, zomariumShipMoulds)
	local release = false
	local currentRelease = false
	local shipMould = ConfigDB.load("ship_mould", self.shipMould)
	--for (int i = 0; i < zomariumShipMoulds.length; i++) {
	-- for i = 1, #zomariumShipMoulds do
	for i, v in pairs(zomariumShipMoulds) do
		local smou = tonumber(zomariumShipMoulds[i])
		if(shipMould.primeMover == smou) then
			currentRelease = true
			break
		end
	end
	local needCount = 0
	if (currentRelease) then
		--for (int i = 0; i < zomariumShipMoulds.length; i++) {
		-- for i = 1, #zomariumShipMoulds do
		for i, v in pairs(zomariumShipMoulds) do
			local smou = tonumber(zomariumShipMoulds[i])
			--for (int j = 0; j < attackObjects.length; j++) {
			-- for j= 1, #attackObjects do
			for j, v in pairs(attackObjects) do
				local battleObject = attackObjects[j]
				if(battleObject == nil or battleObject.isDead) then
					--continue
				else
					if(battleObject.shipMould == smou) then
						needCount = needCount + 1
						break
					end
				end
			end
		end
	end
	if(needCount == #zomariumShipMoulds) then
		release = true
	end
	return release
end

function BattleObject:checkState(attackObjects)
	--> __crint("合体人员：",self.isDead,self.skillPoint,self.zoariumSkillMould,self.zoariumSkillMould.skillQuality,self.zoariumSkillMould.releaseMould)
	if(self.isDead) then
		return false
	end
	if(self.zomlllSkillPoint < 4) then
		return false
	end
	if(self.zoariumSkillMould == nil) then
		return false
	end
	if(self.zoariumSkillMould.skillQuality ~= 2) then
		return false
	end
	if(self.zoariumSkillMould == nil 
			or self.zoariumSkillMould.releaseMould == nil 
			or self.zoariumSkillMould.releaseMould== "-1"
			or self.zoariumSkillMould.releaseMould == "")then
		return false
	end
	local zomariumShipMoulds = zstring.split(self.zoariumSkillMould.releaseMould, ",")
	--> __crint("合体人员：",zomariumShipMoulds)
	return self:checkCanRelease(attackObjects, zomariumShipMoulds)
end

function BattleObject:findByShipMould(attackObjects, shipMould)
	for _, attackObject in pairs(attackObjects) do
			if (attackObject ~= nil) then
				if(tonumber(attackObject.shipMould) == tonumber(shipMould)) then
					return attackObject
				end
			end
	end
	return nil
end

function BattleObject:subExplodeCount(explodeCount)
	self.explodeCount = self.explodeCount - explodeCount
end

function BattleObject:pushTalentJudgeResultList(talentJudgeResult)
	table.insert(self.talentJudgeResultList, talentJudgeResult)
end

function BattleObject:clearTalentJudgeResultList()
	self.talentJudgeResultList = {}
end

function BattleObject:getTalentJudgeResultByResultType(resultType)
	local talentJudgeResultList = {}
	--for (TalentJudgeResult talentJudgeResult : self.talentJudgeResultList) {
	for _, talentJudgeResult in pairs(self.talentJudgeResultList) do
		if(resultType == talentJudgeResult.resultType) then
			table.insert(talentJudgeResultList, talentJudgeResult)
		end
	end
	return talentJudgeResultList
end

function BattleObject:pushTalentImmunityList(talentImmunity)
	--for (Iterator<TalentImmunity> iter = self.talentImmunityList.iterator(); iter.hasNext();) {
	--for _, _talentImmunity in pairs(self.talentImmunityList) do
	-- for i = 1, #self.talentImmunityList do
	for i, v in pairs(self.talentImmunityList) do
		--TalentImmunity _talentImmunity = iter.next()
		local _talentImmunity = self.talentImmunityList[i]
		if(_talentImmunity.immunityStatus == talentImmunity.immunityStatus and _talentImmunity.immunityTalent == talentImmunity.immunityTalent) then
			--iter.remove()
			--return
			self.talentImmunityList[i] = nil
		end
	end
	local tmpImmunityList = self.talentImmunityList
	self.talentImmunityList = {}
	for _, tmpImmunity in pairs(tmpImmunityList) do
		if (tmpImmunity ~= nil) then
			table.insert(self.talentImmunityList, tmpImmunity)
		end
	end
	tmpImmunityList = nil
	table.insert(self.talentImmunityList, talentImmunity)
end

function BattleObject:pushTalentAuraList(talentAura)
	table.insert(self.talentAuraList, talentAura)
end

function BattleObject:setEvasionSurely(isEvasionSurely)
	self.isEvasionSurely = isEvasionSurely
end

function BattleObject:isCanReAttack()
	return self.canReAttack
end

function BattleObject:isDead()
	return self.isDead
end

function BattleObject:setDead(isDead)
	self.isDead = isDead
    --> __crint("角色死亡：", self.battleTag, self.coordinate)
end

function BattleObject:setHealthPoint(healthPoint)
    if nil ~= self.historyHealthPoint then
        local history_info = aeslua.decrypt("jar-world", self.historyHealthPoint, aeslua.AES128, aeslua.ECBMODE)
        --> __crint("hp:", history_info, "" .. self.healthPoint)
        if history_info ~= "" .. self.healthPoint then
            if fwin:find("ReconnectViewClass") == nil then
                _ED._fightModule._error = true
                fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
            end
        end
    end

    print("设置BattleObject血量1: " .. healthPoint)

    self.healthPoint = healthPoint
    self.historyHealthPoint = aeslua.encrypt("jar-world", self.healthPoint, aeslua.AES128, aeslua.ECBMODE)
end

function BattleObject:addHealthPoint(healthPoint)
    if nil ~= self.historyHealthPoint then
        local history_info = aeslua.decrypt("jar-world", self.historyHealthPoint, aeslua.AES128, aeslua.ECBMODE)
        --> __crint("hp:", history_info, "" .. self.healthPoint)
        if history_info ~= "" .. self.healthPoint then
            if fwin:find("ReconnectViewClass") == nil then
                _ED._fightModule._error = true
                fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
            end
        end
    end

    print("增加血量BattleObject:addHealthPoint： " .. healthPoint)
    -- print(debug.traceback())

	self.healthPoint = self.healthPoint + healthPoint
    if self.healthPoint > self.healthMaxPoint then
        self.healthPoint = self.healthMaxPoint
    end

    print("设置BattleObject血量3: " .. healthPoint)

    self.historyHealthPoint = aeslua.encrypt("jar-world", self.healthPoint, aeslua.AES128, aeslua.ECBMODE)
end

function BattleObject:addHealthMaxPoint(healthMaxPoint)
	--_crint ("Calling BattleObject:addHealthMaxPoint(healthMaxPoint)")
	self.healthMaxPoint = self.healthMaxPoint + healthMaxPoint
    print("最大血量2: " .. self.healthMaxPoint)
end

function BattleObject:subHealthPoint(healthPoint)
    if nil ~= self.historyHealthPoint then
        local history_info = aeslua.decrypt("jar-world", self.historyHealthPoint, aeslua.AES128, aeslua.ECBMODE)
        --> __crint("hp:", history_info, "" .. self.healthPoint)
        if history_info ~= "" .. self.healthPoint then
            if fwin:find("ReconnectViewClass") == nil then
                _ED._fightModule._error = true
                fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
            end
        end
    end

    print("减少血量BattleObject:subHealthPoint " .. healthPoint)

	self.healthPoint = self.healthPoint - healthPoint
    self.historyHealthPoint = aeslua.encrypt("jar-world", self.healthPoint, aeslua.AES128, aeslua.ECBMODE)
end

function BattleObject:setSkillPoint(skillPoint)
    if nil ~= self.historySkillPoint then
        local history_info = aeslua.decrypt("jar-world", self.historySkillPoint, aeslua.AES128, aeslua.ECBMODE)
        --> __crint("sp:", history_info, "" .. self.skillPoint)
        if history_info ~= "" .. self.skillPoint then
            if fwin:find("ReconnectViewClass") == nil then
                _ED._fightModule._error = true
                fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
            end
        end
    end

    self.skillPoint = tonumber(skillPoint)
    self.historySkillPoint = aeslua.encrypt("jar-world", self.skillPoint, aeslua.AES128, aeslua.ECBMODE)
end

function BattleObject:addSkillPoint(skillPoint, needCallFormula)
    -- 回复怒气 * （1  + 提高怒气回复速度[61] - 降低怒气回复速度[69] ）
    print("BattleObject:addSkillPoint1: " .. skillPoint)
    if true == needCallFormula then
        skillPoint = skillPoint * (math.max(0, (1 + self.ptvf61 - self.ptvf69)))
    end
    print("BattleObject:addSkillPoint2: " .. skillPoint, self.skillPoint)

    if nil ~= self.historySkillPoint then
        local history_info = aeslua.decrypt("jar-world", self.historySkillPoint, aeslua.AES128, aeslua.ECBMODE)
        --> __crint("sp:", history_info, "" .. self.skillPoint)
        if history_info ~= "" .. self.skillPoint then
            if fwin:find("ReconnectViewClass") == nil then
                _ED._fightModule._error = true
                fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
            end
        end
    end

	self.skillPoint = tonumber(self.skillPoint) + tonumber(skillPoint)
    print("BattleObject:addSkillPoint3: " .. self.skillPoint)

	if self.skillPoint > FightModule.MAX_SP then
		self.skillPoint = FightModule.MAX_SP
    end
    if self.skillPoint < 0 then
		self.skillPoint = 0
	end
    self.historySkillPoint = aeslua.encrypt("jar-world", self.skillPoint, aeslua.AES128, aeslua.ECBMODE)
    return skillPoint
end

function BattleObject:addZomSkillPoint(skillPoint)
	self.zomlllSkillPoint = tonumber(self.zomlllSkillPoint) + tonumber(skillPoint)
end

function BattleObject:subSkillPoint(skillPoint)
    if nil ~= self.historySkillPoint then
        local history_info = aeslua.decrypt("jar-world", self.historySkillPoint, aeslua.AES128, aeslua.ECBMODE)
        --> __crint("sp:", history_info, "" .. self.skillPoint)
        if history_info ~= "" .. self.skillPoint then
            if fwin:find("ReconnectViewClass") == nil then
                _ED._fightModule._error = true
                fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
            end
        end
    end
    
	self.skillPoint = tonumber(self.skillPoint) - tonumber(skillPoint)
	if self.skillPoint < 0 then
		self.skillPoint = 0
	end
    self.historySkillPoint = aeslua.encrypt("jar-world", self.skillPoint, aeslua.AES128, aeslua.ECBMODE)
end

function BattleObject:subZomSkillPoint(skillPoint)
	self.zomlllSkillPoint = 0--tonumber(self.zomlllSkillPoint) - tonumber(skillPoint)
end

function BattleObject:addFinalDamageAddition(finalDamageAddition)
	self.finalDamageAddition = self.finalDamageAddition + finalDamageAddition
end

function BattleObject:subFinalDamageAddition(finalDamageAddition)
	self.finalDamageAddition = finalDamageAddition
end

function BattleObject:pushBuffEffect(fightBuff)
    --[[输出攻击过程信息
    if nil ~= fightBuff.skillInfluence then
        ___writeDebugInfo("\t\t新增BUFF类型：" .. __fight_debug_skill_influence_type_info["" .. fightBuff.skillInfluence.skillCategory .. ""] .. "\t" .. "剩余回合数：" .. fightBuff.effectRound .. "\r\n")
    end
    --]]
    fightBuff.currentRoundCount = _ED._fightModule.roundCount
	table.insert(self.buffEffect, fightBuff)
end

function BattleObject:getBuffEffect(skillCategory)
    for i, v in pairs(self.buffEffect) do
        if v.skillInfluence.skillCategory == skillCategory then -- 是否可叠加：0不叠加   1叠加
            return v
        end
    end
    return nil
end

function BattleObject:removeBuffEffect(skillCategory)
    for i, v in pairs(self.buffEffect) do
        if v.skillInfluence.skillCategory == skillCategory then -- 是否可叠加：0不叠加   1叠加
            FightBuff.clearBuff(v.skillInfluence.skillCategory, self, v.skillInfluence)
            self.buffEffect[i] = nil
        end
    end
    return nil
end

function BattleObject:addSubCritialMultiple(subCritialMultiple)
	self.subCritialMultiple = self.subCritialMultiple -subCritialMultiple
end

function BattleObject:addEvasionValue(addEvasion)
	self.addEvasion = self.addEvasion + addEvasion
end

function BattleObject:restoreAttackState()
	self.isCritical = false
	self.isEvasion = false
	self.isRetain = false
	self.critialMultiple = 1
end

function BattleObject:restoreBuffState()
	self.addAttackPercent = 0; -- 增加攻击加成比率
	self.decAttackPercent = 0;	-- 降低攻击加成比率
	
	self.addEvasion = 0; -- 闪避
	self.addAccuracy = 0; -- 命中
	
	self.addCritialMultiple = 0; -- 暴击
	self.addCriticalResist = 0; -- 抗暴
	
	self.addBruiseDamagePercent = 0;	-- 受到伤害加成比率
	self.decBruiseDamagePercent = 0; -- 受到伤害削弱比率
	
	self.addPhysicalDefPercent = 0;	-- 增加物防比率
	self.decPhysicalDefPercent = 0;	-- 削弱物防比率
	
	self.addSkillDefPercent = 0;	-- 增加技能防御比率
	self.decSkillDefPercent = 0;	-- 削弱技能防御比率
	
	self.addFinalDamagePercent = 0; --增加自身伤害
end

function BattleObject:processUserBuffEffect(userInfo, fightModule, resultBuffer)
    --[[输出攻击过程信息
    ___writeDebugInfo("\t处理攻击者的BUFF" .. "\r\n")
    --]]
	if(#self.buffEffect == 0 or self.isDead or true == self._lockBuff) then
        print("BattleObject:processUserBuffEffect 1")
		table.insert(resultBuffer, 0)
		table.insert(resultBuffer, IniUtil.compart)
	else
        print("BattleObject:processUserBuffEffect 2")
		local buffBuffer = {}
		local buffCount = 0
		local deadState = 0
		for idx,  fightBuff in pairs(self.buffEffect)  do	
            if fightBuff.skillInfluence.skillCategory ~= BattleSkill.SKILL_INFLUENCE_FIRING then			
    			fightBuff:process(self, buffBuffer)
    			if(fightBuff.countBuff > 0) then
    				buffCount = buffCount + 1
    			end
    			if(deadState == 0) then
    				deadState = fightBuff.deadState
    			end

                --[[输出攻击过程信息
                ___writeDebugInfo("\t\tBUFF类型：" .. __fight_debug_skill_influence_type_info["" .. fightBuff.skillInfluence.skillCategory .. ""] .. "\t" .. "剩余回合数：" .. fightBuff.effectRound .. "\r\n")
                --]]

                --> __crint("buff信息：", fightBuff.effectRound, fightBuff.skillInfluence.propertyType, fightBuff.skillInfluence.propertyValue)
    			if(fightBuff.effectRound <= 0) then
                    -- 12  无敌
                    -- 21  增加攻击
                    -- 22  降低攻击
                    -- 27  增加暴击
                    -- 33
                    -- 36  降低治疗效果(对应公式63）
                    -- 43  增加破格挡率
                    -- 48  降低暴击伤害
                    -- 51  降低伤害加成
                    -- 52  增加伤害加成
                    -- 58  增加暴击伤害
                    -- 60  增加暴击强度
                    -- 61
                    -- 64  增加数码兽类型克制伤害加成
                    -- 66  降低暴击率
                    local skillCategory = fightBuff.skillInfluence.skillCategory
                    if skillCategory == 12
                        or skillCategory == 21
                        or skillCategory == 22
                        or skillCategory == 23
                        or skillCategory == 27
                        or skillCategory == 36
                        or skillCategory == 43
                        or skillCategory == 45
                        or skillCategory == 48
                        or skillCategory == 51
                        or skillCategory == 52
                        or skillCategory == 52
                        or skillCategory == 57
                        or skillCategory == 58
                        or skillCategory == 60
                        or skillCategory == 63
                        or skillCategory == 64
                        or skillCategory == 66
                        then
                        -- 修复2回合的技能只生效一回合的bug
                        FightBuff.clearBuff(fightBuff.skillInfluence.skillCategory, self, fightBuff.skillInfluence)
                        self.buffEffect[idx] = nil
                        --continue
                    end
    			else
    				if(deadState > 0) then
    					fightBuff:restoreEffect(self)
    					self.buffEffect[idx] = nil
    					break
    				end
    			end
            end
		end

		if(#buffBuffer > 0) then
            print("BattleObject:processUserBuffEffect 3")
			table.insert(resultBuffer, buffCount)
			IniUtil.concatTable(resultBuffer, buffBuffer)
			table.insert(resultBuffer,IniUtil.compart)
			table.insert(resultBuffer,deadState)
			table.insert(resultBuffer,IniUtil.compart)
		else
            print("BattleObject:processUserBuffEffect 4")
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
		end

		if(self.isDead) then
            print("BattleObject:processUserBuffEffect 5")
			if(self.battleTag == 0) then
				if(nil ~= fightModule.attackObjects[self.coordinate]) then				
					fightModule.attackCount = fightModule.attackCount - 1
					fightModule.attackObjects[self.coordinate] = nil
				end
			else
				if(nil ~= fightModule.byAttackObjects[self.coordinate]) then
					----_crint ("处理BUFF 死亡	byAttackCount--")
					fightModule.byAttackCount = fightModule.byAttackCount - 1
					fightModule.byAttackObjects[self.coordinate] = nil
				end
			end
			TalentSkill.processSelfDead(userInfo, fightModule, nil, self)
			local rewardType = 0
			local rewardCount = 0

			-- //计算卡片掉落
			-- if(self.rewardRatio ~= nil and self.rewardRatio > 0) then
			-- 	if(math.random(1, 100) <= self.rewardCard) then
			-- 		local rewardCard =  fightModule.rewardCard[self.rewardCard]
			-- 		if(rewardCard ~= nil) then
			-- 			fightModule.rewardCard[self.rewardCard] = {self.rewardCard,rewardCard + 1}
			-- 		else
			-- 			fightModule.rewardCard[self.rewardCard] = {self.rewardCard,1}
			-- 		end
			-- 		rewardCount = 1;
			-- 		rewardType = 1;
			-- 	end
			-- end
			-- 	-- //计算道具掉落
			-- if(self.rewardPropRatio ~= nil and self.rewardPropRatio > 0) then
			-- 	if(math.random(1, 100) <= self.rewardPropRatio) then
			-- 		local rewardProp =  fightModule.rewardProp[self.rewardProp]
			-- 		if(rewardProp ~= nil) then
			-- 			fightModule.rewardProp[self.rewardProp] = {self.rewardProp,rewardProp + 1}
			-- 		else
			-- 			fightModule.rewardProp[self.rewardProp] = {self.rewardProp,1}
			-- 		end
			-- 		rewardCount = 1;
			-- 		rewardType = 1;
			-- 	end
			-- end
			-- -- //计算装备掉落
			-- if(self.rewardEquipmentRatio ~= nil and self.rewardEquipmentRatio > 0) then
			-- 	if(math.random(1, 100) <= self.rewardEquipment) then
			-- 		local rewardEquipment =  fightModule.rewardEquipment[self.rewardEquipment]
			-- 		if(rewardEquipment ~= nil) then
			-- 			fightModule.rewardEquipment[self.rewardEquipment] = {self.rewardEquipment,rewardEquipment + 1}
			-- 		else
			-- 			fightModule.rewardEquipment[self.rewardEquipment] = {self.rewardEquipment,1}
			-- 		end
			-- 		rewardCount = 1;
			-- 		rewardType = 1;
			-- 	end
			-- end

			table.insert(resultBuffer,0)
			table.insert(resultBuffer,IniUtil.compart)
			table.insert(resultBuffer,0)
			table.insert(resultBuffer,IniUtil.compart)
		end
	end
end


function BattleObject:resetBuff(fightModule, resultBuffer)
    --> __crint("回合结束，设置BUFF属性失效：", self.battleTag, self.coordinate)
    
    --[[输出攻击过程信息
    ___writeDebugInfo("\t回合结束，设置BUFF属性失效处理" .. "\r\n")
    --]]

    for idx, fightBuff in pairs(self.buffEffect) do
        --> __crint("回合数：", fightBuff.effectRound, fightBuff.skillInfluence.skillCategory, fightBuff.skillInfluence.propertyType, fightBuff.skillInfluence.propertyValue)
        if fightBuff.skillInfluence.skillCategory ~= BattleSkill.SKILL_INFLUENCE_FIRING then
            if(fightBuff.effectRound <= 0) then
                fightBuff.effectRound = -1
                -- if nil ~= fightBuff.skillInfluence and nil ~= fightBuff.skillInfluence.propertyValue then
                --     self:addPropertyValue(fightBuff.skillInfluence.propertyType, -1 * fightBuff.skillInfluence.propertyValue)
                --     fightBuff.skillInfluence.propertyValue = nil
                -- end

                --[[输出攻击过程信息
                ___writeDebugInfo("\t\t失效BUFF类型：" .. __fight_debug_skill_influence_type_info["" .. fightBuff.skillInfluence.skillCategory .. ""] .. "\t" .. "\r\n")
                --]]

                FightBuff.clearBuff(fightBuff.skillInfluence.skillCategory, self, fightBuff.skillInfluence)
                self.buffEffect[idx] = nil
                fightBuff.skillInfluence.propertyValue = nil
            end
        end
    end
end

function BattleObject:processBuffEffect(fightModule, resultBuffer)
	if(#self.buffEffect == 0 or self.isDead or true == self._lockBuff) then
		table.insert(resultBuffer, 0)
		table.insert(resultBuffer, IniUtil.compart)
	else
		local buffBuffer = {}
		local buffCount = 0
		local deadState = 0
		for idx, fightBuff in pairs(self.buffEffect) do
            if fightBuff.skillInfluence.skillCategory ~= BattleSkill.SKILL_INFLUENCE_FIRING then
    			fightBuff:process(self, buffBuffer)
    			if(fightBuff.effectValue > 0) then
    				buffCount = buffCount + 1
    			end
    			if(deadState == 0) then
    				deadState = fightBuff.deadState
    			end
                --> __crint("buff信息：", fightBuff.effectRound, fightBuff.skillInfluence.propertyType, fightBuff.skillInfluence.propertyValue)
    			if(fightBuff.effectRound <= 0) then
                    -- 12  无敌
                    -- 21  增加攻击
                    -- 22  降低攻击
                    -- 27  增加暴击
                    -- 33
                    -- 36  降低治疗效果(对应公式63）
                    -- 43  增加破格挡率
                    -- 48  降低暴击伤害
                    -- 51  降低伤害加成
                    -- 52  增加伤害加成
                    -- 58  增加暴击伤害
                    -- 60  增加暴击强度
                    -- 61
                    -- 64  增加数码兽类型克制伤害加成
                    -- 66  降低暴击率
                    local skillCategory = fightBuff.skillInfluence.skillCategory
                    if skillCategory == 12
                        or skillCategory == 21
                        or skillCategory == 22
                        or skillCategory == 23
                        or skillCategory == 27
                        or skillCategory == 36
                        or skillCategory == 43
                        or skillCategory == 45
                        or skillCategory == 48
                        or skillCategory == 51
                        or skillCategory == 52
                        or skillCategory == 52
                        or skillCategory == 57
                        or skillCategory == 58
                        or skillCategory == 60
                        or skillCategory == 63
                        or skillCategory == 64
                        or skillCategory == 66
                        then
        				-- 修复2回合的技能只生效一回合的bug
        				FightBuff.clearBuff(fightBuff.skillInfluence.skillCategory, self, fightBuff.skillInfluence)
        				self.buffEffect[idx] = nil
        				--continue
                    end
    			else
    				if(deadState > 0) then
    					fightBuff:restoreEffect(self)
    					self.buffEffect[idx] = nil
    					break
    				end
    			end
            end
		end
		
		if(#buffBuffer > 0) then
			table.insert(resultBuffer, buffCount)
			IniUtil.concatTable(resultBuffer, buffBuffer)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, deadState)
			table.insert(resultBuffer, IniUtil.compart)
		else
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
		end
		if(self.isDead) then
			if(self.battleTag == 0) then
				if(nil ~= fightModule.attackObjects[self.coordinate]) then					
					fightModule.attackCount = fightModule.attackCount - 1
					fightModule.attackObjects[self.coordinate] = nil
				end
			else
				if(nil ~= fightModule.byAttackObjects[self.coordinate]) then
					----_crint ("处理BUFF 死亡	byAttackCount--")
					fightModule.byAttackCount = fightModule.byAttackCount - 1
					fightModule.byAttackObjects[self.coordinate] = nil
				end
			end
			local rewardCount = 0
			table.insert(resultBuffer, rewardCount)
			table.insert(resultBuffer, IniUtil.compart)
		end
	end
end

function BattleObject:pushTalentUniteSkillList(talentUniteSkill)
	table.insert(self.talentUniteSkillList, talentUniteSkill)
end

function BattleObject:addPropertyByTalentInfluencePriorValueResults(attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightModule)
	-- if nil ~= self.talentInfos then
	-- 	for i, v in pairs(self.talentInfos) do
	-- 		for p = 3, #v do
	-- 			local element = dms.element(dms["talent_mould"], v[p])
	-- 			local talentMould = TalentMould:new()
	-- 			talentMould:init(element)
	-- 			table.insert(self.talentMouldList, talentMould)
	-- 			self:addPropertyByTalentInfluencePriorValueResult(talentMould, attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightModule)
	-- 		end
	-- 	end
	-- end

	if nil ~= self.talentMouldList then
		for i, v in pairs(self.talentMouldList) do
			local talentMould = v
			self:addPropertyByTalentInfluencePriorValueResult(talentMould, attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightModule)
		end
	end
end

function BattleObject:addPropertyByTalentInfluencePriorValueResult(talentMould, attackerFormationObjects, defenderFormationObjects, camp, battleCache, fightModule)
	print("BattleObject 战斗回合前赋予效果：", talentMould.influencePriorType, talentMould.influencePriorValue)
	if talentMould.influencePriorType < 0 then
		-- self:addPropertyValues(talentMould.influencePriorValue)
    elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_ALL_SELF then -- 22影响我方全体 
        for i, v in pairs(attackerFormationObjects) do
            -- if v.coordinate <= 3 then
                v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
            -- end
        end
    elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_EVERYROUND then -- 27影响自己
        self:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
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
	elseif talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_TARGET_SHIP_PROPERTY then -- 37敌方后排
        for i, v in pairs(defenderFormationObjects) do
            if v.coordinate > 3 then
                v:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
            end
        end
	end
end

function BattleObject:addPropertyByTalentInfluencePriorValueResultCheck(talentMould, camp, battleCache, fightModule)
	--> __crint("战斗回合前赋予效果校验：", talentMould.influencePriorType)
	-- if talentMould.influenceJudgeOpportunity == TalentConstant.JUDGE_OPPORTUNITY_BATTLE_ROUND_START then
		--> __crint("添加战斗回合前赋予效果：", talentMould.influencePriorValue)
		self:addPropertyValues(talentMould.influencePriorValue, talentMould.level)
	-- end
end

function BattleObject:addPropertyByTalentInfluenceJudgeResult(talentMould)
	-- local propertyTypeArray = zstring.split(talentMould.influenceJudgeResult, "|")
	-- -- for (local property ) then propertyTypeArray) {
	-- for _, property in pairs(propertyTypeArray) do
	-- 	local propertyType = tonumber(zstring.split(property, ",")[1])
	-- 	local propertyValue = tonumber(zstring.split(property, ",")[2])
	-- 	self:addPropertyValue(propertyType, propertyValue)
	-- end
	self:addPropertyValues(talentMould.influenceJudgeResult, talentMould.level)
end

function BattleObject:addPropertyValues(propertyInfos, level)
	local propertyTypeArray = zstring.splits(propertyInfos, "!", "|")
	-- for (local property ) then propertyTypeArray) {
	for _, property in pairs(propertyTypeArray[1]) do
		local propertyInfo = zstring.split(property, ",")
		if #propertyInfo > 1 then
			local propertyType = tonumber(propertyInfo[1])
			local propertyValue = tonumber(propertyInfo[2])
			self:addPropertyValue(propertyType, propertyValue)
		end
	end

    if nil ~= level 
        and tonumber(level) > 0 
        and #propertyTypeArray > 1
        then
        for _, property in pairs(propertyTypeArray[2]) do
            local propertyInfo = zstring.split(property, ",")
            if #propertyInfo > 1 then
                local propertyType = tonumber(propertyInfo[1])
                local propertyValue = tonumber(propertyInfo[2])
                --> __crint("升级属性：", level, propertyType, propertyValue)
                self:addPropertyValue(propertyType, (tonumber(level) - 1) * propertyValue)
            end
        end
    end
end

function BattleObject:addPropertyValue(propertyType, propertyValue)
    -- print("目标属性变更")
    -- -- 输出攻击过程信息
    -- print("\t\t\t\t目标属性变更：" .. self.battleTag .. "\t" .. self.coordinate .. "\t"
    --     .. "属性类型：" .. __fight_debug_property_type_info["" .. propertyType .. ""] .. "\t"
    --     .. "变更前的属性值:" .. self:getPropertyValue(propertyType) .. "\t"
    --     .. "变更的属性值:" .. propertyValue .. "\t"
    --     .. "\r\n")

	if (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL) then
        local healthPoint = self.healthPoint
		self:addHealthPoint(propertyValue)
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL .. "】：", self.healthPoint, propertyValue, healthPoint)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL) then
        local attack = self.attack
		self.attack = self.attack + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL .. "】：", self.attack, propertyValue, attack)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL) then
        local physicalDefence = self.physicalDefence
		self.physicalDefence = self.physicalDefence + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL .. "】：", self.physicalDefence, propertyValue, physicalDefence)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL) then
		self.skillDefence = self.skillDefence + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL .. "】：", self.skillDefence, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		-- self.powerAdditionalPercent = self.powerAdditionalPercent + propertyValue
        local addValue = this.fightObject.healthPoint * propertyValue
        self.healthPoint = self.healthPoint + addValue
        self.healthMaxPoint = self.healthMaxPoint + addValue
        print("最大血量3: " .. self.healthMaxPoint)

        print("设置BattleObject血量4: " .. self.healthPoint)

        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL_PERCENTAGE .. "】：", self.powerAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.courageAdditionalPercent = self.courageAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL_PERCENTAGE .. "】：", self.courageAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL_PERCENTAGE) then -- 6
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.intellectAdditionalPercent = self.intellectAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL_PERCENTAGE .. "】：", self.intellectAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL_PERCENTAGE) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.nimableAdditionalPercent = self.nimableAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL_PERCENTAGE .. "】：", self.nimableAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS) then -- 8
		self.criticalAdditionalPercent = self.criticalAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS .. "】：", self.criticalAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS) then -- 9
		self.criticalResistAdditionalPercent = self.criticalResistAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS .. "】：", self.criticalResistAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS) then
		self.retainAdditionalPercent = self.retainAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS .. "】：", self.retainAdditionalPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS) then
		self.retainBreakAdditionalPercent  = self.retainBreakAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS .. "】：", self.retainBreakAdditionalPercent, propertyValue)
	-- 	--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ACCURACY_ODDS) then
		self.accuracyAdditionalPercent  = self.accuracyAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ACCURACY_ODDS .. "】：", self.accuracyAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVASION_ODDS) then
		self.evasionAdditionalPercent  = self.evasionAdditionalPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_EVASION_ODDS .. "】：", self.evasionAdditionalPercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_LESSEN_DAMAGE_PERCENTAGE) then
		self.physicalLessenDamagePercent  = self.physicalLessenDamagePercent + (propertyValue / 100)
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_PHYSIC_LESSEN_DAMAGE_PERCENTAGE .. "】：", self.physicalLessenDamagePercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_LESSEN_DAMAGE_PERCENTAGE) then
		self.skillLessenDamagePercent  = self.skillLessenDamagePercent + (propertyValue / 100)
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_SKILL_LESSEN_DAMAGE_PERCENTAGE .. "】：", self.skillLessenDamagePercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ODDS) then
		self.curePercent  = self.curePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CURE_ODDS .. "】：", self.curePercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ODDS) then
		self.byCurePercent  = self.byCurePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_BY_CURE_ODDS .. "】：", self.byCurePercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE) then
		self.finalDamageAddition  = self.finalDamageAddition + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE .. "】：", self.finalDamageAddition, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE) then
		self.finalSubDamageAddition  = self.finalSubDamageAddition + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE .. "】：", self.finalSubDamageAddition, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_SP_INCREASE) then
        local initialSPIncrease = self.initialSPIncrease
		self.initialSPIncrease = self.initialSPIncrease + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_INITIAL_SP_INCREASE .. "】：", self.initialSPIncrease, propertyValue, initialSPIncrease, self.initialSPIncrease / FightModule.MAX_SP)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_HEAD) then
		self.leader  = self.leader + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_INITIAL_HEAD .. "】：", self.leader, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_BODY) then
		self.strength  = self.strength + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_INITIAL_BODY .. "】：", self.strength, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_WISDOM) then
		self.wisdom  = self.wisdom + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_INITIAL_WISDOM .. "】：", self.wisdom, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_ATTACK_ADDITIONAL) then
		self.physicalAttackAdd  = self.physicalAttackAdd + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_PHYSIC_ATTACK_ADDITIONAL .. "】：", self.physicalAttackAdd, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADDITIONAL) then
		self.skillAttackAdd  = self.skillAttackAdd + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADDITIONAL .. "】：", self.skillAttackAdd, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ADDITIONAL) then
		self.cureAdd  = self.cureAdd + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CURE_ADDITIONAL .. "】：", self.cureAdd, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ADDITIONAL) then
		self.byCureAdd  = self.byCureAdd + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_BY_CURE_ADDITIONAL .. "】：", self.byCureAdd, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_ADDITIONAL) then
		self.firingAdd  = self.firingAdd + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FIRING_ADDITIONAL .. "】：", self.firingAdd, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_ADDITIONAL) then
		self.posionAdd  = self.posionAdd + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_POSION_ADDITIONAL .. "】：", self.posionAdd, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_LESSEN) then
		self.byFiringLes  = self.byFiringLes + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FIRING_LESSEN .. "】：", self.byFiringLes, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_LESSEN) then
		self.byPosionLes  = self.byPosionLes + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_POSION_LESSEN .. "】：", self.byPosionLes, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT) then
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.finalDamagePercent  = self.finalDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT .. "】：", self.finalDamagePercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT) then -- 34
		-- if(propertyValue < 1) then
		-- 	propertyValue = propertyValue * 100
		-- end
		self.finalLessenDamagePercent  = self.finalLessenDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT .. "】：", self.finalLessenDamagePercent, propertyValue)
		--break
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_INIT_ZOMALSKILLPOINT) then
		self.zoariumSkillPoint = propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FINAL_INIT_ZOMALSKILLPOINT .. "】：", self.zoariumSkillPoint, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVERY_ATTACK_ADD_SP) then -- 38.每次出手增加的怒气
		self.everyAttackAddSp = self.everyAttackAddSp + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_EVERY_ATTACK_ADD_SP .. "】：", self.everyAttackAddSp, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_DAMAGE_PERCENT) then -- 39.灼烧伤害% 
		self.firingDamagePercent = self.firingDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_FIRING_DAMAGE_PERCENT .. "】：", self.firingDamagePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT) then -- 40.吸血率%
		self.inhaleHpDamagePercent = self.inhaleHpDamagePercent + propertyValue
        print("设置吸血率为1 " .. self.inhaleHpDamagePercent)
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT .. "】：", self.inhaleHpDamagePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADD_SP_VALUE) then -- 41.怒气
		self.addSpValue = self.addSpValue + propertyValue
        self:addSkillPoint(propertyValue)
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ADD_SP_VALUE .. "】：", self.addSpValue, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_REBOUND_DAMAGE_VALUE) then -- 42.反弹%  
		self.reboundDamageValue = self.reboundDamageValue + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_REBOUND_DAMAGE_VALUE .. "】：", self.reboundDamageValue, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_DAMAGE_PERCENT) then -- 43.暴伤加成%	   
		self.uniqueSkillDamagePercent = self.uniqueSkillDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_DAMAGE_PERCENT .. "】：", self.uniqueSkillDamagePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_AVOID_CONTROL_PERCENT) then -- 44.免控率%  
		self.avoidControlPercent = self.avoidControlPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_AVOID_CONTROL_PERCENT .. "】：", self.avoidControlPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT) then -- 45.小技能触发概率%  
		self.normatinSkillTriggerPercent = self.normatinSkillTriggerPercent + propertyValue
        -- self.normalSkillMouldRate = self.normalSkillMouldRate + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT .. "】：", self.normatinSkillTriggerPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_RESISTANCE_PERCENT) then -- 46.格挡强度% 
		self.uniqueSkillResistancePercent = self.uniqueSkillResistancePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_RESISTANCE_PERCENT .. "】：", self.uniqueSkillResistancePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CONTROL_PERCENT) then -- 47.控制率%
		self.controlPercent = self.controlPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CONTROL_PERCENT .. "】：", self.controlPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_EFFECT_PERCENT) then -- 48.治疗效果% 
		self.cureEffectPercent = self.cureEffectPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CURE_EFFECT_PERCENT .. "】：", self.cureEffectPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ADDITION_PERCENT) then -- 49.暴击强化% 
		self.criticalAdditionPercent = self.criticalAdditionPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_CRITICAL_ADDITION_PERCENT .. "】：", self.criticalAdditionPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_HERO_RESTRAIN_DAMAGEPERCENT) then -- 50.数码兽类型克制伤害%
		self.heroRestrainDamagePercent = self.heroRestrainDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_HERO_RESTRAIN_DAMAGEPERCENT .. "】：", self.heroRestrainDamagePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SPUTTERING_ATTACK_ADD_DAMAGE_PERCENT) then -- 51.溅射伤害%
		self.sputteringAttackAddDamagePercent = self.sputteringAttackAddDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_SPUTTERING_ATTACK_ADD_DAMAGE_PERCENT .. "】：", self.sputteringAttackAddDamagePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADD_DAMAGE_PERCENT) then -- 52.技能伤害%
		self.skillAttackAddDamagePercent = self.skillAttackAddDamagePercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADD_DAMAGE_PERCENT .. "】：", self.skillAttackAddDamagePercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT) then -- 53.被治疗减少%
		self.byCureLessenPercent = self.byCureLessenPercent + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT .. "】：", self.byCureLessenPercent, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_54) then -- 54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
		self.ptvf54 = self.ptvf54 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_54 .. "】：", self.ptvf54, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_ODDS_FOR_55) then -- 55.必杀伤害率%
		self.ptvf55 = self.ptvf55 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_ODDS_FOR_55 .. "】：", self.ptvf55, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_56) then -- 56.增加必杀伤害%
		self.ptvf56 = self.ptvf56 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_56 .. "】：", self.ptvf56, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_57) then -- 57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
		self.ptvf57 = self.ptvf57 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_57 .. "】：", self.ptvf57, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_58) then -- 58.增加暴击伤害%
		self.ptvf58 = self.ptvf58 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_58 .. "】：", self.ptvf58, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_59) then -- 59.减少暴击伤害%
		self.ptvf59 = self.ptvf59 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_59 .. "】：", self.ptvf59, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_60) then -- 60.受到的必杀伤害增加%
		self.ptvf60 = self.ptvf60 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_60 .. "】：", self.ptvf60, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_PWER_ADD_SPEED_FOR_61) then -- 61.怒气回复速度%
		self.ptvf61 = self.ptvf61 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_ADDITIONAL_PWER_ADD_SPEED_FOR_61 .. "】：", self.ptvf61, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_PERCENT_FOR_62) then -- 62.受到伤害降低%
        print(debug.traceback())
        print("增加前x1 " .. self.ptvf62)
		self.ptvf62 = self.ptvf62 + propertyValue
        if self.ptvf62 < 0 then
            self.ptvf62 = 0
        end
        print("增加前x2 " .. self.ptvf62)
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_PERCENT_FOR_62 .. "】：", self.ptvf62, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_ATTACK_PERCENT_FOR_63) then -- 63.降低攻击(%)	
		self.ptvf63 = self.ptvf63 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_ATTACK_PERCENT_FOR_63 .. "】：", self.ptvf63, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_64) then -- 64.降低防御
		self.ptvf64 = self.ptvf64 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_64 .. "】：", self.ptvf64, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_65) then -- 65.降低必杀伤害率%	
		self.ptvf65 = self.ptvf65 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_65 .. "】：", self.ptvf65, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_66) then -- 66.降低必杀伤害率%	
		self.ptvf66 = self.ptvf66 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_66 .. "】：", self.ptvf66, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_67) then -- 67.降低伤害减免%
		self.ptvf67 = self.ptvf67 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_67 .. "】：", self.ptvf67, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_68) then -- 68.降低防御（%）
		self.ptvf68 = self.ptvf68 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_68 .. "】：", self.ptvf68, propertyValue)
	elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_69) then -- 69.降低怒气回复速度
		self.ptvf69 = self.ptvf69 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_69 .. "】：", self.ptvf69, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_70) then -- 70.数码兽类型克制伤害加成%
        self.ptvf70 = self.ptvf70 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_70 .. "】：", self.ptvf70, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_71) then -- 71.数码兽类型克制伤害减免%
        self.ptvf71 = self.ptvf71 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_71 .. "】：", self.ptvf71, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_72) then -- 72.降低攻击
        self.ptvf72 = self.ptvf72 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_72 .. "】：", self.ptvf72, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_73) then -- 73.增加必杀抗性%
        self.ptvf73 = self.ptvf73 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_73 .. "】：", self.ptvf73, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74) then -- 74.减少必杀抗性%
        self.ptvf74 = self.ptvf74 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74 .. "】：", self.ptvf74, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_75) then -- 75.降低免控率%
        self.ptvf75 = self.ptvf75 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_75 .. "】：", self.ptvf75, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_76) then -- 76.复活概率%
        self.ptvf76 = self.ptvf76 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_76 .. "】：", self.ptvf76, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_77) then -- 77.被复活概率%
        self.ptvf77 = self.ptvf77 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_77 .. "】：", self.ptvf77, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_78) then -- 78复活继承血量%
        self.ptvf78 = self.ptvf78 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_78 .. "】：", self.ptvf78, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_79) then -- 79复活继承怒气%
        self.ptvf79 = self.ptvf79 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_79 .. "】：", self.ptvf79, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_80) then -- 80被复活继承血量%
        self.ptvf80 = self.ptvf80 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_80 .. "】：", self.ptvf80, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_81) then -- 81被复活继承怒气%
        self.ptvf81 = self.ptvf81 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_81 .. "】：", self.ptvf81, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_82) then -- 82增加复活概率%
        self.ptvf82 = self.ptvf82 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_82 .. "】：", self.ptvf82, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_83) then -- 83增加复活继承血量%
        self.ptvf83 = self.ptvf83 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_83 .. "】：", self.ptvf83, propertyValue)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_84) then -- 84小技能伤害提升%
        self.ptvf84 = self.ptvf84 + propertyValue
        --> __crint(self.battleTag, self.coordinate, "属性【" .. EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_84 .. "】：", self.ptvf84, propertyValue)
	else
		
	end
    --[[输出攻击过程信息
    ___writeDebugInfo("\t\t\t\t目标属性变更后：" .. self.battleTag .. "\t" .. self.coordinate .. "\t"
        .. "属性类型：" .. __fight_debug_property_type_info["" .. propertyType .. ""] .. "\t"
        .. "变更后的属性值:" .. self:getPropertyValue(propertyType) .. "\t"
        .. "\r\n")
    --]]
end

function BattleObject:getPropertyValue(propertyType)
    if (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL) then
        return self.healthPoint
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL) then
        return self.attack
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL) then
        return self.physicalDefence
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL) then
        return self.skillDefence
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL_PERCENTAGE) then
        return self.healthMaxPoint
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL_PERCENTAGE) then
        return self.courageAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL_PERCENTAGE) then
        return self.intellectAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL_PERCENTAGE) then
        return self.nimableAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS) then
        return self.criticalAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS) then
        return self.criticalResistAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS) then
        return self.retainAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS) then
        return self.retainBreakAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ACCURACY_ODDS) then
        return self.accuracyAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVASION_ODDS) then
        return self.evasionAdditionalPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_LESSEN_DAMAGE_PERCENTAGE) then
        return self.physicalLessenDamagePercentreturn 
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_LESSEN_DAMAGE_PERCENTAGE) then
        return self.skillLessenDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ODDS) then
        return self.curePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ODDS) then
        return self.byCurePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE) then
        return self.finalDamageAdditionreturn 
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE) then
        return self.finalSubDamageAdditionreturn 
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_SP_INCREASE) then
        return self.initialSPIncrease
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_HEAD) then
        return self.leader
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_BODY) then
        return self.strength
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_WISDOM) then
        return self.wisdom
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_ATTACK_ADDITIONAL) then
        return self.physicalAttackAdd
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADDITIONAL) then
        return self.skillAttackAdd
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ADDITIONAL) then
        return self.cureAdd
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ADDITIONAL) then
        return self.byCureAdd
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_ADDITIONAL) then
        return self.firingAdd
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_ADDITIONAL) then
        return self.posionAdd
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_LESSEN) then
        return self.byFiringLes
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_LESSEN) then
        return self.byPosionLes
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT) then
        return self.finalDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT) then
        return self.finalLessenDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_INIT_ZOMALSKILLPOINT) then
        return self.zoariumSkillPoint
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVERY_ATTACK_ADD_SP) then -- 38.每次出手增加的怒气
        return self.everyAttackAddSp
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_DAMAGE_PERCENT) then -- 39.灼烧伤害% 
        return self.firingDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT) then -- 40.吸血率%
        return self.inhaleHpDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADD_SP_VALUE) then -- 41.怒气
        -- self.addSpValue = self.addSpValue + propertyValue
        -- self:addSkillPoint(propertyValue)
        return self.skillPoint
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_REBOUND_DAMAGE_VALUE) then -- 42.反弹%  
        return self.reboundDamageValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_DAMAGE_PERCENT) then -- 43.暴伤加成%     
        return self.uniqueSkillDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_AVOID_CONTROL_PERCENT) then -- 44.免控率%  
        return self.avoidControlPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT) then -- 45.小技能触发概率%  
        return self.normatinSkillTriggerPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_RESISTANCE_PERCENT) then -- 46.格挡强度% 
        return self.uniqueSkillResistancePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CONTROL_PERCENT) then -- 47.控制率%
        return self.controlPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_EFFECT_PERCENT) then -- 48.治疗效果% 
        return self.cureEffectPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ADDITION_PERCENT) then -- 49.暴击强化% 
        return self.criticalAdditionPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_HERO_RESTRAIN_DAMAGEPERCENT) then -- 50.数码兽类型克制伤害%
        return self.heroRestrainDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SPUTTERING_ATTACK_ADD_DAMAGE_PERCENT) then -- 51.溅射伤害%
        return self.sputteringAttackAddDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADD_DAMAGE_PERCENT) then -- 52.技能伤害%
        return self.skillAttackAddDamagePercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT) then -- 53.被治疗减少%
        return self.byCureLessenPercent
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_54) then -- 54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
        return self.ptvf54
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_ODDS_FOR_55) then -- 55.必杀伤害率%
        return self.ptvf55
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_56) then -- 56.增加必杀伤害%
        return self.ptvf56
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_57) then -- 57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
        return self.ptvf57
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_58) then -- 58.增加暴击伤害%
        return self.ptvf58
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_59) then -- 59.减少暴击伤害%
        return self.ptvf59
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_60) then -- 60.受到的必杀伤害增加%
        return self.ptvf60
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_PWER_ADD_SPEED_FOR_61) then -- 61.怒气回复速度%
        return self.ptvf61
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_PERCENT_FOR_62) then -- 62.受到伤害降低%
        return self.ptvf62
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_ATTACK_PERCENT_FOR_63) then -- 63.降低攻击(%)    
        return self.ptvf63
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_64) then -- 64.降低防御
        return self.ptvf64
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_65) then -- 65.降低必杀伤害率%   
        return self.ptvf65
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_66) then -- 66.降低必杀伤害率%   
        return self.ptvf66
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_67) then -- 67.降低伤害减免%
        return self.ptvf67
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_68) then -- 68.降低防御（%）
        return self.ptvf68
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_69) then -- 69.降低怒气回复速度
        return self.ptvf69
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_70) then -- 70.数码兽类型克制伤害加成%
        return self.ptvf70
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_71) then -- 71.数码兽类型克制伤害减免%
        return self.ptvf71
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_72) then -- 72.降低攻击
        return self.ptvf72
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_73) then -- 73.增加必杀抗性%
        return self.ptvf73
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74) then -- 74.减少必杀抗性%
        return self.ptvf74
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_75) then -- 75.降低免控率%
        return self.ptvf75
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_76) then -- 76.复活概率%
        return self.ptvf76
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_77) then -- 77.被复活概率%
        return self.ptvf77
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_78) then -- 78复活继承血量%
        return self.ptvf78
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_79) then -- 79复活继承怒气%
        return self.ptvf79
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_80) then -- 80被复活继承血量%
        return self.ptvf80
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_81) then -- 81被复活继承怒气%
        return self.ptvf81
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_82) then -- 82增加复活概率%
        return self.ptvf82
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_83) then -- 83增加复活继承血量%
        return self.ptvf83
    else
        return 0
    end
end

function BattleObject:setPropertyValue(propertyType, propertyValue)
    --[[输出攻击过程信息
    ___writeDebugInfo("\t\t\t\t目标属性变更（设置）：" .. self.battleTag .. "\t" .. self.coordinate .. "\t"
        .. "属性类型：" .. __fight_debug_property_type_info["" .. propertyType .. ""] .. "\t"
        .. "变更前的属性值:" .. self:getPropertyValue(propertyType) .. "\t"
        .. "变更的属性值:" .. propertyValue .. "\t"
        .. "\r\n")
    --]]
    if (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL) then
        self.healthPoint = propertyValue
        print("设置BattleObject血量2: " .. self.healthPoint)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL) then
        self.attack = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL) then
        self.physicalDefence = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL) then
        self.skillDefence = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LIFE_ADDITIONAL_PERCENTAGE) then
        self.healthMaxPoint = propertyValue
        print("最大血量4: " .. self.healthMaxPoint)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL_PERCENTAGE) then
        self.courageAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL_PERCENTAGE) then
        self.intellectAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_DEFENCE_ADDITIONAL_PERCENTAGE) then
        self.nimableAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS) then
        self.criticalAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS) then
        self.criticalResistAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS) then
        self.retainAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS) then
        self.retainBreakAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ACCURACY_ODDS) then
        self.accuracyAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVASION_ODDS) then
        self.evasionAdditionalPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_LESSEN_DAMAGE_PERCENTAGE) then
        self.physicalLessenDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_LESSEN_DAMAGE_PERCENTAGE) then
        self.skillLessenDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ODDS) then
        self.curePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ODDS) then
        self.byCurePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE) then
        self.finalDamageAddition = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE) then
        self.finalSubDamageAddition = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_SP_INCREASE) then
        self.initialSPIncrease = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_HEAD) then
        self.leader = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_BODY) then
        self.strength = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INITIAL_WISDOM) then
        self.wisdom = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_PHYSIC_ATTACK_ADDITIONAL) then
        self.physicalAttackAdd = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADDITIONAL) then
        self.skillAttackAdd = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_ADDITIONAL) then
        self.cureAdd = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_ADDITIONAL) then
        self.byCureAdd = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_ADDITIONAL) then
        self.firingAdd = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_ADDITIONAL) then
        self.posionAdd = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_LESSEN) then
        self.byFiringLes = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_POSION_LESSEN) then
        self.byPosionLes = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT) then
        self.finalDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT) then
        self.finalLessenDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FINAL_INIT_ZOMALSKILLPOINT) then
        self.zoariumSkillPoint = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_EVERY_ATTACK_ADD_SP) then -- 38.每次出手增加的怒气
        self.everyAttackAddSp = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_FIRING_DAMAGE_PERCENT) then -- 39.灼烧伤害% 
        self.firingDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT) then -- 40.吸血率%
        self.inhaleHpDamagePercent = propertyValue
        print("设置吸血率为2 " .. self.inhaleHpDamagePercent)
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADD_SP_VALUE) then -- 41.怒气
        -- self.addSpValue = self.addSpValue + propertyValue
        -- self:addSkillPoint(propertyValue)
        self.skillPoint = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_REBOUND_DAMAGE_VALUE) then -- 42.反弹%  
        self.reboundDamageValue = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_DAMAGE_PERCENT) then -- 43.暴伤加成%     
        self.uniqueSkillDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_AVOID_CONTROL_PERCENT) then -- 44.免控率%  
        self.avoidControlPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT) then -- 45.小技能触发概率%  
        self.normatinSkillTriggerPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_RESISTANCE_PERCENT) then -- 46.格挡强度% 
        self.uniqueSkillResistancePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CONTROL_PERCENT) then -- 47.控制率%
        self.controlPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CURE_EFFECT_PERCENT) then -- 48.治疗效果% 
        self.cureEffectPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_CRITICAL_ADDITION_PERCENT) then -- 49.暴击强化% 
        self.criticalAdditionPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_HERO_RESTRAIN_DAMAGEPERCENT) then -- 50.数码兽类型克制伤害%
        self.heroRestrainDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SPUTTERING_ATTACK_ADD_DAMAGE_PERCENT) then -- 51.溅射伤害%
        self.sputteringAttackAddDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_SKILL_ATTACK_ADD_DAMAGE_PERCENT) then -- 52.技能伤害%
        self.skillAttackAddDamagePercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT) then -- 53.被治疗减少%
        self.byCureLessenPercent = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_54) then -- 54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
        self.ptvf54 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_ODDS_FOR_55) then -- 55.必杀伤害率%
        self.ptvf55 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_56) then -- 56.增加必杀伤害%
        print("设置ptvf56: " .. propertyValue)
        self.ptvf56 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_57) then -- 57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
        self.ptvf57 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_58) then -- 58.增加暴击伤害%
        self.ptvf58 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_59) then -- 59.减少暴击伤害%
        self.ptvf59 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_60) then -- 60.受到的必杀伤害增加%
        self.ptvf60 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_ADDITIONAL_PWER_ADD_SPEED_FOR_61) then -- 61.怒气回复速度%
        self.ptvf61 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_PERCENT_FOR_62) then -- 62.受到伤害降低%
        self.ptvf62 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_ATTACK_PERCENT_FOR_63) then -- 63.降低攻击(%)    
        self.ptvf63 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_64) then -- 64.降低防御
        self.ptvf64 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_65) then -- 65.降低必杀伤害率%   
        self.ptvf65 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_66) then -- 66.降低必杀伤害率%   
        self.ptvf66 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_67) then -- 67.降低伤害减免%
        self.ptvf67 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_68) then -- 68.降低防御（%）
        self.ptvf68 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_69) then -- 69.降低怒气回复速度
        self.ptvf69 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_70) then -- 70.数码兽类型克制伤害加成%
        self.ptvf70 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_71) then -- 71.数码兽类型克制伤害减免%
        self.ptvf71 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_72) then -- 72.降低攻击
        self.ptvf72 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_73) then -- 73.增加必杀抗性%
        self.ptvf73 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74) then -- 74.减少必杀抗性%
        self.ptvf74 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_75) then -- 75.降低免控率%
        self.ptvf75 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_76) then -- 76.复活概率%
        self.ptvf76 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_77) then -- 77.被复活概率%
        self.ptvf77 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_78) then -- 78复活继承血量%
        self.ptvf78 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_79) then -- 79复活继承怒气%
        self.ptvf79 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_80) then -- 80被复活继承血量%
        self.ptvf80 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_81) then -- 81被复活继承怒气%
        self.ptvf81 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_82) then -- 82增加复活概率%
        self.ptvf82 = propertyValue
    elseif (propertyType == EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_83) then -- 83增加复活继承血量%
        self.ptvf83 = propertyValue
    else
        
    end
    --[[输出攻击过程信息
    ___writeDebugInfo("\t\t\t\t目标属性变更后（设置）：" .. self.battleTag .. "\t" .. self.coordinate .. "\t"
        .. "属性类型：" .. __fight_debug_property_type_info["" .. propertyType .. ""] .. "\t"
        .. "变更后的属性值:" .. self:getPropertyValue(propertyType) .. "\t"
        .. "\r\n")
    --]]
end
--[[
校验条件
索引  条件作用    格式  
0   无条件判断   0   
1   判断所在回合数 1，最低生效回合要求，最高回合生效要求 
2   判断目标的怒气值    2，是否为百分比，最低生效怒气要求，最高生效怒气要求 （0：百分比 1：绝对值）    

索引  值得作用    格式  
0   赋予天赋    0，天赋ID  
1   属性加成（索引1）   1，属性类型，值   

e.g:
48;1,1,2;0!0,1958;11,0|48;1,3,10;0!0,1959;11,0
48;2,0,0,0.6;0!1,33,0.4;3,0|48;2,0,0,0.6;0!1,66,0.1;3,0
--]]
function BattleObject:influenceJudgeResultCheckConditions( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetConditions, resultBuffer )
    local result = false
    for i, v in pairs(judgeResultTargetConditions) do
        result = false
        local conditionType = tonumber(v[1])
        if conditionType == 0 then
            result = true
        elseif conditionType == 1 then
            if tonumber(v[2]) <= fightModule.roundCount and tonumber(v[3]) >= fightModule.roundCount then
                result = true
            end
        elseif conditionType == 2 then
            if nil ~= byAttackObject then
                local checkType = tonumber(v[2])
                if checkType == 0 then
                    local spp = byAttackObject.skillPoint / FightModule.MAX_SP
                    --> __crint("------>>>", spp)
                    if tonumber(v[3]) <= spp and tonumber(v[4]) >= spp then
                        result = true
                    end
                elseif checkType == 1 then
                    if tonumber(v[3]) <= byAttackObject.skillPoint and tonumber(v[4]) >= byAttackObject.skillPoint then
                        result = true
                    end
                end
            end
        end

        if true ~= result then
            break
        end
    end
    return result
end

function BattleObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, resultBuffer, propertyType )
    local resultValue = 0
    -- if #self.additionInfluenceJudgeResult > 0 then
    --     debug.print_r(self.additionInfluenceJudgeResult)
    -- end
    for i, v in pairs(self.additionInfluenceJudgeResult) do
        local conditionResult = self:influenceJudgeResultCheckConditions( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, v[1], resultBuffer )
        if true == conditionResult then
            for m, n in pairs(v[2]) do
                if n[1] == "1" and propertyType == tonumber(n[2]) then
                    resultValue = resultValue + tonumber(n[3])
                    --> __crint("0000000000>>>>>", resultValue)
                end
            end
        end
    end
    return resultValue
end

--[[
目标限定
	1数码兽类型,0无,1攻,2防,3技,其他
	2作用于自身
	3被攻击的每个目标
	4死亡的队友
	5主目标
	6我方特定数码兽,ID,下一个
	7我方任意三人
	8敌方随机两个目标
	9己方数码兽类型,0无,1攻,2防,3技,其他
	10目标周围单位
	11己方后排
	12自己周围友军
	13敌方全体
	14我方随机n只xx斗魂数码兽(14,随机数量,斗魂类型)
	15敌方特定数码兽,ID,下一个
	16我方全体数码兽
	17我方前排数码兽

    22敌方前排 （前排全部死亡时选择敌方后排）
--]]
function BattleObject:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
    print("目标限定, BattleObject:influenceJudgeResultCheckTargets")
	local targets = {}

	local targetType = tonumber(judgeResultTargetArray[1])
    local addType = tonumber(judgeResultTargetArray[2])
    if 1 == addType then
        for i, v in pairs(byAttackCoordinates) do
            local target = byAttackObjects[v]
            if target then
                table.insert(targets, target)
            end
        end
        return targets
    end

    print("目标限定, targetType:" .. targetType)

    --> __crint("进行目标限定处理, 类型：", targetType)

	if 1 == targetType then -- 1数码兽类型,0无,1攻,2防,3技,其他
		local campPreference = tonumber(judgeResultTargetArray[3])
		for i, v in pairs(byAttackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived and v.campPreference == campPreference then
				table.insert(targets, v)
			end
		end
	elseif 2 == targetType then  -- 2作用于自身
		table.insert(targets, self)
	elseif 3 == targetType then  -- 3被攻击的每个目标
		table.insert(targets, byAttackObject)
	elseif 4 == targetType then  -- 4死亡的队友
		local campPreference = tonumber(judgeResultTargetArray[3])
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				table.insert(targets, v)
			end
		end
	elseif 5 == targetType then  -- 5主目标
        if byAttackObject.coordinate == byAttackCoordinates[1] then
		  table.insert(targets, byAttackObject)
        end
	elseif 6 == targetType then  -- 6我方特定数码兽,ID,下一个
		for i = 3, #judgeResultTargetArray do
			local shipMould = tonumber(judgeResultTargetArray[i])
			for _, v in pairs(attackObjects) do
				if nil ~= v and true ~= v.isDead and true ~= v.revived and shipMould == v.shipMould then
					table.insert(targets, v)
					break
				end
			end
		end
	elseif 7 == targetType then  -- 7我方任意三人
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				table.insert(targets, v)
			end
		end
		while #targets > 3 do
			local pos = math.random(1, #targets)
			table.remove(targets, pos, 1)
		end
	elseif 8 == targetType then  -- 8敌方随机两个目标
		for i, v in pairs(byAttackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				table.insert(targets, v)
			end
		end
		while #targets > 2 do
			local pos = math.random(1, #targets)
			table.remove(targets, pos, 1)
		end
	elseif 9 == targetType then  -- 9己方数码兽类型,0无,1攻,2防,3技,其他
		local campPreference = tonumber(judgeResultTargetArray[3])
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived and v.campPreference == campPreference then
				table.insert(targets, v)
			end
		end
	elseif 10 == targetType then  -- 10目标周围单位
		local coordinate = byAttackObject.coordinate
		local cds = {coordinate - 1, coordinate + 1, coordinate - 3, coordinate + 3}
		for i, pos in pairs(cds) do
			for i, v in pairs(byAttackObjects) do
				if nil ~= v and true ~= v.isDead and true ~= v.revived and v.coordinate == pos then
					table.insert(targets, v)
					break
				end
			end
		end
	elseif 11 == targetType then  -- 11己方后排
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived and v.coordinate > 3 then
				table.insert(targets, v)
			end
		end
        if #targets == 0 then
            for i, v in pairs(attackObjects) do
                if nil ~= v and true ~= v.isDead and true ~= v.revived then
                    table.insert(targets, v)
                end
            end
        end
	elseif 12 == targetType then  -- 12自己周围友军
		local coordinate = self.coordinate
		local cds = {coordinate - 1, coordinate + 1, coordinate - 3, coordinate + 3}
		for i, pos in pairs(cds) do
			for i, v in pairs(attackObjects) do
				if nil ~= v and true ~= v.isDead and true ~= v.revived and v.coordinate == pos then
					table.insert(targets, v)
					break
				end
			end
		end
	elseif 13 == targetType then  -- 13敌方全体
		for i, v in pairs(byAttackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				table.insert(targets, v)
			end
		end
	elseif 14 == targetType then  -- 14我方随机n只xx斗魂数码兽(14,随机数量,斗魂类型)
		local nCount = tonumber(judgeResultTargetArray[3])
		local soulType = tonumber(judgeResultTargetArray[4])
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived and v.soulTypes ~= nil then
				for _, st in pairs(v.soulTypes) do
					if st == soulType then
						table.insert(targets, v)
						break
					end
				end
			end
		end
		while #targets > nCount do
			local pos = math.random(1, #targets)
			table.remove(targets, pos, 1)
		end
	elseif 15 == targetType then  -- 15敌方特定数码兽,ID,下一个
		for i = 3, #judgeResultTargetArray do
			local shipMould = tonumber(judgeResultTargetArray[i])
			for _, v in pairs(byAttackObjects) do
				if nil ~= v and shipMould == v.shipMould then
					table.insert(targets, v)
				end
			end
		end
	elseif 16 == targetType then  -- 16我方全体数码兽
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				table.insert(targets, v)
			end
		end
	elseif 17 == targetType then  -- 17我方前排数码兽
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived and v.coordinate <= 3 then
				table.insert(targets, v)
			end
		end
        if #targets == 0 then
            for i, v in pairs(attackObjects) do
                if nil ~= v and true ~= v.isDead and true ~= v.revived then
                    table.insert(targets, v)
                end
            end
        end
	elseif 18 == targetType then  -- 18我方血量低于x%的数码兽,血量百分比
		local hpPercent = tonumber(judgeResultTargetArray[3])
		for i, v in pairs(attackObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				if v.healthPoint / v.healthMaxPoint <= hpPercent then
					table.insert(targets, v)
				end
			end
		end
	elseif 19 == targetType then  -- 19击杀自己的数码兽
		-- for i, v in pairs(byAttackObjects) do
		-- 	if nil ~= v and true ~= v.isDead and true ~= v.revived and v == self.killer then
		-- 		table.insert(targets, v)
		-- 		break
		-- 	end
		-- end
        table.insert(targets, byAttackObject)
    elseif 20 == targetType then  -- 20攻击目标中的数码兽类型，0无，1攻，2防，3技，其他
        local campPreference = tonumber(judgeResultTargetArray[3])
        -- for i, v in pairs(byAttackObjects) do
        --     if nil ~= v and true ~= v.isDead and true ~= v.revived and v.campPreference == campPreference then
        --         table.insert(targets, v)
        --         break
        --     end
        -- end
        table.insert(targets, byAttackObject)
        --> __crint("目标属性：", byAttackObject.battleTag, byAttackObject.coordinate)
    elseif 21 == targetType then  -- 21我方除自身外全体数码兽
        for i, v in pairs(attackObjects) do
            if nil ~= v and true ~= v.isDead and true ~= v.revived and v ~= self then
                table.insert(targets, v)
            end
        end
    elseif 22 == targetType then  -- 22敌方前排 （前排全部死亡时选择敌方后排）
        for i, v in pairs(byAttackObjects) do
            if nil ~= v and true ~= v.isDead and true ~= v.revived and v.coordinate <= 3 then
                table.insert(targets, v)
            end
        end
        if #targets == 0 then
            for i, v in pairs(byAttackObjects) do
                if nil ~= v and true ~= v.isDead and true ~= v.revived then
                    table.insert(targets, v)
                end
            end
        end
    elseif 23 == targetType then  -- 23敌方随机1个目标
        for i, v in pairs(byAttackObjects) do
            if nil ~= v and true ~= v.isDead and true ~= v.revived then
                table.insert(targets, v)
            end
        end
        while #targets > 1 do
            local pos = math.random(1, #targets)
            table.remove(targets, pos, 1)
        end
	end

	return targets
end

-- 天赋判断
function BattleObject:influenceTalentJudgeResults( judgeOpportunity, fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, resultBuffer )
    print("天赋判断 BattleObject:influenceTalentJudgeResults")
    debug.print_r(talentJudgeResultList, "talentJudgeResultList111222")
    -- print(debug.traceback())
    -- print("战斗中赋予效果，类型：", attackObject.battleTag, attackObject.coordinate, judgeOpportunity, table.nums(self.talentJudgeResultList))
    -- -- 输出攻击过程信息
    -- print("\t触发天赋的时机：" .. __fight_debug_execute_time_type_info["" .. judgeOpportunity .. ""] .. "\t" .. "发动方：" .. attackObject.battleTag .. "\t" .. "发动者的占位：" .. attackObject.coordinate .. "\r\n")

    for i, v in pairs(self.talentJudgeResultList) do
		if v.judgeOpportunity == judgeOpportunity then
			local talentJudgeResult = v
			self:influenceJudgeResults( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, resultBuffer )
		end
	end
end

function BattleObject:influenceJudgeResults( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, resultBuffer )
    --[[输出攻击过程信息
    ___writeDebugInfo("\t\t处理天赋信息：" .. "发动方：" .. attackObject.battleTag .. "\t" .. "发动者的占位：" .. attackObject.coordinate .. "\t" .. "触发天赋的ID：" .. talentJudgeResult.talentMould.id .. "\r\n")
    --]]
    print("BattleObject:influenceJudgeResults")

	local judgeResultGroup = zstring.split(talentJudgeResult.talentMould.influenceJudgeResult, "|")
	for i, v in pairs(judgeResultGroup) do
		local judgeResultArrays = zstring.splits(v, ";", ",")
		local resultType = tonumber(judgeResultArrays[1][1])

        print("BattleObject处理天赋类型: " .. resultType)
        
        --[[输出攻击过程信息
        ___writeDebugInfo("\t\t\t天赋类型：" .. __fight_debug_talent_type_info["" .. resultType .. ""] .. "\r\n")
        --]]

        --> __crint("结果类型：", resultType)
        --> __crint("攻击者信息：", attackObject.battleTag, attackObject.coordinate, attackObject.attack, attackObject.physicalDefence)
        if nil ~= byAttackObject then
            --> __crint("防御者信息：", byAttackObject.battleTag, byAttackObject.coordinate, byAttackObject.attack, byAttackObject.physicalDefence)
        end
		if resultType == TalentConstant.JUDGE_RESULT_LESS_PROPERTY_AND_ABSORB_RESULT then -- 12降低和吸取
			self:influenceJudgeResultFor12( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_ADDITION_PROPERTY_AND_EXPEND_RESULT then -- 13增加和消耗
			self:influenceJudgeResultFor13( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_REVIVE then -- 14复活
			self:influenceJudgeResultFor14( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_CLEANSING then -- 15净化
			self:influenceJudgeResultFor15( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_16 then -- 16, 属性类型,值,我方还是敌方,需要匹配的数量,ship_mould ID1,ID2···;目标限定,回合数 （我方0,敌方1。目标限定：buff赋予对象）
			self:influenceJudgeResultFor16( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_17 then -- 17, 属性类型,值,本波次小技能释放次数;目标限定
			self:influenceJudgeResultFor17( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_18 then -- 18, 属性类型,值,条件增加值,数码兽斗魂类型（条件）,值上限；目标限定,数量上限,回合数
			self:influenceJudgeResultFor18( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_19 then -- 19,属性类型,值,我方剩余人数,对方剩余人数 ,目标限定
			self:influenceJudgeResultFor19( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_20 then -- 20, 属性类型,值,数码兽斗魂类型（条件）,条件最低值,条件最大值；目标限定,回合数
			self:influenceJudgeResultFor20( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_21 then -- 21, 属性类型,值,我方还是敌方；数码兽斗魂种类1,种类2···（条件）；条件最低值（种类数量）,条件最大值（种类数量）；目标限定,回合数
			self:influenceJudgeResultFor21( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_22 then -- 22复活buff
			self:influenceJudgeResultFor22( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_23 then -- 23,属性类型,值,我方还是敌方；数码兽资质（条件）,条件最低值,条件最大值；目标限定,回合数
			self:influenceJudgeResultFor23( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_24 then -- 24,属性类型,值,我方还是敌方或者双方；条件增加值（条件：12或6减场上数码兽数量）,值上限；目标限定,回合数,技能类型
			self:influenceJudgeResultFor24( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_25 then -- 25,属性类型,值,自身血量最低值百分比,自身血量最高百分比,目标限定,回合数,技能类型
			self:influenceJudgeResultFor25( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_26 then -- 26, 自身减少当前生命值上限百分比,攻击的每个目标减少当前生命值上限百分比
			self:influenceJudgeResultFor26( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_27 then -- 27, 增加复活的概率,增加复活后血量,目标限定,回合数,技能类型
			self:influenceJudgeResultFor27( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_28 then -- 28,属性类型1,值,敌方目标血量最低值百分比,敌方目标血量最高百分比,开始回合,目标限定,BUFF持续回合数,技能类型|属性类型1,值,敌方目标血量最低值百分比,敌方目标血量最高百分比,开始回合,目标限定,BUFF持续回合数,技能类型|···
			self:influenceJudgeResultFor28( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_29 then -- 29,属性类型1,值,我方还是敌方或者双方,数码兽类型,条件最低值,条件最大值；目标限定,回合数,技能类型|属性类型2,值,我方还是敌方或者双方,数码兽类型,条件最低值,条件最大值；目标限定,回合数,技能类型|···
			self:influenceJudgeResultFor29( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_30 then -- 30,属性类型,值,怒气值对比,回合数,技能类型；目标限定
			self:influenceJudgeResultFor30( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_31 then -- 31,属性类型,值,怒气值百分比最小值,怒气值百分比最大值,回合数,技能类型；目标限定
			self:influenceJudgeResultFor31( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_32 then -- 32,属性类型1,值,属性值增加或者减少,属性变化值,自身血量百分比变化梯度,属性值上限,回合数,技能类型；目标限定
			self:influenceJudgeResultFor32( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_33 then -- 33,属性类型1,值,单波次回合数,buff持续回合数,技能类型；目标限定
			self:influenceJudgeResultFor33( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_34 then -- 34,单波次回合数,触发的技能效用ID,需替换技能效用ID；第几个字段,增加或者减少,变化值；第几个字段,增加或者减少,变化值；···
			self:influenceJudgeResultFor34( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_35 then -- 35,单波次回合数,回复的怒气值,清除自身的减益buff1,清除自身的减益buff2···
			self:influenceJudgeResultFor35( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_36 then -- 36,自身复活后血量%,继承死前怒气%,复活概率%,复活后触发的技能效用ID,复活后替换技能效用ID；第几个字段,增加或者减少,变化值；第几个字段,增加或者减少,变化值；···
			self:influenceJudgeResultFor36( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_37 then -- 37,单数回合触发技能效用ID,双数回合触发技能效用ID
			self:influenceJudgeResultFor37( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_38 then -- 38,自身复活后血量%,继承死前怒气%,复活概率%,此效用复活次数限制,复活需求我方数码兽ship_mould的ID
			self:influenceJudgeResultFor38( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_39 then -- 39,属性类型1,值,技能类型；目标限定|属性类型2,值,技能类型；目标限定|···
			self:influenceJudgeResultFor39( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_40 then -- 40,我方剩余人数,对方剩余人数,人数满足时增加复活概率,人数满足时触发的技能效用ID；人数满足时替换技能效用ID1；第几个字段,增加或者减少,变化值；第几个字段,增加或者减少,变化值；···|人数满足时替换技能效用ID2；第几个字段,增加或者减少,变化值；第几个字段,增加或者减少,变化值；···|···
			self:influenceJudgeResultFor40( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_41 then -- 41,属性类型,值,被嘲讽的敌方数量,回合数,技能类型；目标限定
			self:influenceJudgeResultFor41( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_42 then -- 42,属性类型1,值,可叠加次数,值上限,回合数,技能类型；目标限定|属性类型2,值,可叠加次数,值上限,回合数,技能类型；目标限定|···
			self:influenceJudgeResultFor42( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_43 then -- 43,触发技能效用ID,技能效用每场战斗触发次数上限,自身血量百分比界限,血量变化时触发概率增加基础值,自身血量百分比变化梯度
			self:influenceJudgeResultFor43( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_44 then -- 44,需求我方数码兽ship_mould的ID,释放必杀技次数,必杀技扣除自身血量,目标扣除血量百分比增加值
			self:influenceJudgeResultFor44( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
        elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_45 then -- 45，属性类型，值，斗魂等级成长值
            self:influenceJudgeResultFor45( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
        elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_46 then -- 46，特殊怒气回复
            self:influenceJudgeResultFor46( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
		elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_47 then -- 47，免疫控制
            self:influenceJudgeResultFor47( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
        elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_48 then -- 48，
            self:influenceJudgeResultFor48( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer, v )
        elseif resultType == TalentConstant.JUDGE_RESULT_PROPERTY_TYPE_49 then -- 49，
            self:influenceJudgeResultFor49( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
        end
	end
end

--[[
效果的结果信息返回
--]]
function BattleObject:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, byAttackObject, battleSkill, skillCategory, isDisplay, dspValue, resultBuffer )
    print("效果的结果信息返回 1")
    if nil == resultBuffer or skillCategory < 0 then
        return
    end
    local bs = BattleSkill:new()
    bs.byAttackerTag = byAttackObject.battleTag
    bs.byAttackerCoordinate = byAttackObject.coordinate
    bs.isDisplay = isDisplay
    bs.effectType = skillCategory
    bs.effectValue = dspValue
    bs:writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule, resultBuffer)
    battleSkill.effectAmount = battleSkill.effectAmount + 1
    --> __crint(bs.isDisplay, bs.effectType, bs.effectValue, byAttackObject.battleTag, byAttackObject.coordinate)
    return bs
end

function BattleObject:addPropertyValueForBuff( skillCategory, roundCount, propertyType, propertyValue, percentValue, resultType, buffRoundType, buffSuperpositionType, judgeResultArray, targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer, isDisplay )
    print("BattleObject天赋给承受目标添加BUFF、增加属性, skillCategory: " .. skillCategory)
    if nil == isDisplay then
        isDisplay = 1
    end
    for i, v in pairs(targets) do
        -- 输出攻击过程信息
        print("\t\t\t天赋的承受目标：" .. v.battleTag .. "\t" .. v.coordinate .. "\r\n")

        local needAdd = true
        if roundCount >= 0 then
            local fightBuff = nil
            if skillCategory >= 0 then
                if nil == buffSuperpositionType or buffSuperpositionType == 0 then
                    fightBuff = v:getBuffEffect(skillCategory)
                end
            end
            if nil == fightBuff then
                local skillInfluence = {
                    skillCategory = skillCategory, 
                    influenceDuration = roundCount,
                    propertyType = propertyType,
                    propertyValue = propertyValue,
                    percentValue = percentValue,
                    resultType = resultType,
                    buffRoundType = buffRoundType,
                    judgeResultArray = judgeResultArray,
                }
                fightBuff = FightBuff:new()
                fightBuff.skillInfluence = skillInfluence
                fightBuff.effectRound = skillInfluence.influenceDuration
                v:pushBuffEffect(fightBuff)

                -- 输出攻击过程信息
                print("\t\t\t\t天赋给承受目标添加BUFF：" .. "BUFF类型：" .. __fight_debug_skill_influence_type_info["" .. skillCategory .. ""] .. "\t" .. "回合数：" .. roundCount .. "\r\n")

            else
                needAdd = false
            end
        end
        if needAdd then
            v:addPropertyValue(propertyType, propertyValue)
            self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, v, battleSkill, skillCategory, isDisplay, propertyValue, resultBuffer )
            -- 输出攻击过程信息
            print("\t\t\t\t天赋给承受目标添加属性：" .. "属性类型：" .. __fight_debug_property_type_info["" .. propertyType .. ""] .. "\t" .. "此次的新增值：" .. propertyValue .. "\t" .. "新增后的属性值：" .. v:getPropertyValue(propertyType) .. "\r\n")

        else
            print("这个buff效果有，不再重复加")
        end
    end
    print("BattleObject:addPropertyValueForBuff 2")
end

--[[
12降低和吸取
12,属性类型1,值,返还百分比,回合数,技能类型；目标限定|属性类型2,值,返还百分比,回合数,技能类型；目标限定|···
（属性类型,值：被攻击的每个目标降低的属性   返还百分比：降低的属性值总和按照比例增加给目标限定  回合数：属性增加和降低持续的回合数,回合结束后属性恢复）
--]]
function BattleObject:influenceJudgeResultFor12( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local percentValue = tonumber(judgeResultArray[4])
	local roundCount = tonumber(judgeResultArray[5])
	local skillCategory = tonumber(judgeResultArray[6])
    local buffRoundType = tonumber(judgeResultArray[7])
    local buffSuperpositionType = tonumber(judgeResultArray[8]) -- 是否可叠加：0不叠加   1叠加
    local skillCategory1 = tonumber(judgeResultArray[9]) or skillCategory
    -- self:addPropertyValue(propertyType, addPropertyValue)
    -- self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, attackObject, battleSkill, skillCategory, 1, addPropertyValue, resultBuffer )

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    local len = #targets
    if len > 0 then
        local calculateParams = judgeResultArrays[3]
        local subPropertyValue = 0
        local addPropertyValue = 0
        if nil == calculateParams or calculateParams[1] == "0" then
            subPropertyValue = -1 * (propertyValue)
            addPropertyValue = propertyValue * len * percentValue
            self:addPropertyValueForBuff(skillCategory, 
                    roundCount,
                    propertyType,
                    subPropertyValue,
                    percentValue,
                    resultType,
                    buffRoundType,
                    buffSuperpositionType,
                    judgeResultArray,
                    targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer, 1
                )
        else
            subPropertyValue = 0
            addPropertyValue = 0

            for i, target in pairs(targets) do
                local result = target:getPropertyValue(propertyType)
                result = result * propertyValue
                subPropertyValue = -1 * (result)
                addPropertyValue = addPropertyValue + result * percentValue
                self:addPropertyValueForBuff(skillCategory, 
                    roundCount,
                    propertyType,
                    subPropertyValue,
                    percentValue,
                    resultType,
                    buffRoundType,
                    buffSuperpositionType,
                    judgeResultArray,
                    {target}, fightModule, userInfo, attackObject, battleSkill, resultBuffer, 1
                )
            end
        end

        self:addPropertyValueForBuff(skillCategory1, 
                roundCount,
                propertyType,
                addPropertyValue,
                percentValue,
                resultType,
                buffRoundType,
                buffSuperpositionType,
                judgeResultArray,
                {self}, fightModule, userInfo, attackObject, battleSkill, resultBuffer, 1
            )
    end
end

--[[
13增加和消耗
13,属性类型1,值,消耗百分比,回合数,技能类型；目标限定|属性类型2,值,消耗百分比,回合数,技能类型；目标限定|···
（属性类型,值：自身增加的属性   返还百分比：自身增加的属性按照目标限定总数比例均分后,目标限定对应的属性降低  回合数：属性增加和降低持续的回合数,回合结束后属性恢复）
--]]
function BattleObject:influenceJudgeResultFor13( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local percentValue = tonumber(judgeResultArray[4])
	local roundCount = tonumber(judgeResultArray[5])
	local skillCategory = tonumber(judgeResultArray[6])
    local buffRoundType = tonumber(judgeResultArray[7])
    local buffSuperpositionType = tonumber(judgeResultArray[8]) -- 是否可叠加：0不叠加   1叠加
	-- self:addPropertyValue(propertyType, propertyValue)
 --    self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, attackObject, battleSkill, skillCategory, 1, propertyValue, resultBuffer )

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    local len = #targets
    if len > 0 then
        local addPropertyValue = -1 * (propertyValue / len)
        self:addPropertyValueForBuff(skillCategory, 
                roundCount,
                propertyType,
                addPropertyValue,
                percentValue,
                resultType,
                buffRoundType,
                buffSuperpositionType,
                judgeResultArray,
                targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
            )

        self:addPropertyValueForBuff(skillCategory, 
                roundCount,
                propertyType,
                propertyValue,
                percentValue,
                resultType,
                buffRoundType,
                buffSuperpositionType,
                judgeResultArray,
                {self}, fightModule, userInfo, attackObject, battleSkill, resultBuffer
            )
    end
end

--[[
14复活
14,血量%,死前怒气%；目标限定
（目标限定：复活的对象）
--]]
function BattleObject:influenceJudgeResultFor14( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyHpPercentValue = tonumber(judgeResultArray[2])
	local propertySpPercentValue = tonumber(judgeResultArray[3])

    -- debug.print_r(judgeResultArrays)

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    --> __crint("复活目标数量：", #targets)
	for i, v in pairs(targets) do
		v:setHealthPoint(v.healthMaxPoint * propertyHpPercentValue)
		v:setSkillPoint(v.skillPoint * propertyHpPercentValue)
		v.isDead = false
		v.unload = false
		v.revived = true
        v.reviveCount = v.reviveCount + 1
	end
end

--[[
15净化
15,清楚负面buff;目标限定
--]]
function BattleObject:influenceJudgeResultFor15( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local skillCategory = tonumber(judgeResultArray[2])

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

	for i, v in pairs(targets) do
		-- FightBuff.clearBuff(skillCategory, v)
        for idx,  fightBuff in pairs(v.buffEffect)  do               
            if fightBuff.skillInfluence.buffRoundType ~= 1 then
                FightBuff.clearBuff(fightBuff.skillInfluence.skillCategory, v, fightBuff.skillInfluence)
                v.buffEffect[idx] = nil
            end
        end
	end
end

--[[
16, 属性类型，值,我方还是敌方，需要匹配ID的数量,回合数，技能类型；ship_mould ID1，ID2···；目标限定
（我方还是敌方：需要检索的阵营，我方0，敌方1。     需要匹配ID的数量：需要满足匹配的最少数量，大于等于此数量时触发属性加成
   [ship_mould ID1，ID2···]：进行匹配的库组      目标限定：属性加成赋予对象    回合数：属性加成持续的回合数 ,-1时表示即时生效）
--]]
function BattleObject:influenceJudgeResultFor16( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
	local choiceCount = tonumber(judgeResultArray[5])
	local roundCount = tonumber(judgeResultArray[6])
	local skillCategory = tonumber(judgeResultArray[7])
    local buffRoundType = tonumber(judgeResultArray[8])
    local buffSuperpositionType = tonumber(judgeResultArray[9]) -- 是否可叠加：0不叠加   1叠加
	-- self:addPropertyValue(propertyType, propertyValue)

	local targetFormationObjects = nil
	if camp == 0 then
		targetFormationObjects = attackObjects
	else
		targetFormationObjects = byAttackObjects
	end

	local checkCount = 0
	for i, id in pairs(judgeResultArrays[2]) do
		for j, v in pairs(targetFormationObjects) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived and v.shipMould == tonumber(id) then
				checkCount = checkCount + 1
				break
			end
		end
	end

	if checkCount >= choiceCount then
        local judgeResultTargetArray = judgeResultArrays[3]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
        
        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
17, 属性类型，值，本波次小技能释放次数,回合数，技能类型，切换波次是否清除，是否可叠加；目标限定
（目标限定：属性加成赋予对象）
--]]
function BattleObject:influenceJudgeResultFor17( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local normalSkillUseCount = tonumber(judgeResultArray[4])
    local roundCount = tonumber(judgeResultArray[5])
    local skillCategory = tonumber(judgeResultArray[6])
    local buffRoundType = tonumber(judgeResultArray[7])
    local buffSuperpositionType = tonumber(judgeResultArray[8]) -- 是否可叠加：0不叠加   1叠加

	if self.normalSkillUseCount >= normalSkillUseCount then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
18, 属性类型,值,我方还是敌方,条件增加值,数码兽斗魂类型（条件）,值上限,数量上限,回合数,技能类型；目标限定
（属性类型,值：基础值   条件增加值：满足条件时的增加值   最终值=基础值+条件增加值*满足条件的数量
  值上限：最终值的上限   目标限定：属性加成赋予对象   数量上限：属性加成赋予对象的数量上限 
  回合数：属性加成持续的回合数 ）
--]]
function BattleObject:influenceJudgeResultFor18( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
	local addValue = tonumber(judgeResultArray[5])
	local needSoulType = tonumber(judgeResultArray[6])
	local needMinValue = tonumber(judgeResultArray[7])
	local needMaxValue = tonumber(judgeResultArray[8])
    local roundCount = tonumber(judgeResultArray[9])
    local skillCategory = tonumber(judgeResultArray[10])
    local buffRoundType = tonumber(judgeResultArray[11])
    local buffSuperpositionType = tonumber(judgeResultArray[12]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
end

--[[
19，属性类型，值，我方剩余人数，对方剩余人数，回合数，技能类型，切换波次是否清除，是否可叠加；目标限定
--]]
function BattleObject:influenceJudgeResultFor19( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	print("进入天赋->19")

    local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local attackerNeedValue = tonumber(judgeResultArray[4])
	local defenderNeedValue = tonumber(judgeResultArray[5])
    local roundCount = tonumber(judgeResultArray[6])
    local skillCategory = tonumber(judgeResultArray[7])
    local buffRoundType = tonumber(judgeResultArray[8])
    local buffSuperpositionType = tonumber(judgeResultArray[9]) -- 是否可叠加：0不叠加   1叠加
	
	-- self:addPropertyValue(propertyType, propertyValue)

	local attackerCount = 0
	for i, v in pairs(attackObjects) do
		if nil ~= v and true ~= v.isDead and true ~= v.revived then
			attackerCount = attackerCount + 1
		end
	end

	local defenderCount = 0
	for i, v in pairs(byAttackObjects) do
		if nil ~= v and true ~= v.isDead and true ~= v.revived then
			defenderCount = defenderCount + 1
		end
	end

    print("attackerCount: " .. attackerCount)
    print("attackerNeedValue: " .. attackerNeedValue)
    print("defenderCount: " .. defenderCount)
    print("defenderNeedValue: " .. defenderNeedValue)
    
	if (attackerCount > 0 and (attackerNeedValue < 0 or attackerCount == attackerNeedValue))
        and (defenderCount > 0 and (defenderNeedValue < 0 or defenderCount == defenderNeedValue))
        then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        --> __crint("获取到的目标数量：", #targets)

        print("进入天赋->19, 2")

		self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
20, 属性类型,值,我方还是敌方,数码兽斗魂类型（条件）,条件最低值,条件最大值,回合数,技能类型；目标限定
（ [条件最低值,条件最大值]：满足斗魂类型的数量区间   目标限定：属性加成赋予对象  回合数：属性加成持续的回合数）
--]]
function BattleObject:influenceJudgeResultFor20( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
	local needSoulType = tonumber(judgeResultArray[5])
	local needMinValue = tonumber(judgeResultArray[6])
	local needMaxValue = tonumber(judgeResultArray[7])
	local roundCount = tonumber(judgeResultArray[8])
	local skillCategory = tonumber(judgeResultArray[9])
    local buffRoundType = tonumber(judgeResultArray[10])
    local buffSuperpositionType = tonumber(judgeResultArray[11]) -- 是否可叠加：0不叠加   1叠加

	local targetFormationObjects = nil
	if camp == 0 then
		targetFormationObjects = attackObjects
	else
		targetFormationObjects = byAttackObjects
	end

	local checkCount = 0
	for i, v in pairs(targetFormationObjects) do
		if nil ~= v and true ~= v.isDead and true ~= v.revived and nil ~= v.soulTypes then
			for _, soulType in pairs(v.soulTypes) do
				if needSoulType == soulType then
					checkCount = checkCount + 1
				end
			end
		end
	end

	if needMinValue <= checkCount and checkCount <= needMaxValue then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
21, 属性类型，值，我方还是敌方，条件最低值（种类数量）,条件最大值（种类数量）,回合数，技能类型；数码兽斗魂种类1，种类2···（条件）；目标限定
（ [条件最低值（种类数量）,条件最大值（种类数量）]:满足斗魂种类的数量，在此区间内时触发属性加成     数码兽斗魂种类1，种类2··· ：进行匹配的种类库组   ）
--]]
function BattleObject:influenceJudgeResultFor21( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
	local needMinValue = tonumber(judgeResultArray[5])
	local needMaxValue = tonumber(judgeResultArray[6])
	local roundCount = tonumber(judgeResultArray[7])
	local skillCategory = tonumber(judgeResultArray[8])
    local buffRoundType = tonumber(judgeResultArray[9])
    local buffSuperpositionType = tonumber(judgeResultArray[10]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	local targetFormationObjects = nil
	if camp == 0 then
		targetFormationObjects = attackObjects
	else
		targetFormationObjects = byAttackObjects
	end

	local checkCount = 0
	for m, t in pairs (judgeResultArrays[2]) do
        local needSoulType = tonumber(t)
		for i, v in pairs(targetFormationObjects) do
			local lcheckCount = checkCount
			if nil ~= v and true ~= v.isDead and true ~= v.revived and nil ~= v.soulTypes then
				for _, soulType in pairs(v.soulTypes) do
					if needSoulType == soulType then
						checkCount = checkCount + 1
						break
					end
				end
			end
			if lcheckCount < checkCount then
				break
			end
		end
	end

	if needMinValue <= checkCount and checkCount <= needMaxValue then
		local judgeResultTargetArray = judgeResultArrays[3]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )

        -- 移除天赋
        for i, v in pairs(attackObject.talentMouldList) do
            if v == talentJudgeResult.talentMould then
                table.remove(attackObject.talentMouldList, i, 1)
                break
            end
        end
	end
end

--[[
-- 22复活buff
-- 22,血量%,死前怒气%,复活概率%,回合数,技能类型；目标限定
-- （目标限定：buff加成对象  回合数：buff持续回合数）
22复活buff，
22，属性类型，值，血量%，死前怒气%，复活次数限制；目标限定
（目标限定：buff加成对象        ）
--]]
function BattleObject:influenceJudgeResultFor22( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    local judgeResultArray = judgeResultArrays[1]
    local resultType = tonumber(judgeResultArray[1])
    local propertyType = tonumber(judgeResultArray[2])
    local propertyValue = tonumber(judgeResultArray[3])
    local propertyHpPercentValue = tonumber(judgeResultArray[4])
    local propertySpPercentValue = tonumber(judgeResultArray[5])
    local reviveCountLimit = tonumber(judgeResultArray[6])
    local buffSuperpositionType = tonumber(judgeResultArray[7]) -- 是否可叠加：0不叠加   1叠加

    local judgeResultTargetArray = judgeResultArrays[2]
    local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    for i, v in pairs(targets) do
        v:addPropertyValue(propertyType, propertyValue)
    end

	-- local judgeResultArray = judgeResultArrays[1]
	-- local resultType = tonumber(judgeResultArray[1])
	-- local propertyHpPercentValue = tonumber(judgeResultArray[2])
	-- local propertySpPercentValue = tonumber(judgeResultArray[3])
	-- local reviveOddsValue = tonumber(judgeResultArray[4])

	-- local judgeResultTargetArray = judgeResultArrays[2]
	-- local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

 --    local skillInfluence = nil
 --    if roundCount >= 0 then
 --    	skillInfluence = {
 --    		skillCategory = skillCategory, 
 --    		influenceDuration = roundCount,
 --    		propertyType = propertyType,
 --    		propertyValue = propertyValue,
 --    		percentValue = percentValue,
 --    		resultType = resultType,
 --    		judgeResultArray = judgeResultArray,
 --    	}
 --    end

	-- for i, v in pairs(targets) do
 --        if nil ~= skillInfluence then
 --    		local fightBuff = FightBuff:new()
 --    		fightBuff.skillInfluence = skillInfluence
 --    		fightBuff.effectRound = skillInfluence.influenceDuration
 --    		v:pushBuffEffect(fightBuff)
 --        -- else
 --            -- v:addPropertyValue(propertyType, propertyValue)
 --        end
 --        v:addPropertyValue(propertyType, propertyValue)
	-- end
end

--[[
23,属性类型,值,我方还是敌方；数码兽资质（条件）,条件最低值,条件最大值,回合数,技能类型；目标限定
( 数码兽资质（条件）:要求的数码兽资质  [条件最低值,条件最大值]:等于要求资质的数码兽数量区间,在区间内则触发加成
  目标限定：属性加成赋予对象  回合数：属性加成持续的回合数 )
--]]
function BattleObject:influenceJudgeResultFor23( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
    local checkValue = tonumber(judgeResultArray[5])
	local needMinValue = tonumber(judgeResultArray[6])
	local needMaxValue = tonumber(judgeResultArray[7])
	local roundCount = tonumber(judgeResultArray[8])
	local skillCategory = tonumber(judgeResultArray[9])
    local buffRoundType = tonumber(judgeResultArray[10])
    local buffSuperpositionType = tonumber(judgeResultArray[11]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

    -- debug.print_r(judgeResultArray)

    local targetFormationObjects = nil
    if camp == 0 then
        targetFormationObjects = attackObjects
    else
        targetFormationObjects = byAttackObjects
    end

    local checkCount = 0
    for i, v in pairs(targetFormationObjects) do
        if nil ~= v and true ~= v.isDead and true ~= v.revived then
            if checkValue == v.fightObject.ability then
                checkCount = checkCount + 1
            end
        end
    end

    --> __crint("23号属性：", checkCount, needMinValue, needMaxValue, roundCount, propertyType, propertyValue)
	if needMinValue <= checkCount and checkCount <= needMaxValue then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
        --> __crint("目标数量：", #targets)
        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
24,属性类型,值,我方还是敌方或者双方,条件增加值（条件：12或6减场上数码兽数量）,值上限,回合数,技能类型；目标限定
（我方0,敌方1,双方2   条件增加值：满足条件时的增加值  最终值=基础值+条件增加值* 【12或6减场上数码兽数量】 单方为6 ,双方为12 ）
 值上限：最终值的上限   目标限定：属性加成赋予对象  回合数：属性加成持续的回合数 ）
--]]
function BattleObject:influenceJudgeResultFor24( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
	local propertyAddValue = tonumber(judgeResultArray[5])
	local upperLimitValue = tonumber(judgeResultArray[6])
	local roundCount = tonumber(judgeResultArray[7])
	local skillCategory = tonumber(judgeResultArray[8])
    local buffRoundType = tonumber(judgeResultArray[9])
    local buffSuperpositionType = tonumber(judgeResultArray[10]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	local targetFormationObjects = nil
    local subCount = 6
    if camp == 2 then
        targetFormationObjects = {}
        table.add(targetFormationObjects, attackObjects)
        table.add(targetFormationObjects, byAttackObjects)
        subCount = 12
	elseif camp == 0 then
		targetFormationObjects = attackObjects
	else
		targetFormationObjects = byAttackObjects
	end

	local checkCount = 0
	for i, v in pairs(targetFormationObjects) do
		if nil ~= v then
			checkCount = checkCount + 1
		end
	end

	propertyValue = propertyValue + propertyAddValue * (subCount - checkCount)
	if propertyValue >= upperLimitValue then
		propertyValue = upperLimitValue
	end

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
end

--[[
25，属性类型，值,自身血量最低值百分比，自身血量最高百分比,回合数，技能类型，切换波次是否清除，是否可叠加；目标限定;触发该结果的概率，每级概率成长值

最终概率 = 触发该结果的概率 + （技能等级-1）* 每级概率成长值 
（目标限定，buff赋予对象。     触发条件：自身血量处于[最低值，最高值]时     回合数：-1时表示即时生效 ）
--]]
function BattleObject:influenceJudgeResultFor25( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local needMinValue = tonumber(judgeResultArray[4])
	local needMaxValue = tonumber(judgeResultArray[5])
	local roundCount = tonumber(judgeResultArray[6])
	local skillCategory = tonumber(judgeResultArray[7])
    local buffRoundType = tonumber(judgeResultArray[8])
    local buffSuperpositionType = tonumber(judgeResultArray[9]) -- 是否可叠加：0不叠加   1叠加

    local canExecute = true
    if nil ~= judgeResultArrays[3] then
        local odds = tonumber(judgeResultArrays[3][1]) + tonumber(judgeResultArrays[3][2]) * talentJudgeResult.talentMould.level
        -- 改成0使self.ptvf62减伤必现
        if (math.random(1, 100) > odds) then
        -- if 0 > odds then
            canExecute = false
        end
    end

    print("判断25号天赋")
	
    if true == canExecute then
        print("触发了减伤")
    	-- self:addPropertyValue(propertyType, propertyValue)
    	local percentValue = self.healthPoint / self.healthMaxPoint
        if percentValue < 0 then
            percentValue = 0
        end

        -- 如果是青龙兽，并且减伤属性ptvf62大于0，则重置，就是减伤只能持续一次攻击
        if tonumber(self.shipMould) == 10 then
            self.ptvf62 = 0
        end

    	if needMinValue <= percentValue and percentValue <= needMaxValue then
    		local judgeResultTargetArray = judgeResultArrays[2]
    		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    		self:addPropertyValueForBuff(skillCategory, 
                roundCount,
                propertyType,
                propertyValue,
                percentValue,
                resultType,
                buffRoundType,
                buffSuperpositionType,
                judgeResultArray,
                targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
            )
    	end
    end
end

--[[
26, 自身减少当前生命值上限百分比,攻击的每个目标减少当前生命值上限百分比
26, 自身减少当前生命值上限百分比，攻击的每个目标减少当前生命值上限百分比，技能类型，对非玩家BOSS的伤害上限；当什么数码兽在场时（数码兽ID)；自身减少当前生命值上限百分比，攻击的每个目标减少当前生命值上限百分比，技能类型，对非玩家BOSS的伤害上限（仅首次生效）
（技能类型：0，用于掉血绘制    对非玩家BOSS的伤害上限：用该值乘以释放者的攻击力算出对非玩家BOSS的伤害上限）
--]]
function BattleObject:influenceJudgeResultFor26( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local percentValue1 = tonumber(judgeResultArray[2])
	local percentValue2 = tonumber(judgeResultArray[3])
    local skillCategory = tonumber(judgeResultArray[4])
    local attackerAttackPercent = tonumber(judgeResultArray[5])
	
	-- self:addPropertyValue(propertyType, propertyValue)

	-- attackObject:setHealthPoint(attackObject.healthPoint - percentValue1 * attackObject.healthMaxPoint)
	-- byAttackObject:setHealthPoint(byAttackObject.healthPoint - percentValue2 * byAttackObject.healthMaxPoint)

    -- pve战斗有效
    local skillInfluence = nil
    local finalDamage = -1
    if nil ~= attackObject.oneselfBattleSkill then
        for i, v in pairs(attackObject.oneselfBattleSkill) do
            if v.skillInfluence then
                local formulaInfo = v.formulaInfo
                if formulaInfo == FightUtil.FORMULA_INFO_SPECIAL_DAMAGE then
                    skillInfluence = v.skillInfluence
                    break
                end
            end
        end
    end

    if nil ~= skillInfluence then
        if 1 == attackObject.powerSkillUseCount then
            local targetFormationObjects = {}
            table.add(targetFormationObjects, attackObjects)
            table.add(targetFormationObjects, byAttackObjects)
            local ret = false
            for i, shipMould in pairs(judgeResultArrays[2]) do
                ret = false
                for _, v in pairs(targetFormationObjects) do
                    if nil ~= v 
                        and true ~= v.isDead 
                        and true ~= v.revived 
                        and tonumber(shipMould) == v.shipMould 
                        then
                        ret = true
                        break
                    end
                end
            end

            if true == ret then
                judgeResultArray = judgeResultArrays[3]
                resultType = tonumber(judgeResultArray[1])
                percentValue1 = tonumber(judgeResultArray[2])
                percentValue2 = tonumber(judgeResultArray[3])
                skillCategory = tonumber(judgeResultArray[4])
                attackerAttackPercent = tonumber(judgeResultArray[5])
            end
        end

        local P1 = (attackObject.attack - byAttackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63)) * attackerAttackPercent -- ①攻击力=   攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
        local P2 = byAttackObject.physicalDefence - byAttackObject.ptvf64 + byAttackObject.fightObject.physicalDefence * (byAttackObject.intellectAdditionalPercent - byAttackObject.ptvf68) -- ②防御力=   防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
        local P3 = attackObject.uniqueSkillDamagePercent
        local P4 = byAttackObject.uniqueSkillResistancePercent
        local P5 = attackObject.finalDamagePercent * (1 + attackObject.ptvf65)
                + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, resultBuffer, 33 )
        local P6 = byAttackObject.finalLessenDamagePercent
        local P7 = attackObject.ptvf55 -- + attackObject.fightObject.ptvf55 / 100
        local P8 = attackObject.ptvf56 -- + attackObject.fightObject.ptvf56 / 100
        local P9 = byAttackObject.ptvf73 -- + attackObject.fightObject.ptvf73 / 100

        local P13 = 0
        if (1 == attackObject.campPreference and 3 == byAttackObject.campPreference)
            or (2 == attackObject.campPreference and 1 == byAttackObject.campPreference)
            or (3 == attackObject.campPreference and 2 == byAttackObject.campPreference)
            then
            P13 = attackObject.ptvf70 + attackObject.fightObject.ptvf70
        end

        local P14 = 0
        if (1 == byAttackObject.campPreference and 3 == attackObject.campPreference)
            or (2 == byAttackObject.campPreference and 1 == attackObject.campPreference)
            or (3 == byAttackObject.campPreference and 2 == attackObject.campPreference)
            then
            P14 = byAttackObject.ptvf71 + byAttackObject.fightObject.ptvf71
        end

        local cia = P1 - P2
        local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
        if (P1 * FightModule.frA) > cia then
            -- （攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
            total = ( P1 * ( ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100 ) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue ) * FightModule.frA
        else
            -- （攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
            total = cia * (ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
        end

        local frF = math.random(FightModule.frF1, FightModule.frF2) / 100

        local ptvf54 = attackObject.ptvf54 + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, resultBuffer, 54 )

        finalDamage = total
            * math.max(FightModule.lvf, (1 + P5 - P6 + P7 - attackObject.ptvf66 - byAttackObject.ptvf62))
            * math.max(FightModule.lvf, (1 + P13 - P14 + ptvf54 + P8 - attackObject.ptvf57 + byAttackObject.ptvf60 - P9 + byAttackObject.ptvf74))
            * frF

        -- if attackObject.isCritical then
        --     -- -- 造成的最终伤害值 * （1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数C + 增加暴击伤害[58] - 减少暴击伤害[59]）
        --     -- finalDamage = finalDamage * (1 + FightModule.frB + attackObject.uniqueSkillDamagePercent * FightModule.frC + attackObject.ptvf58 - byAttackObject.ptvf59)

        --     -- 暴击伤害=    攻方造成的伤害值 * （1 + ( 暴击伤害系数B + 攻方暴击强度③ * 暴击强度系数C ）* （ 1 + 攻方增加暴击伤害[58] - 攻方减少暴击伤害[59]））
        --     finalDamage = finalDamage * (1 + (FightModule.frB + P3 * FightModule.frC) * (attackObject.ptvf58 - attackObject.ptvf59))
        -- end

        -- if byAttackObject.isRetain then
        --     -- -- 格挡伤害= 造成的最终伤害值 * （1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）
        --     -- finalDamage = finalDamage * (1 - FightModule.frD - byAttackObject.uniqueSkillResistancePercent * FightModule.frE)

        --     -- 格挡伤害=    造成的伤害值 *  max（下限值系数MIN ，（1 - 格挡伤害系数D - 防方格挡强度④ * 格挡强度系数E））
        --     finalDamage = finalDamage * math.max(FightModule.lvf, (1 - FightModule.frD - P4 * FightModule.frE))
        -- end

        finalDamage = math.floor(finalDamage)
    end

    local hv1 = percentValue1 * attackObject.healthPoint
    attackObject:setHealthPoint(attackObject.healthPoint - hv1)

    local hv2 = percentValue2 * byAttackObject.healthMaxPoint
    if finalDamage > 0 then
        if hv2 > finalDamage then
            hv2 = finalDamage
        end
    end
    byAttackObject:setHealthPoint(byAttackObject.healthPoint - hv2)

    self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, attackObject, battleSkill, skillCategory, 1, hv1, resultBuffer )
    self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, byAttackObject, battleSkill, skillCategory, 1, hv2, resultBuffer )
end

--[[
27, 属性类型，值，增加继承血量%，是否可叠加，回合数，技能类型，切换波次是否清除；目标限定
--]]
function BattleObject:influenceJudgeResultFor27( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
    local propertyType = tonumber(judgeResultArray[2])
    local propertyValue = tonumber(judgeResultArray[3])
	local propertyHpPercentValue = tonumber(judgeResultArray[4])
	-- local propertySpPercentValue = tonumber(judgeResultArray[3])
    local roundCount = tonumber(judgeResultArray[5])
    local skillCategory = tonumber(judgeResultArray[6])
    local buffRoundType = tonumber(judgeResultArray[7])
    local buffSuperpositionType = tonumber(judgeResultArray[8]) -- 是否可叠加：0不叠加   1叠加

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
end

--[[
28,属性类型1,值,敌方目标血量最低值百分比,敌方目标血量最高百分比,开始回合,BUFF持续回合数,技能类型；目标限定|属性类型1,值,敌方目标血量最低值百分比,敌方目标血量最高百分比,开始回合,BUFF持续回合数,技能类型；目标限定|···
（[敌方目标血量最低值百分比,敌方目标血量最高百分比]：敌方血量在此区间内属性加成生效    开始回合：单波次从此回合开始生效    目标限定：属性加成赋予对象  ）
--]]
function BattleObject:influenceJudgeResultFor28( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local needMinValue = tonumber(judgeResultArray[4])
	local needMaxValue = tonumber(judgeResultArray[5])
	local needStartRoundCount = tonumber(judgeResultArray[6])
	local roundCount = tonumber(judgeResultArray[7])
	local skillCategory = tonumber(judgeResultArray[8])
    local buffRoundType = tonumber(judgeResultArray[9])
    local buffSuperpositionType = tonumber(judgeResultArray[10]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	if fightModule.roundCount >= needStartRoundCount and nil ~= byAttackObject then
		local percentValue = byAttackObject.healthPoint / byAttackObject.healthMaxPoint
        -- --> __crint(percentValue, needMinValue, needMaxValue, byAttackObject.healthPoint, attackObject.healthMaxPoint)
		if needMinValue <= percentValue and percentValue <= needMaxValue then
			local judgeResultTargetArray = judgeResultArrays[2]
			local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
            -- --> __crint("生效的属性：", #targets, propertyType, propertyValue)
            self:addPropertyValueForBuff(skillCategory, 
                roundCount,
                propertyType,
                propertyValue,
                percentValue,
                resultType,
                buffRoundType,
                buffSuperpositionType,
                judgeResultArray,
                targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
            )
		end
	end
end

--[[
29,属性类型1,值,我方还是敌方或者双方,数码兽类型,条件最低值,条件最大值,回合数,技能类型；目标限定|属性类型2,值,我方还是敌方或者双方,数码兽类型,条件最低值,条件最大值,回合数,技能类型；目标限定|···
(数码兽类型：攻、防、技    [条件最低值,条件最大值]:符合类型的数码兽数量区间,在区间内则触发加成   目标限定：属性加成赋予对象  回合数：属性加成持续的回合数 )
--]]
function BattleObject:influenceJudgeResultFor29( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local camp = tonumber(judgeResultArray[4])
	local shipType = tonumber(judgeResultArray[5])
	local needMinValue = tonumber(judgeResultArray[6])
	local needMaxValue = tonumber(judgeResultArray[7])
	local roundCount = tonumber(judgeResultArray[8])
	local skillCategory = tonumber(judgeResultArray[9])
    local buffRoundType = tonumber(judgeResultArray[10])
    local buffSuperpositionType = tonumber(judgeResultArray[11]) -- 是否可叠加：0不叠加   1叠加
	
	-- self:addPropertyValue(propertyType, propertyValue)

	local targetFormationObjects = nil
	if camp == 0 then
		targetFormationObjects = attackObjects
	elseif camp == 1 then
		targetFormationObjects = byAttackObjects
	else
		targetFormationObjects = {}
		table.add(targetFormationObjects, attackObjects)
		table.add(targetFormationObjects, byAttackObjects)
	end

	local checkCount = 0
	for i, v in pairs(targetFormationObjects) do
		if nil ~= v and true ~= v.isDead and true ~= v.revived and v.campPreference == shipType then
			checkCount = checkCount + 1
		end
	end

	if needMinValue <= checkCount and checkCount <= needMaxValue then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
30,属性类型,值,怒气值对比,回合数,技能类型；目标限定
( 怒气值对比: 0自身怒气值大于等于攻击目标,1自身怒气值小于攻击目标     目标限定：属性加成赋予对象  回合数：属性加成持续的回合数 )
--]]
function BattleObject:influenceJudgeResultFor30( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local compareType = tonumber(judgeResultArray[4])
	local roundCount = tonumber(judgeResultArray[5])
	local skillCategory = tonumber(judgeResultArray[6])
    local buffRoundType = tonumber(judgeResultArray[7])
    local buffSuperpositionType = tonumber(judgeResultArray[8]) -- 是否可叠加：0不叠加   1叠加
	
	-- self:addPropertyValue(propertyType, propertyValue)

	local checkResult = false
	if compareType == 0 then
		if attackObject.skillPoint >= byAttackObject.skillPoint then
			checkResult = true
		end
	else
		if attackObject.skillPoint < byAttackObject.skillPoint then
			checkResult = true
		end
	end

	if true == checkResult then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
31,属性类型,值,怒气值百分比最小值,怒气值百分比最大值,回合数,技能类型；目标限定
( 怒气值对比: 0自身怒气值大于等于攻击目标,1自身怒气值小于攻击目标     目标限定：属性加成赋予对象  回合数：属性加成持续的回合数 )
--]]
function BattleObject:influenceJudgeResultFor31( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local needMinValue = tonumber(judgeResultArray[4])
	local needMaxValue = tonumber(judgeResultArray[5])
	local roundCount = tonumber(judgeResultArray[6])
	local skillCategory = tonumber(judgeResultArray[7])
    local buffRoundType = tonumber(judgeResultArray[8])
    local buffSuperpositionType = tonumber(judgeResultArray[9]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	local percentValue = byAttackObject.skillPoint / FightModule.MAX_SP
    --> __crint("当前sp百分比：", percentValue, needMinValue, needMaxValue)
	if needMinValue <= percentValue and percentValue <= needMaxValue then
        --> __crint("校验成功")
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
32,属性类型1,值,属性值增加或者减少,属性变化值,自身血量百分比变化梯度,属性值上限,回合数,技能类型；目标限定|属性类型2,值,属性值增加或者减少,属性变化值,血量百分比增加或减少,自身血量百分比变化梯度,属性值上限,回合数,技能类型；目标限定|···
( 属性值增加或者减少：0增加,1减少      血量百分比增加或减少：0增加,1减少      自身血量百分比变化梯度：百分比变化基础值（例：每减少1%生命值的1%即为变化梯度）
  属性变化值:每变化1个梯度属性的变化值（每减少1%生命值增加5%攻击,5%即为属性变化值 ）   
  属性值上限：属性值加成最大值     最终加成值 = 值 + 变化值 * int(自身血量变化值  /血量百分比变化梯度）
  目标限定：属性加成赋予对象  回合数：属性加成持续的回合数 )
--]]
function BattleObject:influenceJudgeResultFor32( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local propertyChangeType = tonumber(judgeResultArray[4])
	local propertyChangeValue = tonumber(judgeResultArray[5])
	local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	local roundCount = tonumber(judgeResultArray[8])
	local skillCategory = tonumber(judgeResultArray[9])
    local buffRoundType = tonumber(judgeResultArray[10])
    local buffSuperpositionType = tonumber(judgeResultArray[11]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

    --> __crint("属性类型32属性")

    -- debug.print_r(judgeResultArray)

    local flag = 1
    if propertyChangeType == 1 then
        flag = -1
    end

	propertyValue = propertyValue + flag * propertyChangeValue * math.floor((self.healthMaxPoint - self.healthPoint) / self.healthMaxPoint / propertyChangeGradientValue)

    if flag < 0 then
        propertyValue = math.max(propertyValue, propertyChangeUpperLimit)
    else
        propertyValue = math.min(propertyValue, propertyChangeUpperLimit)
    end

    --> __crint(propertyValue, propertyChangeValue, flag, self.healthPoint, self.healthMaxPoint, propertyChangeGradientValue)

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
end

--[[
33,属性类型1,值,单波次回合数,buff持续回合数,技能类型；目标限定|33,属性类型2,值,单波次回合数,buff持续回合数,技能类型；目标限定|···
( 单波次回合数：在此回合开始时获得buff加成   目标限定：属性加成赋予对象  buff持续回合数：属性加成持续的回合数 ) ）
--]]
function BattleObject:influenceJudgeResultFor33( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local needStartRoundCount = tonumber(judgeResultArray[4])
	local roundCount = tonumber(judgeResultArray[5])
	local skillCategory = tonumber(judgeResultArray[6])
    local buffRoundType = tonumber(judgeResultArray[7])
    local buffSuperpositionType = tonumber(judgeResultArray[8]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	if fightModule.roundCount >= needStartRoundCount then
		local judgeResultTargetArray = judgeResultArrays[2]
		local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
	end
end

--[[
34,单波次回合数,触发的技能效用ID,需替换技能效用ID；第几个字段,增加或者减少,变化值；第几个字段,增加或者减少,变化值；···
( 单波次回合数：在此回合触发替换     触发的技能效用ID:达到回合后触发,填-1时不触发效用     
  需替换技能效用ID技能效用ID：进行替换的技能效用ID    增加或者减少：0增加 1减少   ）
--]]
function BattleObject:influenceJudgeResultFor34( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	-- local propertyType = tonumber(judgeResultArray[2])
	-- local propertyValue = tonumber(judgeResultArray[3])
	-- local propertyChangeType = tonumber(judgeResultArray[4])
	-- local propertyChangeValue = tonumber(judgeResultArray[5])
	-- local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	-- local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	-- local roundCount = tonumber(judgeResultArray[8])
	-- local skillCategory = tonumber(judgeResultArray[9])
    local needStartRoundCount = tonumber(judgeResultArray[2])
    local needCheckinfluenceId = tonumber(judgeResultArray[3])
    local changeInfluenceId = tonumber(judgeResultArray[4])

	-- self:addPropertyValue(propertyType, propertyValue)

    if (fightModule.roundCount == needStartRoundCount or needStartRoundCount < 0)
        and (needCheckinfluenceId == -1 or needCheckinfluenceId == battleSkill.skillInfluence.id)
        then
    	local pos = 2
    	while (judgeResultArrays[pos]) do
    		for i, v in pairs(attackObject.commonBattleSkill) do
    			if v.skillInfluence.id == changeInfluenceId then
                    v.skillInfluence:setPropertyValue(tonumber(judgeResultArrays[pos][1]), tonumber(judgeResultArrays[pos][3]), tonumber(judgeResultArrays[pos][2]))
    			end
    		end

    		for i, v in pairs(attackObject.oneselfBattleSkill) do
                if v.skillInfluence.id == changeInfluenceId then
                    v.skillInfluence:setPropertyValue(tonumber(judgeResultArrays[pos][1]), judgeResultArrays[pos][3], tonumber(judgeResultArrays[pos][2]))
                end
    		end

    		for i, v in pairs(attackObject.normalBattleSkill) do
                if v.skillInfluence.id == changeInfluenceId then
                    v.skillInfluence:setPropertyValue(tonumber(judgeResultArrays[pos][1]), judgeResultArrays[pos][3], tonumber(judgeResultArrays[pos][2]))
                end
    		end
            pos = pos + 1
    	end
    end
end

--[[
35,单波次回合数,回复的怒气值,清除自身的减益buff1,清除自身的减益buff2···
( 单波次回合数：在此回合触发替换      清除自身的减益buff：清除的buff对应技能类型 ）
--]]
function BattleObject:influenceJudgeResultFor35( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local roundCount = tonumber(judgeResultArray[2])
	local propertySpAddValue = tonumber(judgeResultArray[3])

	-- self:addPropertyValue(propertyType, propertyValue)
	local pos = 4
	while (judgeResultArray[pos]) do
		pos = pos + 1
	end
end

--[[
-- 36,自身复活后血量%,继承死前怒气%,复活概率%,复活后触发的技能效用ID,复活后替换技能效用ID；第几个字段,增加或者减少,变化值；第几个字段,增加或者减少,变化值；···
36,自身复活后血量%，继承死前怒气%，复活概率%，复活后触发的技能效用ID，复活后替换技能效用ID；第几个字段，增加或者减少，变化值；第几个字段，增加或者减少，变化值；···
（复活后触发的技能效用ID:达到回合后触发,填-1时不触发效用     
  复活后替换技能效用ID：进行替换的技能效用ID    增加或者减少：0增加 1减少   ）
--]]
function BattleObject:influenceJudgeResultFor36( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyHpPercentValue = tonumber(judgeResultArray[3])
    local propertySpPercentValue = tonumber(judgeResultArray[4])
    local propertyRevivedOdds = tonumber(judgeResultArray[5])
    -- local propertyRrevivedPro

	local propertyChangeType = tonumber(judgeResultArray[4])
	local propertyChangeValue = tonumber(judgeResultArray[5])
	local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	local roundCount = tonumber(judgeResultArray[8])
	local skillCategory = tonumber(judgeResultArray[9])

	-- self:addPropertyValue(propertyType, propertyValue)


end

--[[
37,单数回合触发技能效用ID,双数回合触发技能效用ID:目标限定1：目标限定2
--]]
function BattleObject:influenceJudgeResultFor37( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	-- local propertyType = tonumber(judgeResultArray[2])
	-- local propertyValue = tonumber(judgeResultArray[3])
	-- local propertyChangeType = tonumber(judgeResultArray[4])
	-- local propertyChangeValue = tonumber(judgeResultArray[5])
	-- local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	-- local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	-- local roundCount = tonumber(judgeResultArray[8])
	-- local skillCategory = tonumber(judgeResultArray[9])

	-- self:addPropertyValue(propertyType, propertyValue)

    local skillInfluenceId1 = tonumber(judgeResultArray[2])
    local skillInfluenceId2 = tonumber(judgeResultArray[3])

    local skillInfluenceId = skillInfluenceId1
    local targetCheckPos = 2
    if attackObject.powerSkillUseCount % 2 == 0 then
        skillInfluenceId = skillInfluenceId2
        targetCheckPos = 3
    end

    local judgeResultTargetArray = judgeResultArrays[targetCheckPos]
    local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
    if #targets > 0 then
        local nextSkillInfluenceInstance = ConfigDB.load("skill_influence", skillInfluenceId)
        for i, target in pairs(targets) do
            battleSkill:executeNextSkillInfluence(attackObject, target, userInfo, fightModule, resultBuffer, nextSkillInfluenceInstance)
        end
    end
end

--[[
-- 38,自身复活后血量%,继承死前怒气%,复活概率%,此效用复活次数限制,复活需求我方数码兽ship_mould的ID
38,自身复活后血量%，继承死前怒气%，复活概率%，此效用复活次数限制，复活需求我方数码兽ship_mould的ID
（此效用复活次数限制：此效用复活次数限制，其他复活效用不受影响              复活需求我方数码兽ship_mould的ID：我方场上存在此数码兽时才触发
--]]
function BattleObject:influenceJudgeResultFor38( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
    local resultType = tonumber(judgeResultArray[1])
    local propertyHpPercentValue = tonumber(judgeResultArray[2])
    local propertySpPercentValue = tonumber(judgeResultArray[3])
    local reviveOddsValue = tonumber(judgeResultArray[4])
    local reviveCountLimit = tonumber(judgeResultArray[5])
    local shipMould = tonumber(judgeResultArray[6])

    local checkResult = 0
    for i, v in pairs(byAttackCoordinates) do
        if v.shipMould == shipMould then
            checkResult = 1
            break
        end
    end

    if 1 == checkResult then
        byAttackObject:setHealthPoint(byAttackObject.healthMaxPoint * propertyHpPercentValue)
        byAttackObject:setSkillPoint(byAttackObject.skillPoint * propertyHpPercentValue)
        byAttackObject.isDead = false
        byAttackObject.unload = false
        byAttackObject.revived = true
        byAttackObject.reviveCount = byAttackObject.reviveCount + 1

        if (byAttackObject.battleTag == 0) then
            fightModule.attackCount = fightModule.attackCount - 1
        else
            fightModule.byAttackCount = fightModule.byAttackCount - 1
        end
    end

    -- local judgeResultArray = judgeResultArrays[1]
	-- local resultType = tonumber(judgeResultArray[1])
	-- local propertyType = tonumber(judgeResultArray[2])
	-- local propertyValue = tonumber(judgeResultArray[3])
	-- local propertyChangeType = tonumber(judgeResultArray[4])
	-- local propertyChangeValue = tonumber(judgeResultArray[5])
	-- local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	-- local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	-- local roundCount = tonumber(judgeResultArray[8])
	-- local skillCategory = tonumber(judgeResultArray[9])

	-- -- self:addPropertyValue(propertyType, propertyValue)

end

--[[
39,属性类型1，值，回合数，技能类型，切换波次是否清除，是否可叠加；目标限定
--]]
function BattleObject:influenceJudgeResultFor39( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
    local roundCount = tonumber(judgeResultArray[4])
    local skillCategory = tonumber(judgeResultArray[5])
    local buffRoundType = tonumber(judgeResultArray[6])
    local buffSuperpositionType = tonumber(judgeResultArray[7]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
end

--[[
40,我方剩余人数，对方剩余人数，人数满足时替换技能效用ID1；第几个字段，增加或者减少，变化值；第几个字段，增加或者减少，变化值；···

(我方剩余人数，对方剩余人数: 填-1时表示无人数要求,人数匹配时触发)
--]]
function BattleObject:influenceJudgeResultFor40( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
    -- local attackerAliveRoleCount = tonumber(judgeResultArray[2])
    -- local defenderAliveRoleCount = tonumber(judgeResultArray[3])
    -- local reviveOddsValue = tonumber(judgeResultArray[4])
    -- local influenceId1 = tonumber(judgeResultArray[5])
    -- local influenceId2 = tonumber(judgeResultArray[6])
    local needAttackerCount = tonumber(judgeResultArray[2])
    local needDefenderCount = tonumber(judgeResultArray[3])
    local changeInfluenceId = tonumber(judgeResultArray[4])

    -- self:addPropertyValue(propertyType, propertyValue)

    local checkAttackerCount = 0
    for i, v in pairs(attackObjects) do
        if nil ~= v and true ~= v.isDead and true ~= v.revived then
            checkAttackerCount = checkAttackerCount + 1
        end
    end

    local checkDefenderCount = 0
    for i, v in pairs(byAttackObjects) do
        if nil ~= v and true ~= v.isDead and true ~= v.revived then
            checkDefenderCount = checkDefenderCount + 1
        end
    end

    if (checkAttackerCount == needAttackerCount or -1 == needAttackerCount)
        and (checkDefenderCount == needDefenderCount or -1 == needDefenderCount)
        then
        local pos = 2
        while (judgeResultArrays[pos]) do
            for i, v in pairs(attackObject.commonBattleSkill) do
                if v.skillInfluence.id == changeInfluenceId then
                    v.skillInfluence:setPropertyValue(tonumber(judgeResultArrays[pos][1]), tonumber(judgeResultArrays[pos][3]), tonumber(judgeResultArrays[pos][2]))
                end
            end

            for i, v in pairs(attackObject.oneselfBattleSkill) do
                if v.skillInfluence.id == changeInfluenceId then
                    v.skillInfluence:setPropertyValue(tonumber(judgeResultArrays[pos][1]), judgeResultArrays[pos][3], tonumber(judgeResultArrays[pos][2]))
                end
            end

            for i, v in pairs(attackObject.normalBattleSkill) do
                if v.skillInfluence.id == changeInfluenceId then
                    v.skillInfluence:setPropertyValue(tonumber(judgeResultArrays[pos][1]), judgeResultArrays[pos][3], tonumber(judgeResultArrays[pos][2]))
                end
            end
            pos = pos + 1
        end
    end
end

--[[
41,属性类型，值，被嘲讽的敌方数量增加值, 嘲讽的技能类型，回合数，技能类型，切换波次是否清除，是否可叠加；目标限定
( 最终加成值 = 值  + 增加值* 被嘲讽的敌方数量 )
--]]
function BattleObject:influenceJudgeResultFor41( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local bySneerPropertyAddValue = tonumber(judgeResultArray[4])
    local bySneerSkillCategory = tonumber(judgeResultArray[5])
	local roundCount = tonumber(judgeResultArray[6])
	local skillCategory = tonumber(judgeResultArray[7])
    local buffRoundType = tonumber(judgeResultArray[8])
    local buffSuperpositionType = tonumber(judgeResultArray[9]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

    local bySneerCount = 0
    for i, v in pairs(byAttackObjects) do
        for idx,  fightBuff in pairs(v.buffEffect)  do     
            local skillInfluence = fightBuff.skillInfluence
            if skillInfluence.skillCategory == bySneerSkillCategory then
                bySneerCount = bySneerCount + 1
            end
        end
    end

    propertyValue = propertyValue + bySneerCount * bySneerPropertyAddValue

	local judgeResultTargetArray = judgeResultArrays[2]
	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

    self:addPropertyValueForBuff(skillCategory, 
            roundCount,
            propertyType,
            propertyValue,
            percentValue,
            resultType,
            buffRoundType,
            buffSuperpositionType,
            judgeResultArray,
            targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
        )
end

--[[
42,属性类型1,值,可叠加次数,值上限,回合数,技能类型；目标限定|属性类型2,值,可叠加次数,值上限,回合数,技能类型；目标限定|···
--]]
function BattleObject:influenceJudgeResultFor42( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local additionCountLimit = tonumber(judgeResultArray[4])
	local propertyValueUpperLimit = tonumber(judgeResultArray[5])
	local roundCount = tonumber(judgeResultArray[6])
	local skillCategory = tonumber(judgeResultArray[7])
    local buffRoundType = tonumber(judgeResultArray[8])
    local buffSuperpositionType = tonumber(judgeResultArray[9]) -- 是否可叠加：0不叠加   1叠加

	-- self:addPropertyValue(propertyType, propertyValue)

    local haveCount = 0
    for idx, fightBuff in pairs(attackObject.buffEffect) do
        if fightBuff.skillInfluence.skillCategory == skillCategory then
            haveCount = haveCount + 1
        end
    end

    if haveCount < additionCountLimit then
    	local judgeResultTargetArray = judgeResultArrays[2]
    	local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )

        self:addPropertyValueForBuff(skillCategory, 
                roundCount,
                propertyType,
                propertyValue,
                percentValue,
                resultType,
                buffRoundType,
                buffSuperpositionType,
                judgeResultArray,
                targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
            )

        -- for i, v in pairs(targets) do
        --     local ret = v:getPropertyValue(propertyType)
        --     if ret > propertyValueUpperLimit then
        --         v:setPropertyValue(propertyType, propertyValueUpperLimit)
        --     end
        -- end
    end
end

--[[
43，触发技能效用ID，技能效用每场战斗触发次数上限，自身血量百分比界限，血量变化时触发概率增加基础值，自身血量百分比变化梯度

( 最终触发概率 = 技能效用模板触发概率字段 + 血量变化时触发概率增加基础值 * int（（自身血量百分比界限 - 当前剩余血量百分比）/ 自身血量百分比变化梯度 )
  自身血量百分比界限：自身血量低于界限时触发技能效用 )
--]]
function BattleObject:influenceJudgeResultFor43( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	-- local propertyType = tonumber(judgeResultArray[2])
	-- local propertyValue = tonumber(judgeResultArray[3])
	-- local propertyChangeType = tonumber(judgeResultArray[4])
	-- local propertyChangeValue = tonumber(judgeResultArray[5])
	-- local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	-- local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	-- local roundCount = tonumber(judgeResultArray[8])
	-- local skillCategory = tonumber(judgeResultArray[9])
    local skillInfluenceId = tonumber(judgeResultArray[2])

	-- self:addPropertyValue(propertyType, propertyValue)

    battleSkill._srs = battleSkill._srs or {}
    local tCount = battleSkill._srs[judgeResultArray[2]] or 0

    if tCount < tonumber(judgeResultArray[3]) then
        tCount = tCount + 1
        battleSkill._srs[judgeResultArray[2]] = tCount

        local judgeResultTargetArray = judgeResultArrays[2]
        local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
        if #targets > 0 then
            local nextSkillInfluenceInstance = ConfigDB.load("skill_influence", skillInfluenceId)
            nextSkillInfluenceInstance.additionEffectProbability = math.floor(nextSkillInfluenceInstance.additionEffectProbability + tonumber(judgeResultArray[5])
                + math.floor((tonumber(judgeResultArray[4]) - attackObject.healthPoint / attackObject.healthMaxPoint) / tonumber(judgeResultArray[6])))

            for i, target in pairs(targets) do
                battleSkill:executeNextSkillInfluence(attackObject, target, userInfo, fightModule, resultBuffer, nextSkillInfluenceInstance)
            end
        end
    end
end

--[[
44,需求我方数码兽ship_mould的ID,释放必杀技次数,必杀技扣除自身血量,目标扣除血量百分比增加值
--]]
function BattleObject:influenceJudgeResultFor44( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
	local judgeResultArray = judgeResultArrays[1]
	local resultType = tonumber(judgeResultArray[1])
	local propertyType = tonumber(judgeResultArray[2])
	local propertyValue = tonumber(judgeResultArray[3])
	local propertyChangeType = tonumber(judgeResultArray[4])
	local propertyChangeValue = tonumber(judgeResultArray[5])
	local propertyChangeGradientValue = tonumber(judgeResultArray[6])
	local propertyChangeUpperLimit = tonumber(judgeResultArray[7])
	local roundCount = tonumber(judgeResultArray[8])
	local skillCategory = tonumber(judgeResultArray[9])

	-- self:addPropertyValue(propertyType, propertyValue)
end

--[[
45，属性类型，值，斗魂等级成长值
( 最终加成值 = 值 + （斗魂等级-1）* 斗魂等级成长值   )
--]]
function BattleObject:influenceJudgeResultFor45( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    local judgeResultArray = judgeResultArrays[1]
    local resultType = tonumber(judgeResultArray[1])
    local propertyType = tonumber(judgeResultArray[2])
    local propertyValue = tonumber(judgeResultArray[3])
    local propertyGrowValue = tonumber(judgeResultArray[4])
    local skillCategory = tonumber(judgeResultArray[5])
    local isDisplay = tonumber(judgeResultArray[6]) or 0
    
    local level = talentJudgeResult.talentMould.level
    if nil ~= judgeResultArrays[2] and judgeResultArrays[2][1] == "1" then
        -- level = battleSkill.skillInfluence.level
        level = talentJudgeResult.talentMould.level
    end
    propertyValue = propertyValue + (level - 1) * propertyGrowValue 
    if nil ~= talentJudgeResult._owner then
        local hp = talentJudgeResult._owner.healthMaxPoint
        talentJudgeResult._owner:addPropertyValue(propertyType, propertyValue)
        if (skillCategory == 19) then
            propertyValue = talentJudgeResult._owner.healthMaxPoint - hp
        end
        self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, talentJudgeResult._owner, battleSkill, skillCategory, isDisplay, propertyValue, resultBuffer )
    else
        byAttackObject:addPropertyValue(propertyType, propertyValue)
        self:writeInfluenceJudgeResult( fightModule, userInfo, attackObject, byAttackObject, battleSkill, skillCategory, isDisplay, propertyValue, resultBuffer )
    end
    --> __crint("斗魂添加属性：", talentJudgeResult.talentMould.id, skillCategory, propertyType, judgeResultArray[3], propertyGrowValue, propertyValue)
end

--[[
46特殊怒气回复
46,普攻或小技能额外回复怒气值，击杀回复怒气，扣血回复怒气，是否可叠加
（击杀回复怒气：1 回复，0 不回复       扣血回复怒气：1 回复 ， 0不回复          是否可叠加：1可叠加，0不可叠加）
--]]
function BattleObject:influenceJudgeResultFor46( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    local judgeResultArray = judgeResultArrays[1]
    local resultType = tonumber(judgeResultArray[1])
    local attackAdditionSpValue = tonumber(judgeResultArray[2])
    local killTargetAddSp = tonumber(judgeResultArray[3])
    local byAttackDamageAddSp = tonumber(judgeResultArray[4])

    self.attackAdditionSpValue = attackAdditionSpValue
    self.killTargetAddSp = killTargetAddSp
    self.byAttackDamageAddSp = byAttackDamageAddSp
end

--[[
47免疫控制
--]]
function BattleObject:influenceJudgeResultFor47( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    self.buffNegativeImmunityStatus = true
    --> __crint("开启：免疫控制", self.battleTag, self.coordinate)
end

--[[
48;添加条件;天赋数据;目标限定|49;添加条件;天赋数据;目标限定
索引  条件作用    格式  
0   无条件判断   0   
1   判断所在回合数 1，最低生效回合要求，最高回合生效要求 
2   判断目标的怒气值    2，是否为百分比，最低生效怒气要求，最高生效怒气要求 （0：百分比 1：绝对值）    

索引  值得作用    格式  
0   赋予天赋    0，天赋ID  
1   属性加成（索引1）   1，属性类型，值   

e.g:
48;1,1,2;0!0,1958;11,0|48;1,3,10;0!0,1959;11,0
48;2,0,0,0.6;0!1,33,0.4;3,0|48;2,0,0,0.6;0!1,66,0.1;3,0


48 添加条件 天赋数据 目标限定
条件
    条件类型1  0
        属性值
            判断条件
            相等 0,1,2,
            >
            <
            >=
    条件类型2
        属性值
            判断条件

48,0,76,4,400

天赋数据
    类型
        直接加属性
        赋予天赋id
        。。。

        结果


        79
        80（
            条件序列
                判断类型

         值  
            类型 数值
         ）


（小技能)为己方后排数码兽增加致命效果2回合（当敌方目标生命值大于50%时，伤害加成8%）；若自己上场大于3回合，为己方后排增加斩杀效果2回合（当敌方生命小于50%时，伤害加成8%）  （被动）驱散自身的减益效果


,|;

添加条件
    :,

48;添加条件;天赋数据;目标限定|49;添加条件;天赋数据;目标限定

添加条件(0,2,1,0,50:0,2,1,1,500000)
结果数据（发动条件!结果值(:,) （0 id 1 76, 10））
--]]
function BattleObject:influenceJudgeResultFor48( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer, talentJudgeResultCell )
    local judgeResultArray = judgeResultArrays[1]
    local resultType = tonumber(judgeResultArray[1])

    local talentJudgeResultItems = zstring.split(talentJudgeResultCell, ";")
    local judgeResultTargetConditions = zstring.splits(talentJudgeResultItems[2], ":", ",")
    local judgeResultTargetResultInfos = zstring.split(talentJudgeResultItems[3], "!")
    local judgeResultTargetResultValues = {zstring.splits(judgeResultTargetResultInfos[1], ":", ","), zstring.splits(judgeResultTargetResultInfos[2], ":", ",")}
    
    local judgeResultTargetArray = judgeResultArrays[4]
    local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
    
    -- debug.print_r(judgeResultTargetConditions)

    if #targets > 0 then
        for i, target in pairs(targets) do
            local conditionResult = self:influenceJudgeResultCheckConditions( fightModule, userInfo, attackObject, target, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetConditions, resultBuffer )
            if true == conditionResult then
                table.insert(target.additionInfluenceJudgeResult, judgeResultTargetResultValues)
                conditionResult = target:influenceJudgeResultCheckConditions( fightModule, userInfo, attackObject, target, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetResultValues[1], resultBuffer )
                if true == conditionResult then
                    for m, n in pairs(judgeResultTargetResultValues[2]) do
                        if n[1] == "0" then
                            local needAdd = true
                            local tId = tonumber(n[2])
                            for j, k in pairs(target.fightObject.talentMouldList) do
                                if k.id == tId then
                                    needAdd = false
                                    break
                                end
                            end
                            if true == needAdd then
                                local element = dms.element(dms["talent_mould"], n[2])
                                local talentMould = TalentMould:new()
                                talentMould:init(element)
                                table.insert(target.talentMouldList, talentMould)
                                table.insert(target.fightObject.talentMouldList, talentMould)
                                --> __crint("给天赋了", n[2])
                            end
                        end
                    end
                end
                --> __crint("给目标增加了属性")
                -- debug.print_r(judgeResultTargetResultValues)
            end
        end
    end
end

--[[
49无敌状态
49，触发血量条件最低值，触发血量条件最高值，触发原始几率，几率增加或减少，几率变化值，自身血量百分比变化梯度，几率上限，回合数，技能类型，切换波次是否清除，是否可叠加；目标限定
最终触发几率=触发原始几率+（触发血量条件最高值（百分比）-自身剩余血量百分比）/自身血量百分比变化梯度*几率变化值
几率增加或减少：0，增加；1，减少
无敌状态：免疫一切伤害和debuff
--]]
function BattleObject:influenceJudgeResultFor49( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, talentJudgeResult, judgeResultArrays, resultBuffer )
    local judgeResultArray = judgeResultArrays[1]
    local resultType = tonumber(judgeResultArray[1])
    local needHpMinValue = tonumber(judgeResultArray[2]) -- 触发血量条件最低值
    local needHpMaxValue = tonumber(judgeResultArray[3]) -- 触发血量条件最高值
    local baseOddsValue = tonumber(judgeResultArray[4]) -- 触发原始几率
    local executeType = tonumber(judgeResultArray[5]) -- 几率增加或减少
    local oddsValue = tonumber(judgeResultArray[6]) -- 几率变化值
    local hpHValue = tonumber(judgeResultArray[7]) -- 自身血量百分比变化梯度
    local oddsValieLimit = tonumber(judgeResultArray[8]) -- 几率上限
    local roundCount = tonumber(judgeResultArray[9])    -- 回合数
    local skillCategory = tonumber(judgeResultArray[10]) -- 技能类型
    local buffRoundType = tonumber(judgeResultArray[11]) -- 切换波次是否清除
    local buffSuperpositionType = tonumber(judgeResultArray[12]) -- 是否可叠加：0不叠加   1叠加

    if true == attackObject._open_isNoDamage then
        return
    end

    local hpPercent = attackObject.healthPoint / attackObject.healthMaxPoint
    if needHpMinValue <= hpPercent and hpPercent <= needHpMaxValue then
        local flag = 1
        if executeType == 1 then
            flag = -1
        end

        local oddsResultValue = math.min(oddsValieLimit, baseOddsValue + (flag) * (needHpMaxValue - hpPercent) / hpHValue * oddsValue)
        if (oddsResultValue >= math.random(1, 100)) then
            local judgeResultTargetArray = judgeResultArrays[2]
            local targets = self:influenceJudgeResultCheckTargets( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, judgeResultTargetArray, resultBuffer )
            
            if #targets > 0 then
                attackObject._open_isNoDamage = true
                for i, target in pairs(targets) do
                    target.isNoDamage = true
                end
                local propertyType = -1
                local propertyValue = 0
                local percentValue = 0
                self:addPropertyValueForBuff(skillCategory, 
                    roundCount,
                    propertyType,
                    propertyValue,
                    percentValue,
                    resultType,
                    buffRoundType,
                    buffSuperpositionType,
                    judgeResultArray,
                    targets, fightModule, userInfo, attackObject, battleSkill, resultBuffer
                )
            end
        end
    end
end

local obj = BattleObject:new()
