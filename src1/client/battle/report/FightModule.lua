app.load("client.battle.report.ConfigDB")
app.load("client.battle.report.BattleCache")
app.load("client.battle.report.FightObject")
app.load("client.battle.report.IniUtil")
app.load("client.battle.report.BattleObject")
app.load("client.battle.report.TalentSkill")
app.load("client.battle.report.TalentUniteSkill")
app.load("client.battle.report.TalentAura")
app.load("client.battle.report.TalentConstant")
app.load("client.battle.report.TalentImmunity")
app.load("client.battle.report.TalentJudge")
app.load("client.battle.report.TalentJudgeResult")
app.load("client.battle.report.TalentMould")
app.load("client.battle.report.FormationInfo")

-- 战斗模块
-- @author xiaofeng
FightModule = class("FightModule")
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_NORMAL =  0
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_ELIT =  1
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_MONEY_TREE =  2
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_TREASURE_EXPERIENCE =  3
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_PANDA_EXPERIENCE =  4
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_WORLD_BOSS =  5
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_TRANS_TOWER =  6
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_COUNTERPART =  7
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_BATTLEGROUND =  8
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_GREAT_SOLDIER =  9
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_DAILY_INSTANCE =  101
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_THREE_KING =  102
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_MANOR =  103
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVE_REBELARMY =  104
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_GREAT_SOLDIER_B =  105
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_GRAB =  10
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_ARENA =  11
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_DUEL =  12
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_UNIO =  13
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_RESOURCE_MINE =  14
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_SPIRITE_PALACE =  15
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_PVP_CROSS_SERVER =  16
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_51 =  51
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_TYPE_52 =  52
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_RESULT_CONTINUE =  1
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_RESULT_WIN =  1
-- 战斗模块
-- @author xiaofeng
FightModule.FIGHT_RESULT_LOST =  0

if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
	-- 5	【数码宝贝】出手怒气值，击杀奖励怒气值，每波奖励怒气值，怒气上限值	5	200,200,150,1050
	local fightParams = zstring.split(dms.string(dms["fight_config"], 5 ,user_config.param),",")
	FightModule.ATTACK_SP_ADD_VAULE = tonumber(fightParams[1])
	FightModule.KILL_TARGET_SP_ADD_VAULE = tonumber(fightParams[2])
	FightModule.CHANGE_NEXT_FIGHT_SP_ADD_VAULE = tonumber(fightParams[3])
	FightModule.MAX_SP = tonumber(fightParams[4])

	-- 6	【数码宝贝】伤害公式系数A	6	0.1
	-- 7	【数码宝贝】伤害公式系数B	7	0.5
	-- 8	【数码宝贝】伤害公式系数C	8	1
	-- 9	【数码宝贝】伤害公式系数D	9	0.3
	-- 10	【数码宝贝】伤害公式系数E	10	1
	-- 11	【数码宝贝】伤害公式系数F	11	0.95,1.05
	FightModule.frA = dms.float(dms["fight_config"], 6 ,user_config.param)
	FightModule.frB = dms.float(dms["fight_config"], 7 ,user_config.param)
	FightModule.frC = dms.float(dms["fight_config"], 8 ,user_config.param)
	FightModule.frD = dms.float(dms["fight_config"], 9 ,user_config.param)
	FightModule.frE = dms.float(dms["fight_config"], 10 ,user_config.param)
	fightParams = zstring.split(dms.string(dms["fight_config"], 11 ,user_config.param),",")
	FightModule.frF1 = tonumber(fightParams[1])
	FightModule.frF2 = tonumber(fightParams[2])
	FightModule.lvf = dms.float(dms["fight_config"], 19 ,user_config.param)
	FightModule.nsrs = zstring.split(dms.string(dms["fight_config"], 20 ,user_config.param), ",", function ( value ) return tonumber(value) end)

	local fight_module_frf_change_terminal = {
	    _name = "fight_module_frf_change",
	    _init = function (terminal)
	        
	    end,
	    _inited = false,
	    _instance = self,
	    _state = 0,
	    _invoke = function(terminal, instance, params)
	    	if params == 0 then
	    		local fightParams = zstring.split(dms.string(dms["fight_config"], 11 ,user_config.param),",")
		        FightModule.frF1 = tonumber(fightParams[1])
				FightModule.frF2 = tonumber(fightParams[2])
			else
				FightModule.frF1 = 100
				FightModule.frF2 = 100
			end
			-- state_machine.excute("fight_module_frf_change", 0, 1) 将战斗公式随机参数设置成百分百
			-- state_machine.excute("fight_module_frf_change", 0, 0) 还原
	        return false
	    end,
	    _terminal = nil,
	    _terminals = nil
	}

	state_machine.add(fight_module_frf_change_terminal)
	state_machine.init()

	__fight_debug_skill_influence_type_info = {
		["-1"] = "无",
		["0"] = "攻击",
		["1"] = "加血",
		["2"] = "加怒",
		["3"] = "减怒",
		["4"] = "封怒（无法积累怒气）老项目废弃",
		["5"] = "眩晕（无法行动）",
		["6"] = "腐蚀（中毒）老项目废弃",
		["7"] = "麻痹（无法行动）",
		["8"] = "沉默（无法怒气攻击）",
		["9"] = "燃烧",
		["10"] = "集中（老项目废弃）",
		["11"] = "格挡",
		["12"] = "无敌",
		["13"] = "必闪（老项目废弃）",
		["14"] = "吸血（老项目废弃）",
		["15"] = "封疗（老项目废弃）",
		["16"] = "盲目（老项目废弃）",
		["17"] = "冰冻（无法行动）",
		["18"] = "备用",
		["19"] = "备用",
		["20"] = "无绘制",
		["21"] = "增加攻击",
		["22"] = "降低攻击",
		["23"] = "增加防御",
		["24"] = "降低防御",
		["25"] = "受到的伤害增加（老项目废弃）",
		["26"] = "受到的伤害降低",
		["27"] = "增加暴击",
		["28"] = "增加抗暴",
		["29"] = "增加命中（老项目废弃）",
		["30"] = "增加闪避（老项目废弃）",
		["31"] = "持续回血（老项目废弃）",
		["32"] = "清除减益BUFF(清除技能类型5,7,8,9,17,22,24,36,39,47,48,50,51,55,56,61,66,67,69的效用)",
		["33"] = "造成伤害增加（老项目废弃）",
		["34"] = "全体秒杀（老项目废弃）",
		["35"] = "固定伤害（老项目废弃）",
		["36"] = "降低治疗效果(对应公式63）",
		["37"] = "溅射",
		["38"] = "增加格挡强度",
		["39"] = "降低格挡率",
		["40"] = "增加吸血率",
		["41"] = "--",
		["42"] = "小技能触发概率",
		["43"] = "增加破格挡率",
		["44"] = "增加反弹率",
		["45"] = "增加伤害减免",
		["46"] = "废弃",
		["47"] = "降低小技能触发概率",
		["48"] = "降低暴击伤害",
		["49"] = "减少造成的必杀伤害",
		["50"] = "嘲讽",
		["51"] = "降低伤害加成",
		["52"] = "增加伤害加成",
		["53"] = "增加控制率",
		["54"] = "增加造成的必杀伤害",
		["55"] = "减少必杀伤害率",
		["56"] = "降低怒气回复速度",
		["57"] = "提高怒气回复速度",
		["58"] = "增加暴击伤害",
		["59"] = "--",
		["60"] = "增加暴击强度",
		["61"] = "降低伤害减免",
		["62"] = "增加必杀伤害率",
		["63"] = "增加格挡率",
		["64"] = "增加数码兽类型克制伤害加成",
		["65"] = "增加数码兽类型克制伤害减免",
		["66"] = "降低暴击率",
		["67"] = "降低抗暴率",
		["68"] = "增加必杀抗性",
		["69"] = "减少必杀抗性",
		["70"] = "复活概率",
		["71"] = "复活继承血量",
		["72"] = "复活继承怒气",
		["73"] = "增加复活复活概率",
		["74"] = "增加复活继承血量",
		["75"] = "被复活概率",
		["76"] = "被复活继承血量",
		["77"] = "被复活继承怒气",
		["78"] = "免疫控制",
		["79"] = "复活",
		["80"] = "小技能伤害提升（绘制类型）",
	}
	__fight_debug_talent_type_info = {
		["12"] = "降低对方的值，并将总和加给自己",
		["13"] = "加给自己一个值，并将值分摊给敌方减去，自动平摊",
		["16"] = "特定数码兽在场造成的属性加成",
		["17"] = "小技能释放次数影响的属性加成",
		["18"] = "数码兽某种斗魂属性的数量造成的属性加成，斗魂未激活也会计算（带有自身成长属性）",
		["19"] = "场上人数造成的属性加成",
		["20"] = "数码兽某种斗魂属性的数量造成的属性加成，斗魂未激活也会计算",
		["21"] = "数码兽斗魂种类造成的属性加成",
		["23"] = "数码兽某种资质的数量造成的属性增加",
		["24"] = "人越少造成的属性加成",
		["25"] = "自身血量造成的属性加成",
		["26"] = "自杀性袭击（伤害上限计算方法：攻击力*0.45，技术尚未做处理）",
		["28"] = "敌方血量和绝对回合数造成的属性加成",
		["29"] = "场上某种数码兽类型的数量造成的属性加成",
		["30"] = "与自身怒气值对比（高或低）造成的属性加成",
		["32"] = "失血百分比每梯度造成的属性加成",
		["33"] = "单波次内根据回合数造成的属性加成",
		["34"] = "单波次回合数满足时更改技能效用中的任一参数值（单波次需要清除）",
		["36"] = "复活时更改技能效用中的任一参数值（永久替换）",
		["37"] = "必杀技释放单双回合触发不同技能效用",
		["39"] = "普通属性加成（无条件触发，切场可不清除）",
		["40"] = "根据敌我双方人数修改技能效用中的任一参数值",
		["41"] = "根据敌方某个BUFF状态的人数造成的属性加成",
		["42"] = "属性叠加处理（有上限处理，切场可不清除）",
		["43"] = "根据自身血量触发技能效用（可控制触发次数，可控制触发概率）",
		["45"] = "斗魂和技能升级专用，回怒和竞技场血量，属性值得成长",
		["46"] = "副本npc专用回怒",
		["47"] = "副本 npc免疫控制",
		["48"] = "给其他的数码兽赋予天赋",
		["49"] = "无敌状态",
	}
	__fight_debug_property_type_info = {
		["-1"] = "无",
		["0"] = "生命",
		["1"] = "攻击",
		["2"] = "物防",
		["3"] = "魔防",
		["4"] = "生命",
		["5"] = "攻击",
		["6"] = "物防",
		["7"] = "魔防",
		["8"] = "暴击率",
		["9"] = "抗暴率",
		["10"] = "格挡率",
		["11"] = "破击率",
		["12"] = "命中率",
		["13"] = "闪避率",
		["14"] = "物理免伤",
		["15"] = "魔法免伤",
		["16"] = "治疗率",
		["17"] = "被治疗率",
		["18"] = "最终伤害",
		["19"] = "最终减伤",
		["20"] = "初始怒气",
		["21"] = "体质",
		["22"] = "力量",
		["23"] = "灵力",
		["24"] = "物理攻击",
		["25"] = "额外伤害",
		["26"] = "治疗值",
		["27"] = "被治疗值",
		["28"] = "灼烧伤害",
		["29"] = "中毒伤害",
		["30"] = "灼伤免伤",
		["31"] = "中毒免伤",
		["32"] = "经验",
		["33"] = "伤害加成",
		["34"] = "伤害减免",
		["35"] = "PVP终伤",
		["36"] = "PVP免伤",
		["37"] = "初始合击点数",
		["38"] = "每次出手增加的怒气",
		["39"] = "灼烧伤害%",
		["40"] = "吸血率%",
		["41"] = "怒气",
		["42"] = "反弹率%",
		["43"] = "暴击强度%(暴伤加成）",
		["44"] = "免控率%",
		["45"] = "小技能触发概率%",
		["46"] = "格挡强度%",
		["47"] = "控制率%",
		["48"] = "--(治疗效果%,废弃）",
		["49"] = "--(暴击强化%,废弃）",
		["50"] = "--(数码兽类型克制伤害%,废弃）",
		["51"] = "--(溅射伤害%,废弃）",
		["52"] = "--(技能伤害%,废弃）",
		["53"] = "被治疗率减少%",
		["54"] = "伤害提升%",
		["55"] = "必杀伤害率%",
		["56"] = "增加造成的必杀伤害%",
		["57"] = "减少造成的必杀伤害%",
		["58"] = "增加暴击伤害%",
		["59"] = "减少暴击伤害%",
		["60"] = "受到的必杀伤害增加%",
		["61"] = "怒气回复速度%",
		["62"] = "受到直接伤害降低%",
		["63"] = "降低攻击(%)",
		["64"] = "降低防御",
		["65"] = "伤害加成百分比提升%",
		["66"] = "降低必杀伤害率%",
		["67"] = "--(降低伤害减免百分比%,废弃）",
		["68"] = "降低防御（%）",
		["69"] = "降低怒气回复速度%",
		["70"] = "数码兽类型克制伤害加成%",
		["71"] = "数码兽类型克制伤害减免%",
		["72"] = "降低攻击",
		["73"] = "增加必杀抗性%",
		["74"] = "减少必杀抗性%",
		["75"] = "降低免控率%",
		["76"] = "复活概率%",
		["77"] = "被复活概率%",
		["78"] = "复活继承血量%",
		["79"] = "复活继承怒气%",
		["80"] = "被复活继承血量%",
		["81"] = "被复活继承怒气%",
		["82"] = "增加复活概率%",
		["83"] = "增加复活继承血量%",
		["84"] = "小技能伤害提升",
	}
	__fight_debug_execute_time_type_info = {
		["0"] = "被击时判断",
		["1"] = "攻击时判断",
		["2"] = "自身死亡时判断",
		["3"] = "自己击杀对手时判断",
		["4"] = "判断敌方行动后",
		["5"] = "判断我方行动后",
		["6"] = "每波次开战前判定",
		["7"] = "友军阵亡时判定",
		["8"] = "入场时判定",
		["9"] = "回合开始时判定",
		["10"] = "出手前判定",
		["11"] = "对手死亡时判断",
		["12"] = "发动攻击前",
	}
	__fight_debug_formula_type_info = {
		["1"] = "普通攻击",
		["2"] = "怒气攻击",
		["3"] = "加血(以释放者攻击力计算）",
		["4"] = "加怒",
		["5"] = "减怒",
		["6"] = "禁怒（脱力）",
		["7"] = "眩晕（无法行动）",
		["8"] = "中毒（侵蚀）",
		["9"] = "灼烧",
		["10"] = "爆裂（集中）",
		["11"] = "麻痹（无法行动）",
		["12"] = "沉默（短路）",
		["13"] = "增加格挡",
		["14"] = "无敌（铁壁）",
		["15"] = "必闪",
		["16"] = "吸血",
		["17"] = "封疗",
		["18"] = "盲目",
		["19"] = "冰冻（无法行动）",
		["20"] = "备用",
		["21"] = "增加攻击",
		["22"] = "降低攻击",
		["23"] = "增加防御",
		["24"] = "降低防御",
		["25"] = "受到的伤害增加",
		["26"] = "受到的伤害降低",
		["27"] = "增加暴击",
		["28"] = "增加抗暴",
		["29"] = "增加命中",
		["30"] = "增加闪避",
		["31"] = "持续回血",
		["32"] = "清除BUFF",
		["33"] = "造成伤害增加",
		["34"] = "必杀",
		["35"] = "固定伤害",
		["36"] = "--(老项目废弃)",
		["37"] = "溅射",
		["38"] = "增加格挡强度",
		["39"] = "降低格挡率",
		["40"] = "小技能攻击",
		["41"] = "--",
		["42"] = "小技能触发概率",
		["43"] = "灼烧（目标生命值上限,灼烧伤害值上限自身攻击力40%）",
		["44"] = "增加破格挡率",
		["45"] = "增加反弹率",
		["46"] = "回血（以目标最大生命值计算）",
		["47"] = "增加伤害减免",
		["48"] = "废弃",
		["49"] = "降低小技能触发概率",
		["50"] = "降低暴击伤害",
		["51"] = "减少必杀伤害",
		["52"] = "嘲讽",
		["53"] = "加血（以目标已损失生命值计算）",
		["54"] = "加血（以目标剩余生命值计算）",
		["55"] = "降低伤害加成",
		["56"] = "增加伤害加成",
		["57"] = "增加控制率",
		["58"] = "增加必杀伤害",
		["59"] = "减少必杀伤害率",
		["60"] = "降低怒气回复速度",
		["61"] = "提高怒气回复速度",
		["62"] = "增加暴击伤害",
		["63"] = "降低治疗效果",
		["64"] = "增加暴击强度",
		["65"] = "降低伤害减免",
		["66"] = "增加必杀伤害率",
		["67"] = "增加格挡率",
		["68"] = "增加数码兽类型克制伤害加成",
		["69"] = "增加数码兽类型克制伤害减免",
		["70"] = "降低暴击率",
		["71"] = "降低抗暴率",
		["72"] = "增加必杀抗性",
		["73"] = "减少必杀抗性",
		["74"] = "增加吸血率",
	}
else
	FightModule.MAX_SP = 4
end

function FightModule:ctor()

    --战斗中的攻击者对象数组
	self.attackObjects = {}

	--缓存数据对象
	self.attackTempObjects = {}
	
    --战斗中的被攻者对象数组
	self.byAttackObjects = {}
	
    --战斗类型
	self.fightType = FightModule.FIGHT_TYPE_PVE_NORMAL

    --回合计数
	self.roundCount = 1

    --出战人数
	self.shipCount = 0

    --死亡人数
	self.deathCount = 0

    --战斗结果
    self.fightResult =  0

    --剩余血量
	self.surplusHealth = 0

    --总血量
    self.totalHealth =  0

    --用户承受伤害= 总血量-剩余血量
	self.totalAttackDamage = 0

    --NPC承受伤害 = 总血量-剩余
	self.totalDefenceDamage = 0

    self.npcMaxHealth =  0

    self.fakeLevel =  1

    self.isFake =  false

    self.worldBossDamageAdditional =  0

    self.attackDamages =  ""

    self.defenceDamages =  ""

    self.attackDeadState =  ""

    self.defenceDeadState =  ""

    self.fighters =  {}

    self.userThreeKingdomsInfo =  nil

    --日常副本回合数
    self.dailyRoundCount =  0
	
	self.totalRound = 10

    --叛军信息
    self.userRebelArmy =  nil

    --是否加倍
    --1 普通 2加倍
    self.isDouble =  false

    --额外加成血量
    self.addHpoint =  0

    --额外加成攻击
    self.addAttack =  0

    --合体技能
    --检查死亡人数和剩余血量
    --检查NPC所受伤害
    self.fitBuffer =  nil
	
	self.attackCount = 0
	self.byAttackCount = 0
	self.headBuffer = nil
	self.bodyBuffer = nil
	self.buffBuffer = nil

	self.fitBattleSkillCount = 0
	-- self.fitHeadBuffer = nil
	-- self.fitBodyBuffer = nil
	self.fitSelfBuffer = nil
	self.talentSelfTailBuffer = nil--自身回合结束天赋数据
	
	self.counterBuffer = nil
	self.battleSkillCount = 0
	self.battleSkillBuffer = nil
	self.tanlentSkillBuffer = nil
	
	self.fightOrderList = {}	--定义出手对象列表	table 顺序取出
	
	self.currentObject = nil 	-- 定义当前出手对象
	
	self.nextFightObject = nil   -- 定义下一个出手对象
	
	self.hasNextRound = true	--是否有下一场战斗
	
	self.greadCount = 0 	--评分计数
	
	self.star = 0		--星数
	
	self.gradeAttack = 0 	--伤害加成
	

	self.canFreeSkill = false   		--评分加成

	self.rewardProp = {}	--掉落道具
	self.rewardEquipment = {}	--掉落装备
	
	self.rewardCard = {}	--掉落卡牌

	self.maxZolSkillPoint = 4		--合体怒气点数上限

	self.battleTag = 0	--默认我方出手

	-- 攻击方的战队信息
	self.attackerFormationInfo = nil

	-- 防守方的战队信息
	self.defenderFormationInfo = nil
end

function FightModule:setDouble(type)
	self.isDouble = type == 2
end

function FightModule:isFake()
	return isFake
end

function FightModule:setFake(isFake)
	self.isFake = isFake
end

function FightModule:initNewBattleField(npcId,fightType)
	--清空战斗缓存
	_ED.user_info.battleCache = nil

	local resultBuffer = {}

	--初始化NPC 战斗缓存
	local npc = ConfigDB.load("npc",npcId)
	local battleCache = BattleCache:new()


	battleCache.userInfo = _ED.user_info
	battleCache.battleType = fightType
	battleCache.byAttackerId = npc.id
	battleCache.currentBattleCount  = 0
	battleCache.maxBattleCount = npc.formationCount
	local attackObjects = {}
	local seatIndex = {environment_formation.seat_one, environment_formation.seat_two, environment_formation.seat_three,environment_formation.seat_four, environment_formation.seat_five, environment_formation.seat_six}
	local tempRookieCache = _ED.user_info.rookieCache
	local seatArray = {}
	if(tonumber(fightType) == 1)then
		for idx, val in pairs(seatIndex) do
			seatArray[#seatArray + 1] = dms.int(dms["environment_formation"], eveNpc, val)
		end	
		for idx, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= val) then
				local fightObject = FightObject:new()
				fightObject:initWithNpc(npc, difficulty, idx, #attackObjects+1, self.fakeLevel, self.isFake)
				fightObject.battleTag = 0
				-- attackObjects[idx] = fightObject
				table.insert(attackObjects,fightObject)
				if(fightObject.shipMould > 0) then
					local shipMould = ConfigDB.load('ship_mould', self.shipMould)
					--ShipMould)Transformers.shipMouldDAOProxy().load(this.shipMould);
					--shipMould:init(dms.element(dms[''], self.shipMould))
					self.zoarium = shipMould.zoariumSkill;
					----_crint ("Id is: " .. shipMould.id)
						--小兵模板
					local forceMould = dms.element(dms["ship_force_mould"], 1)
					local forceCount = dms.atos(forceMould,ship_force_mould.force_count)
					-- _crint("小兵模板",forceCount)
					for i=1,forceCount do
						local forceFightObject = self:fightObject(forceMould,userId)
						forceFightObject.coordinate = #attackObjects+1
						 table.insert(attackObjects,forceFightObject)
						 table.insert(fightObject.forceArray,forceFightObject)					end
				end
			end
		end
		battleCache.attackCombatForce = dms.int(dms["environment_formation"], eveNpc, environment_formation.combat_force)
	else
		seatArray = {}
		for idx = 1, 6 do
			seatArray[idx] = self.fightType == 15 and _ED.em_user_ship[idx] or _ED.formetion[idx + 1]
			if (tonumber(seatArray[idx]) > 0) then
				if( _ED.user_ship[ seatArray[idx] ] ~= nil) then
					local userShip = _ED.user_ship[seatArray[idx]]
					local fightObject = FightObject:new()
					fightObject:initWithUserData(#attackObjects+1, userShip, 0, _ED.user_info.user_id)
					-- attackObjects[idx] = fightObject
					table.insert(attackObjects,fightObject)
					--小兵模板
					local forceMould = dms.element(dms["ship_force_mould"], 1)
					local forceCount = dms.atos(forceMould,ship_force_mould.force_count)
					for i=1,forceCount do
						local forceFightObject = self:fightObject(forceMould,userId)
						 -- table.insert(self.forceArray, forceFightObject)
						 forceFightObject.coordinate=#attackObjects+1
						 table.insert(attackObjects,forceFightObject)
						 table.insert(fightObject.forceArray,forceFightObject)					end
				else
					attackObjects[idx] = nil
				end
			else
				attackObjects[idx] = nil
			end
		end
		battleCache.attackCombatForce = _ED.user_info.fight_capacity
	end
	
	battleCache.attackName = _ED.user_info.user_name
	battleCache.attackerObjects = attackObjects
	local byAttackerObjectsList = {}
	for i = 1, npc.formationCount do
		local byAttackObjects = {}
		local formationId = npc:getEnvironmentFormation(i)
		local environmentFormation = ConfigDB.load("environment_formation", formationId)
		seatArray = {}
		for idx, val in pairs(seatIndex) do
			local shipId = dms.int(dms["environment_formation"], formationId, val)
			seatArray[#seatArray + 1] = shipId
		end
		
		local amplifyPercentString = dms.string(dms["environment_formation"], formationId, environment_formation.amplify_percentage)
		local amplifyPercentArray = zstring.split(amplifyPercentString, ",")
		 
		for j, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= tonumber(val)) then
				local fightObject = FightObject:new()
				fightObject:initWithNpc(npc, difficulty, #byAttackObjects+1, seatArray[j], self.fakeLevel, self.isFake)
				fightObject.amplifyPercent = amplifyPercentArray[j]
				fightObject.name = environmentFormation.formationName
				-- byAttackObjects[j] = fightObject
				table.insert(byAttackObjects,fightObject)
				--小兵模板
				local forceMould = dms.element(dms["ship_force_mould"], 1)
				local forceCount = dms.atos(forceMould,ship_force_mould.force_count)
				for i=1,forceCount do
					local forceFightObject = self:fightObject(forceMould,userId)
					 -- table.insert(self.forceArray, forceFightObject)
					 forceFightObject.coordinate = #byAttackObjects+1
					 table.insert(attackObjects,forceFightObject)
					 table.insert(fightObject.forceArray,forceFightObject)				end
			end
		end
		battleCache.byAttackComobatForce = environmentFormation.combatForce
		table.insert(byAttackerObjectsList, byAttackObjects)
	end
	battleCache.byAttackName = npc.npcName
	battleCache.byAttackerObjectsList = byAttackerObjectsList
	_ED.user_info.battleCache = battleCache
	-- self:writeBattleFieldInit(battleCache,  0,  1, resultBuffer)
	-- local temp ="战场初始化\r\n"
	-- for k = 1, #resultBuffer do
	-- 	temp = temp..resultBuffer[k]
	-- end
	-- _crint(temp)
	-- self:initNewBattleInfo()
end

function FightModule:initNewBattleInfo()
	local battleCache = _ED.user_info.battleCache
	if battleCache == nil then
		return
	end
	local attackObjects = battleCache.attackerObjects
	battleCache.currentBattleCount = battleCache.currentBattleCount + 1
	local byAttackObjects = battleCache.byAttackerObjectsList[battleCache.currentBattleCount]
	--for (local i = 0; i < attackObjects.length; i++) {
	local attackObject = nil
	local byAttackObject = nil
	for i, atkObj in pairs(attackObjects) do
		if(nil ~= attackObjects[i]) then
			local battleObject = BattleObject:new()
			battleObject:initWithAttackObject(attackObjects[i])
			self.attackObjects[i] = battleObject
			-- self.shipCount = self.shipCount + 1
			-- self.totalHealth = self.totalHealth + battleObject.healthMaxPoint
			attackObject = battleObject
		end		
	end
	--for (local i = 0; i < byAttackObjects.length; i++) {
	for i, atkObj in pairs(byAttackObjects) do
		if(nil ~= byAttackObjects[i])then
			local battleObject = BattleObject:new()
			battleObject:initWithAttackObject(byAttackObjects[i])
			self.byAttackObjects[i] = battleObject
			-- self.npcMaxHealth = self.npcMaxHealth + battleObject.healthMaxPoint
			byAttackObject = battleObject
		end
	end

	self:calculateTalentUnite(self.attackObjects, self.byAttackObjects)

	-- if(battleCache.battleType == FightModule.FIGHT_TYPE_PVE_MONEY_TREE) then
	-- 	self.fightType = FightModule.FIGHT_TYPE_PVE_MONEY_TREE
	-- 	self.totalRound = 5
	-- end
	-- if(battleCache.battleType == FightModule.FIGHT_TYPE_PVE_REBELARMY) then
	-- 	self.fightType = FightModule.FIGHT_TYPE_PVE_REBELARMY
	-- 	self.totalRound = 5
	-- end
	-- if(battleCache.battleType == FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
	-- 	self.totalRound = self.dailyRoundCount
	-- end
	
	self:fightByAttackObject(attackObject,byAttackObject)
end

--指定A角色攻击B角色
function FightModule:fightByAttackObject(battleObject,byBattleObject)
	--只要有一个人死亡就不处理攻击逻辑
	if battleObject.isDead == true or byBattleObject.isDead == true then
		return
	end
	local resultBuffer = {}
	table.insert(resultBuffer, battleObject.battleTag)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleObject.coordinate)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, 0)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, 0)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, 0)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleObject.commonSkillMould.id)
	table.insert(resultBuffer, IniUtil.compart)
	battleObject:processUserBuffEffect(userInfo, self, resultBuffer)
	local battleSkillList = battleObject.oneselfBattleSkill
	local skillBuffer = {}
	self.battleSkillCount = 0
	for _, battleSkill in pairs(battleSkillList) do
		battleSkill.formulaInfo = battleSkill.skillInfluence.formulaInfo
		battleSkill:processOneAttack(userInfo,battleObject, byBattleObject, self, skillBuffer)
	end
	table.insert(resultBuffer, self.battleSkillCount)
	table.insert(resultBuffer, IniUtil.compart)
	IniUtil.concatTable(resultBuffer, skillBuffer)
	-- local temp ="战斗数据\r\n"
	-- for k = 1, #resultBuffer do
	-- 	temp = temp..resultBuffer[k]
	-- end
	-- _crint(temp)
end


--[[
--   attackUser 包含了服务器传过来的数据  attackUser.fightForce  为 战力, attackUser.fightObjects 为战斗对象, nickname 为昵称
]]---

function FightModule:initBattleField(npc, difficulty, fightType, resultBuffer,eveNpc, write)
	if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        if (fightType == FightModule.FIGHT_TYPE_PVP_COUNTERPART) then
			self.union_pve_attribute_bonus = zstring.tonumber(_ED.union_pve_attribute_bonus) / 100
		end
		self.union_pve_attribute_bonus = self.union_pve_attribute_bonus or 0
    end

	self.fightType = fightType
	local battleCache = BattleCache:new()
	battleCache.userInfo =  _ED.user_info
	battleCache.battleType = fightType
	battleCache.byAttackerId = npc.id
	battleCache.maxBattleCount = npc.formationCount
	battleCache.difficulty = difficulty
	local attackObjects = {}
	local seatIndex = {environment_formation.seat_one, environment_formation.seat_two, environment_formation.seat_three,
		environment_formation.seat_four, environment_formation.seat_five, environment_formation.seat_six}
	local tempRookieCache = _ED.user_info.rookieCache
	local seatArray = {}
	
	
	if(tonumber(fightType) == 1)then
		
		for idx, val in pairs(seatIndex) do
			seatArray[#seatArray + 1] = dms.int(dms["environment_formation"], eveNpc, val)
		end	
		

		local amplifyPercentString = dms.string(dms["environment_formation"], eveNpc, environment_formation.amplify_percentage)
		local amplifyPercentArray = zstring.split(amplifyPercentString, IniUtil.comma)

		for idx, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= val) then
				local fightObject = FightObject:new()
				fightObject:initWithNpc(npc, difficulty, idx, seatArray[idx], self.fakeLevel, self.isFake)
				fightObject.amplifyPercent = amplifyPercentArray[idx]
				fightObject.battleTag = 0
				attackObjects[idx] = fightObject
			end
		end

		battleCache.attackCombatForce = dms.int(dms["environment_formation"], eveNpc, environment_formation.combat_force)
	else
		-- 此处本来应该从 服务器传过来, 本地保存的数据取的, 目前写死. 本人是知道 相关数据的
		--local formation = UserDB.findByUserAndIndex(attackUser.id,  1)
		--seatArray = new Integer[]{formation.seatOne, formation.seatTwo, formation.seatThree, formation.seatFour, formation.seatFive, formation.seatSix}
		seatArray = {}
		battleCache.attackerSpeedValue = 0
		for idx = 1, 6 do
			seatArray[idx] = self.fightType == 15 and _ED.em_user_ship[idx] or _ED.formetion[idx + 1]
			--_crint ("idx .. ": " .. seatArray[idx])
			if (tonumber(seatArray[idx]) > 0) then
				if( _ED.user_ship[ seatArray[idx] ] ~= nil) then
					local fightObject = FightObject:new()
					fightObject:initWithUserData(idx, _ED.user_ship[seatArray[idx]], 0, _ED.user_info.user_id)
					fightObject.attack = fightObject.attack * (1 + self.union_pve_attribute_bonus)
					fightObject.physicalDefence = fightObject.physicalDefence * (1 + self.union_pve_attribute_bonus)
					fightObject.skillPoint = fightObject.skillPoint * (1 + self.union_pve_attribute_bonus)
					attackObjects[idx] = fightObject
					
					battleCache.attackerSpeedValue = battleCache.attackerSpeedValue + fightObject.attackSpeed
				else
					attackObjects[idx] = nil
					--_crint ("Ship not found in user_ship: " .. seatArray[idx])
				end
				--local fightObject = FightObject:new()
				--attackObjects[idx] = fightObject:initWithUserData(_ED)
			else
				--_crint("Set to nil: " .. tonumber(seatArray[idx]))
				attackObjects[idx] = nil
			end
		end
		
		battleCache.attackCombatForce = _ED.user_info.fight_capacity
		if fightType == _enum_fight_type._fight_type_211 then
		else
			if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				local isVerity = true
				if isVerity == true and _ED.old_speed_sum ~= nil then
					local old_speed_sum = aeslua.decrypt("jar-world", _ED.old_speed_sum, aeslua.AES128, aeslua.ECBMODE)
					if tonumber(old_speed_sum) ~= tonumber(_ED.user_info.speed_sum) then
						isVerity = false
						_ED.user_info.speed_sum = old_speed_sum
					end
				end
			end
			battleCache.attackerSpeedValue = _ED.user_info.speed_sum
		end
	end
	--_crint ("Attack object seat array info: " .. #attackObjects)
	--crint_lua_table(_ED.formetion)
	--_crint ("End print _ED.formetion")
	--crint_lua_table(seatArray)
	for _, attackObject in pairs(attackObjects) do
		if (attackObject ~= nil) then
			--_crint ("Pos " .. _  .. " id: " ..attackObject.id)
		else
			--_crint ("Pos " .. _  .. " is nil")
		end
	end
	
	battleCache.attackName = _ED.user_info.user_name
	battleCache.attackerObjects = attackObjects
	local byAttackerObjectsList = {}
	--_crint ("npc.formationCount = ".. npc.formationCount)
	for i = 1, npc.formationCount do
		local byAttackObjects = {}
		local formationId = npc:getEnvironmentFormation(i)

		--_crint ("loading formation, id: " .. formationId .. "   npc: " .. npc.id)
		local environmentFormation = ConfigDB.load("environment_formation", formationId)
		--EnvironmentFormation:new()
		--environmentFormation:init(dms.element(dms["environment_formation"], formationId))
		
		seatArray = {}
		for idx, val in pairs(seatIndex) do
			local shipId = dms.int(dms["environment_formation"], formationId, val)
			seatArray[#seatArray + 1] = shipId
			-- _crint ("NPC shipId" , i, idx, shipId)
		end
		
		local amplifyPercentString = dms.string(dms["environment_formation"], formationId, environment_formation.amplify_percentage)
		local amplifyPercentArray = zstring.split(amplifyPercentString, IniUtil.comma)
		 
		for j, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= tonumber(val)) then
				local fightObject = FightObject:new() --(npc, difficulty, j + 1, seatArray[j], fakeLevel, isFake)
				--_crint("Calling: ", j, seatArray[j], self.fakeLevel, self.isFake)
				fightObject:initWithNpc(npc, difficulty, j, seatArray[j], self.fakeLevel, self.isFake)
				fightObject.amplifyPercent = amplifyPercentArray[j]
				fightObject.attackSpeed = environmentFormation.fightBg
				if fightObject.signType <= 0 then
					-- fightObject.name = environmentFormation.formationName
					-- fightObject.picIndex = environmentFormation.picIndex
				end
				byAttackObjects[j] = fightObject
			end
		end

		battleCache.byAttackComobatForce = environmentFormation.combatForce
		
		--_crint ("ByAttack object seat array info: ")
		--crint_lua_table(seatArray)
		for _, attackObject in pairs(byAttackObjects) do
			if (attackObject ~= nil) then
				--_crint(_, attackObject.id)
				----crint_lua_table (attackObject)
			else
				--_crint ("Pos " .. _  .. " is nil")
			end
		end
	
		table.insert(byAttackerObjectsList, byAttackObjects)
	end
	
	
	
	battleCache.byAttackName = npc.npcName
	-- if (true) then
	-- _crint ("战场初始化：",#byAttackerObjectsList)
	-- end
	
	battleCache.byAttackerObjectsList = byAttackerObjectsList
	_ED.user_info.battleCache = battleCache
	
	----_crint("Dump battleCache info")

	battleCache.attacker_priority = battleCache.attackerSpeedValue
	battleCache.defender_priority = 0
	battleCache.attacker_name = _ED.user_info.user_name
	battleCache.defender_name = battleCache.byAttackName
	battleCache.attacker_head_pic = 0
	battleCache.defender_head_pic = 0
	
	if false ~= write then
		self:writeBattleFieldInit(battleCache,  0,  1, resultBuffer)
	end
	--writeFashionEquipmentInit(attackUser, nil, resultBuffer)
	-- self:initFightOrder(_ED.user_info,resultBuffer)

	-- -- 初始化战前的部队全局属性
	-- for i, v in pairs(attackObjects) do
	-- 	v:addPropertyByTalentInfluencePriorValueResults(attackObjects, nil, 0, battleCache, self)
	-- end

	-- for _, l in pairs(byAttackerObjectsList) do
	-- 	for i, v in pairs(l) do
	-- 		-- v:addPropertyByTalentInfluencePriorValueResults(l, nil, 0, battleCache, self)
	-- 	end
	-- end
end

--数码净化
function FightModule:initPurifyBattleField(npc, difficulty, fightType, resultBuffer,eveNpc, write)
	self.fightType = fightType
	local battleCache = BattleCache:new()
	battleCache.userInfo =  _ED.user_info
	battleCache.battleType = fightType
	battleCache.byAttackerId = npc.id
	battleCache.maxBattleCount = npc.formationCount
	battleCache.difficulty = difficulty
	local attackObjects = {}
	local seatIndex = {environment_formation.seat_one, environment_formation.seat_two, environment_formation.seat_three,
		environment_formation.seat_four, environment_formation.seat_five, environment_formation.seat_six}
	local tempRookieCache = _ED.user_info.rookieCache
	local seatArray = {}
	
	
	if(tonumber(fightType) == 1)then
		
		for idx, val in pairs(seatIndex) do
			seatArray[#seatArray + 1] = dms.int(dms["environment_formation"], eveNpc, val)
		end	
		

		for idx, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= val) then
				local fightObject = FightObject:new()
				fightObject:initWithNpc(npc, difficulty, idx, seatArray[idx], self.fakeLevel, self.isFake)
				fightObject.battleTag = 0
				attackObjects[idx] = fightObject
			end
		end

		battleCache.attackCombatForce = dms.int(dms["environment_formation"], eveNpc, environment_formation.combat_force)
	else
		seatArray = {}
		battleCache.attackerSpeedValue = 0
		for idx = 1, 6 do
			seatArray[idx] = _ED.purify_user_ship[idx]
			if (seatArray[idx] ~= nil) then
				if( _ED.purify_user_ship[idx] ~= nil) then
					local fightObject = FightObject:new()
					fightObject:initWithUserData(idx, _ED.purify_user_ship[idx], 0, _ED.user_info.user_id)
					attackObjects[idx] = fightObject
					battleCache.attackerSpeedValue = battleCache.attackerSpeedValue + fightObject.attackSpeed
				else
					attackObjects[idx] = nil
				end
			else
				attackObjects[idx] = nil
			end
		end
		
		battleCache.attackCombatForce = _ED.user_info.fight_capacity
		if fightType == _enum_fight_type._fight_type_211 then
		else
			if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				local isVerity = true
				if isVerity == true and _ED.old_speed_sum ~= nil then
					local old_speed_sum = aeslua.decrypt("jar-world", _ED.old_speed_sum, aeslua.AES128, aeslua.ECBMODE)
					if tonumber(old_speed_sum) ~= tonumber(_ED.user_info.speed_sum) then
						isVerity = false
						_ED.user_info.speed_sum = old_speed_sum
					end
				end
			end
			battleCache.attackerSpeedValue = _ED.user_info.speed_sum
		end
	end

	for _, attackObject in pairs(attackObjects) do
		if (attackObject ~= nil) then
		else
		end
	end
	
	battleCache.attackName = _ED.user_info.user_name
	battleCache.attackerObjects = attackObjects
	local byAttackerObjectsList = {}
	for i = 1, npc.formationCount do
		local byAttackObjects = {}
		local formationId = npc:getEnvironmentFormation(i)

		local environmentFormation = ConfigDB.load("environment_formation", formationId)
		
		seatArray = {}
		for idx, val in pairs(seatIndex) do
			local shipId = dms.int(dms["environment_formation"], formationId, val)
			seatArray[#seatArray + 1] = shipId
		end
		
		local amplifyPercentString = dms.string(dms["environment_formation"], formationId, environment_formation.amplify_percentage)
		local amplifyPercentArray = zstring.split(amplifyPercentString, IniUtil.comma)
		 
		for j, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= tonumber(val)) then
				local fightObject = FightObject:new()
				fightObject:initWithNpc(npc, difficulty, j, seatArray[j], self.fakeLevel, self.isFake)
				fightObject.amplifyPercent = amplifyPercentArray[j]
				fightObject.attackSpeed = environmentFormation.fightBg
				if fightObject.signType <= 0 then
				end
				byAttackObjects[j] = fightObject
			end
		end

		battleCache.byAttackComobatForce = environmentFormation.combatForce
		
		for _, attackObject in pairs(byAttackObjects) do
			if (attackObject ~= nil) then
			else
			end
		end
	
		table.insert(byAttackerObjectsList, byAttackObjects)
	end
	
	battleCache.byAttackName = npc.npcName

	battleCache.byAttackerObjectsList = byAttackerObjectsList
	_ED.user_info.battleCache = battleCache

	battleCache.attacker_priority = battleCache.attackerSpeedValue
	battleCache.defender_priority = 0
	battleCache.attacker_name = _ED.user_info.user_name
	battleCache.defender_name = battleCache.byAttackName
	battleCache.attacker_head_pic = 0
	battleCache.defender_head_pic = 0
	
	if false ~= write then
		self:writeBattleFieldInit(battleCache,  0,  1, resultBuffer)
	end
end
-- function FightModule:initBattleField(attackUser, byAttackUser, fightType, resultBuffer)
		-- self.fightType = fightType
		-- BattleCache battleCache = new BattleCache()
		-- battleCache.userInfo=attackUser
		-- battleCache.battleType=fightType
		-- battleCache.byAttackerId=byAttackUser.id
		-- battleCache.maxBattleCount=(byte) 1
		-- battleCache.difficulty=(byte) 1
		-- FightObject[] attackObjects = new FightObject[6]
		-- Formation formation = UserDB.findByUserAndIndex(attackUser.id,  1)
		-- Integer seatArray[] = new Integer[]{formation.seatOne, formation.seatTwo, formation.seatThree, formation.seatFour, formation.seatFive, formation.seatSix}
		-- for (local i = 0; i < seatArray.length; i++) {
			-- if(nil ~= seatArray[i] and 0 ~= seatArray[i]){
				-- FightObject fightObject = new FightObject((byte) (i + 1), seatArray[i],  0)
				-- attackObjects[i] = fightObject
			-- }
		-- }
		-- battleCache.attackerObjects=attackObjects
		-- battleCache.attackCombatForce=formation.combatForce
		-- battleCache.attackName=attackUser.nickname
		-- List<FightObject[]> byAttackerObjectsList = new ArrayList<FightObject[]>()
		-- FightObject[] byAttackObjects = new FightObject[6]
		-- Formation byFormation = UserDB.findByUserAndIndex(byAttackUser.id,  1)
		-- Integer bySeatArray[] = new Integer[]{byFormation.seatOne, byFormation.seatTwo, byFormation.seatThree, byFormation.seatFour, byFormation.seatFive, byFormation.seatSix}
		-- for (local i = 0; i < bySeatArray.length; i++) {
			-- if(nil ~= bySeatArray[i] and 0 ~= bySeatArray[i]){
				-- FightObject fightObject = new FightObject((byte) (i + 1), bySeatArray[i],  1)
				-- byAttackObjects[i] = fightObject
			-- }
		-- }
		-- byAttackerObjectsList.add(byAttackObjects)
		-- battleCache.byAttackName=byAttackUser.nickname
		-- battleCache.byAttackComobatForce=byFormation.combatForce
		-- battleCache.byAttackerObjectsList=byAttackerObjectsList
		-- attackUser.battleCache=battleCache
		-- UserViceCaptainInfo userViceCaptainInfo = nil
		-- if(userViceCaptainInfo == nil){
			-- userViceCaptainInfo = new UserViceCaptainInfo()
		-- }
		-- battleCache.userViceCaptainInfo=userViceCaptainInfo
		-- UserViceCaptainInfo byUserViceCaptainInfo = nil
		-- if(byUserViceCaptainInfo == nil){
			-- byUserViceCaptainInfo = new UserViceCaptainInfo()
		-- }
		-- battleCache.byUserViceCaptainInfo=byUserViceCaptainInfo
		-- writeBattleFieldInit(battleCache,  0,  0, resultBuffer)
		-- writeFashionEquipmentInit(attackUser, byAttackUser, resultBuffer)
-- end

-- function FightModule:initThreeBattleField(attackUser, npc, difficulty, fightType, resultBuffer)
		-- self.fightType = fightType
		-- BattleCache battleCache = new BattleCache()
		-- battleCache.userInfo=attackUser
		-- battleCache.battleType=fightType
		-- battleCache.byAttackerId=npc.id
		-- battleCache.maxBattleCount=(byte)1
		-- battleCache.difficulty=difficulty
		-- FightObject[] attackObjects = new FightObject[6]
		-- Integer seatArray[] = nil
		-- Formation formation = UserDB.findByUserAndIndex(attackUser.id,  1)
		-- seatArray = new Integer[]{formation.seatOne, formation.seatTwo, formation.seatThree, formation.seatFour, formation.seatFive, formation.seatSix}
		-- for (local i = 0; i < seatArray.length; i++) {
			-- if(nil ~= seatArray[i] and 0 ~= seatArray[i]){
				-- FightObject fightObject = new FightObject((byte) (i + 1), seatArray[i],  0)
				-- fightObject.finalDamagePercent=worldBossDamageAdditional
				-- if(self.userThreeKingdomsInfo ~= nil){
					-- fightObject.addPropertyByInfluenceValue(userThreeKingdomsInfo.attribute)
				-- }
				-- attackObjects[i] = fightObject
			-- }
		-- }
		-- battleCache.attackCombatForce=formation.combatForce
		-- battleCache.attackName=attackUser.nickname
		-- battleCache.attackerObjects=attackObjects
		-- List<FightObject[]> byAttackerObjectsList = new ArrayList<FightObject[]>()
		-- FightObject[] byAttackObjects = new FightObject[6]
		-- Integer formationId = npc.getEnvironmentFormation(difficulty)
		-- EnvironmentFormation environmentFormation = (EnvironmentFormation)ConfigDB.load("EnvironmentFormation", formationId)
		-- String amplifyPercentArray[] = environmentFormation.amplifyPercentage.split(IniUtil.comma)
		-- seatArray = new Integer[]{environmentFormation.seatOne, environmentFormation.seatTwo, environmentFormation.seatThree, environmentFormation.seatFour, environmentFormation.seatFive, environmentFormation.seatSix}
		-- for (local j = 0; j < seatArray.length; j++) {
			-- if(nil ~= seatArray[j] and 0 ~= seatArray[j]){
				-- FightObject fightObject = new FightObject(npc, difficulty,  (j + 1), seatArray[j], fakeLevel, isFake)
				-- fightObject.amplifyPercent=amplifyPercentArray[j]
				-- fightObject.name=environmentFormation.formationName
				-- byAttackObjects[j] = fightObject
			-- }
		-- }
		-- battleCache.byAttackComobatForce=environmentFormation.combatForce
		-- byAttackerObjectsList.add(byAttackObjects)
 		-- battleCache.byAttackName=npc.npcName
		-- battleCache.byAttackerObjectsList=byAttackerObjectsList
		-- attackUser.battleCache=battleCache
		-- UserViceCaptainInfo userViceCaptainInfo = nil
		-- if(userViceCaptainInfo == nil){
			-- userViceCaptainInfo = new UserViceCaptainInfo()
		-- }
		-- battleCache.userViceCaptainInfo=userViceCaptainInfo
		-- userViceCaptainInfo = new UserViceCaptainInfo()
		-- battleCache.byUserViceCaptainInfo=userViceCaptainInfo
		-- writeBattleFieldInit(battleCache,  0,  1, resultBuffer)
		-- writeFashionEquipmentInit(attackUser, nil, resultBuffer)
-- end

function FightModule:initBattleInfo(battleCache)
	self.fightResult = 0
	self.hasNextRound = true
	self.npcMaxHealth = 0
	self.roundCount = 1
	-- self.shipCount = 0
	self.lastBattleTag = -1

	local resetAttackerInfo = true
	if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        if battleCache.currentBattleCount > 0 then
        	resetAttackerInfo = false
        end
    end

	local attackObjects = battleCache.attackerObjects

	local byAttackObjects = battleCache.byAttackerObjectsList[battleCache.currentBattleCount + 1]
	--for (local i = 0; i < attackObjects.length; i++) {
	for i, atkObj in pairs(attackObjects) do
		if(nil ~= attackObjects[i]) then
			if true == resetAttackerInfo then
				local battleObject = BattleObject:new()
				battleObject:initWithAttackObject(attackObjects[i])
				if(self.attackObjects[i] ~= nil) then
					battleObject.zomlllSkillPoint = self.attackObjects[i].zomlllSkillPoint
				end
				self.attackObjects[i] = battleObject
				self.shipCount = self.shipCount + 1
				self.totalHealth = self.totalHealth + battleObject.healthMaxPoint
			else
				local battleObject = self.attackObjects[i]
				if nil == battleObject or true == battleObject.isDead then
					attackObjects[i] = nil
				else
					-- self.shipCount = self.shipCount + 1
					-- self.totalHealth = self.totalHealth + battleObject.healthMaxPoint

					battleObject.normalSkillUseCount = 0
					battleObject.powerSkillUseCount = 0
				end
			end
		end		
	end
	--for (local i = 0; i < byAttackObjects.length; i++) {
	for i, atkObj in pairs(byAttackObjects) do
		if(nil ~= byAttackObjects[i])then
			local battleObject = BattleObject:new()
			battleObject:initWithAttackObject(byAttackObjects[i])
			self.byAttackObjects[i] = battleObject
			self.npcMaxHealth = self.npcMaxHealth + battleObject.healthMaxPoint
		end
	end
	if(battleCache.battleType == FightModule.FIGHT_TYPE_PVE_MONEY_TREE) then
		self.fightType = FightModule.FIGHT_TYPE_PVE_MONEY_TREE
		self.totalRound = 5
	end
	if(battleCache.battleType == FightModule.FIGHT_TYPE_PVE_REBELARMY) then
		self.fightType = FightModule.FIGHT_TYPE_PVE_REBELARMY
		self.totalRound = 5
	end
	if(battleCache.battleType == FightModule.FIGHT_TYPE_PVE_TREASURE_EXPERIENCE) then
		self.fightType = FightModule.FIGHT_TYPE_PVE_TREASURE_EXPERIENCE
		self.totalRound = 5
	end
	if(battleCache.battleType == FightModule.FIGHT_TYPE_PVE_PANDA_EXPERIENCE) then
		self.fightType = FightModule.FIGHT_TYPE_PVE_PANDA_EXPERIENCE
		self.totalRound = 5
	end
	if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        if(battleCache.battleType == FightModule.FIGHT_TYPE_PVP_COUNTERPART) then
			self.fightType = FightModule.FIGHT_TYPE_PVP_COUNTERPART
			self.totalRound = 5
		end
    end
    self.union_pve_attribute_bonus = self.union_pve_attribute_bonus or 0

	if(battleCache.battleType == FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
		self.totalRound = self.dailyRoundCount
	end
	if battleCache.battleType == FightModule.FIGHT_TYPE_51
		or battleCache.battleType == FightModule.FIGHT_TYPE_52 then
		self.totalRound = 10
	end
	self:calculateTalentUnite(self.attackObjects, self.byAttackObjects)
	--initRebelArmy()

	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		-- 全回合开战前部队全局属性
		for i, v in pairs(self.attackObjects) do
			-- v:resetProperty()
			v:nextBattleInfo()
		end
		if battleCache.currentBattleCount == 0 then
			for i, v in pairs(self.attackObjects) do
				v:addPropertyByTalentInfluencePriorValueResults(self.attackObjects, self.byAttackObjects, 0, battleCache, self)
			end
		end
		-- for i, v in pairs(self.byAttackObjects) do
		-- 	v:resetProperty()
		-- 	v:addPropertyByTalentInfluencePriorValueResults(self.byAttackObjects, self.attackObjects, 1, battleCache, self)
		-- end

		local buffBattleSkill = {effectAmount = 0}
		local buffBuffer = {}

		-- 9回合开始时判定
		local dest = {}
		table.add(dest, self.attackObjects)
		table.add(dest, self.byAttackObjects)
		for k, v in pairs(dest) do
			if (nil ~= v) then
				if (v.battleTag == 0 ) then
					TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_BATTLE_ROUND_START, v, nil, nil, self)
					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_BATTLE_ROUND_START, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )
					
					TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, v, nil, nil, self)
					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )

					if battleCache.currentBattleCount == 0 then
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE, v, nil, nil, self)
						v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )
					end
				else
					TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_BATTLE_ROUND_START, v, nil, nil, self)
					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_BATTLE_ROUND_START, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )
					
					TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, v, nil, nil, self)
					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )

					-- if battleCache.currentBattleCount == 0 then
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE, v, nil, nil, self)
						v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )
					-- end
				end
				v:clearTalentJudgeResultList()
			end
		end

		table.insert(buffBuffer, 1, NetworkProtocol.sequence)			-- seq
		table.insert(buffBuffer, 2, IniUtil.enter)
		table.insert(buffBuffer, 3, "environment_fight_round_start")	-- cmdname
		table.insert(buffBuffer, 4, IniUtil.enter)
		table.insert(buffBuffer, 5, "0")								-- result
		table.insert(buffBuffer, 6, IniUtil.enter)
		table.insert(buffBuffer, 7, 14710)
		table.insert(buffBuffer, 8, IniUtil.enter)
		table.insert(buffBuffer, 9, buffBattleSkill.effectAmount)
		table.insert(buffBuffer, 10, IniUtil.enter)

		table.insert(buffBuffer, "14713")
		table.insert(buffBuffer, IniUtil.enter)
		table.insert(buffBuffer, (battleCache.currentBattleCount + 1))
		table.insert(buffBuffer, IniUtil.enter)
		table.insert(buffBuffer, table.nums(dest))
		table.insert(buffBuffer, IniUtil.enter)
		for k, v in pairs(dest) do
			if (nil ~= v) then
				table.insert(buffBuffer, v.battleTag)
				table.insert(buffBuffer, IniUtil.compart)
				table.insert(buffBuffer, v.coordinate)
				table.insert(buffBuffer, IniUtil.compart)
				table.insert(buffBuffer, v.healthPoint)
				table.insert(buffBuffer, IniUtil.compart)
				table.insert(buffBuffer, v.healthMaxPoint)
				table.insert(buffBuffer, IniUtil.compart)
				table.insert(buffBuffer, v.skillPoint)
				table.insert(buffBuffer, IniUtil.enter)
			end
		end
		
		local protocalData = {}
		protocalData.resouce = table.concat(buffBuffer, "")
		NetworkProtocol.parser_func(protocalData)

		-- 添加属性调试信息
		-- _crint("输出角色属性调试信息：")
		for k, v in pairs(dest) do
			-- _crint(v.battleTag, v.coordinate, v.physicalDefence)
		end
	end
end

function FightModule:calculateTalentAuraInfluence(battleObjects)
	local tmpBattleObjects = battleObjects
	for idx, tmpBattleObject in  ipairs(tmpBattleObjects) do
		if(nil ~= tmpBattleObject) then				
			for idx2, talentMould in ipairs(tmpBattleObject.talentMouldList) do
				if(talentMould.influencePriorType ~= -1) then
					if(talentMould.influencePriorType <= 5) then
						for _, battleObject in pairs( battleObjects) do
							if(nil == battleObject or tmpBattleObject.id == battleObject.id) then
								--continue
							else
								self:calculateTalentAuraInfluence(talentMould, battleObject)
							end
						end
					elseif(talentMould.influencePriorType == TalentConstant.JUDGE_OPPORTUNITY_EMAMY_ATTACK 
							or talentMould.influencePriorType == TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK) then
						--continue
					else
						for idx4, battleObject in pairs(battleObjects) do
							if(nil ~= battleObject)then
								--continue
							else
								if(tmpBattleObject.id == battleObject.id) then
									self:calculateTalentAuraInfluence(talentMould, battleObject)
									break
								end
							end
						end
					end
				end
			end
		end
	end
end



function FightModule:calculateTalentUnite(attackObjects, byAttackObjects)
	local tmpBattleObjects = attackObjects
	for _, tmpBattleObject in pairs(tmpBattleObjects)  do
		if(nil == tmpBattleObject)then
			--continue
		else
			for _, talentMould in pairs(tmpBattleObject.talentMouldList) do
				if(talentMould.influenceJudgeOpportunity ~= -1) then
					if(talentMould.influenceJudgeOpportunity == TalentConstant.JUDGE_OPPORTUNITY_EMAMY_ATTACK) then
						for _, battleObject in pairs(byAttackObjects) do
							if(nil == battleObject) then
								--continue
							else
								FightModule:calculateTalentUnite(talentMould, battleObject, tmpBattleObject)
							end
						end
					elseif(talentMould.influenceJudgeOpportunity == TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK) then
						for _, battleObject in pairs(attackObjects) do
							if(nil == battleObject)then
								--continue
							else
								if(tmpBattleObject.id == battleObject.id)then
									--continue
								else
									FightModule:calculateTalentUnite(talentMould, battleObject, tmpBattleObject)
								end
							end
						end
					end
				end
			end
		end
	end
end



function FightModule:calculateTalentAuraInfluence(talentMould, battleObject)
	local effectCount = -1
	local isActivate = false
	if (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_MALE ) then
		isActivate = battleObject.gender == 1
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_FEMALE) then
		isActivate = battleObject.gender == 2			
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_WEI) then
		isActivate = battleObject.campPreference == 1			
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SHU) then
		isActivate = battleObject.campPreference == 2			
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_WU) then
		isActivate = battleObject.campPreference == 3			
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_QUN) then
		isActivate = battleObject.campPreference == 4
		
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT1) then
		isActivate = true
		effectCount = 1
		
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT2) then
		isActivate = true
		effectCount = 2
	end
	if(isActivate) then
		local effectType  = tonumber(zstring.split(talentMould.influencePriorValue, IniUtil.comma)[1])
		local effectValue = tonumber(zstring.split(talentMould.influencePriorValue, IniUtil.comma)[2])
		if(effectType == TalentConstant.INFLUENCE_PRIOR_VALUE_LIFE_ADDITIONAL_PERCENT) then
			battleObject.healthMaxPoint = math.floor(battleObject.healthMaxPoint * (1.0 + effectValue / 100.0))
			-- battleObject.healthPoint    = math.floor(battleObject.healthPoint * (1.0 + effectValue / 100.0))
			battleObject:setHealthPoint(math.floor(battleObject.healthPoint * (1.0 + effectValue / 100.0)))
		else				
			local talentAura = TalentAura:new()
			talentAura.effectCount = effectCount
			talentAura.effectType = effectType
			talentAura.effectValue = effectValue
			battleObject:pushTalentAuraList(talentAura)
		end
	end
end


function FightModule:calculateTalentUnite(talentMould, battleObject, extuteObject)
	local effectCount = -1
	local isActivate = false
	if (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_EM_WEI ) then
		isActivate = true
		
	elseif (talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_EM_SHU or
		talentMould.influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_EM_WU ) then
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_EM_QUN) then
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_EM_MALE) then
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_EM_FEMALE) then
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT3) then
		effectCount = 3
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT4) then
		effectCount = 4
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT5) then
		effectCount = 5
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT6) then
		effectCount = 6
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT7) then
		effectCount = 7
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT8) then
		effectCount = 8
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT9) then
		effectCount = 9
		isActivate = true
		
	elseif (talentMould.influencePriorType ==  TalentConstant.INFLUENCE_PRIOR_TYPE_SELF_COUNT10) then
		effectCount = 10
		isActivate = true
		
	end
	if(isActivate) then
		if( talentMould.influencePriorValue ~= "-1" ) then
			local effectType = tonumber(zstring.split(talentMould.influencePriorValue, IniUtil.comma)[1])
			local effectValue = tonumber(zstring.split(talentMould.influencePriorValue, IniUtil.comma)[2])
			if(effectType == TalentConstant.INFLUENCE_PRIOR_VALUE_LIFE_ADDITIONAL_PERCENT) then
				battleObject.healthMaxPoint = math.floor( (battleObject.healthMaxPoint * (1.0 + effectValue / 100.0)))
				-- battleObject.healthPoint    = math.floor( (battleObject.healthPoint * (1.0 + effectValue / 100.0)))
				battleObject:setHealthPoint(math.floor( (battleObject.healthPoint * (1.0 + effectValue / 100.0))))
			elseif(effectCount == -1) then			
				local talentAura = TalentAura:new()
				talentAura.effectCount = effectCount
				talentAura.effectType = effectType
				talentAura.effectValue = effectValue
				battleObject.pushTalentAuraList(talentAura)
			end
		else
			local talentUniteSkill = TalentUniteSkill:new()
			talentUniteSkill.battleObject = extuteObject
			talentUniteSkill.effectCount = effectCount
			talentUniteSkill.talentMould = talentMould
			battleObject.pushTalentUniteSkillList(talentUniteSkill)
		end
	end	
end

--	获取下一个出手对象
--	k 当前出手序列号
--	从k往后开始循环寻找存活战斗对象.不包含k,如果k后面没有,从头开始找下一个出手的人
function FightModule:getNextFightObject(k,fightOrderList)
	local isFind = false
	local nextObject = nil
	for s, battleObject in pairs(fightOrderList) do
		if (s < k) then
			if isFind == false then
				if(battleObject.isDead) then
				else
					nextObject = battleObject
					isFind = true
				end
			end			
		elseif(s > k) then
			if(battleObject.isDead) then
			else
				nextObject = battleObject
				break;
			end
		else
		end
	end
	return nextObject
end


--	重置全部的出手状态
function FightModule:resetActionStatus(resetAll)
	if self.byAttackerAttacking then
		return
	end
	for s, battleObject in pairs(self.fightOrderList) do
		if resetAll or (battleObject.battleTag == 0) then
			if(battleObject.isDead) then
			else
				battleObject.isAction = false
			end
		end
		-- _crint("====================================================")
	end
end

-- 重置全部的出手状态的技能状态
function FightModule:resetAllRoleSkillStatus()
	for s, battleObject in pairs(self.fightOrderList) do
		-- _crint("====================================================")
		if nil ~= battleObject.normalSkillMould then
			local randomValue = math.random(1, 100)
			local normalSkillMouldRate = battleObject.normalSkillMouldRate
			-- if normalSkillMouldRate >= 0 then
				normalSkillMouldRate = normalSkillMouldRate + battleObject.normatinSkillTriggerPercent
			-- end
			-- print("-----------", battleObject.normatinSkillTriggerPercent, battleObject.normalSkillMouldRate, randomValue, normalSkillMouldRate)
			if battleObject.normalSkillMouldRate >= randomValue then
				if battleObject.normalSkillMouldOpened1 == 2 then
					battleObject.normalSkillMouldOpened = false
					battleObject.normalSkillMouldOpened1 = nil
				else
					battleObject.normalSkillMouldOpened = true
				end
				-- _crint("开启技能")
			else
				if battleObject.normalSkillMouldOpened1 == 1 then
					battleObject.normalSkillMouldOpened = true
					battleObject.normalSkillMouldOpened1 = nil
				end
			end

			if true == battleObject.normalSkillMouldOpened then
				if battleObject.normalSkillMouldRateIndex == 1 then
					battleObject.normalSkillMouldRateIndex = battleObject.normalSkillMouldRateIndex + 1
				elseif battleObject.normalSkillMouldRateIndex == 2 then
					battleObject.normalSkillMouldRateIndex = 2
				elseif battleObject.normalSkillMouldRateIndex == 3 then
					battleObject.normalSkillMouldRateIndex = 2
				end
			else
				if battleObject.normalSkillMouldRateIndex == 1 then
					battleObject.normalSkillMouldRateIndex = 1
				elseif battleObject.normalSkillMouldRateIndex == 2 then
					battleObject.normalSkillMouldRateIndex = battleObject.normalSkillMouldRateIndex + 1
				elseif battleObject.normalSkillMouldRateIndex == 3 then
					battleObject.normalSkillMouldRateIndex = 1
				end
			end

			battleObject.normalSkillMouldRate = battleObject.normalSkillMouldRates[battleObject.normalSkillMouldRateIndex] or normalSkillMouldRate
			-- print("小技能释放的概率：", battleObject.battleTag, battleObject.coordinate, battleObject.normatinSkillTriggerPercent, battleObject.normalSkillMouldRateIndex, battleObject.normalSkillMouldRate, battleObject.normalSkillMouldOpened)
			
			if nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP) and battleObject.isDisSp ~= true) then
				battleObject.skipSuperSkillMould = false
			else
				battleObject.skipSuperSkillMould = true
			end
		end
	end
	return self.fightOrderList
end

--	获取指定出手对象
--	参数:标示,方位
function FightModule:getAppointFightObject(battleTag,coordinate)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		-- print(battleObject.battleTag, battleObject.coordinate, battleTag, coordinate)
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				if(battleObject.isDead) then
					return nil
				else
					return battleObject
				end
			end
		end
	end
	return nil
end

function FightModule:findAppointFightObject(battleTag,coordinate)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				return battleObject
			end
		end
	end
	return nil
end

function FightModule:killAppointFightObject(battleTag,coordinate)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				battleObject.isDead = true
				self.byAttackObjects[tonumber(coordinate)] = nil
				table.remove(self.fightOrderList, s, 1)
				return
			end
		end
	end
	return nil
end

function FightModule:addPowerValueFightObject(battleTag, coordinate, value)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(coordinate) < 0 then
				battleObject:setSkillPoint(battleObject.skillPoint + value)
			elseif tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				battleObject:setSkillPoint(battleObject.skillPoint + value)
				if battleObject.skillPoint >= FightModule.MAX_SP then
					battleObject.skipSuperSkillMould = false
				end
				return
			end
		end
	end
	return nil
end

function FightModule:setFightObjectSkillAttack(battleTag, coordinate, value)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				battleObject.normalSkillMouldOpened1 = value
				return
			end
		end
	end
	return nil
end

-- 设置绝技攻击
function FightModule:setPowerSkillState(battleTag, coordinate)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				battleObject.skipSuperSkillMould = true
				battleObject:setSkillPoint(math.max(battleObject.skillPoint, FightModule.MAX_SP))
				return
			end
		end
	end
	return nil
end

function FightModule:setActionStatus(battleTag,coordinate, attackState)
	if type(attackState) ~= "boolean" then
		return
	end
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				-- battleObject.isDead = attackState
				battleObject.isAction = attackState
				return
			end
		end
	end
	return nil
end

-- 清除绝技攻击
function FightModule:clearPowerSkillState(battleTag)
	--_crint("获取出手方人员数量：",#self.fightOrderList)
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			battleObject.skipSuperSkillMould = true
		end
	end
	return nil
end

-- 切换战斗对象的数据
function FightModule:changeBattleRoleInfo( battleTag, coordinate, environmentShipId )
	local info
	for s, battleObject in pairs(self.fightOrderList) do
		if tonumber(battleObject.battleTag) == tonumber(battleTag) then			--指定攻击方
			if tonumber(battleObject.coordinate) == tonumber(coordinate) then	--指定攻击对象
				-- _crint("line:", 1196)
				local healthPoint = battleObject.healthPoint
				local skillPoint = battleObject.skillPoint
				
				battleObject.fightObject:initWithEnvironmentShip(environmentShipId)

				battleObject:initWithAttackObject(battleObject.fightObject)

				battleObject:setHealthPoint(healthPoint)
				battleObject:setSkillPoint(skillPoint)
				return battleObject
			end
		end
	end
	return nil
end

--初始化出手顺序
function FightModule:initFightOrder(userInfo, resultBuffer)
	if self.waitAttack == true then
		return
	end
	self.waitAttack = true
	local tempBattleCache = userInfo.battleCache
	local attackerCombatForce = tempBattleCache.attackCombatForce
	local byAttackerCombatForce = tempBattleCache.byAttackComobatForce
	self:initBattleInfo(tempBattleCache)
	self:initDailyInstance()
	
	local tempAttackObjects = self.attackObjects
	local tempByAttackObjects = self.byAttackObjects
	
	-- if (tonumber(attackerCombatForce) < tonumber(byAttackerCombatForce)) then
	-- 	tempAttackObjects = self.byAttackObjects
	-- 	tempByAttackObjects = self.attackObjects
	-- end


	self._attack_speed_type = 0
	
	local attackerSpeedValue = tempBattleCache.attackerSpeedValue or 0
	local byAttackerSpeedValue = 0
	for i = 1, 6 do
		if (tempByAttackObjects[i] ~= nil) then
			byAttackerSpeedValue = byAttackerSpeedValue + tempByAttackObjects[i].attackSpeed
			break
		end
	end

	if attackerSpeedValue < byAttackerSpeedValue then
		tempAttackObjects = self.byAttackObjects
		tempByAttackObjects = self.attackObjects
		self._attack_speed_type = 1
	end

	self.fightOrderList = {}
	--- 生成战战斗对象序列
	for i = 1, 6 do
		if (tempAttackObjects[i] ~= nil) then
			tempAttackObjects[i].isAction = false
			table.insert(self.fightOrderList, tempAttackObjects[i])
		end
	end
	for i = 1, 6 do
		if (tempByAttackObjects[i] ~= nil) then
			tempByAttackObjects[i].isAction = false
			table.insert(self.fightOrderList, tempByAttackObjects[i])
		end
	end

	self.byAttackerAttacking = false

	self.attackerSpeedValue = attackerSpeedValue
	self.byAttackerSpeedValue = byAttackerSpeedValue
	if attackerSpeedValue < byAttackerSpeedValue then
		-- for i, v in pairs(self.attackObjects) do
		-- 	v.isAction = true
		-- end
		self.byAttackerAttacking = true
	end
	-- print(self.byAttackerAttacking, self.attackerSpeedValue, self.byAttackerSpeedValue)
end

--	获取下一个出手对象
--	从k往后开始循环寻找存活战斗对象.如果k后面没有,表示回合结束
function FightModule:getNextRoundFightObject(battleObject)
	local nextObject = nil
	local k  = 0
	for s, tempObject in pairs(self.fightOrderList) do
		if(tempObject.isDead) then
		else
			if(battleObject.battleTag == tempObject.battleTag) then
				if(battleObject.coordinate == tempObject.coordinate)then 
					k = s
				end
			end
		end
		if(k ~= 0) then
			if(s > k) then
				if(tempObject.isDead) then
				else
					nextObject = tempObject
					break;
				end
			end
		end
	end
	return nextObject
end


--	获取出手对象位置
function FightModule:getBattleObjectSite()
	local k  = 1
	for s, tempObject in pairs(self.fightOrderList) do
		if(tempObject.isDead) or tempObject == nil then
		else
--			-- _crint("+*****+",tempObject.battleTag,tempObject.coordinate,tempObject.isAction)
			if(tempObject.isAction == true) then
				k = 0
				break
			end
		end
	end
	return k
end


--	检测我方是否除自身以外其他人都出手过了
function FightModule:findIsAllAttack(battleObject)
	for s, tempObject in pairs(self.attackObjects) do
		if(tempObject.isDead) or tempObject == nil then
		else
			if(tempObject.isAction ~= true and tonumber(battleObject.coordinate) ~= tonumber(tempObject.coordinate)) then
				return 0
			end
		end
	end
	return 1
end


--	检测我方是否只剩眩晕的人未出手
function FightModule:checkLessIsDizzy()
	for s, tempObject in pairs(self.attackObjects) do
		if tempObject ~= nil and tempObject.isDead ~= true and tempObject.isAction ~= true then
			if tempObject.isDizzy ~= true then
				return false
			end
		end
	end
	return true
end

-- 校验阵营的变更
function FightModule:checkChangeBattleTag()
	-- print("处理切换阵型的天赋", self.lastBattleTag, self.battleTag)
	if self.lastBattleTag ~= self.battleTag then
		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon 
			or __lua_project_id == __lua_project_l_naruto 
			then
			if self.lastBattleTag > -1 then

				local buffBattleSkill =  BattleSkill:new()-- {effectAmount = 0}
				local buffBuffer = {}

				-- print("处理切换阵型的天赋")
				
				--[[输出攻击过程信息
				___writeDebugInfo("处理切换阵型的天赋" .. "\r\n")
				--]]

				if self.lastBattleTag == 0 then
					for k, v in pairs(self.attackObjects) do
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK, v, nil, nil, self)
						v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )
					end

					for k, v in pairs(self.byAttackObjects) do
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_EMAMY_ATTACK, v, nil, nil, self)
						v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_EMAMY_ATTACK, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )
					end
				else
					for k, v in pairs(self.attackObjects) do
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_EMAMY_ATTACK, v, nil, nil, self)
						v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_EMAMY_ATTACK, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )
					end

					for k, v in pairs(self.byAttackObjects) do
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK, v, nil, nil, self)
						v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )
					end
				end

				-- 处理灼烧
				local function executeBuff( battleObject, fightModule, buffEffect, buffBattleSkill, buffBuffer )
					if buffEffect then
						for i, fightBuff in pairs(buffEffect) do
							-- print("---buff:", battleObject.battleTag, battleObject.coordinate, fightBuff.skillInfluence.skillCategory, fightBuff.effectRound)
							if fightBuff.effectRound > 0 then
								if fightBuff.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_FIRING then
									fightBuff.effectRound = fightBuff.effectRound - 1
									if fightBuff.effectRound <= 0 then
										buffEffect[i] = nil
									end

									local bs = BattleSkill:new()

									local grade_attack = 1
									if battleObject.battleTag == 1 then
										grade_attack = self.total_grade_attack0 or 1
									else
										grade_attack = self.total_grade_attack1 or 1
									end

									-- 修改单人在场的连击位数（策划数据错误，由于策划数值都做过一轮的验证，此bug由程序处理）
									if grade_attack >= 2 then
										grade_attack = 1
									end

									bs.effectValue = fightBuff.effectValue * grade_attack

									battleObject:subHealthPoint(bs.effectValue)
									if(battleObject.healthPoint < 1) then
										battleObject.isDead = true
										bs.aliveState = 1
										-- print("灼烧死亡了。。。。。。。。")
										if(battleObject.battleTag == 0) then
											fightModule.attackCount = fightModule.attackCount - 1
											fightModule.attackObjects[battleObject.coordinate] = nil
										else
											fightModule.byAttackCount = fightModule.byAttackCount - 1
											fightModule.byAttackObjects[battleObject.coordinate] = nil
										end
									else
										-- 中毒伤害回复怒气
										local damageDspValue = bs.effectValue / battleObject.healthMaxPoint * FightModule.MAX_SP
										if battleObject.skillPoint <= FightModule.MAX_SP then
											if damageDspValue > 0 then
												local dbs = BattleSkill:new()
												dbs.byAttackerTag = battleObject.battleTag
												dbs.byAttackerCoordinate = battleObject.coordinate
												dbs.isDisplay = 0
												dbs.effectType = BattleSkill.SKILL_INFLUENCE_ADDSP
												dbs.effectValue = damageDspValue
												dbs.effectValue = battleObject:addSkillPoint(damageDspValue, true)
												dbs:writeSkillAttack(userInfo, battleObject, battleObject, fightModule, buffBuffer)
												buffBattleSkill.effectAmount = buffBattleSkill.effectAmount + 1
												-- _crint("反弹伤害回复怒气:", damageDspValue, reboundDamageValueResult, battleObject.healthMaxPoint, FightModule.MAX_SP)
											end
										end
									end

									bs.byAttackerTag = battleObject.battleTag
									bs.byAttackerCoordinate = battleObject.coordinate
									bs.isDisplay = 1
									bs.effectType = BattleSkill.SKILL_INFLUENCE_FIRING
									bs.effectRound = fightBuff.effectRound
									bs:writeSkillAttack(userInfo, battleObject, battleObject, fightModule, buffBuffer)
									buffBattleSkill.effectAmount = buffBattleSkill.effectAmount + 1
									-- print("燃烧回合：", battleObject.battleTag, battleObject.coordinate, fightBuff.effectRound, "伤害值：", bs.effectValue, grade_attack)

									local lastSkillInfluence = buffBattleSkill.skillInfluence
									buffBattleSkill.skillInfluence = fightBuff.skillInfluence
									buffBattleSkill.attackerTag = battleObject.battleTag
									buffBattleSkill.attacterCoordinate = battleObject.coordinate
									buffBattleSkill:executeNextSkillInfluence(battleObject, battleObject, userInfo, fightModule, buffBuffer)
									buffBattleSkill.skillInfluence = lastSkillInfluence

									--[[输出攻击过程信息
									___writeDebugInfo("\t" .. "当前被灼烧的目标" .. "\t" 
										.. "承受方：" .. battleObject.battleTag .. "\t" 
										.. "承受者站位：" .. battleObject.coordinate .. "\t"
										.. "承受者最终血量：" .. battleObject.healthPoint .. "\t"
										.. "承受者最终怒气：" .. battleObject.skillPoint .. "\t"
										.. "当前的灼烧伤害值：" .. bs.effectValue .. "\t"
										.. "\r\n")
									--]]
								end
							end
						end
					end
				end
				-- print("处理：：：", self.lastBattleTag)
				
				--[[输出攻击过程信息
				___writeDebugInfo("处理灼烧" .. "\r\n")
				--]]
				
				if self.lastBattleTag == 0 then
					for k, v in pairs(self.attackObjects) do
						-- v.revived = false
						if true ~= v.revived then
							executeBuff(v, self, v.buffEffect, buffBattleSkill, buffBuffer)
						end
					end
				else 
					for k, v in pairs(self.byAttackObjects) do
						-- v.revived = false
						if true ~= v.revived then
							executeBuff(v, self, v.buffEffect, buffBattleSkill, buffBuffer)
						end
					end
				end

				table.insert(buffBuffer, 1, NetworkProtocol.sequence)			-- seq
				table.insert(buffBuffer, 2, IniUtil.enter)
				table.insert(buffBuffer, 3, "environment_fight_battle_camp_change")	-- cmdname
				table.insert(buffBuffer, 4, IniUtil.enter)
				table.insert(buffBuffer, 5, "0")								-- result
				table.insert(buffBuffer, 6, IniUtil.enter)
				table.insert(buffBuffer, 7, 14712)
				table.insert(buffBuffer, 8, IniUtil.enter)
				table.insert(buffBuffer, 9, self.roundCount)
				table.insert(buffBuffer, 10, IniUtil.enter)
				table.insert(buffBuffer, 11, self.lastBattleTag)
				table.insert(buffBuffer, 12, IniUtil.enter)
				table.insert(buffBuffer, 13, buffBattleSkill.effectAmount)
				table.insert(buffBuffer, 14, IniUtil.enter)
				
				local protocalData = {}
				protocalData.resouce = table.concat(buffBuffer, "")
				NetworkProtocol.parser_func(protocalData)
			end
		end
		self.lastBattleTag = self.battleTag
	end
end

function FightModule:roundCountChange()
	if(self.roundCount >= self.totalRound) then
		self.roundCount = self.totalRound
		if(self.roundCount == self.totalRound) then
			self.hasNextRound = false
			self.fightResult = 0
		end
		if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
			self.fightResult = 1
		end
	else
		self.roundCount = self.roundCount+1

		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then

			local buffBattleSkill = {effectAmount = 0}
			local buffBuffer = {}

			-- 9回合开始时判定
			for k, v in pairs(self.fightOrderList) do
				v._lockBuff = nil
				-- v.revived = false
				v:resetBuff()
				TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, v, nil, nil, self)
				if (v.battleTag == 0) then
					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )
				else
					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )
				end
			end

			table.insert(buffBuffer, 1, NetworkProtocol.sequence)			-- seq
			table.insert(buffBuffer, 2, IniUtil.enter)
			table.insert(buffBuffer, 3, "environment_fight_battle_round")	-- cmdname
			table.insert(buffBuffer, 4, IniUtil.enter)
			table.insert(buffBuffer, 5, "0")								-- result
			table.insert(buffBuffer, 6, IniUtil.enter)
			table.insert(buffBuffer, 7, 14711)
			table.insert(buffBuffer, 8, IniUtil.enter)
			table.insert(buffBuffer, 9, self.roundCount)
			table.insert(buffBuffer, 10, IniUtil.enter)
			table.insert(buffBuffer, 11, buffBattleSkill.effectAmount)
			table.insert(buffBuffer, 12, IniUtil.enter)
			
			local protocalData = {}
			protocalData.resouce = table.concat(buffBuffer, "")
			NetworkProtocol.parser_func(protocalData)
		end
	end
	-- _crint("总回合数",self.roundCount,self.totalRound)
	
	self:resetActionStatus(true)
end

-- 校验回合的变更
function FightModule:checkRoundCountChange()
	-- if self.battleTag == 0 then
	-- 	self.battleTag = 1
	-- 	self:checkChangeBattleTag()
	-- else
	-- 	self.battleTag = 0
	-- 	self:checkChangeBattleTag()
	-- end
	self:roundCountChange()
end

-- 写入战斗过程数据
function ___writeDebugInfo( info )
	if true == app.configJson.fightDebug then
		_ED._fightModule.debug_info = _ED._fightModule.debug_info or {}
		table.insert(_ED._fightModule.debug_info, info)
	end
end

-- 校验承受方是否有角色可以进行攻击
function FightModule:checkHasByAttacker(attackObject)
	local defenderTeam = nil
	if (attackObject.battleTag == 1) then
		defenderTeam = self.attackObjects
	else
		defenderTeam = self.byAttackObjects
	end

	if nil ~= defenderTeam then
		for i, v in pairs(defenderTeam) do
			if nil ~= v and true ~= v.isDead and true ~= v.revived then
				return true
			end
		end
	end
	return false
end

-- 获取单一对象的攻击数据
function FightModule:fightObjectAttack(attackObject,resultBuffer)
	self.waitAttack = false

	local battleObject = attackObject
--	-- _crint("出手",battleObject.battleTag,battleObject.coordinate,battleObject.zomlllSkillPoint)
	local attackOver = 0
	local isFrist = self:getBattleObjectSite()
	local isLast = self:findIsAllAttack(battleObject)
	if(tonumber(isLast) == 1) then 
		self.greadCount = 0
		-- self.roundCount = self.roundCount+1
	end
	-- 当前出手是第一次出手
	if(tonumber(isFrist) == 1) then 
		-- self:resetActionStatus()
		self:clearAttacksStatus()
	end
	-- _crint("请求战斗",battleObject.isAction)
	if (battleObject.isAction == true or true == battleObject.isDead) then
		return
	end
	-- local nextFigter = self:getNextRoundFightObject(battleObject)
	-- if(nextFigter == nil)then
		
	-- end
	-- --_crint("出手坐标："..battleObject.battleTag..battleObject.coordinate)
	--记录当前出手对象
	self.currentObject  = battleObject
	--获取下一个出手对象 
	-- self.nextFightObject = self:getNextFightObject(attackObject,self.fightOrderList)
	-- --_crint("下一个出手坐标："..self.nextFightObject.battleTag..self.nextFightObject.coordinate)
	self.counterBuffer = nil
	self.battleSkillCount = 0
	self.battleSkillBuffer = {}
	
	--设置出手状态
	-- battleObject.isAction = true

	local skillPoint = battleObject.skillPoint
	
	self.headBuffer = {}
	self.bodyBuffer = {}
	self.buffBuffer = {}
	battleObject.fitBattleObjects = {}
	if(battleObject.battleTag == 0) then
		battleObject:checkBattleObject(self.attackObjects)
	else
		battleObject:checkBattleObject(self.byAttackObjects)
	end
	self.fitBuffer = nil
	local hasZoumarSkill = false
	if(battleObject.battleTag == 0) then
		hasZoumarSkill = battleObject:checkState(self.attackObjects)
	else
		hasZoumarSkill = battleObject:checkState(self.byAttackObjects)
	end
	battleObject.effectDamage = 0
	battleObject.totalEffectDamage = 0
	battleObject.reboundDamageValueResult = 0

	--[[输出攻击过程信息
	___writeDebugInfo("--------------------------------------------------------\r\n")
	___writeDebugInfo("处理攻击者的战斗过程数据：\r\n")
	___writeDebugInfo("\t当前的回合数：" .. self.roundCount .. "\r\n")
	___writeDebugInfo("\t攻击方：" .. battleObject.battleTag .. "\t攻击者站位：" .. battleObject.coordinate .. "\r\n")
	___writeDebugInfo("\t攻击者当前拥有的BUFF信息：" .. "\r\n")
	for idx, fightBuff in pairs(battleObject.buffEffect) do
		___writeDebugInfo("\t\t" .. __fight_debug_skill_influence_type_info["" .. fightBuff.skillInfluence.skillCategory .. ""] .. "\r\n")
	end
	--]]

	-- 设置当前行动的阵营
	self.battleTag = 0

	if(battleObject.isDead ) then
		if(battleObject.battleTag == 0) then
			self.attackObjects[battleObject.coordinate ] = nil
		else
			self.byAttackObjects[battleObject.coordinate ] = nil
		end
		self.fightOrderList[k] = nil
	else
		if(battleObject.isDizzy or battleObject.isParalysis or battleObject.isCripple or true == battleObject.revived or false == self:checkHasByAttacker(battleObject)) then
			if (attackOver ~= 0) then
				--_crint("1回合：" .. roundCount)
				table.insert(resultBuffer, "0")
				table.insert(resultBuffer, IniUtil.compart)
			end
			table.insert(resultBuffer, battleObject.battleTag)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, battleObject.coordinate)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, battleObject.healthPoint)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, battleObject.skillPoint)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, battleObject.commonSkillMould.id)
			table.insert(resultBuffer, IniUtil.compart)
			battleObject:processUserBuffEffect(userInfo, self, resultBuffer)
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, 0)
			table.insert(resultBuffer, IniUtil.compart)
			-- TODO....
			self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
			attackOver = 1
			--continue
			battleObject.normalSkillMouldOpened = false

			battleObject.isAction = true
		else
			
			local battleSkillList = nil
			local skillReleasePosion = 0
			local goon = true
			-- 处理怒气攻击, 包括buff 和攻击技能
			if true ~= battleObject.skipSuperSkillMould and nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP or self.canFreeSkill == true) and battleObject.isDisSp ~= true) then
				local  realSkillMould = battleObject.specialSkillMould.id
				-- print("我方释放必杀技：", battleObject.coordinate, "技能ID:", realSkillMould)
				if (attackOver ~= 0)then
					table.insert(resultBuffer, "0")
					table.insert(resultBuffer, IniUtil.compart)
					--_crint("2回合：" + roundCount)
				end
				-- battleObject:processUserBuffEffect(userInfo, self, self.buffBuffer)
				table.insert(self.buffBuffer, 0)
				table.insert(self.buffBuffer, IniUtil.compart)

				table.insert(self.headBuffer, battleObject.battleTag)
				table.insert(self.headBuffer, IniUtil.compart)
				table.insert(self.headBuffer, battleObject.coordinate)
				skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition

				if(hasZoumarSkill == true and self.canFreeSkill == true) then
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, #battleObject.fitBattleObjects)
					battleObject:subZomSkillPoint(5)
					self:fitFight(battleObject,battleObject.fitBattleObjects, userInfo)
					-- battleObject.isAction = true
					battleSkillList = {}
					skillReleasePosion = battleObject.zoariumSkillMould.skillReleasePosition
					realSkillMould = battleObject.zoariumSkillMould.id
				else
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, 0)
					battleSkillList = battleObject.oneselfBattleSkill
				end
				table.insert(self.headBuffer, IniUtil.compart)
				if(battleObject.battleTag == 0) then
					local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects)
					table.insert(self.bodyBuffer, movePos)
					----_crint ("Move pos 0 : " .. movePos)
					--os.exit()
				else
					local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects)
					table.insert(self.bodyBuffer, movePos)
					----_crint ("Move pos 1 : " .. movePos)
					--os.exit()
				end
				table.insert(self.bodyBuffer, IniUtil.compart)
				table.insert(self.bodyBuffer, realSkillMould)
				table.insert(self.bodyBuffer, IniUtil.compart)

				-- battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
				IniUtil.concatTable(self.bodyBuffer, self.buffBuffer)

				battleObject._isAction = true
				battleObject.powerSkillUseCount = battleObject.powerSkillUseCount + 1

				--[[输出攻击过程信息
				___writeDebugInfo("\t当前发动绝技攻击\r\n")
				--]]
			else
				battleObject._isAction = nil
				-- 处理普通攻击, 包括buff 和攻击技能
				if(battleObject.isParalysis) then
					if (attackOver ~= 0) then
						table.insert(resultBuffer, "0")
						table.insert(resultBuffer, IniUtil.compart)
						--_crint("3回合：" + roundCount)
					end
					table.insert(self.headBuffer, battleObject.battleTag)
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, battleObject.coordinate)
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, 0)
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, battleObject.healthPoint)
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, battleObject.skillPoint)
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.bodyBuffer, 0)
					table.insert(self.bodyBuffer, IniUtil.compart)
					table.insert(self.bodyBuffer, battleObject.commonSkillMould.id)
					table.insert(self.bodyBuffer, IniUtil.compart)
					battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
					table.insert(self.bodyBuffer, 0)
					table.insert(self.bodyBuffer, IniUtil.compart)
					table.insert(self.bodyBuffer, 0)
					table.insert(self.bodyBuffer, IniUtil.compart)
					table.insert(self.bodyBuffer, 0)
					table.insert(self.bodyBuffer, IniUtil.compart)
					-- TODO....
					self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
					attackOver = 1
					goon = false
					--continue
					battleObject.normalSkillMouldOpened = false
				else
					
					if (attackOver ~= 0) then
						table.insert(resultBuffer, "0")
						table.insert(resultBuffer, IniUtil.compart)
						--_crint("4回合：" + roundCount)
					end
					table.insert(self.headBuffer, battleObject.battleTag)
					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, battleObject.coordinate)

					table.insert(self.headBuffer, IniUtil.compart)
					table.insert(self.headBuffer, 0)
					table.insert(self.headBuffer, IniUtil.compart)
					
					local skillId = 0
					if true == battleObject.normalSkillMouldOpened then
						battleSkillList = battleObject.normalBattleSkill
						skillReleasePosion = battleObject.normalSkillMould.skillReleasePosition
						battleObject.normalSkillMouldOpened = false
						skillId = battleObject.normalSkillMould.id
						battleObject.normalSkillUseCount = battleObject.normalSkillUseCount + 1

						--[[输出攻击过程信息
						___writeDebugInfo("\t当前发动小技能攻击\r\n")
						--]]
					else
						battleSkillList = battleObject.commonBattleSkill
						skillReleasePosion = battleObject.commonSkillMould.skillReleasePosition
						skillId = battleObject.commonSkillMould.id

						--[[输出攻击过程信息
						___writeDebugInfo("\t当前发动普通攻击\r\n")
						--]]
					end

					if(battleObject.battleTag == 0) then							
						table.insert(self.bodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects))
					else
						table.insert(self.bodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects))
					end
					table.insert(self.bodyBuffer, IniUtil.compart)
					-- table.insert(self.bodyBuffer, battleObject.commonSkillMould.id)
					table.insert(self.bodyBuffer, skillId)
					table.insert(self.bodyBuffer, IniUtil.compart)
					
					battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
				end
			end
			if (goon) then -- 麻痹后不走这里
				--  处理普通或者怒气攻击 技能效用
				local tmpBattleSkillBuffer = {}
				local hasRestrain = 0
				local byAttackCoordinates = {}
				local tempByAttackCoordinates = nil
				battleObject.byEffectCoordinateList = nil
				local attackTargetIndex = 0
				if(battleObject.isDead ~= true) then
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
						-- 触发攻击前的天赋
						local attackObjects = nil
						local byAttackObjects = nil
						if battleObject.battleTag == 0 then
							attackObjects = self.attackObjects
							byAttackObjects = self.byAttackObjects
						else
							attackObjects = self.byAttackObjects
							byAttackObjects = self.attackObjects
						end
						local buffBattleSkill = {effectAmount = 0}
						local buffBuffer = {}
						TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_OPPONENT_FOR_ATTACK_BEFORE, battleObject, nil, battleSkillList[1].skillMould, self)
						battleObject:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_OPPONENT_FOR_ATTACK_BEFORE, self, userInfo, battleObject, nil, nil, attackObjects, byAttackObjects, buffBattleSkill, buffBuffer )
						battleObject:clearTalentJudgeResultList()
					end
					local lastBattleSkill = nil
					for _, battleSkill in pairs(battleSkillList) do
						-- if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or 
						-- 	battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP)then
						-- 	byAttackCoordinates = {}
						-- end

						local attackSkill = battleSkill
						attackSkill.formulaInfo = battleSkill.skillInfluence.formulaInfo
						local battleTag = battleObject.battleTag
						local influenceGroup = attackSkill.skillInfluence.influenceGroup
						local formulaInfo = attackSkill.skillInfluence.formulaInfo
						local skillInfluence =  attackSkill.skillInfluence

						local needInitAttackTarget = true
						if skillInfluence.influenceRange == 24 then
							if nil ~= tempByAttackCoordinates then
								needInitAttackTarget = false
							end
						end

						if true == needInitAttackTarget then
							if (formulaInfo ~= FightUtil.FORMULA_INFO_FORTHWITH) then
								byAttackCoordinates= {}
								if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
									or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects, self.byAttackTargetTag)
								else
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects, self.byAttackTargetTag)
								end
							else
								local tempList = {}
								if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
									or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
									tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects, self.byAttackTargetTag)
								else
									tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects, self.byAttackTargetTag)
								end
								if (#byAttackCoordinates == 0)then
									byAttackCoordinates = tempList
								else
									local realCoordinates = {}
									for i,v in pairs(byAttackCoordinates) do
										for z,k in pairs(tempList) do
											if(v == k) then
												table.insert(realCoordinates,v)
											end
										end
									end
									byAttackCoordinates = realCoordinates
									attackSkill.formulaInfo = lastBattleSkill.formulaInfo
								end
							end
						end

						if skillInfluence.influenceRange == 24 then
							attackTargetIndex = attackTargetIndex + 1

							if nil == tempByAttackCoordinates then
								tempByAttackCoordinates = byAttackCoordinates
							end

							byAttackCoordinates = {tempByAttackCoordinates[attackTargetIndex]}
						end

						if (0 == battleObject.battleTag) then
							if(influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE) then
								if(hasRestrain == 0) then
									hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
								end
								attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
							elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE)then
								if(hasRestrain == 0)then
									hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
								end
								attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
							elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								if(hasRestrain == 0)then
									hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
								end
								attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
							end
						else
							if(influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)then
								if(hasRestrain == 0)then
									hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
								end
								attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
							elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
								if(hasRestrain == 0)then
									hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
								end
								attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
							elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								if(hasRestrain == 0) then
									hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
								end
								attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
							end
						end
						lastBattleSkill = attackSkill
					end
				end
				IniUtil.concatTable(resultBuffer, self.headBuffer)
				
				table.insert(resultBuffer, battleObject.healthPoint)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, battleObject.skillPoint)
				table.insert(resultBuffer, IniUtil.compart)

				table.insert(resultBuffer, hasRestrain)
				table.insert(resultBuffer, IniUtil.compart)
				IniUtil.concatTable(resultBuffer, self.bodyBuffer)
				table.insert(resultBuffer, self.battleSkillCount)
				table.insert(resultBuffer, IniUtil.compart)
				IniUtil.concatTable(resultBuffer, tmpBattleSkillBuffer)
				
				
				if(hasZoumarSkill == true and self.canFreeSkill == true) then
					----_crint("合击数量 " + battleObject.fitBattleObjects.size())
					table.insert(resultBuffer, tonumber(#battleObject.fitBattleObjects))
					
					table.insert(resultBuffer, IniUtil.compart)
					if(self.fitBuffer ~= nil) then
						----_crint("合体技能： " + fitBuffer.toString())
						IniUtil.concatTable(resultBuffer, self.fitBuffer)
					end
					self.canFreeSkill = false
				end
				
				IniUtil.concatTable(resultBuffer, self.battleSkillBuffer)
				if(nil ~= self.counterBuffer)then
					IniUtil.concatTable(resultBuffer, self.counterBuffer)
					self.counterBuffer = nil
				else
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
				end
				self.battleSkillCount = 0
				table.insert(resultBuffer, 0)
				table.insert(resultBuffer, IniUtil.compart)
				if battleObject.isDead == true then
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
				end
				self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
				if true == battleObject._isAction then
					battleObject.isAction = false
					battleObject._isAction = nil
					-- if battleObject.skillPoint >= FightModule.MAX_SP then
					-- 	table.insert(actorList, 1, k)
					-- end

					if battleObject.shipMould == 6 and battleObject.inhaleHpDamagePercent > 0 then
						battleObject:clearBuffByTypeInhaleHp()
					end

				end
			end  -- 麻痹后不走这里
		end  --眩晕判断结束  眩晕不走下面的代码
	end  -- 死亡判断结束
	-- table.insert(resultBuffer, "1")
	-- self:checkFightResult()
	-- self:checkHasNextRound()
	if(self:checkLessIsDizzy()) then 
		for s, tempObject in pairs(self.attackObjects) do
			if(tempObject ~= nil) then
				if tempObject.isAction ~= true then
					if(tempObject.isDizzy) then
						tempObject.isAction = true
						table.insert(resultBuffer, tempObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, tempObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(self.headBuffer, battleObject.healthPoint)
						table.insert(self.headBuffer, IniUtil.compart)
						table.insert(self.headBuffer, battleObject.skillPoint)
						table.insert(self.headBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, tempObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
						tempObject:processUserBuffEffect(userInfo, self, resultBuffer)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
					end
				end
			end
		end
	end

	-- _crint("是否需要请求下一场战斗",self.hasNextRound)
	--local temp =""
	--for k = 1, #resultBuffer do
	--temp = temp..resultBuffer[k]
	--end
	-- _crint(temp)

	-- battleObject.isAction = true

	-- if __lua_project_id == __lua_project_l_digital 
 --        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
 --        then
	-- 	if battleObject.normalSkillMouldOpened then
	-- 		battleObject.isAction = false
	-- 	end
	-- end

	--[[输出攻击过程信息
	___writeDebugInfo("行动结束->" .. "攻击方：" .. battleObject.battleTag .. "\t攻击者站位：" .. battleObject.coordinate .. "\r\n\r\n")
	--]]

	local isAttackState = _ED._fightModule:checkAttackSell(true)
	if isAttackState ~= true then
		self.lastBattleTag = 1
		self:checkChangeBattleTag()
		if self.attackerSpeedValue < self.byAttackerSpeedValue then
			self:checkRoundCountChange()
		end
	end

	self:checkFightResult()
	self:checkDefenceResult()
	self:checkHasNextRound()
end

--获取一回合的攻击数据。不包括已出手的
function FightModule:rountdFight(resultBuffer)
	self.waitAttack = false

	--回合数+1
	local isFrist = self:getBattleObjectSite()

	-- 当前出手是第一次出手
	if(tonumber(isFrist) == 1) then 
		-- _crint("----------------------------------------------------")
		-- self:resetActionStatus()
		self:clearAttacksStatus()
	end

	local isAllFight = true
	if (_ED._fightModule.attackerSpeedValue < _ED._fightModule.byAttackerSpeedValue and _ED._fightModule:checkByAttackSell() == true) then
		-- for i, v in pairs(self.attackObjects) do
		-- 	v.isAction = false
		-- end
	else
		for k,v in pairs(self.attackObjects) do
			if nil ~= v or v.battleTag == 0 then
				if v.isAction ~= true then
					isAllFight = false
					-- break
				end
			end
		end
	end
	-- _crint("我方是否全部出手",isAllFight)
	if isAllFight == true then
		self.battleTag = 1
	else
		self.battleTag = 0
		-- return
	end
	-- _crint("9++++++++++++++",self.battleTag)

	-- self:checkChangeBattleTag()
	
	local attackOver = 0
	table.insert(resultBuffer, self.roundCount)
	table.insert(resultBuffer, IniUtil.enter)
	-- 检查是否有合击技能
	local needNext = true
	-- for k, v in pairs(self.fightOrderList) do
	-- 	local battleObject = self.fightOrderList[k]
	-- 	if(battleObject ~= nil and true ~= battleObject.revived) then
	-- 		-- _crint("出手",self.battleTag,battleObject.battleTag)
	-- 		if tonumber(battleObject.battleTag) ~= tonumber(self.battleTag) then
	-- 		else
			
	-- 		self.counterBuffer = nil
	-- 		self.battleSkillCount = 0
	-- 		self.battleSkillBuffer = {}
	-- 		if battleObject.isAction ~= true then
	-- 			self.currentObject  = battleObject

	-- 			self.headBuffer = {}
	-- 			self.bodyBuffer = {}
	-- 			self.buffBuffer = {}
	-- 			battleObject.fitBattleObjects = {}
	-- 			if(battleObject.battleTag == 0) then
	-- 				battleObject:checkBattleObject(self.attackObjects)
	-- 			else
	-- 				battleObject:checkBattleObject(self.byAttackObjects)
	-- 			end
	-- 			self.fitBuffer = nil
	-- 			local hasZoumarSkill = false
	-- 			if(battleObject.battleTag == 0) then
	-- 				hasZoumarSkill = battleObject:checkState(self.attackObjects)
	-- 			else
	-- 				hasZoumarSkill = battleObject:checkState(self.byAttackObjects)
	-- 			end
	-- 			if(hasZoumarSkill == true and battleObject.isDizzy ~= true) then
	-- 				needNext = false
	-- 				battleObject.effectDamage = 0
	-- 				battleObject.effectDamage = 0
	-- 				battleObject.totalEffectDamage = 0
	-- 				battleObject.reboundDamageValueResult = 0

	-- 				if(battleObject.isDead) then
	-- 					if(battleObject.battleTag == 0) then
	-- 						self.attackObjects[battleObject.coordinate ] = nil
	-- 					else
	-- 						self.byAttackObjects[battleObject.coordinate ] = nil
	-- 					end
	-- 					self.fightOrderList[k] = nil
	-- 					self.counterBuffer = nil
	-- 					self.battleSkillBuffer = {}
	-- 					--k = k - 1
	-- 				else
	-- 					local battleSkillList = nil
	-- 					local skillReleasePosion = 0
	-- 					local  realSkillMould = battleObject.specialSkillMould.id
	-- 					local goon = true
	-- 					-- 处理怒气攻击, 包括buff 和攻击技能
	-- 					if (attackOver ~= 0)then
	-- 						table.insert(resultBuffer, "0")
	-- 						table.insert(resultBuffer, IniUtil.compart)
	-- 						-- --_crint("4回合：" + self.roundCount)
	-- 					end
	-- 					battleObject:processUserBuffEffect(userInfo, self, self.buffBuffer)
	-- 					table.insert(self.headBuffer, battleObject.battleTag)
	-- 					table.insert(self.headBuffer, IniUtil.compart)
	-- 					table.insert(self.headBuffer, battleObject.coordinate)
	-- 					skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition
	-- 					if(hasZoumarSkill == true) then
	-- 						table.insert(self.headBuffer, IniUtil.compart)
	-- 						table.insert(self.headBuffer, #battleObject.fitBattleObjects)
	-- 						battleObject:subZomSkillPoint(5)
	-- 						battleObject.isNeedAddSkillPoint = false
	-- 						self:fitFight(battleObject,battleObject.fitBattleObjects, userInfo)
	-- 						battleObject.isAction = true
	-- 						battleSkillList = {}
	-- 						skillReleasePosion = battleObject.zoariumSkillMould.skillReleasePosition
	-- 						realSkillMould = battleObject.zoariumSkillMould.id
	-- 					else
	-- 						table.insert(self.headBuffer, IniUtil.compart)
	-- 						table.insert(self.headBuffer, 0)
	-- 						battleSkillList = battleObject.oneselfBattleSkill
	-- 					end
	-- 					table.insert(self.headBuffer, IniUtil.compart)
	-- 					if(battleObject.battleTag == 0) then
	-- 						local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects)
	-- 						table.insert(self.bodyBuffer, movePos)
	-- 						----_crint ("Move pos 0 : " .. movePos)
	-- 						--os.exit()
	-- 					else
	-- 						local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects)
	-- 						table.insert(self.bodyBuffer, movePos)
	-- 						----_crint ("Move pos 1 : " .. movePos)
	-- 						--os.exit()
	-- 					end
	-- 					table.insert(self.bodyBuffer, IniUtil.compart)
	-- 					table.insert(self.bodyBuffer, realSkillMould)
	-- 					table.insert(self.bodyBuffer, IniUtil.compart)
	-- 					-- battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
	-- 					IniUtil.concatTable(self.bodyBuffer, self.buffBuffer)
	-- 					--  处理普通或者怒气攻击 技能效用
	-- 					local tmpBattleSkillBuffer = {}
	-- 					local hasRestrain = 0
	-- 					local byAttackCoordinates = {}
	-- 					if(goon) then
	-- 						if(battleObject.isDead ~= true) then
	-- 							local lastBattleSkill = nil
	-- 							for _, battleSkill in pairs(battleSkillList) do
	-- 								-- if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or 
	-- 								-- 	battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP)then
	-- 								-- 	byAttackCoordinates = {}
	-- 								-- end
	-- 								local attackSkill = battleSkill
	-- 								attackSkill.formulaInfo = battleSkill.skillInfluence.formulaInfo
	-- 								local battleTag = battleObject.battleTag
	-- 								local influenceGroup = attackSkill.skillInfluence.influenceGroup
	-- 								local formulaInfo = attackSkill.skillInfluence.formulaInfo
	-- 								local skillInfluence =  attackSkill.skillInfluence
									
	-- 								if (formulaInfo ~= FightUtil.FORMULA_INFO_FORTHWITH) then
	-- 									byAttackCoordinates= {}
	-- 									if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
	-- 										or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
	-- 										byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
	-- 									else
	-- 										byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
	-- 									end
	-- 								else
	-- 									local tempList = {}
	-- 									tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
	-- 									-- if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
	-- 									-- 	or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
	-- 									-- 	tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
	-- 									-- else
	-- 									-- 	tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
	-- 									-- end
	-- 									if (#byAttackCoordinates == 0)then
	-- 										byAttackCoordinates = tempList
	-- 									else
	-- 										local realCoordinates = {}
	-- 										for i,v in pairs(byAttackCoordinates) do
	-- 											for z,k in pairs(tempList) do
	-- 												if(v == k) then
	-- 													table.insert(realCoordinates,v)
	-- 												end
	-- 											end
	-- 										end
	-- 										byAttackCoordinates = realCoordinates
	-- 										attackSkill.formulaInfo = lastBattleSkill.formulaInfo
	-- 									end
	-- 								end
	-- 								if (0 == battleTag) then
	-- 									if(influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE) then
	-- 										if(hasRestrain == 0) then
	-- 											hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
	-- 										end
	-- 										attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
	-- 									elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE)then
	-- 										if(hasRestrain == 0)then
	-- 											hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
	-- 										end
	-- 										attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
	-- 									elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
	-- 										byAttackCoordinates = {}
	-- 										table.insert(byAttackCoordinates, battleObject.coordinate)
	-- 										if(hasRestrain == 0)then
	-- 											hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
	-- 										end
	-- 										attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
	-- 									end
	-- 								else
	-- 									if(influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)then
	-- 										if(hasRestrain == 0)then
	-- 											hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
	-- 										end
	-- 										attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
	-- 									elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
	-- 										if(hasRestrain == 0)then
	-- 											hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
	-- 										end
	-- 										attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
	-- 									elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
	-- 										byAttackCoordinates = {}
	-- 										table.insert(byAttackCoordinates, battleObject.coordinate)
	-- 										if(hasRestrain == 0) then
	-- 											hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
	-- 										end
	-- 										attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
	-- 									end
	-- 								end
	-- 								lastBattleSkill = battleSkill
	-- 							end
	-- 						end
	-- 					end
	-- 					IniUtil.concatTable(resultBuffer, self.headBuffer)

	-- 					table.insert(resultBuffer, battleObject.healthPoint)
	-- 					table.insert(resultBuffer, IniUtil.compart)
	-- 					table.insert(resultBuffer, battleObject.skillPoint)
	-- 					table.insert(resultBuffer, IniUtil.compart)

	-- 					table.insert(resultBuffer, hasRestrain)
	-- 					table.insert(resultBuffer, IniUtil.compart)
	-- 					IniUtil.concatTable(resultBuffer, self.bodyBuffer)
	-- 					if hasZoumarSkill then
	-- 						table.insert(resultBuffer, 0)
	-- 					else
	-- 						table.insert(resultBuffer, self.battleSkillCount)
	-- 					end
	-- 					table.insert(resultBuffer, IniUtil.compart)
	-- 					IniUtil.concatTable(resultBuffer, tmpBattleSkillBuffer)
						
	-- 					if hasZoumarSkill then
	-- 						table.insert(resultBuffer, #battleObject.fitBattleObjects)
	-- 						table.insert(resultBuffer, IniUtil.compart)
	-- 						if(self.fitBuffer ~= nil) then
	-- 							IniUtil.concatTable(resultBuffer, self.fitBuffer)
	-- 						end
	-- 					end
						
						
	-- 					self.canFreeSkill = false
	-- 					IniUtil.concatTable(resultBuffer, self.battleSkillBuffer)
	-- 					if(nil ~= counterBuffer)then
	-- 						IniUtil.concatTable(resultBuffer, counterBuffer)
	-- 						counterBuffer = nil
	-- 					else
	-- 						table.insert(resultBuffer, 0)
	-- 						table.insert(resultBuffer, IniUtil.compart)
	-- 					end
	-- 					self.battleSkillCount = 0
	-- 					table.insert(resultBuffer, 0)
	-- 					table.insert(resultBuffer, IniUtil.compart)
	-- 					attackOver = 1
	-- 					self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
	-- 					battleObject:restoreBuffState()

	-- 				end  -- 死亡判断结束
	-- 				battleObject.isAction = false
	-- 				-- battleObject.isNeedAddSkillPoint = true
	-- 				table.insert(resultBuffer, 1)
	-- 				table.insert(resultBuffer, IniUtil.compart)
	-- 				self:checkHasNextRound()
	-- 				self:checkDefenceResult()
	-- 				break
	-- 			end
	-- 		end
	-- 		end
	-- 	end
	-- end
	-- -- _crint("是否需要请求下一场战斗",needNext)
	-- if needNext == false then
	-- 	return
	-- end

	local actorList = {}

	for k, v in pairs(self.fightOrderList) do
		local battleObject = self.fightOrderList[k]
		if(battleObject ~= nil) then
			if battleObject.battleTag == self.battleTag then
				if true ~= battleObject.skipSuperSkillMould and (battleObject.skillPoint >= FightModule.MAX_SP and battleObject.isDisSp ~= true) then
					battleObject._insertSuperSkillMould = true
					table.insert(actorList, k)
				end
			end
		end
	end

	for k, v in pairs(self.fightOrderList) do
		local battleObject = self.fightOrderList[k]
		if(battleObject ~= nil and true ~= battleObject.isDead) then
			if battleObject.battleTag == self.battleTag then
				-- _crint("pos:", k, battleObject.normalSkillMouldOpened,  battleObject._insertSuperSkillMould)
				-- if true == battleObject.normalSkillMouldOpened 
				-- 	or true ~= battleObject._insertSuperSkillMould
				-- 	then
					table.insert(actorList, k)
				-- end
			end
			battleObject._insertSuperSkillMould = false
		end
	end

	-- _crint("=============================================",#self.fightOrderList)
	-- _crint("#self.fightOrderList",#self.fightOrderList)
	-- for k = 1,  #self.fightOrderList do
	-- for k, v in pairs(self.fightOrderList) do
	-- 	local battleObject = self.fightOrderList[k]
	-- for i, v in pairs(actorList) do
	while #actorList > 0 do
		local k = table.remove(actorList, 1, 1)
		local battleObject = self.fightOrderList[k]
		if(battleObject ~= nil) then
			--[[输出攻击过程信息
			___writeDebugInfo("--------------------------------------------------------\r\n")
			___writeDebugInfo("处理攻击者的战斗过程数据：\r\n")
			___writeDebugInfo("\t当前的回合数：" .. self.roundCount .. "\r\n")
			___writeDebugInfo("\t攻击方：" .. battleObject.battleTag .. "\t攻击者站位：" .. battleObject.coordinate .. "\r\n")
			___writeDebugInfo("\t攻击者当前拥有的BUFF信息：" .. "\r\n")
			for idx, fightBuff in pairs(battleObject.buffEffect) do
				___writeDebugInfo("\t\t" .. __fight_debug_skill_influence_type_info["" .. fightBuff.skillInfluence.skillCategory .. ""] .. "\r\n")
			end
			--]]

			-- _crint("11出手",self.battleTag,battleObject.battleTag)
			if tonumber(battleObject.battleTag) ~= tonumber(self.battleTag) then
			else
				-- 添加跳过战斗的攻击连击加成
				if tonumber(battleObject.battleTag) == 0 then
					local t = {0,	5,	10,	15}
					local grade = t[math.random(1, 4)]
					self:setGradeAttack(battleObject,grade, 0)
				end

				local isLast = self:findIsAllAttack(battleObject)
				if(tonumber(isLast) == 1) then 
					self.greadCount = 0
				end
				--_crint("===========battleObject",battleObject)
				self.counterBuffer = nil
				self.battleSkillCount = 0
				self.battleSkillBuffer = {}
				-- _crint("是否已经出手过:",battleObject.isAction)
				-- _crint("出手坐标：",battleObject.battleTag.." "..battleObject.coordinate)
				if battleObject.isAction ~= true then		
					--_crint("出手坐标：",battleObject.battleTag.." "..battleObject.coordinate)
					--记录当前出手对象
					self.currentObject  = battleObject
					--获取下一个出手对象 
					-- self.nextFightObject = FightModule:getNextFightObject(k,self.fightOrderList)
					--_crint("下一个出手坐标："..self.nextFightObject.battleTag..self.nextFightObject.coordinate)
					--重置出手状态
					-- battleObject.isAction = true
					
					self.headBuffer = {}
					self.bodyBuffer = {}
					battleObject.fitBattleObjects = {}
					if(battleObject.battleTag == 0) then
						battleObject:checkBattleObject(self.attackObjects)
					else
						battleObject:checkBattleObject(self.byAttackObjects)
					end
					self.fitBuffer = nil
					local hasZoumarSkill = false
					-- if(battleObject.battleTag == 0) then
					-- 	hasZoumarSkill = battleObject:checkState(self.attackObjects)
					-- else
					-- 	hasZoumarSkill = battleObject:checkState(self.byAttackObjects)
					-- end
					battleObject.effectDamage = 0
					battleObject.totalEffectDamage = 0
					battleObject.reboundDamageValueResult = 0

					if(battleObject.isDead ) then
						if(battleObject.battleTag == 0) then
							self.attackObjects[battleObject.coordinate ] = nil
						else
							self.byAttackObjects[battleObject.coordinate ] = nil
						end
						self.fightOrderList[k] = nil
						--k = k - 1
						battleObject.normalSkillMouldOpened = false
					else
						-- print("出手信息：", battleObject.battleTag, battleObject.coordinate, battleObject.isDizzy, battleObject.isParalysis, battleObject.isCripple)
						if(battleObject.isDizzy or battleObject.isParalysis or battleObject.isCripple or true == battleObject.revived or false == self:checkHasByAttacker(battleObject)) then
							battleObject.isAction = true
							if (attackOver ~= 0) then
								-- --_crint("4回合：" + self.roundCount)
								table.insert(resultBuffer, "0")
								table.insert(resultBuffer, IniUtil.compart)
							end
							table.insert(resultBuffer, battleObject.battleTag)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.coordinate)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.healthPoint)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.skillPoint)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.commonSkillMould.id)
							table.insert(resultBuffer, IniUtil.compart)
							battleObject:processUserBuffEffect(userInfo, self, resultBuffer)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							-- TODO....
							self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
							attackOver = 1
							--continue
							battleObject.normalSkillMouldOpened = false

							battleObject.isAction = true
						else
							
							local battleSkillList = nil
							local skillReleasePosion = 0
							local goon = true
							-- 处理怒气攻击, 包括buff 和攻击技能
							if true ~= battleObject.skipSuperSkillMould and nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP) and battleObject.isDisSp ~= true) then
								local  realSkillMould = battleObject.specialSkillMould.id
								if (attackOver ~= 0)then
									table.insert(resultBuffer, "0")
									table.insert(resultBuffer, IniUtil.compart)
									-- --_crint("4回合：" + self.roundCount)
								end
								table.insert(self.headBuffer, battleObject.battleTag)
								table.insert(self.headBuffer, IniUtil.compart)
								table.insert(self.headBuffer, battleObject.coordinate)
								skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition
								if(hasZoumarSkill == true and self.canFreeSkill == true) then
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, #battleObject.fitBattleObjects)
									battleObject:subZomSkillPoint(5)
									self:fitFight(battleObject,battleObject.fitBattleObjects, userInfo)
									-- battleObject.isAction = true
									battleSkillList = {}
									skillReleasePosion = battleObject.zoariumSkillMould.skillReleasePosition
									realSkillMould = battleObject.zoariumSkillMould.id
								else
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, 0)
									battleSkillList = battleObject.oneselfBattleSkill
								end
								table.insert(self.headBuffer, IniUtil.compart)
								if(battleObject.battleTag == 0) then
									local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects)
									table.insert(self.bodyBuffer, movePos)
									----_crint ("Move pos 0 : " .. movePos)
									--os.exit()
								else
									local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects)
									table.insert(self.bodyBuffer, movePos)
									----_crint ("Move pos 1 : " .. movePos)
									--os.exit()
								end
								table.insert(self.bodyBuffer, IniUtil.compart)
								table.insert(self.bodyBuffer, realSkillMould)
								table.insert(self.bodyBuffer, IniUtil.compart)
								-- battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
								table.insert(self.bodyBuffer, 0)
								table.insert(self.bodyBuffer, IniUtil.compart)
								
								battleObject._isAction = true
								battleObject.powerSkillUseCount = battleObject.powerSkillUseCount + 1

								--[[输出攻击过程信息
								___writeDebugInfo("\t当前发动绝技攻击\r\n")
								--]]
							else
								-- battleObject.isAction = true
								battleObject._isAction = nil
								-- 处理普通攻击, 包括buff 和攻击技能
								if(battleObject.isParalysis) then
									if (attackOver ~= 0) then
										table.insert(resultBuffer, "0")
										table.insert(resultBuffer, IniUtil.compart)
										-- --_crint("4回合：" + self.roundCount)
									end
									table.insert(self.headBuffer, battleObject.battleTag)
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, battleObject.coordinate)
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, 0)
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, battleObject.healthPoint)
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, battleObject.skillPoint)
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.bodyBuffer, 0)
									table.insert(self.bodyBuffer, IniUtil.compart)
									table.insert(self.bodyBuffer, battleObject.commonSkillMould.id)
									table.insert(self.bodyBuffer, IniUtil.compart)
									battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
									table.insert(self.bodyBuffer, 0)
									table.insert(self.bodyBuffer, IniUtil.compart)
									table.insert(self.bodyBuffer, 0)
									table.insert(self.bodyBuffer, IniUtil.compart)
									table.insert(self.bodyBuffer, 0)
									table.insert(self.bodyBuffer, IniUtil.compart)
									-- TODO....
									self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
									attackOver = 1
									goon = false
									--continue

									battleObject.normalSkillMouldOpened = false
								else
									
									if (attackOver ~= 0) then
										table.insert(resultBuffer, "0")
										table.insert(resultBuffer, IniUtil.compart)
										-- --_crint("4回合：" + self.roundCount)
									end
									table.insert(self.headBuffer, battleObject.battleTag)
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, battleObject.coordinate)
				
									table.insert(self.headBuffer, IniUtil.compart)
									table.insert(self.headBuffer, 0)
									table.insert(self.headBuffer, IniUtil.compart)
									
									local skillId = 0
									if true == battleObject.normalSkillMouldOpened then
										battleSkillList = battleObject.normalBattleSkill
										skillReleasePosion = battleObject.normalSkillMould.skillReleasePosition
										battleObject.normalSkillMouldOpened = false
										skillId = battleObject.normalSkillMould.id
										battleObject.normalSkillUseCount = battleObject.normalSkillUseCount + 1

										--[[输出攻击过程信息
										___writeDebugInfo("\t当前发动小技能攻击\r\n")
										--]]
									else
										battleSkillList = battleObject.commonBattleSkill
										skillReleasePosion = battleObject.commonSkillMould.skillReleasePosition
										skillId = battleObject.commonSkillMould.id

										--[[输出攻击过程信息
										___writeDebugInfo("\t当前发动普通攻击\r\n")
										--]]
									end

									if(battleObject.battleTag == 0) then							
										table.insert(self.bodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects))
									else
										table.insert(self.bodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects))
									end
									table.insert(self.bodyBuffer, IniUtil.compart)
									-- table.insert(self.bodyBuffer, battleObject.commonSkillMould.id)
									table.insert(self.bodyBuffer, skillId)
									table.insert(self.bodyBuffer, IniUtil.compart)
									
									battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
								end
							end
							if(goon) then -- 麻痹后不走这里
								--  处理普通或者怒气攻击 技能效用
								local tmpBattleSkillBuffer = {}
								local hasRestrain = 0
								local byAttackCoordinates = {}
								local tempByAttackCoordinates = nil
								local attackTargetIndex = 0
								battleObject.byEffectCoordinateList = nil
								if(battleObject.isDead ~= true) then
									if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
										-- 触发攻击前的天赋
										local attackObjects = nil
										local byAttackObjects = nil
										if battleObject.battleTag == 0 then
											attackObjects = self.attackObjects
											byAttackObjects = self.byAttackObjects
										else
											attackObjects = self.byAttackObjects
											byAttackObjects = self.attackObjects
										end
										local buffBattleSkill = {effectAmount = 0}
										local buffBuffer = {}
										TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_OPPONENT_FOR_ATTACK_BEFORE, battleObject, nil, battleSkillList[1].skillMould, self)
										battleObject:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_OPPONENT_FOR_ATTACK_BEFORE, self, userInfo, battleObject, nil, nil, attackObjects, byAttackObjects, buffBattleSkill, buffBuffer )
										battleObject:clearTalentJudgeResultList()
									end
									local lastBattleSkill = nil
									for _, battleSkill in pairs(battleSkillList) do
										-- if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or 
										-- 	battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP)then
										-- 	byAttackCoordinates = {}
										-- end
										local attackSkill = battleSkill
										attackSkill.formulaInfo = battleSkill.skillInfluence.formulaInfo
										local battleTag = battleObject.battleTag
										local influenceGroup = attackSkill.skillInfluence.influenceGroup
										local formulaInfo = attackSkill.skillInfluence.formulaInfo
										local skillInfluence =  attackSkill.skillInfluence
										
										local needInitAttackTarget = true
										if skillInfluence.influenceRange == 24 then
											if nil ~= tempByAttackCoordinates then
												needInitAttackTarget = false
											end
										end

										if true == needInitAttackTarget then
											if (formulaInfo ~= FightUtil.FORMULA_INFO_FORTHWITH) then
												byAttackCoordinates= {}
												if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
													or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
													byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
												else
													byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
												end
											else
												local tempList = {}
												if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
													or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
													tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
												else
													tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
												end
												if (#byAttackCoordinates == 0)then
													byAttackCoordinates = tempList
												else
													local realCoordinates = {}
													for i,v in pairs(byAttackCoordinates) do
														for z,k in pairs(tempList) do
															if(v == k) then
																table.insert(realCoordinates,v)
															end
														end
													end
													byAttackCoordinates = realCoordinates
													attackSkill.formulaInfo = lastBattleSkill.formulaInfo
												end
											end
										end

										if skillInfluence.influenceRange == 24 then
											attackTargetIndex = attackTargetIndex + 1

											if nil == tempByAttackCoordinates then
												tempByAttackCoordinates = byAttackCoordinates
											end

											byAttackCoordinates = {tempByAttackCoordinates[attackTargetIndex]}
										end

										if (0 == battleObject.battleTag) then
											if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE) then
												if(hasRestrain == 0) then
													hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
												end
												attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
											elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE)then
												if(hasRestrain == 0)then
													hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
												end
												attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
											elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
												byAttackCoordinates = {}
												table.insert(byAttackCoordinates, battleObject.coordinate)
												if(hasRestrain == 0)then
													hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
												end
												attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
											end
										else
											if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)then
												if(hasRestrain == 0)then
													hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
												end
												attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
											elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
												if(hasRestrain == 0)then
													hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
												end
												attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
											elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
												byAttackCoordinates = {}
												table.insert(byAttackCoordinates, battleObject.coordinate)
												if(hasRestrain == 0) then
													hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
												end
												attackSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
											end
										end
										lastBattleSkill = battleSkill
									end
								end
								IniUtil.concatTable(resultBuffer, self.headBuffer)

								table.insert(resultBuffer, battleObject.healthPoint)
								table.insert(resultBuffer, IniUtil.compart)
								table.insert(resultBuffer, battleObject.skillPoint)
								table.insert(resultBuffer, IniUtil.compart)

								table.insert(resultBuffer, hasRestrain)
								table.insert(resultBuffer, IniUtil.compart)
								IniUtil.concatTable(resultBuffer, self.bodyBuffer)
								table.insert(resultBuffer, self.battleSkillCount)
								table.insert(resultBuffer, IniUtil.compart)
								IniUtil.concatTable(resultBuffer, tmpBattleSkillBuffer)
								if(hasZoumarSkill == true and self.canFreeSkill == true) then
									----_crint("合击数量 " + battleObject.fitBattleObjects.size())
									table.insert(resultBuffer, #battleObject.fitBattleObjects)
									table.insert(resultBuffer, IniUtil.compart)
									if(self.fitBuffer ~= nil) then
										IniUtil.concatTable(resultBuffer, self.fitBuffer)
									end
									self.canFreeSkill = false
								end
								IniUtil.concatTable(resultBuffer, self.battleSkillBuffer)
								if(nil ~= counterBuffer)then
									IniUtil.concatTable(resultBuffer, counterBuffer)
									counterBuffer = nil
								else
									table.insert(resultBuffer, 0)
									table.insert(resultBuffer, IniUtil.compart)
								end
								self.battleSkillCount = 0
								table.insert(resultBuffer, 0)
								table.insert(resultBuffer, IniUtil.compart)
								-- TODO....
								self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
								attackOver = 1
							end  -- 麻痹后不走这里
							battleObject:restoreBuffState()

							-- 释放了怒气技能，可以继续行动
							if true == battleObject._isAction then
								battleObject.isAction = false
								battleObject._isAction = nil
								if battleObject.skillPoint >= FightModule.MAX_SP then
									table.insert(actorList, 1, k)
								end
							end
						end  --眩晕判断结束  眩晕不走下面的代码
					end  -- 死亡判断结束
				end
				self:checkHasNextRound()
				self:checkDefenceResult()
			end

			--[[输出攻击过程信息
			___writeDebugInfo("行动结束->" .. "攻击方：" .. battleObject.battleTag .. "\t攻击者站位：" .. battleObject.coordinate .. "\r\n\r\n")
			--]]
		end
	-- 下面这段代码, 死亡后也会走, 不过下面这段代码是废代码, 所以可以不管
		-- if (self.attackCount <= 0 or self.byAttackCount<=0 ) then
		-- 	win = self.byAttackCount<=0
		-- 	fightOver = true
		-- 	self.fightResult = 0
		-- 	if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
		-- 		self.fightResult = 1
		-- 	end
		-- 	-- _crint("1111111111111111111111")
		-- 	break
		-- end

		
		if (self.hasNextRound == false) then
			-- _crint("2222222222222222222222222")
			break
		end
	end
	
	-- self:resetActionStatus()
	table.insert(resultBuffer, "1")
	-- local temp ="敌方，"
	-- for k = 1, #resultBuffer do
	-- temp = temp..resultBuffer[k]
	-- end
	-- _crint(temp)

	if self.byAttackerAttacking then
		self.byAttackerAttacking = false
		for i, v in pairs(self.attackObjects) do
			v.isAction = false
		end
	end

	local isAttackState = _ED._fightModule:checkAttackSell(true)
	if isAttackState == true then
		self.lastBattleTag = 1
	else
		self.lastBattleTag = 0
	end

	-- print(self.battleTag, self.lastBattleTag, self.roundCount)

	self:checkChangeBattleTag()

	if self.attackerSpeedValue < self.byAttackerSpeedValue then
		for i, v in pairs(self.attackObjects) do
			v.isAction = false
		end
		if self.battleTag == 0 then
			self:checkRoundCountChange()
		end 
	else
		if self.battleTag == 1 then
			self:checkRoundCountChange()
		end
	end

	self:checkHasNextRound()
	self:checkDefenceResult()

	-- if self.battleTag == 0 then
	-- 	self.battleTag = 1
	-- 	self:checkChangeBattleTag()
	-- else
	-- 	self.battleTag = 0
	-- 	self:checkChangeBattleTag()
	-- 	if(self.roundCount >= self.totalRound) then
	-- 		self.roundCount = self.totalRound
	-- 		if(self.roundCount == self.totalRound) then
	-- 			self.hasNextRound = false
	-- 			self.fightResult = 0
	-- 		end
	-- 		if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
	-- 			self.fightResult = 1
	-- 		end
	-- 	else
	-- 		self.roundCount = self.roundCount+1

	-- 		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then

	-- 			local buffBattleSkill = {effectAmount = 0}
	-- 			local buffBuffer = {}

	-- 			-- 9回合开始时判定
	-- 			for k, v in pairs(self.fightOrderList) do
	-- 				v.revived = false
	-- 				v:resetBuff()
	-- 				TalentJudge:judge(TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, v, nil, nil, self)
	-- 				if (v.battleTag == 0) then
	-- 					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, self, userInfo, v, nil, nil, self.attackObjects, self.byAttackObjects, buffBattleSkill, buffBuffer )
	-- 				else
	-- 					v:influenceTalentJudgeResults( TalentConstant.JUDGE_OPPORTUNITY_ATTACK_ROUND_START, self, userInfo, v, nil, nil, self.byAttackObjects, self.attackObjects, buffBattleSkill, buffBuffer )
	-- 				end
	-- 			end

	-- 			table.insert(buffBuffer, 1, NetworkProtocol.sequence)			-- seq
	-- 			table.insert(buffBuffer, 2, IniUtil.enter)
	-- 			table.insert(buffBuffer, 3, "environment_fight_battle_round")	-- cmdname
	-- 			table.insert(buffBuffer, 4, IniUtil.enter)
	-- 			table.insert(buffBuffer, 5, "0")								-- result
	-- 			table.insert(buffBuffer, 6, IniUtil.enter)
	-- 			table.insert(buffBuffer, 7, 14711)
	-- 			table.insert(buffBuffer, 8, IniUtil.enter)
	-- 			table.insert(buffBuffer, 9, self.roundCount)
	-- 			table.insert(buffBuffer, 10, IniUtil.enter)
	-- 			table.insert(buffBuffer, 11, buffBattleSkill.effectAmount)
	-- 			table.insert(buffBuffer, 12, IniUtil.enter)
				
	-- 			local protocalData = {}
	-- 			protocalData.resouce = table.concat(buffBuffer, "")
	-- 			NetworkProtocol.parser_func(protocalData)
	-- 		end
	-- 	end
	-- 	-- _crint("总回合数",self.roundCount,self.totalRound)
		
	-- 	self:resetActionStatus()
	-- end

	-- _crint("出手",self.battleTag)
end


function FightModule:fight(userInfo, resultBuffer)
	self.fightOrderList = {}
	self.attackCount = 0
	self.byAttackCount = 0
	local tempBattleCache = userInfo.battleCache
	self:initBattleInfo(tempBattleCache)
	self:initDailyInstance()
	self.roundCount = 1
	local fightOver = false
	local attackerCombatForce = tempBattleCache.attackCombatForce
	local byAttackerCombatForce = tempBattleCache.byAttackComobatForce
	
	local attackIndex = 1
	local byAttackIndex = 1
	local arrLength = #self.attackObjects
	local win = false
	local tempAttackObjects = self.attackObjects
	local tempByAttackObjects = self.byAttackObjects
	--_crint("AttackCombatForce type: " .. type(attackerCombatForce) .. attackerCombatForce)
	--_crint("byAttackerCombatForce type: " .. type(byAttackerCombatForce) .. byAttackerCombatForce)
	--_crint ("attack object size: " .. #tempAttackObjects)
	if (tonumber(attackerCombatForce) < tonumber(byAttackerCombatForce)) then
		tempAttackObjects = self.byAttackObjects
		tempByAttackObjects = self.attackObjects
	end	
	
	--- 生成战战斗对象序列
	for i = 1, 6 do
		
		if (tempAttackObjects[i] ~= nil) then
			table.insert(self.fightOrderList, tempAttackObjects[i])
			if(tempAttackObjects[i].battleTag == 0) then
				self.attackCount = self.attackCount + 1
			else
				self.byAttackCount = self.byAttackCount + 1
			end
		end
		
		if (tempByAttackObjects[i] ~= nil) then
			table.insert(self.fightOrderList, tempByAttackObjects[i])
			if(tempByAttackObjects[i].battleTag == 0) then
				self.attackCount = self.attackCount + 1
			else
				self.byAttackCount = self.byAttackCount + 1
			end
		end
	end
	
	for k, obj in pairs(self.fightOrderList) do
		--_crint(k, obj.battleTag, obj.coordinate)
	end
	-- os.exit()
	--_crint("attackCount = " .. self.attackCount)
	--_crint("byAttackCount = " .. self.byAttackCount)
	--_crint("fightType = " .. self.fightType)
	--_crint("self.roundCount = " .. self.roundCount)
	--_crint("self.totalRound = " .. self.totalRound)
	--_crint(self.fightOrderList)
	-- os.exit()
	self.talentSelfTailBuffer = {}
	while(fightOver ~= true) do
		if (self.attackCount <= 0 or self.byAttackCount <= 0) then
			win = self.byAttackCount <= 0
			fightOver = true			
			self.hasNextRound = false;
			if self.attackCount <= 0 then
				self.fightResult = 0
				if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
					self.fightResult = 1
				end
			else
				self.fightResult = 1
			end
			break
		end
		if(self.roundCount == self.totalRound) then
			win = self.fightType == FightModule.FIGHT_TYPE_PVE_MONEY_TREE
			fightOver = true
			hasNextRound = false;
			self.fightResult = 0
			if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
				self.fightResult = 1
			end
			break
		end
		self:resetActionStatus(true)
		self.roundCount = self.roundCount + 1
 		local nowAttackHeathPoint = self:getBattleObjectHeathPoint(self.attackObjects)
		local nowDefenceHeathPoint = self:getBattleObjectHeathPoint(self.byAttackObjects)

		table.insert(resultBuffer, IniUtil.enter)
		table.insert(resultBuffer, self.roundCount)
		table.insert(resultBuffer, IniUtil.enter)
		local attackOver = 0

		local backedFightOrderList = self.fightOrderList
		self.fightOrderList = {}		
		-- for k = 1, #backedFightOrderList do
		for k, v in pairs(backedFightOrderList) do
			local battleObj = backedFightOrderList[k]
			if (battleObj ~= nil and battleObj.isDead ~= true)  then
				self.fightOrderList[#self.fightOrderList + 1] = battleObj
				--_crint ("backedFightOrderList[k].coordinate)
			end
		end

		backedFightOrderList = nil
		
		-- for k = 1,  #self.fightOrderList do
		for k, v in pairs(self.fightOrderList) do
			if (self.attackCount <= 0 or self.byAttackCount<=0) then
				win = self.byAttackCount<=0
				fightOver = true
				self.hasNextRound = false;
				if self.attackCount <= 0 then
					self.fightResult = 0
					if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
						self.fightResult = 1
					end
				else
					self.fightResult = 1
				end
				break
			end
			self.counterBuffer = nil
			self.battleSkillCount = 0
			self.battleSkillBuffer = {}
			for i = 1, 6 do
				if(nil ~= self.attackObjects[i]) then
					self.attackObjects[i].canReAttack = true
					self.attackObjects[i].talentJudgeResultList = {}
				end
			end
			for i = 1, 6 do
				if(nil ~= self.byAttackObjects[i]) then
					self.byAttackObjects[i].canReAttack = true
					self.byAttackObjects[i].talentJudgeResultList = {}
				end
			end
			local battleObject = self.fightOrderList[k]
			--_crint("出手坐标："..battleObject.battleTag..battleObject.coordinate)
			--记录当前出手对象
			self.currentObject  = battleObject
			--获取下一个出手对象 
			self.nextFightObject = FightModule:getNextFightObject(k,self.fightOrderList)
			--_crint("下一个出手坐标："..self.nextFightObject.battleTag..self.nextFightObject.coordinate)
			--重置出手状态
			-- battleObject.isAction = true
			
			self.headBuffer = {}
			self.bodyBuffer = {}
			battleObject.fitBattleObjects = {}
			if(battleObject.battleTag == 0) then
				battleObject:checkBattleObject(self.attackObjects)
			else
				battleObject:checkBattleObject(self.byAttackObjects)
			end
			self.fitBuffer = nil
			local hasZoumarSkill = false
			if(battleObject.battleTag == 0) then
				hasZoumarSkill = battleObject:checkState(self.attackObjects)
			else
				hasZoumarSkill = battleObject:checkState(self.byAttackObjects)
			end
			battleObject.effectDamage = 0
			battleObject.totalEffectDamage = 0

			if(battleObject.isDead ) then
				if(battleObject.battleTag == 0) then
					self.attackObjects[battleObject.coordinate ] = nil
				else
					self.byAttackObjects[battleObject.coordinate ] = nil
				end
				self.fightOrderList[k] = nil
				k = k - 1
				battleObject.normalSkillMouldOpened = false
			else
				if(battleObject.isDizzy) then
					if (attackOver ~= 0) then
						----_crint("1回合：" .. roundCount)
						table.insert(resultBuffer, "0")
						table.insert(resultBuffer, IniUtil.compart)
					end
					table.insert(resultBuffer, battleObject.battleTag)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, battleObject.coordinate)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, battleObject.commonSkillMould.id)
					table.insert(resultBuffer, IniUtil.compart)
					battleObject:processUserBuffEffect(userInfo, self, resultBuffer)
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, 0)
					table.insert(resultBuffer, IniUtil.compart)
					-- TODO....
					self:talentSelfTailFight(userInfo, battleObject, resultBuffer)
					attackOver = 1
					--continue
					battleObject.normalSkillMouldOpened = false
				else
					
					local battleSkillList = nil
					local skillReleasePosion = 0
					local goon = true
					-- 处理怒气攻击, 包括buff 和攻击技能
					if true ~= battleObject.skipSuperSkillMould and nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP or hasZoumarSkill == true) and battleObject.isDisSp ~= true) then
						local  realSkillMould = battleObject.specialSkillMould.id
						if (attackOver ~= 0)then
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
							----_crint("2回合：" + roundCount)
						end
						table.insert(self.headBuffer, battleObject.battleTag)
						table.insert(self.headBuffer, IniUtil.compart)
						table.insert(self.headBuffer, battleObject.coordinate)
						skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition
						if(hasZoumarSkill == true and self.canFreeSkill == true) then
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.headBuffer, #battleObject.fitBattleObjects)
							battleObject:subZomSkillPoint(5)
							self:fitFight(battleObject,battleObject.fitBattleObjects, userInfo)
							-- battleObject.isAction = true
							battleSkillList = {}
							skillReleasePosion = battleObject.zoariumSkillMould.skillReleasePosition
							realSkillMould = battleObject.zoariumSkillMould.id
						else
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.headBuffer, 0)
							battleSkillList = battleObject.oneselfBattleSkill
						end
						table.insert(self.headBuffer, IniUtil.compart)
						if(battleObject.battleTag == 0) then
							local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects)
							table.insert(self.bodyBuffer, movePos)
							----_crint ("Move pos 0 : " .. movePos)
							--os.exit()
						else
							local movePos = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects)
							table.insert(self.bodyBuffer, movePos)
							----_crint ("Move pos 1 : " .. movePos)
							--os.exit()
						end
						table.insert(self.bodyBuffer, IniUtil.compart)
						table.insert(self.bodyBuffer, realSkillMould)
						table.insert(self.bodyBuffer, IniUtil.compart)
						-- battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
						table.insert(self.bodyBuffer, 0)
						table.insert(self.bodyBuffer, IniUtil.compart)
					else
						-- 处理普通攻击, 包括buff 和攻击技能
						if(battleObject.isParalysis) then
							if (attackOver ~= 0) then
								table.insert(resultBuffer, "0")
								table.insert(resultBuffer, IniUtil.compart)
								----_crint("3回合：" + roundCount)
							end
							table.insert(self.headBuffer, battleObject.battleTag)
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.headBuffer, battleObject.coordinate)
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.headBuffer, 0)
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.bodyBuffer, 0)
							table.insert(self.bodyBuffer, IniUtil.compart)
							table.insert(self.bodyBuffer, battleObject.commonSkillMould.id)
							table.insert(self.bodyBuffer, IniUtil.compart)
							battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
							table.insert(self.bodyBuffer, 0)
							table.insert(self.bodyBuffer, IniUtil.compart)
							table.insert(self.bodyBuffer, 0)
							table.insert(self.bodyBuffer, IniUtil.compart)
							table.insert(self.bodyBuffer, 0)
							table.insert(self.bodyBuffer, IniUtil.compart)
							-- TODO....
							self:talentSelfTailFight(userInfo,battleObject,resultBuffer)

							attackOver = 1
							goon = false
							--continue
							battleObject.normalSkillMouldOpened = false
						else
							
							if (attackOver ~= 0) then
								table.insert(resultBuffer, "0")
								table.insert(resultBuffer, IniUtil.compart)
								----_crint("4回合：" + roundCount)
							end
							table.insert(self.headBuffer, battleObject.battleTag)
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.headBuffer, battleObject.coordinate)
		
							table.insert(self.headBuffer, IniUtil.compart)
							table.insert(self.headBuffer, 0)
							table.insert(self.headBuffer, IniUtil.compart)
							
							local skillId = 0
							if true == battleObject.normalSkillMouldOpened then
								battleSkillList = battleObject.normalBattleSkill
								skillReleasePosion = battleObject.normalSkillMould.skillReleasePosition
								battleObject.normalSkillMouldOpened = false
								skillId = battleObject.normalSkillMould.id
								battleObject.normalSkillUseCount = battleObject.normalSkillUseCount + 1
							else
								battleSkillList = battleObject.commonBattleSkill
								skillReleasePosion = battleObject.commonSkillMould.skillReleasePosition
								skillId = battleObject.commonSkillMould.id
							end

							if(battleObject.battleTag == 0) then							
								table.insert(self.bodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects))
							else
								table.insert(self.bodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects))
							end
							table.insert(self.bodyBuffer, IniUtil.compart)
							-- table.insert(self.bodyBuffer, battleObject.commonSkillMould.id)
							table.insert(self.bodyBuffer, skillId)
							table.insert(self.bodyBuffer, IniUtil.compart)
							
							battleObject:processUserBuffEffect(userInfo, self, self.bodyBuffer)
						end
					end
					if (goon) then -- 麻痹后不走这里
					    --  处理普通或者怒气攻击 技能效用
						local tmpBattleSkillBuffer = {}
						local hasRestrain = 0
						local byAttackCoordinates = {}
						
						for _, battleSkill in pairs(battleSkillList) do
							if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or 
								battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP)then
								byAttackCoordinates = {}
							end
							if (0 == battleObject.battleTag) then
								if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE) then
									if (#byAttackCoordinates == 0) then
										byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
									end
									if(hasRestrain == 0) then
										hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
									end
									battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
								elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE)then
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
									if(hasRestrain == 0)then
										hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
									end
									battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
								elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
									byAttackCoordinates = {}
									table.insert(byAttackCoordinates, battleObject.coordinate)
									if(hasRestrain == 0)then
										hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
									end
									battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
								end
							else
								if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)then
									if (#byAttackCoordinates == 0)then
										byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
									end
									if(hasRestrain == 0)then
										hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
									end
									battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, tmpBattleSkillBuffer)
								elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
									if(hasRestrain == 0)then
										hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
									end
									battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
								elseif(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
									byAttackCoordinates = {}
									table.insert(byAttackCoordinates, battleObject.coordinate)
									if(hasRestrain == 0) then
										hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
									end
									battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, tmpBattleSkillBuffer)
								end
							end
						end
						IniUtil.concatTable(resultBuffer, self.headBuffer)
						table.insert(resultBuffer, hasRestrain)
						table.insert(resultBuffer, IniUtil.compart)
						IniUtil.concatTable(resultBuffer, self.bodyBuffer)
						table.insert(resultBuffer, self.battleSkillCount)
						table.insert(resultBuffer, IniUtil.compart)
						IniUtil.concatTable(resultBuffer, tmpBattleSkillBuffer)
						if(hasZoumarSkill == true and self.canFreeSkill == true) then
							----_crint("合击数量 " + battleObject.fitBattleObjects.size())
							table.insert(resultBuffer, #battleObject.fitBattleObjects)
							table.insert(resultBuffer, IniUtil.compart)
							if(fitBuffer ~= nil) then
								----_crint("合体技能： " + fitBuffer.toString())
								IniUtil.concatTable(resultBuffer, fitBuffer)
							end
							self.canFreeSkill = false
						end
						IniUtil.concatTable(resultBuffer, self.battleSkillBuffer)
						if(nil ~= counterBuffer)then
							IniUtil.concatTable(resultBuffer, counterBuffer)
							counterBuffer = nil
						else
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
						end
						self.battleSkillCount = 0
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						-- TODO....
						self:talentSelfTailFight(userInfo,battleObject,resultBuffer)
						attackOver = 1
					end  -- 麻痹后不走这里
				end  --眩晕判断结束  眩晕不走下面的代码
			end  -- 死亡判断结束
			
			-- 下面这段代码, 死亡后也会走, 不过下面这段代码是废代码, 所以可以不管
			if (self.attackCount <= 0 or self.byAttackCount<=0 ) then
				win = self.byAttackCount<=0
				fightOver = true
				self.fightResult = 0
				if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
					self.fightResult = 1
				end
				break
			end
		end
		table.insert(resultBuffer, "1")
		local endAttackHeathPoint = self:getBattleObjectHeathPoint(self.attackObjects)
		local endDefenceHeathPoint = self:getBattleObjectHeathPoint(self.byAttackObjects)
		local attackHeathPoint = nowAttackHeathPoint - endAttackHeathPoint
		local defenceHeathPoint = nowDefenceHeathPoint - endDefenceHeathPoint
		--_crint("\nThe " .. self.roundCount .. " round health point loses are: " .. attackHeathPoint .. " : " .. defenceHeathPoint)
		self.attackDamages = self.attackDamages .. "," .. attackHeathPoint
		self.defenceDamages = self.defenceDamages .. "," .. defenceHeathPoint
		if (endAttackHeathPoint <= 0) then
			endAttackHeathPoint = endAttackHeathPoint .. ",1"
		else
			endAttackHeathPoint = endAttackHeathPoint .. ",0"
		end
		
		if (endDefenceHeathPoint <= 0) then
			self.defenceDeadState = self.defenceDeadState .. ",1"
		else
			self.defenceDeadState = self.defenceDeadState .. ",0"
		end		
		self:checkDefenceResult()
	end
	self.attackDamages = string.sub(self.attackDamages, 1)
	self.defenceDamages = string.sub(self.defenceDamages, 1)
	--self.attackDeadState = string.sub(attackDeadState, 1)
	--self.defenceDeadState = string.sub(defenceDeadState, 1)
	self:checkFightResult()
	if(win) then
		table.insert(resultBuffer, 1, FightModule.FIGHT_RESULT_WIN)
		table.insert(resultBuffer, 2, IniUtil.enter)
		table.insert(resultBuffer, 3, self.totalRound)
		table.insert(resultBuffer, 4, IniUtil.enter)
		table.insert(resultBuffer, 5, self.roundCount)		
		--table.insert(resultBuffer, 6, IniUtil.enter)
		
		userInfo.battleCache.currentBattleCount = math.min(userInfo.battleCache.currentBattleCount + 1, userInfo.battleCache.maxBattleCount)
		return FightModule.FIGHT_RESULT_WIN
	else
		table.insert(resultBuffer, 1, FightModule.FIGHT_RESULT_LOST)
		table.insert(resultBuffer, 2, IniUtil.enter)
		table.insert(resultBuffer, 3, self.totalRound)
		table.insert(resultBuffer, 4, IniUtil.enter)
		table.insert(resultBuffer, 5, self.roundCount)		
		--table.insert(resultBuffer, 6, IniUtil.enter)
		userInfo.battleCache.currentBattleCount = 0
		return FightModule.FIGHT_RESULT_LOST
	end
end


function FightModule:talentSelfTailFight(userInfo, selfObject, resultBuffer)
	local talentMouldList = selfObject.talentMouldList
	local talentCount = 0
	local skillBuffer = {}
	for k,talentMould in pairs(talentMouldList) do
		if tonumber(talentMould.influenceJudgeOpportunity) == TalentConstant.JUDGE_OPPORTUNITY_OWER_ATTACK 
			and table.nums(talentMould.talentBattleSkill) > 0 then
			local battleSkillList = talentMould.talentBattleSkill
			talentCount = talentCount + table.nums(talentMould.talentBattleSkill)
			local byAttackCoordinates = {}
			local battleObjectList = nil
			if tonumber(selfObject.battleTag) == 0 then
				battleObjectList = self.attackObjects
			else
				battleObjectList = self.byAttackObjects
			end
			
			
			if talentMould.influencePriorType < 0 then 
				table.insert(byAttackCoordinates,selfObject.coordinate)
			else				
				for k,battleObject in pairs(battleObjectList) do
					if battleObject~=nil and battleObject.isDead ~= true then
						local influencePriorType = tonumber(talentMould.influencePriorType)
						local campPreference = tonumber(battleObject.campPreference)
						if influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_WEI then --魏
							if campPreference == 1 then 
								table.insert(byAttackCoordinates,battleObject.coordinate)
							end 
						elseif influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_SHU then --蜀
							if campPreference == 2 then 
								table.insert(byAttackCoordinates,battleObject.coordinate)
							end
						elseif influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_WU then --吴
							if campPreference == 3 then 
								table.insert(byAttackCoordinates,battleObject.coordinate)
							end
						elseif influencePriorType == TalentConstant.INFLUENCE_PRIOR_TYPE_QUN then --群
							if campPreference == 4 then 
								table.insert(byAttackCoordinates,battleObject.coordinate)
							end
						end
					end
				end
			end
			for _, battleSkill in pairs(battleSkillList) do
				battleSkill:processTalentAttack(userInfo, byAttackCoordinates, selfObject, battleObjectList, self, false, skillBuffer)
			end
		end
	end
	table.insert(resultBuffer,talentCount)
	table.insert(resultBuffer,IniUtil.compart)
	IniUtil.concatTable(resultBuffer, skillBuffer)

end
function FightModule:fitFight(selfObject, list, userInfo)
	self.fitBuffer = {}
	self.fitSelfBuffer = {}
	table.insert(self.fitSelfBuffer, selfObject.battleTag)
	table.insert(self.fitSelfBuffer,IniUtil.compart)
	table.insert(self.fitSelfBuffer,selfObject.coordinate)
	table.insert(self.fitSelfBuffer,IniUtil.compart)
	table.insert(self.fitSelfBuffer,0)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	table.insert(self.fitSelfBuffer, 3)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	table.insert(self.fitSelfBuffer, 4)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	table.insert(self.fitSelfBuffer, 0)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	table.insert(self.fitSelfBuffer, 0)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	table.insert(self.fitSelfBuffer, 0)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	table.insert(self.fitSelfBuffer, 0)
	table.insert(self.fitSelfBuffer, IniUtil.compart)
	-- for k = 1, #list do
	for k, v in pairs(list) do
		battleObject = list[k]
		if(#battleObject.releaseSkill == 0) then
			--continue
		else
			local fitHeadBuffer = {}
			local fitBodyBuffer = {}
			self.fitBattleSkillCount = 0
			table.insert(fitHeadBuffer, battleObject.battleTag)
			table.insert(fitHeadBuffer, IniUtil.compart)
			table.insert(fitHeadBuffer, battleObject.coordinate)
			table.insert(fitHeadBuffer, IniUtil.compart)
			table.insert(fitHeadBuffer, 0)
			table.insert(fitHeadBuffer, IniUtil.compart)
			local battleSkillList = battleObject.releaseSkill
			local skillReleasePosion  = battleObject.releaseSKillMould.skillReleasePosition
			if(battleObject.battleTag == 0) then						
				table.insert(fitBodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.byAttackObjects))
			else
				table.insert(fitBodyBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, self.attackObjects))
			end
			table.insert(fitBodyBuffer, IniUtil.compart)
			table.insert(fitBodyBuffer, battleObject.releaseSKillMould.id)
			table.insert(fitBodyBuffer, IniUtil.compart)
			self.battleSkillBuffer = {}
			for i = 1, 6 do
				if(nil ~= self.attackObjects[i]) then
					self.attackObjects[i].canReAttack=true
					self.attackObjects[i]:clearTalentJudgeResultList()
				end
			end
			for i = 1, 6 do
				if(nil ~= self.byAttackObjects[i]) then
					self.byAttackObjects[i].canReAttack=true
					self.byAttackObjects[i]:clearTalentJudgeResultList()
				end
			end
			battleObject.effectDamage=0
			battleObject.totalEffectDamage=0
			local battleSkillBuffer = {}
			local hasRestrain = 0
			local byAttackCoordinates = {}
			local lastBattleSkill = {}
			for _,  battleSkill in pairs(battleSkillList) do
				local attackSkill = battleSkill
				attackSkill.formulaInfo = battleSkill.skillInfluence.formulaInfo
				local battleTag = battleObject.battleTag
				local influenceGroup = attackSkill.skillInfluence.influenceGroup
				local formulaInfo = attackSkill.skillInfluence.formulaInfo
				local skillInfluence =  attackSkill.skillInfluence
				
				if (formulaInfo ~= FightUtil.FORMULA_INFO_FORTHWITH) then
					byAttackCoordinates= {}
					if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
						or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
						byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
					else
						byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
					end
				else
					local tempList = {}
					if((battleTag == 0 and influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)
						or (battleTag == 1 and influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE))then
						tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.byAttackObjects)
					else
						tempList = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, self.attackObjects)
					end
					if (#byAttackCoordinates == 0)then
						byAttackCoordinates = tempList
					else
						local realCoordinates = {}
						for i,v in pairs(byAttackCoordinates) do
							for z,k in pairs(tempList) do
								if(v == k) then
									table.insert(realCoordinates,v)
								end
							end
						end
						byAttackCoordinates = realCoordinates
						attackSkill.formulaInfo = lastBattleSkill.formulaInfo
					end
				end
				--BattleSkill battleSkill = battleSkillList.get(j)
				-- if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or 
				-- 	battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP) then
				-- 	byAttackCoordinates = {}
				-- end
				if (0 == battleObject.battleTag) then
					if(influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE) then
						if(hasRestrain == 0) then
							hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
						end
						attackSkill:processFitAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, battleSkillBuffer)
					elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
						if(hasRestrain == 0) then
							hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
						end
						attackSkill:processFitAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, battleSkillBuffer)
					elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
						byAttackCoordinates = {}
						table.insert(byAttackCoordinates, battleObject.coordinate)
						if(hasRestrain == 0) then
							hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, attackObjects)
						end
						attackSkill:processFitAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, battleSkillBuffer)
					end
				else
					if(influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE) then
						if(hasRestrain == 0) then
							hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.attackObjects)
						end
						attackSkill:processFitAttack(userInfo, byAttackCoordinates, battleObject, self.attackObjects, self, battleSkillBuffer)
					elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
						if(hasRestrain == 0) then
							hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
						end
						attackSkill:processFitAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, battleSkillBuffer)
					elseif(influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT) then
						byAttackCoordinates = {}
						table.insert(byAttackCoordinates, battleObject.coordinate)
						if(hasRestrain == 0) then
							hasRestrain = RestrainUtil.hasRestrain(battleObject, byAttackCoordinates, self.byAttackObjects)
						end
						attackSkill:processFitAttack(userInfo, byAttackCoordinates, battleObject, self.byAttackObjects, self, battleSkillBuffer)
					end
				end
				lastBattleSkill = battleSkill
			end
			
			battleObject:addFigSkillCount(self.fitBattleSkillCount)
			IniUtil.concatTable(self.fitBuffer, fitHeadBuffer)
			table.insert(self.fitBuffer, hasRestrain)
			table.insert(self.fitBuffer, IniUtil.compart)
			IniUtil.concatTable(self.fitBuffer, fitBodyBuffer)
			-- _crint("====fitBodyBuffer====")
			-- debug.print_r(fitBodyBuffer)
			if(self.fitSelfBuffer ~= nil) then
				self.fitBattleSkillCount = self.fitBattleSkillCount + 1
			end
			table.insert(self.fitBuffer, self.fitBattleSkillCount)
			table.insert(self.fitBuffer, IniUtil.compart)
			IniUtil.concatTable(self.fitBuffer, battleSkillBuffer)
			IniUtil.concatTable(self.fitBuffer, self.battleSkillBuffer)
			--取消合体技触发人员的出手状态
			-- if selfIsAction ~= true then
			-- 	battleObject.isAction = false
			-- end
		end		
	end
	-- selfObject.isAction = true
end


function FightModule:getBattleObjectHeathPoint(battleObjects)
	local lessAttackHp = 0
	for _, battleObject in pairs(battleObjects) do
		--BattleObject battleObject = battleObjects[i]
		if(battleObject~=nil and battleObject.isDead ~= true) then
			lessAttackHp = lessAttackHp + battleObject.healthPoint
			----_crint (" battleObject.healthPoint = " ..  battleObject.healthPoint)
		else
			----_crint ("battleObject nil or dead")
		end
	end
	--_crint ("getBattleObjectHeathPoint " ..  lessAttackHp)
	return lessAttackHp
end

function FightModule:getFightObjectCount(attackerObjects)
	local count = 0
	for _, attackObj in pairs(attackerObjects) do
		if (attackObj ~= nil) then
			count = count + 1
		end
	end
	return count
end

function FightModule:writeBattleFieldInit(battleCache, selfTag, targetTag, resultBuffer)
	table.insert(resultBuffer, 182)
	table.insert(resultBuffer, IniUtil.enter)
	table.insert(resultBuffer, battleCache.battleType)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.byAttackerId)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.difficulty)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.maxBattleCount)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.attacker_priority)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.defender_priority)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.attacker_name)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.defender_name)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.attacker_head_pic)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.defender_head_pic)
	table.insert(resultBuffer, IniUtil.enter)
	table.insert(resultBuffer, self:getFightObjectCount(battleCache.attackerObjects))
	table.insert(resultBuffer, IniUtil.enter)
	local fightObjects = battleCache.attackerObjects
	for i, v in pairs(fightObjects) do
		if(nil ~= fightObjects[i]) then
			table.insert(resultBuffer, fightObjects[i].id)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, i)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].picIndex)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].specialSkillDecribe)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].zoarium)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].quality)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].healthPoint)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].skillPoint)
			table.insert(resultBuffer, IniUtil.compart)
			if(self.fightType == 1) then
				table.insert(resultBuffer, 1)
			else
				table.insert(resultBuffer, selfTag)
			end
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].mouldId)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].amplifyPercent)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].fightName)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].evolutionLevel)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].wisdom)
			table.insert(resultBuffer, IniUtil.compart)
			table.insert(resultBuffer, fightObjects[i].healthPoint)
			table.insert(resultBuffer, IniUtil.enter)
		end
	end
	
	table.insert(resultBuffer, 0)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer,  "0,0")
	table.insert(resultBuffer, IniUtil.enter)
	
	local byAttackerObjectsList = battleCache.byAttackerObjectsList
	local battleCount = 1
	--for (FightObject[] _fightObjects : byAttackerObjectsList) {
	for _, _fightObjects in pairs(byAttackerObjectsList) do
		table.insert(resultBuffer, battleCount)
		table.insert(resultBuffer, IniUtil.enter)
		if(self.fightType < 10) then
			--for (local i = 0; i < _fightObjects.length; i++) {
			-- for i = 1, #_fightObjects do
			for i, v in pairs(_fightObjects) do
				if(nil ~= _fightObjects[i]) then
					table.insert(resultBuffer, _fightObjects[i].name)
					table.insert(resultBuffer, IniUtil.enter)
					break
				end
			end
		else
			table.insert(resultBuffer, "?")
			table.insert(resultBuffer, IniUtil.enter)
		end
		table.insert(resultBuffer, self:getFightObjectCount(_fightObjects))
		table.insert(resultBuffer, IniUtil.enter)
		--for (local i = 0; i < _fightObjects.length; i++) {
		----_crint("Size is: " .. (#_fightObjects))
		--for i = 1, #_fightObjects do
		for i, attackObj in pairs(_fightObjects) do
			if(nil ~= attackObj) then
				table.insert(resultBuffer, attackObj.id)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, i)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.picIndex)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.specialSkillDecribe)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.zoarium)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.quality)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.healthPoint)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.skillPoint)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, targetTag)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.mouldId)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.amplifyPercent)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.fightName)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.evolutionLevel)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.wisdom)
				table.insert(resultBuffer, IniUtil.compart)
				table.insert(resultBuffer, attackObj.healthPoint)
				table.insert(resultBuffer, IniUtil.enter)
			end
		end
		battleCount = battleCount + 1
		table.insert(resultBuffer, 0)
		table.insert(resultBuffer, IniUtil.compart)
		table.insert(resultBuffer,  "0,0")
		table.insert(resultBuffer, IniUtil.enter)
	end
	table.insert(resultBuffer, 206)
	table.insert(resultBuffer, IniUtil.enter)
	table.insert(resultBuffer, battleCache.attackName)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.attackCombatForce)
	table.insert(resultBuffer, IniUtil.enter)
	table.insert(resultBuffer, battleCache.byAttackName)
	table.insert(resultBuffer, IniUtil.compart)
	table.insert(resultBuffer, battleCache.byAttackComobatForce)
	table.insert(resultBuffer, IniUtil.enter)
end

--检查是否有下一回合
--重置评分伤害加成倍率
function FightModule:checkHasNextRound()
	if(self.hasNextRound == true) then	
		self.attackCount = 0
		self.byAttackCount = 0
		for s, tempObject in pairs(self.attackObjects) do
			if(tempObject.isDead) then
			else
				tempObject.grade_attack = 1
				self.attackCount = self.attackCount + 1
			end
		end
		for s, tempObject in pairs(self.byAttackObjects) do
			if(tempObject.isDead) then
			else
				tempObject.grade_attack = 1
				self.byAttackCount = self.byAttackCount + 1
			end
		end
		if (self.attackCount <= 0 or self.byAttackCount <= 0) then
			self.hasNextRound = false
			_ED.user_info.battleCache.currentBattleCount = math.min(_ED.user_info.battleCache.currentBattleCount + 1, _ED.user_info.battleCache.maxBattleCount)
			if self.attackCount <= 0 then
				self.fightResult = 0
			else
				self.fightResult = 1
			end
		end
		
		self:checkFightResult()
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			if self.hasNextRound == false then
				if(tonumber(self.deathCount) == 0) then
					self.star = 3
				elseif(tonumber(self.deathCount) == 1) then
					self.star = 2
				elseif(tonumber(self.deathCount) == tonumber(self.shipCount)) then
					self.star = 0
				else
					self.star = 1
				end
			else
				self.star = 3
			end
		else
			if(self.hasNextRound == false and tonumber(self.fightType) ~= 1) then
				if self.fightType == 108 then
					if tonumber(self.roundCount) <= 4 then
						self.star = 3
					elseif tonumber(self.roundCount) > 4 and tonumber(self.roundCount) <= 8 then
						self.star = 2
					else
						self.star = 1
					end
				else
					if(tonumber(self.deathCount) == 0) then
						self.star = 3
					elseif(tonumber(self.deathCount) == 1) then
						self.star = 2
					elseif(tonumber(self.deathCount) == tonumber(self.shipCount)) then
						self.star = 0
					else
						self.star = 1
					end
				end
			else
				self.star = 3
			end
		end
		-- _crint("总回合数",self.roundCount,self.totalRound)
		-- if(self.roundCount == self.totalRound) then
		-- 	self.hasNextRound = false
		-- 	self.fightResult = 0
		-- end

		if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_51) 
			or tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_52)
			then
			if self.fightResult == 0 then
				self.star = 0
			end
		end
		if tonumber(self.fightType) == tonumber(FightModule.FIGHT_TYPE_DAILY_INSTANCE) then
			self.fightResult = 1
		end
	end
end

function FightModule:checkFightResult()
	local nowHeal = 0
	local liveCount = 0
	for _, battleObject in pairs(self.attackObjects) do
		if(battleObject~=nil and battleObject.isDead ~= true) then
			liveCount = liveCount + 1
			nowHeal = nowHeal + battleObject.healthPoint
		end
	end
	self.totalAttackDamage = math.floor (self.totalHealth - nowHeal)
	self.deathCount = self.shipCount - liveCount
	self.surplusHealth = math.floor(nowHeal/self.totalHealth*100)
end

-- 设置攻击目标
function FightModule:setByAttackTargetTag(byAttackTargetTag)
	self.byAttackTargetTag = byAttackTargetTag
end

--传递出手方位人员的位置以及评分
--设置评分加成倍率
function FightModule:setGradeAttack(battleObject,grade,byAttackTargetTag)
	self.canFreeSkill = false
	self.greadCount = self.greadCount+1
	self.byAttackTargetTag = byAttackTargetTag
	local operateAddition = dms.element(dms["operate_addition"], self.greadCount)
	local badScore = dms.atoi(operateAddition, operate_addition.bad_score)
	local goodScore = dms.atoi(operateAddition, operate_addition.good_score)
	local greatScore = dms.atoi(operateAddition, operate_addition.great_score)
	local perfectScore = dms.atoi(operateAddition, operate_addition.prefect_score)
	if(tonumber(grade) == tonumber(badScore)) then	--糟糕
		self.gradeAttack = self.gradeAttack + dms.atof(operateAddition, operate_addition.bad_add)
		battleObject.grade_attack = battleObject.grade_attack + self.gradeAttack

		-- self.gradeAttack = 0
		-- battleObject.grade_attack = 1

	elseif(tonumber(grade) == tonumber(goodScore)) then --普通
		self.gradeAttack = self.gradeAttack + dms.atof(operateAddition, operate_addition.good_add)
		battleObject.grade_attack = battleObject.grade_attack + self.gradeAttack
	elseif(tonumber(grade) == tonumber(greatScore)) then	--良好
		self.gradeAttack = self.gradeAttack + dms.atof(operateAddition, operate_addition.great_add)
		battleObject.grade_attack = battleObject.grade_attack + self.gradeAttack
	elseif(tonumber(grade) == tonumber(perfectScore)) then	--完美
		self.gradeAttack = self.gradeAttack + dms.atof(operateAddition, operate_addition.prefect_add)
		battleObject.grade_attack = battleObject.grade_attack + self.gradeAttack
		--self.canFreeSkill = true
	end

	if battleObject.battleTag == 0 then
		self.total_grade_attack0 = battleObject.grade_attack
	else
		self.total_grade_attack1 = battleObject.grade_attack
	end
	-- print("当前的连击倍率：", battleObject.battleTag, battleObject.coordinate, battleObject.grade_attack)
end


-- 设置是否能是否合体就
function FightModule:setFreeSkillTrue()
	self.canFreeSkill = true
end

function FightModule:resetAction(camp)
	if 0 == camp then
		for _, battleObject in pairs(self.attackObjects) do
			if (battleObject ~= nil) then
				if true == battleObject.revived
					then
					if self.roundCount > battleObject.reviveRoundCount + 1 then
						battleObject.revived = false
						battleObject.isAction = false
					else
						battleObject.isAction = true
					end
				else
					battleObject.isAction = false
				end
			end
		end

		for _, battleObject in pairs(self.byAttackObjects) do
			if (battleObject ~= nil) then
				if true == battleObject.revived
					then
					if self.roundCount > battleObject.reviveRoundCount then
						battleObject.revived = false
					end
					battleObject.isAction = true
				end
			end
		end
	else
		for _, battleObject in pairs(self.byAttackObjects) do
			if (battleObject~=nil) then
				if true == battleObject.revived
					then
					if self.roundCount > battleObject.reviveRoundCount + 1 then
						battleObject.revived = false
						battleObject.isAction = false
					else
						battleObject.isAction = true
					end
				else
					battleObject.isAction = false
				end
			end
		end

		for _, battleObject in pairs(self.attackObjects) do
			if (battleObject ~= nil) then
				if true == battleObject.revived
					then
					if self.roundCount > battleObject.reviveRoundCount then
						battleObject.revived = false
					end
					battleObject.isAction = true
				end
			end
		end
	end
	return false
end

-- 复活
function FightModule:executeRevived(camp)
	if 0 == camp then
		for _, battleObject in pairs(self.attackObjects) do
			if (battleObject ~= nil) then
				battleObject.revived = false
			end
		end
	else
		for _, battleObject in pairs(self.byAttackObjects) do
			if (battleObject~=nil) then
				battleObject.revived = false
			end
		end
	end
	return false
end

-- 复活
function FightModule:checkAllRevived(camp)
	if 0 == camp then
		for _, battleObject in pairs(self.attackObjects) do
			if (battleObject ~= nil) then
				if battleObject.revived == false then
					return false
				end
			end
		end
	else
		for _, battleObject in pairs(self.byAttackObjects) do
			if (battleObject~=nil) then
				if battleObject.revived == false then
					return false
				end
			end
		end
	end
	return true
end

--检查我方是否还有人能出手
function FightModule:checkAttackSell(checkAllState)
	-- if self.byAttackerAttacking then
	-- 	return false
	-- end
	if (_ED._fightModule.attackerSpeedValue < _ED._fightModule.byAttackerSpeedValue and _ED._fightModule:checkByAttackSell() == true) then
		return false
    end

	local selfAction = false
	for _, battleObject in pairs(self.attackObjects) do
		if(battleObject~=nil and battleObject.isDead ~= true
			and battleObject.isAction ~= true
			and battleObject.isParalysis ~= true 
			and battleObject.isDizzy ~= true
			and battleObject.isCripple ~= true
			-- and battleObject.revived ~= true
			) then
			if checkAllState then
				if battleObject.isParalysis ~= true and battleObject.isDizzy ~= true and battleObject.isCripple ~= true then
					selfAction  = true
				end
			else
				selfAction  = true
			end
			-- print(battleObject.battleTag, battleObject.coordinate, battleObject.isAction, battleObject.isParalysis, battleObject.isDizzy)
		end
	end
	--检查敌方是否有人存活
	local canAction = false
	for _, battleObject in pairs(self.byAttackObjects) do
		if(battleObject~=nil and battleObject.isDead ~= true and battleObject.revived ~= true) then
			canAction = true;
		end
	end
	if(selfAction == true) and (canAction == true) then
		return true
	end
	return false
end
--检查敌方是否还有人能出手
function FightModule:checkByAttackSell()
	local selfAction = false
	for _, battleObject in pairs(self.byAttackObjects) do
		if(battleObject~=nil and battleObject.isDead ~= true
			and battleObject.isAction ~= true
			-- and battleObject.isParalysis ~= true 
			-- and battleObject.isDizzy ~= true
			) then
				selfAction  = true
		end
	end
	--检查地方是否有人存活
	local canAction = false
	for _, battleObject in pairs(self.attackObjects) do
		if(battleObject~=nil and battleObject.isDead ~= true and battleObject.revived ~= true) then
			canAction = true;
		end
	end
	if(selfAction == true) and (canAction == true) then
		return true
	end
	return false
end


--传递我方当前状态
--0:无人,1:正常普通技能,2:死亡,3:眩晕 4:怒气技能 5:合体技能 6:合体怒气并存
function FightModule:checkSelfAttackStatus()
	local selfAttackObjects = {}
	for i, battleObject in pairs(self.attackObjects) do
		if(battleObject~=nil) then
			if(battleObject.isDead ~= true) then
				if(battleObject.isDizzy == true or battleObject.isCripple == true or battleObject.isParalysis == true or battleObject.revived == true) then
					local resultBuffer = {}
					self:fightObjectAttack(battleObject,resultBuffer)
					-- battleObject.isAction = true
					battleObject._lockBuff = true
				end
				if(battleObject.isCripple == true) then
					selfAttackObjects[i] = 8
				elseif(battleObject.isParalysis == true) then
					selfAttackObjects[i] = 9

				
					
				elseif(battleObject.isAction == true) then	
					selfAttackObjects[i] = 10

				elseif(battleObject.revived == true) then	
					selfAttackObjects[i] = 11
				
				elseif(battleObject.isDizzy ~= true) then
					selfAttackObjects[i] = 1;
					-- if(battleObject.skillPoint >= FightModule.MAX_SP) then
					if true ~= battleObject.skipSuperSkillMould and nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP) and battleObject.isDisSp ~= true) then
						selfAttackObjects[i] = 4
					end
					local hasZoumarSkill = battleObject:checkState(self.attackObjects)
					if(hasZoumarSkill) then
						selfAttackObjects[i] = 5
					end
					if(battleObject.skillPoint >= FightModule.MAX_SP and hasZoumarSkill) then
						selfAttackObjects[i] = 6
					end
				else
					selfAttackObjects[i] = 3;	
				end
			else
				selfAttackObjects[i] = 2;
			end
			-- print("--------::", battleObject.battleTag, battleObject.coordinate, selfAttackObjects[i], battleObject.isAction)
		else
			selfAttackObjects[i] = 0;
		end
	end
	return selfAttackObjects
end

function FightModule:getSelfAttackStatus(coordinate)
	local selfAttackObjects = -1
	for i, battleObject in pairs(self.attackObjects) do
		if (battleObject ~= nil and coordinate == battleObject.coordinate) then
			if(battleObject.isDead ~= true) then
				if(battleObject.isCripple == true) then
					-- selfAttackObjects = 8
				elseif(battleObject.isParalysis == true) then
					-- selfAttackObjects = 9
				elseif(battleObject.isAction == true) then	
					-- selfAttackObjects = 10
				elseif(battleObject.isDizzy ~= true) then
					selfAttackObjects = 1
					-- if(battleObject.skillPoint >= FightModule.MAX_SP) then
					if -- true ~= battleObject.skipSuperSkillMould and 
						nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP) and battleObject.isDisSp ~= true) then
						selfAttackObjects = 4
					end
					local hasZoumarSkill = battleObject:checkState(self.attackObjects)
					if(hasZoumarSkill) then
						selfAttackObjects = 5
					end
					if(battleObject.skillPoint >= FightModule.MAX_SP and hasZoumarSkill) then
						selfAttackObjects = 6
					end
				else
					selfAttackObjects = 3
				end
			else
				selfAttackObjects = 2
			end
			-- print("--------::", battleObject.battleTag, battleObject.coordinate, selfAttackObjects, battleObject.isAction, battleObject.isCripple, battleObject.isParalysis, battleObject.isDizzy)
			break
		end
	end
	return selfAttackObjects
end

--传递出手人员合击怒气槽
--0:无人,1:正常普通技能,2:死亡,3:眩晕 4:怒气技能 5:合体技能 6:合体怒气并存
function FightModule:getAttackZomlllSkillPoint()
	local selfAttackObjects = {}
	for i=1,6 do
		local battleObject = self.attackObjects[i]
		if(battleObject~=nil and battleObject.isDead ~= true) then
			selfAttackObjects[i] = battleObject.zomlllSkillPoint
		else
			selfAttackObjects[i] = 0
		end
	end
	return selfAttackObjects
end

--跳过整场战斗过程
function FightModule:jumpFight(userInfo, resultBuffer)
	while tonumber(_ED.user_info.battleCache.currentBattleCount) < tonumber(#_ED.user_info.battleCache.byAttackerObjectsList) do
		-- _crint("跳过",_ED.user_info.battleCache.currentBattleCount,#_ED.user_info.battleCache.byAttackerObjectsList)
		while self.hasNextRound == true do
			self:rountdFight(resultBuffer)
		end
		if tonumber(_ED.user_info.battleCache.currentBattleCount) < tonumber(#_ED.user_info.battleCache.byAttackerObjectsList) then
			self:initBattleInfo(_ED.user_info.battleCache)
		end
	end
end

--跳过当前场战斗过程
function FightModule:jumpCurrentFight(userInfo, resultBuffer)
	-- while tonumber(_ED.user_info.battleCache.currentBattleCount) < tonumber(#_ED.user_info.battleCache.byAttackerObjectsList) do
		-- _crint("当前场次",_ED.user_info.battleCache.currentBattleCount)
		while self.hasNextRound == true do
			-- _crint("跳过11",self.hasNextRound,#self.fightOrderList)
			local roundCount = self.roundCount
			self:rountdFight(resultBuffer)
			if roundCount ~= self.roundCount then
				self:resetAllRoleSkillStatus()
			end
		end
	-- 	if tonumber(_ED.user_info.battleCache.currentBattleCount) < tonumber(#_ED.user_info.battleCache.byAttackerObjectsList) then
	-- 		self:initBattleInfo(_ED.user_info.battleCache)
	-- 	end
	-- end
	self:checkDefenceResult()
end

--重置连击加成倍数
function FightModule:clearAttacksStatus()
	self.gradeAttack = 0
	for s, tempObject in pairs(self.attackObjects) do
		if tempObject ~= nil then
			tempObject.grade_attack = 1
		end
	end
end
--[[
function FightModule:getFirstEnvironmentShip(npc)
	local seatArray = nil
	local environmentShip = nil
	for i = 1,  npc.formationCount do
		local formationId = npc.getEnvironmentFormation(i)
		--EnvironmentFormation environmentFormation = (EnvironmentFormation)ConfigDB.load("EnvironmentFormation", formationId)
		--seatArray = new Integer[]{environmentFormation.seatOne, environmentFormation.seatTwo, environmentFormation.seatThree, environmentFormation.seatFour, environmentFormation.seatFive, environmentFormation.seatSix}
		local formationId = npc:getEnvironmentFormation(i)
		local seatArray = {}
		for idx, val in pairs(seatIndex) do
			seatArray[#seatArray + 1] = dms.int(dms["environment_formation"], formationId, val)
		end
			
		--local amplifyPercentString = dms.string(dms["environment_formation"], formationId, environment_formation.amplify_percentage)
		--local amplifyPercentArray = zstring.split(amplifyPercentString, IniUtil.comma)
			 
		for j, val in pairs(seatArray) do		
		
			if(nil ~= seatArray[j] and 0 ~= seatArray[j]){
				environmentShip = (EnvironmentShip) ConfigDB.load("EnvironmentShip", seatArray[j])
			end
		end
	end
	return environmentShip
end

function FightModule:getTotalHealthPoint(userInfo)
		local seatArray = nil
		local healthPoint= 0
		Formation formation = UserDB.findByUserAndIndex(userInfo.id,  1)
		seatArray = new Integer[]{formation.seatOne, formation.seatTwo, formation.seatThree, formation.seatFour, formation.seatFive, formation.seatSix}
		for (local i = 0; i < seatArray.length; i++) {
			if(nil ~= seatArray[i] and 0 ~= seatArray[i]){
				Ship ship = (Ship) UserDB.load("Ship", seatArray[i])
				healthPoint += ship.power
			}
		}
		return healthPoint
end


function FightModule:getNpcTotalHealthPoint(npc)
	local seatArray = nil
	local healthPoint= 0
	local formationId = npc.getEnvironmentFormation(1)
	local environmentFormation =(EnvironmentFormation)ConfigDB.load("EnvironmentFormation", formationId)
	seatArray = new Integer[]{environmentFormation.seatOne, environmentFormation.seatTwo, environmentFormation.seatThree, environmentFormation.seatFour, environmentFormation.seatFive, environmentFormation.seatSix}
	for (local j = 0; j < seatArray.length; j++) {
		if(nil ~= seatArray[j] and 0 ~= seatArray[j]){
			EnvironmentShip environmentShip = (EnvironmentShip) ConfigDB.load("EnvironmentShip", seatArray[j])
			String difficultyAdditionalArray[] = npc.difficultyAdditional.split("\\|")[0].split(IniUtil.comma)
			healthPoint +=(long) (environmentShip.power * Float.parseFloat(difficultyAdditionalArray[0]))
		}
	}
	return healthPoint
end
--]]
function FightModule:checkDefenceResult()
	local liveHealth = 0
	for _, battleObject in pairs(self.byAttackObjects) do			
		if(battleObject~=nil and battleObject.isDead ~= true) then
			liveHealth = liveHealth + battleObject.healthPoint
		end
	end
	self.totalDefenceDamage = self.npcMaxHealth - liveHealth
end

function FightModule:initUserBattleField(attackUser, battleCache)
	if(battleCache == nil or attackUser == nil) then
		return
	end
	battleCache.userInfo=attackUser
	battleCache.attackCombatForce=attackUser.combatForce
	battleCache.attackName=attackUser.nickname
	battleCache.attackerObjects=attackUser.attackObjects
	attackUser.battleCache=battleCache
end

function FightModule:initNpcBattleField(attackUser, npc, battleCache)
	if(battleCache == nil or npc == nil or attackUser == nil) then
		return
	end
	battleCache.byAttackerId=npc.id
	battleCache.maxBattleCount=npc.formationCount
	local seatArray = {}
	local byAttackerObjectsList = {}
	for i = 1, npc.formationCount do
	
		local byAttackObjects = {}
		local formationId = npc:getEnvironmentFormation(i)
		local seatArray = {}
		for idx, val in pairs(seatIndex) do
			seatArray[#seatArray + 1] = dms.int(dms["environment_formation"], formationId, val)
		end
		
		local amplifyPercentString = dms.string(dms["environment_formation"], formationId, environment_formation.amplify_percentage)
		local amplifyPercentArray = zstring.split(amplifyPercentString, IniUtil.comma)
		 
		for j, val in pairs(seatArray) do
			if(nil ~= val and 0 ~= val) then
				local fightObject = FightObject:new(npc, difficulty, j + 1, seatArray[j], fakeLevel, isFake)
				fightObject.amplifyPercent = amplifyPercentArray[j]
				fightObject.name=environmentFormation.formationName
				byAttackObjects[j] = fightObject
			end
		end
		battleCache.byAttackComobatForce(environmentFormation.combatForce)
		table.insert(byAttackerObjectsList, byAttackObjects)
	end			
	
	battleCache.byAttackName=npc.npcName
	battleCache.byAttackerObjectsList=byAttackerObjectsList
	attackUser.battleCache=battleCache
end
--[[
function FightModule:unionFight(userInfo, resultBuffer, obj, member)
		attackCount = 0
		byAttackCount = 0
		fighters = new Object[2][2]
		self.attackDamages = ""
		self.defenceDamages = ""
		self.attackDeadState = ""
		self.defenceDeadState = ""
		roundCount = 0
		boolean fightOver = false
		local attackerCombatForce = 0
		local byAttackerCombatForce = 0
		List<BattleObject> fightOrderList = new ArrayList<BattleObject>()
		local attackIndex = 0
		local byAttackIndex = 0
		local arrLength = attackObjects.length
		boolean win = false
		BattleObject[] tempAttackObjects = attackerCombatForce >= byAttackerCombatForce ? attackObjects : byAttackObjects
		BattleObject[] tempByAttackObjects = attackerCombatForce >= byAttackerCombatForce ? byAttackObjects : attackObjects
		for (local i = 0; i < arrLength; i++) {
			for (; attackIndex<tempAttackObjects.length; attackIndex++){
				if(nil ~= tempAttackObjects[attackIndex]){
					fightOrderList.add(tempAttackObjects[attackIndex])
					if(tempAttackObjects[attackIndex].battleTag == 0){						
						attackCount++
					else
						byAttackCount++
					}
					attackIndex++
					break
				}
			}
			for (; byAttackIndex<tempByAttackObjects.length; byAttackIndex++){
				if(nil ~= tempByAttackObjects[byAttackIndex]){
					fightOrderList.add(tempByAttackObjects[byAttackIndex])
					if(tempByAttackObjects[byAttackIndex].battleTag == 0){						
						attackCount++
					else
						byAttackCount++
					}
					byAttackIndex++
					break
				}
			}
		}
		while(!fightOver){
			if (attackCount <= 0 or byAttackCount<=0){
				win = byAttackCount<=0
				fightOver = true
				break
			}
			if(roundCount == totalRound){
				win = self.fightType == FIGHT_TYPE_PVE_MONEY_TREE
				fightOver = true
				break
			}
			roundCount++
			long nowAttackHeathPoint = self:getBattleObjectHeathPoint(attackObjects)
			long nowDefenceHeathPoint = self:getBattleObjectHeathPoint(byAttackObjects)
			table.insert(resultBuffer, IniUtil.enter)
			table.insert(resultBuffer, roundCount)
			table.insert(resultBuffer, IniUtil.enter)
			byte attackOver = 0
			for (local k = 0; k < fightOrderList.size(); k++) {
				if (attackCount <= 0 or byAttackCount<=0){
					win = byAttackCount<=0
					fightOver = true
					break
				}
				counterBuffer = nil
				battleSkillCount = 0
				battleSkillBuffer = new StringBuffer()
				for (local i = 0; i < attackObjects.length; i++) {
					if(nil ~= attackObjects[i]){
						attackObjects[i].canReAttack=true
						attackObjects[i].clearTalentJudgeResultList()
					}
				}
				for (local i = 0; i < byAttackObjects.length; i++) {
					if(nil ~= byAttackObjects[i]){
						byAttackObjects[i].canReAttack=true
						byAttackObjects[i].clearTalentJudgeResultList()
					}
				}
				BattleObject battleObject = fightOrderList.get(k)
				battleObject.action=true
				battleObject.effectDamage=0
				battleObject.totalEffectDamage=0
				if(battleObject.isDead){
					if(battleObject.battleTag == 0){
						attackObjects[battleObject.coordinate - 1] = nil
					else
						byAttackObjects[battleObject.coordinate - 1] = nil
					}
					fightOrderList.remove(k)
					k--
					sortBattleObject(attackerCombatForce >= byAttackerCombatForce, fightOrderList, battleObject)
				else
					if(battleObject.isDizzy()){
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						battleObject:processBuffEffect(userInfo, self, resultBuffer)
						attackOver = 1
						continue
					}
					List<BattleSkill> battleSkillList = nil
					byte skillReleasePosion = 0
					if(battleObject.skillPoint >= FightModule.MAX_SP and !battleObject.isDisSp()){
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						battleSkillList = battleObject.oneselfBattleSkill
						skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition
						if(battleObject.battleTag == 0){							
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, byAttackObjects))
						else
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, attackObjects))
						}
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.specialSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
					else
						if(battleObject.isParalysis()){
							if (attackOver ~= 0){
								table.insert(resultBuffer, "0")
								table.insert(resultBuffer, IniUtil.compart)
							}
							table.insert(resultBuffer, battleObject.battleTag)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.coordinate)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.commonSkillMould.id)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							battleObject:processBuffEffect(userInfo, self, resultBuffer)
							attackOver = 1
							continue
						}
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						battleSkillList = battleObject.commonBattleSkill
						skillReleasePosion = battleObject.commonSkillMould.skillReleasePosition
						if(battleObject.battleTag == 0){							
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, byAttackObjects))
						else
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, attackObjects))
						}
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
					}
					StringBuffer battleSkillBuffer = new StringBuffer()
					List<Byte> byAttackCoordinates = new ArrayList<Byte>()
					for (BattleSkill battleSkill : battleSkillList) {
						if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP){
							byAttackCoordinates = {}
						}
						if (0 == battleObject.battleTag) {
							if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE){
								if (#byAttackCoordinates == 0){
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, self.battleObject, self.byAttackObjects)
								}
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE){
								byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, attackObjects)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT){
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}
						else
							if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE){
								if (#byAttackCoordinates == 0){									
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, attackObjects)
								}
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE){
								byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, self.battleObject, self.byAttackObjects)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT){
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}
						}
					}
					table.insert(resultBuffer, battleSkillCount)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, battleSkillBuffer)
					table.insert(resultBuffer, self.battleSkillBuffer)
					if(nil ~= counterBuffer){
						table.insert(resultBuffer, counterBuffer)
						counterBuffer = nil
					else
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
					}
					battleSkillCount = 0
					battleObject:processBuffEffect(userInfo, self, resultBuffer)
					attackOver = 1
				}
				if (attackCount <= 0 or byAttackCount<=0){
					win = byAttackCount<=0
					fightOver = true
					break
				}
			}
			table.insert(resultBuffer, "1")
			long endAttackHeathPoint = self:getBattleObjectHeathPoint(attackObjects)
			long endDefenceHeathPoint = self:getBattleObjectHeathPoint(byAttackObjects)
			long attackHeathPoint = nowAttackHeathPoint - endAttackHeathPoint
			long defenceHeathPoint = nowDefenceHeathPoint - endDefenceHeathPoint
			----_crint("第"+roundCount+ "回合双方损血量分别是："+attackHeathPoint+" : "+ defenceHeathPoint)
			attackDamages += "," +attackHeathPoint
			defenceDamages += "," +defenceHeathPoint
			attackDeadState += endAttackHeathPoint <= 0 ? ",1" : ",0"
			defenceDeadState += endDefenceHeathPoint <= 0 ? ",1" : ",0"
		}
		if (IniUtil.isEmpty(attackDamages)) {
			if(attackDamages.startsWith(IniUtil.comma)){				
				attackDamages = string.sub(attackDamages, 1)
			}
		}
		if (IniUtil.isEmpty(defenceDamages)) {
			if(defenceDamages.startsWith(IniUtil.comma)){					
				defenceDamages = string.sub(defenceDamages, 1)
			}
		}
		if (IniUtil.isEmpty(attackDeadState)) {
			if(attackDeadState.startsWith(IniUtil.comma)){					
				attackDeadState = string.sub(attackDeadState, 1)
			}
		}
		if (IniUtil.isEmpty(defenceDeadState)) {
			if(defenceDeadState.startsWith(IniUtil.comma)){				
				defenceDeadState = string.sub(defenceDeadState, 1)
			}
		}
		self.checkFightResult()
		self.checkDefenceResult()
		fighters[member][0] = self.attackObjects
		fighters[member][1] = self.byAttackObjects
		if(win){
			return FIGHT_RESULT_WIN
		}
		else{
			return FIGHT_RESULT_LOST
		}
end

function FightModule:battlegroundFight(userInfo, resultBuffer, member)
		attackCount = 0
		byAttackCount = 0
		self.attackDamages = ""
		self.defenceDamages = ""
		self.attackDeadState = ""
		self.defenceDeadState = ""
		roundCount = 0
		boolean fightOver = false
		local attackerCombatForce = 0
		local byAttackerCombatForce = 0
		List<BattleObject> fightOrderList = new ArrayList<BattleObject>()
		local attackIndex = 0
		local byAttackIndex = 0
		local arrLength = attackObjects.length
		boolean win = false
		BattleObject[] tempAttackObjects = attackerCombatForce >= byAttackerCombatForce ? attackObjects : byAttackObjects
		BattleObject[] tempByAttackObjects = attackerCombatForce >= byAttackerCombatForce ? byAttackObjects : attackObjects
		for (local i = 0; i < arrLength; i++) {
			for (; attackIndex<tempAttackObjects.length; attackIndex++){
				if(nil ~= tempAttackObjects[attackIndex]){
					fightOrderList.add(tempAttackObjects[attackIndex])
					if(tempAttackObjects[attackIndex].battleTag == 0){						
						attackCount++
					else
						byAttackCount++
					}
					attackIndex++
					break
				}
			}
			for (; byAttackIndex<tempByAttackObjects.length; byAttackIndex++){
				if(nil ~= tempByAttackObjects[byAttackIndex]){
					fightOrderList.add(tempByAttackObjects[byAttackIndex])
					if(tempByAttackObjects[byAttackIndex].battleTag == 0){						
						attackCount++
					else
						byAttackCount++
					}
					byAttackIndex++
					break
				}
			}
		}
		while(!fightOver){
			if (attackCount <= 0 or byAttackCount<=0){
				win = byAttackCount<=0
				fightOver = true
				break
			}
			if(roundCount == totalRound){
				win = self.fightType == FIGHT_TYPE_PVE_MONEY_TREE
				fightOver = true
				break
			}
			roundCount++
			long nowAttackHeathPoint = self:getBattleObjectHeathPoint(attackObjects)
			long nowDefenceHeathPoint = self:getBattleObjectHeathPoint(byAttackObjects)
			table.insert(resultBuffer, IniUtil.enter)
			table.insert(resultBuffer, roundCount)
			table.insert(resultBuffer, IniUtil.enter)
			byte attackOver = 0
			for (local k = 0; k < fightOrderList.size(); k++) {
				if (attackCount <= 0 or byAttackCount<=0){
					win = byAttackCount<=0
					fightOver = true
					break
				}
				counterBuffer = nil
				battleSkillCount = 0
				battleSkillBuffer = new StringBuffer()
				for (local i = 0; i < attackObjects.length; i++) {
					if(nil ~= attackObjects[i]){
						attackObjects[i].canReAttack=true
						attackObjects[i].clearTalentJudgeResultList()
					}
				}
				for (local i = 0; i < byAttackObjects.length; i++) {
					if(nil ~= byAttackObjects[i]){
						byAttackObjects[i].canReAttack=true
						byAttackObjects[i].clearTalentJudgeResultList()
					}
				}
				BattleObject battleObject = fightOrderList.get(k)
				battleObject.action=true
				battleObject.effectDamage=0
				battleObject.totalEffectDamage=0
				if(battleObject.isDead){
					if(battleObject.battleTag == 0){
						attackObjects[battleObject.coordinate - 1] = nil
					else
						byAttackObjects[battleObject.coordinate - 1] = nil
					}
					fightOrderList.remove(k)
					k--
					sortBattleObject(attackerCombatForce >= byAttackerCombatForce, fightOrderList, battleObject)
				else
					if(battleObject.isDizzy()){
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						battleObject:processBuffEffect(userInfo, self, resultBuffer)
						attackOver = 1
						continue
					}
					List<BattleSkill> battleSkillList = nil
					byte skillReleasePosion = 0
					if(battleObject.skillPoint >= FightModule.MAX_SP and !battleObject.isDisSp()){
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						battleSkillList = battleObject.oneselfBattleSkill
						skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition
						if(battleObject.battleTag == 0){							
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, byAttackObjects))
						else
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, attackObjects))
						}
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.specialSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
					else
						if(battleObject.isParalysis()){
							if (attackOver ~= 0){
								table.insert(resultBuffer, "0")
								table.insert(resultBuffer, IniUtil.compart)
							}
							table.insert(resultBuffer, battleObject.battleTag)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.coordinate)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.commonSkillMould.id)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							battleObject:processBuffEffect(userInfo, self, resultBuffer)
							attackOver = 1
							continue
						}
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						battleSkillList = battleObject.commonBattleSkill
						skillReleasePosion = battleObject.commonSkillMould.skillReleasePosition
						if(battleObject.battleTag == 0){							
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, byAttackObjects))
						else
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, attackObjects))
						}
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
					}
					StringBuffer battleSkillBuffer = new StringBuffer()
					List<Byte> byAttackCoordinates = new ArrayList<Byte>()
					for (BattleSkill battleSkill : battleSkillList) {
						if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP){
							byAttackCoordinates = {}
						}
						if (0 == battleObject.battleTag) {
							if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE){
								if (#byAttackCoordinates == 0){
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, self.battleObject, self.byAttackObjects)
								}
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE){
								byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, attackObjects)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT){
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}
						else
							if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE){
								if (#byAttackCoordinates == 0){									
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, attackObjects)
								}
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE){
								byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, self.battleObject, self.byAttackObjects)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT){
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}
						}
					}
					table.insert(resultBuffer, battleSkillCount)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, battleSkillBuffer)
					table.insert(resultBuffer, self.battleSkillBuffer)
					if(nil ~= counterBuffer){
						table.insert(resultBuffer, counterBuffer)
						counterBuffer = nil
					else
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
					}
					battleSkillCount = 0
					battleObject:processBuffEffect(userInfo, self, resultBuffer)
					attackOver = 1
				}
				if (attackCount <= 0 or byAttackCount<=0){
					win = byAttackCount<=0
					fightOver = true
					break
				}
			}
			table.insert(resultBuffer, "1")
			----_crint("第"+roundCount+ "回合双方损血量分别是："+nowAttackHeathPoint+" : "+ nowDefenceHeathPoint)
			long endAttackHeathPoint = self:getBattleObjectHeathPoint(attackObjects)
			long endDefenceHeathPoint = self:getBattleObjectHeathPoint(byAttackObjects)
			long attackHeathPoint = nowAttackHeathPoint - endAttackHeathPoint
			long defenceHeathPoint = nowDefenceHeathPoint - endDefenceHeathPoint
			----_crint("第"+roundCount+ "回合双方损血量分别是："+attackHeathPoint+" : "+ defenceHeathPoint)
			attackDamages += "," +attackHeathPoint
			defenceDamages += "," +defenceHeathPoint
			attackDeadState += endAttackHeathPoint <= 0 ? ",1" : ",0"
			defenceDeadState += endDefenceHeathPoint <= 0 ? ",1" : ",0"
		}
		if (IniUtil.isEmpty(attackDamages)) {
			if(attackDamages.startsWith(IniUtil.comma)){				
				attackDamages = string.sub(attackDamages, 1)
			}
		}
		if (IniUtil.isEmpty(defenceDamages)) {
			if(defenceDamages.startsWith(IniUtil.comma)){					
				defenceDamages = string.sub(defenceDamages, 1)
			}
		}
		if (IniUtil.isEmpty(attackDeadState)) {
			if(attackDeadState.startsWith(IniUtil.comma)){					
				attackDeadState = string.sub(attackDeadState, 1)
			}
		}
		if (IniUtil.isEmpty(defenceDeadState)) {
			if(defenceDeadState.startsWith(IniUtil.comma)){				
				defenceDeadState = string.sub(defenceDeadState, 1)
			}
		}
		if(win){
			return FIGHT_RESULT_WIN
		}
		else{
			return FIGHT_RESULT_LOST
		}
end
--]]
function FightModule:initAttackerBattleInfo(battleCache)
		local attackObjects = battleCache.attackerObjects
		self.totalHealth = 0
		self.attackObjects = {}
		for i, attackObject in pairs(attackObjects) do
			if(nil ~= attackObject) then			
				local battleObject = BattleObject:new(attackObject)
				self.attackObjects[i] = battleObject
				self.shipCount = self.shipCount + 1
				self.totalHealth = self.totalHealth + battleObject.healthMaxPoint
			end
		end
end

function FightModule:initAttackerBattleInfo(attackUser)
	FightModule:initAttackerBattleInfo(attackUser.battleCache)
end
--[[
function FightModule:initAttackerBattleInfo(attackUser, fighter)
		totalHealth = 0
		local damage = fighter.damage
		local defence = fighter.defence
		FightObject[] attackObjects = new FightObject[6]
		Integer seatArray[] = nil
		Formation formation = UserDB.findByUserAndIndex(attackUser.id,  1)
		seatArray = new Integer[]{formation.seatOne, formation.seatTwo, formation.seatThree, formation.seatFour, formation.seatFive, formation.seatSix}
		for (local i = 0; i < seatArray.length; i++) {
			if(nil ~= seatArray[i] and 0 ~= seatArray[i]){
				FightObject fightObject = new FightObject((byte) (i + 1), seatArray[i],  0)
				attackObjects[i] = fightObject
			}
		}
		for (local i = 0; i < attackObjects.length; i++) {
			self.attackObjects[i] = nil
			if(nil ~= attackObjects[i]){				
				BattleObject battleObject = new BattleObject(attackObjects[i])
				damage = battleObject.finalDamagePercent
				defence = battleObject.finalLessenDamagePercent
				battleObject.finalDamagePercent=damage
				battleObject.finalLessenDamagePercent=defence
				self.attackObjects[i] = battleObject
				shipCount++
				totalHealth+=battleObject.healthMaxPoint
			}
		}
end

function FightModule:initByAttackerBattleInfo(attackUser, fighter)
		FightObject[] attackObjects = new FightObject[6]
		Integer seatArray[] = nil
		local damage = fighter.damage
		local defence = fighter.defence
		Formation formation = UserDB.findByUserAndIndex(attackUser.id,  1)
		seatArray = new Integer[]{formation.seatOne, formation.seatTwo, formation.seatThree, formation.seatFour, formation.seatFive, formation.seatSix}
		for (local i = 0; i < seatArray.length; i++) {
			if(nil ~= seatArray[i] and 0 ~= seatArray[i]){
				FightObject fightObject = new FightObject((byte) (i + 1), seatArray[i],  1)
				attackObjects[i] = fightObject
			}
		}
		for (local i = 0; i < attackObjects.length; i++) {
			self.byAttackObjects[i] = nil
			if(nil ~= attackObjects[i]){				
				BattleObject battleObject = new BattleObject(attackObjects[i])
				damage = battleObject.finalDamagePercent
				defence = battleObject.finalLessenDamagePercent
				battleObject.finalDamagePercent=damage
				battleObject.finalLessenDamagePercent=defence
				self.byAttackObjects[i] = battleObject
			}
		}
end

function FightModule:initByAttackerBattleInfo(battleCache)
		npcMaxHealth = 0
		FightObject byAttackObjects[]  = battleCache.byAttackerObjectsList.get(battleCache.currentBattleCount)
		for (local i = 0; i < byAttackObjects.length; i++) {
			if(nil ~= byAttackObjects[i]){				
				BattleObject battleObject = new BattleObject(byAttackObjects[i])
				self.byAttackObjects[i] = battleObject
				npcMaxHealth += battleObject.healthMaxPoint
			}
		}
end

function FightModule:initByAttackerBattleInfo(npc)
	self.npcMaxHealth = 0
	local seatArray = nil
	local byAttackerObjectsList = {}
	for i = 1, npc.formationCount do
		local byAttackObjects = {}
		local formationId = npc:getEnvironmentFormation(i)

		local seatIndex = {environment_formation.seat_one, environment_formation.seat_two, environment_formation.seat_three,
			environment_formation.seat_four, environment_formation.seat_five, environment_formation.seat_six}
		local seatArray = {}
		for idx, val in pairs(seatIndex) do
			seatArray[#seatArray + 1] = dms.local(dms["environment_formation"], formationId, val)
		end
			
		local amplifyPercentString = dms.string(dms["environment_formation"], formationId, environment_formation.amplify_percentage)
		local amplifyPercentArray = zstring.split(amplifyPercentString, IniUtil.comma)
			
		for j, val in pairs(seatArray) do
			if(nil ~= seatArray[j] and 0 ~= seatArray[j]){
				local fightObject = FightObject:new(npc, 1,  (j + 1), seatArray[j], fakeLevel, isFake)
				fightObject.amplifyPercent=amplifyPercentArray[j]
				fightObject.name=environmentFormation.formationName
				if(fightType == FIGHT_TYPE_PVE_WORLD_BOSS) then
					fightObject.healthPoint=ConfigDB.worldBossPower
				end
				byAttackObjects[j] = fightObject
			end
		end
		byAttackerObjectsList.add(byAttackObjects)
	end
	local byAttackObjects  = byAttackerObjectsList.get(0)
	for i = 1, 6 do
		self.byAttackObjects[i] = nil
		if(nil ~= byAttackObjects[i]) then			
			BattleObject battleObject = BattleObject:new(byAttackObjects[i])
			self.byAttackObjects[i] = battleObject
			npcMaxHealth = npcMaxHealth + battleObject.healthMaxPoint
		end
	end
end
--]]
--[[
function FightModule:writeFashionEquipmentInit(attacker, byAttacker, resultBuffer)
		if(Constant.CURRENT_PROJECT_NAME.equals("koa")){
		}
end

function FightModule:dragonTigerfight(userInfo, resultBuffer)
		attackCount = 0
		byAttackCount = 0
		BattleCache tempBattleCache = (BattleCache)userInfo.battleCache
		initBattleInfo(tempBattleCache)
		roundCount = 0
		boolean fightOver = false
		local attackerCombatForce = tempBattleCache.attackCombatForce
		local byAttackerCombatForce = tempBattleCache.byAttackComobatForce
		List<BattleObject> fightOrderList = new ArrayList<BattleObject>()
		local attackIndex = 0
		local byAttackIndex = 0
		local arrLength = attackObjects.length
		boolean win = false
		BattleObject[] tempAttackObjects = attackerCombatForce >= byAttackerCombatForce ? attackObjects : byAttackObjects
		BattleObject[] tempByAttackObjects = attackerCombatForce >= byAttackerCombatForce ? byAttackObjects : attackObjects
		for (local i = 0; i < arrLength; i++) {
			for (; attackIndex<tempAttackObjects.length; attackIndex++){
				if(nil ~= tempAttackObjects[attackIndex]){
					fightOrderList.add(tempAttackObjects[attackIndex])
					if(tempAttackObjects[attackIndex].battleTag == 0){						
						attackCount++
					else
						byAttackCount++
					}
					attackIndex++
					break
				}
			}
			for (; byAttackIndex<tempByAttackObjects.length; byAttackIndex++){
				if(nil ~= tempByAttackObjects[byAttackIndex]){
					fightOrderList.add(tempByAttackObjects[byAttackIndex])
					if(tempByAttackObjects[byAttackIndex].battleTag == 0){						
						attackCount++
					else
						byAttackCount++
					}
					byAttackIndex++
					break
				}
			}
		}
		while(!fightOver){
			if (attackCount <= 0 or byAttackCount<=0){
				win = byAttackCount<=0
				fightOver = true
				break
			}
			if(roundCount == totalRound){
				win = self.fightType == FIGHT_TYPE_PVE_MONEY_TREE
				fightOver = true
				break
			}
			roundCount++
			long nowAttackHeathPoint = self:getBattleObjectHeathPoint(attackObjects)
			long nowDefenceHeathPoint = self:getBattleObjectHeathPoint(byAttackObjects)
			table.insert(resultBuffer, IniUtil.enter)
			table.insert(resultBuffer, roundCount)
			table.insert(resultBuffer, IniUtil.enter)
			byte attackOver = 0
			for (local k = 0; k < fightOrderList.size(); k++) {
				if (attackCount <= 0 or byAttackCount<=0){
					win = byAttackCount<=0
					fightOver = true
					break
				}
				counterBuffer = nil
				battleSkillCount = 0
				battleSkillBuffer = new StringBuffer()
				for (local i = 0; i < attackObjects.length; i++) {
					if(nil ~= attackObjects[i]){
						attackObjects[i].canReAttack=true
						attackObjects[i].clearTalentJudgeResultList()
					}
				}
				for (local i = 0; i < byAttackObjects.length; i++) {
					if(nil ~= byAttackObjects[i]){
						byAttackObjects[i].canReAttack=true
						byAttackObjects[i].clearTalentJudgeResultList()
					}
				}
				BattleObject battleObject = fightOrderList.get(k)
				battleObject.action=true
				battleObject.effectDamage=0
				battleObject.totalEffectDamage=0
				if(battleObject.isDead){
					if(battleObject.battleTag == 0){
						attackObjects[battleObject.coordinate - 1] = nil
					else
						byAttackObjects[battleObject.coordinate - 1] = nil
					}
					fightOrderList.remove(k)
					k--
				else
					if(battleObject.isDizzy()){
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
						battleObject:processBuffEffect(userInfo, self, resultBuffer)
						attackOver = 1
						continue
					}
					List<BattleSkill> battleSkillList = nil
					byte skillReleasePosion = 0
					if(battleObject.skillPoint >= FightModule.MAX_SP and !battleObject.isDisSp()){
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						battleSkillList = battleObject.oneselfBattleSkill
						skillReleasePosion = battleObject.specialSkillMould.skillReleasePosition
						if(battleObject.battleTag == 0){							
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, byAttackObjects))
						else
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, attackObjects))
						}
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.specialSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
					else
						if(battleObject.isParalysis()){
							if (attackOver ~= 0){
								table.insert(resultBuffer, "0")
								table.insert(resultBuffer, IniUtil.compart)
							}
							table.insert(resultBuffer, battleObject.battleTag)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.coordinate)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, battleObject.commonSkillMould.id)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							table.insert(resultBuffer, 0)
							table.insert(resultBuffer, IniUtil.compart)
							battleObject:processBuffEffect(userInfo, self, resultBuffer)
							attackOver = 1
							continue
						}
						if (attackOver ~= 0){
							table.insert(resultBuffer, "0")
							table.insert(resultBuffer, IniUtil.compart)
						}
						table.insert(resultBuffer, battleObject.battleTag)
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.coordinate)
						table.insert(resultBuffer, IniUtil.compart)
						battleSkillList = battleObject.commonBattleSkill
						skillReleasePosion = battleObject.commonSkillMould.skillReleasePosition
						if(battleObject.battleTag == 0){							
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, byAttackObjects))
						else
							table.insert(resultBuffer, FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, attackObjects))
						}
						table.insert(resultBuffer, IniUtil.compart)
						table.insert(resultBuffer, battleObject.commonSkillMould.id)
						table.insert(resultBuffer, IniUtil.compart)
					}
					StringBuffer battleSkillBuffer = new StringBuffer()
					List<Byte> byAttackCoordinates = new ArrayList<Byte>()
					for (BattleSkill battleSkill : battleSkillList) {
						if (battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_DAMAGEHP or battleSkill.skillInfluence.skillCategory == BattleSkill.SKILL_INFLUENCE_ADDHP){
							byAttackCoordinates = {}
						}
						if (0 == battleObject.battleTag) {
							if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE){
								if (#byAttackCoordinates == 0){
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, self.battleObject, self.byAttackObjects)
								}
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE){
								byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, attackObjects)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT){
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}
						else
							if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE){
								if (#byAttackCoordinates == 0){									
									byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, battleObject, attackObjects)
								}
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, attackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE){
								byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, battleSkill.skillInfluence, self.battleObject, self.byAttackObjects)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}else if(battleSkill.skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_CURRENT){
								byAttackCoordinates = {}
								table.insert(byAttackCoordinates, battleObject.coordinate)
								battleSkill:processAttack(userInfo, byAttackCoordinates, battleObject, byAttackObjects, self, battleSkillBuffer)
							}
						}
					}
					table.insert(resultBuffer, battleSkillCount)
					table.insert(resultBuffer, IniUtil.compart)
					table.insert(resultBuffer, battleSkillBuffer)
					table.insert(resultBuffer, self.battleSkillBuffer)
					if(nil ~= counterBuffer){
						table.insert(resultBuffer, counterBuffer)
						counterBuffer = nil
					else
						table.insert(resultBuffer, 0)
						table.insert(resultBuffer, IniUtil.compart)
					}
					battleSkillCount = 0
					battleObject:processBuffEffect(userInfo, self, resultBuffer)
					attackOver = 1
				}
				if (attackCount <= 0 or byAttackCount<=0){
					win = byAttackCount<=0
					fightOver = true
					break
				}
			}
			table.insert(resultBuffer, "1")
			long endAttackHeathPoint = self:getBattleObjectHeathPoint(attackObjects)
			long endDefenceHeathPoint = self:getBattleObjectHeathPoint(byAttackObjects)
			long attackHeathPoint = nowAttackHeathPoint - endAttackHeathPoint
			long defenceHeathPoint = nowDefenceHeathPoint - endDefenceHeathPoint
			----_crint("第"+roundCount+ "回合双方损血量分别是："+attackHeathPoint+" : "+ defenceHeathPoint)
			attackDamages += "," +attackHeathPoint
			defenceDamages += "," +defenceHeathPoint
			attackDeadState += endAttackHeathPoint <= 0 ? ",1" : ",0"
			defenceDeadState += endDefenceHeathPoint <= 0 ? ",1" : ",0"
		}
		attackDamages = string.sub(attackDamages, 1)
		defenceDamages = string.sub(defenceDamages, 1)
		attackDeadState = string.sub(attackDeadState, 1)
		defenceDeadState = string.sub(defenceDeadState, 1)
		self.checkFightResult()
		self.checkDefenceResult()
		if(win){
			return FIGHT_RESULT_WIN
		}
		else{
			return FIGHT_RESULT_LOST
		}
end
--]]
--[[
function FightModule:initRebelArmy()
		if(userRebelArmy ~= nil){
			if(byAttackObjects[0] ~= nil){
				if(userRebelArmy.setOne < 1){
					byAttackObjects[0] = nil
				else
					byAttackObjects[0].healthPoint=userRebelArmy.setOne
				}	
			}
			if(byAttackObjects[1] ~= nil){
				if(userRebelArmy.setTwo < 1){
					byAttackObjects[1] = nil
				else
					byAttackObjects[1].healthPoint=userRebelArmy.setTwo
				}
			}
			if(byAttackObjects[2] ~= nil){
				if(userRebelArmy.setThree < 1){
					byAttackObjects[2] = nil
				else
					byAttackObjects[2].healthPoint=userRebelArmy.setThree
				}
			}
			if(byAttackObjects[3] ~= nil){
				if(userRebelArmy.setFour < 1){
					byAttackObjects[3] = nil
				else
					byAttackObjects[3].healthPoint=userRebelArmy.setFour
				}
			}
			if(byAttackObjects[4] ~= nil){
				if(userRebelArmy.setFive < 1){
					byAttackObjects[4] = nil
				else
					byAttackObjects[4].healthPoint=userRebelArmy.setFive
				}
			}
			if(byAttackObjects[5] ~= nil){
				if(userRebelArmy.setSex < 1){
					byAttackObjects[5] = nil
				else
					byAttackObjects[5].healthPoint=userRebelArmy.setSex
				}
			}
			float doubleAttack = 1
			if(isDouble){
				doubleAttack = 250/100
			}
			if(attackObjects[0] ~= nil){
				attackObjects[0].attack=(local) (attackObjects[0].attack * (attackObjects[0].advance+1) * doubleAttack)
			}
			if(attackObjects[1] ~= nil){
				attackObjects[1].attack=(local) (attackObjects[1].attack * (attackObjects[1].advance+1) * doubleAttack)
			}
			if(attackObjects[2] ~= nil){
				attackObjects[2].attack=(local) (attackObjects[2].attack * (attackObjects[2].advance+1) * doubleAttack)
			}
			if(attackObjects[3] ~= nil){
				attackObjects[3].attack=(local) (attackObjects[3].attack * (attackObjects[3].advance+1) * doubleAttack)
			}
			if(attackObjects[4] ~= nil){
				attackObjects[4].attack=(local) (attackObjects[4].attack * (attackObjects[4].advance+1) * doubleAttack)
			}
			if(attackObjects[5] ~= nil){
				attackObjects[5].attack=(local) (attackObjects[5].attack * (attackObjects[5].advance+1) * doubleAttack)
			}
		}
end
--]]

function FightModule:initFight(npcId, difficulty, fightType,resultBuffer,eveNpc)
	-- local formulaUtil = FormulaUtil:new()
	-- formulaUtil:findFormulaByIndex(1)
	local npcObj = ConfigDB.load("npc", npcId)
	--_crint ("FightModule:initFight ", npcId, difficulty, fightType)
	if(resultBuffer == nil) then
		resultBuffer = {}
	end
	self:initBattleField(npcObj, difficulty, fightType, resultBuffer,eveNpc)
	
	table.insert(resultBuffer, 1, 100)                   -- seq
	table.insert(resultBuffer, 2, IniUtil.enter)
	table.insert(resultBuffer, 3, "battle_field_init")   --cmdname
	table.insert(resultBuffer, 4, IniUtil.enter)
	table.insert(resultBuffer, 5, "0")                   -- result
	table.insert(resultBuffer, 6, IniUtil.enter)
	
	local protocalData = {}
	protocalData.resouce = table.concat(resultBuffer, "")
	
	--_crint ("Using client report data to init battle field \n" .. protocalData.resouce)
	NetworkProtocol.parser_func(protocalData)
end

--数码工会副本
function FightModule:initUninoFight(npcId, difficulty, fightType,resultBuffer,eveNpc)
	-- local formulaUtil = FormulaUtil:new()
	-- formulaUtil:findFormulaByIndex(1)
	local npcObj = ConfigDB.load("npc", npcId)
	--_crint ("FightModule:initFight ", npcId, difficulty, fightType)
	if(resultBuffer == nil) then
		resultBuffer = {}
	end
	self:initBattleField(npcObj, difficulty, fightType, resultBuffer,eveNpc, false)

	local npcInfo = _ED.union_pve_info[tonumber(_ED.union_copy_fight_data_id)]
    if tonumber(npcInfo.max_hp) > 0 then
    	local byAttackObjects = _ED.user_info.battleCache.byAttackerObjectsList[1]
    	local index = 0
		for i,v in pairs(byAttackObjects) do
			index = index + 1
			if v~= nil then
				-- v:setHealthPoint(tonumber(npcInfo.current_hp))
				v.healthPoint = tonumber(npcInfo.current_hp)
			end
		end
    end


	self:writeBattleFieldInit(_ED.user_info.battleCache,  0,  1, resultBuffer)
	
	table.insert(resultBuffer, 1, 100)                   -- seq
	table.insert(resultBuffer, 2, IniUtil.enter)
	table.insert(resultBuffer, 3, "battle_field_init")   --cmdname
	table.insert(resultBuffer, 4, IniUtil.enter)
	table.insert(resultBuffer, 5, "0")                   -- result
	table.insert(resultBuffer, 6, IniUtil.enter)
	
	local protocalData = {}
	protocalData.resouce = table.concat(resultBuffer, "")
	
	--_crint ("Using client report data to init battle field \n" .. protocalData.resouce)
	NetworkProtocol.parser_func(protocalData)
end

--数码净化
function FightModule:initPurifyFight(npcId, difficulty, fightType,resultBuffer,eveNpc)
	local npcObj = ConfigDB.load("npc", npcId)
	if(resultBuffer == nil) then
		resultBuffer = {}
	end

	self:initPurifyBattleField(npcObj, difficulty, fightType, resultBuffer,eveNpc, false)

	function RandFetch(list,num,poolSize,pool) -- list 存放筛选结果，num 筛取个数，poolSize 筛取源大小，pool 筛取源
	    pool = pool or {}
	    math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)))
	    for i=1,num do
	        local rand = math.random(i,poolSize)
	        local tmp = pool[rand] or rand -- 对于第二个池子，序号跟id号是一致的
	        pool[rand] = pool[i] or i
	        pool[i] = tmp

	        table.insert(list, tmp)
	    end
	end

	local byAttackObjects = _ED.user_info.battleCache.byAttackerObjectsList[1]

	local fight_interval_data = zstring.splits(dms.string(dms["play_config"], 65, play_config.param), "|", ",")
	local interval = 1
	local all_fight = {}
	--计算npc战斗力
	if table.nums(_ED.purify_user_ship) > 1 then
		--多人战斗的计算方式
		local totalCombatPower = 0
		local index = 0
		--先计算和上阵卡牌相同数量的npc的战力
		for i,v in pairs(_ED.purify_user_ship) do
			index = index + 1
			if zstring.tonumber(v.hero_fight) > 0 then
				totalCombatPower = totalCombatPower + zstring.tonumber(v.hero_fight)
				all_fight[index] = {}

				all_fight[index].hero_fight = zstring.tonumber(v.hero_fight)
				if zstring.tonumber(all_fight[index].hero_fight) < 200 then
					all_fight[index].hero_fight = 200
				end
				for j,w in pairs(fight_interval_data) do
					if w[2] == "-1" then
						if tonumber(v.hero_fight) > tonumber(w[1]) then
							all_fight[index].interval = j
							break
						end
					else
						if tonumber(v.hero_fight) > tonumber(w[1]) and tonumber(v.hero_fight) <= tonumber(w[2]) then
							all_fight[index].interval = j
							break
						end
					end
				end
			end
		end
		--再计算大于上阵卡牌数的npc的战力
		local average = totalCombatPower/table.nums(_ED.purify_user_ship)
		if average < 200 then
			average = 200
		end
		for j,w in pairs(fight_interval_data) do
			if w[2] == "-1" then
				if tonumber(average) > tonumber(w[1]) then
					interval = j
					break
				end
			else
				if tonumber(average) > tonumber(w[1]) and tonumber(average) <= tonumber(w[2]) then
					interval = j
					break
				end
			end
		end
		for i=1,6 do
			if all_fight[i] == nil then
				all_fight[i] = {}
				all_fight[i].hero_fight = zstring.tonumber(average)
				all_fight[i].interval = interval
			end
		end
	else
		--单人战斗的计算方式
		--找到对应的区间
		local hero_fight = 0
		local my_hero_fight_list = {}
		local function fightingCapacity(a,b)
			local al = tonumber(a.hero_fight)
			local bl = tonumber(b.hero_fight)
			local result = false
			if al > bl then
				result = true
			end
			return result 
		end
		for i,v in pairs(_ED.user_ship) do
			table.insert(my_hero_fight_list, v)
		end
		table.sort(my_hero_fight_list, fightingCapacity)
		hero_fight = zstring.tonumber(my_hero_fight_list[1].hero_fight)
		if hero_fight < 200 then
			hero_fight = 200
		end
		
		-- for i,v in pairs(_ED.purify_user_ship) do
		-- 	if zstring.tonumber(v.hero_fight) > 0 then
		-- 		hero_fight = zstring.tonumber(v.hero_fight)
		-- 		if hero_fight < 200 then
		-- 			hero_fight = 200
		-- 		end
		-- 	end
		-- end
		for i,v in pairs(fight_interval_data) do
			if v[2] == "-1" then
				if tonumber(hero_fight) > tonumber(v[1]) then
					interval = i
					break
				end
			else
				if tonumber(hero_fight) > tonumber(v[1]) and tonumber(hero_fight) <= tonumber(v[2]) then
					interval = i
					break
				end
			end
		end

		--所有NPC的战力
		for i=1,6 do
			all_fight[i] = {}
			all_fight[i].interval = interval
			all_fight[i].hero_fight = hero_fight
		end
	end
	local index = 0

	--随机打乱数组
	local lists = {1,2,3,4,5,6}
	local lists_two = {}
	RandFetch(lists_two,#lists,#lists,lists)
	lists = lists_two

	local index = 0
	for i,v in pairs(lists) do
		index = index + 1
		if byAttackObjects[tonumber(v)] ~= nil then
			--系数A
			local coefficientA = zstring.splits(dms.string(dms["play_config"], 66, play_config.param), "|", ",")[tonumber(all_fight[index].interval)]
			--系数B
			local coefficientB = zstring.splits(dms.string(dms["play_config"], 67, play_config.param), "|", ",")[tonumber(all_fight[index].interval)]
			--系数C
			local coefficientC = zstring.splits(dms.string(dms["play_config"], 68, play_config.param), "|", ",")[tonumber(all_fight[index].interval)]

			--系数D
			local coefficientD = zstring.split(dms.string(dms["play_config"], 69, play_config.param), "|")[tonumber(all_fight[index].interval)]
			--系数E
			local coefficientE = zstring.split(dms.string(dms["play_config"], 70, play_config.param), "|")[tonumber(all_fight[index].interval)]

			byAttackObjects[tonumber(v)].attack = math.ceil(tonumber(coefficientA[1])*tonumber(all_fight[index].hero_fight)^tonumber(coefficientB[1])+tonumber(coefficientC[1]))
			byAttackObjects[tonumber(v)].physicalDefence = math.ceil(tonumber(coefficientA[2])*tonumber(all_fight[index].hero_fight)^tonumber(coefficientB[2])+tonumber(coefficientC[2]))
			byAttackObjects[tonumber(v)].healthPoint = math.ceil(tonumber(coefficientA[3])*tonumber(all_fight[index].hero_fight)^tonumber(coefficientB[3])+tonumber(coefficientC[3]))

			--最终伤害比例
			local f_data = zstring.split(coefficientD,",")
			if table.nums(f_data) > 1 then
				--  -1.548*10^(-12)*战力^2+1.512*10^(-6)*战力-3.925*10^(-3)
				byAttackObjects[tonumber(v)].finalDamagePercent = string.format("%0.4f",math.floor(tonumber(f_data[1])*tonumber(f_data[2])^(tonumber(f_data[3]))*tonumber(all_fight[index].hero_fight)^tonumber(f_data[4])
					+tonumber(f_data[5])*tonumber(f_data[6])^(tonumber(f_data[7]))*tonumber(all_fight[index].hero_fight)+tonumber(f_data[8])*tonumber(f_data[9])^(tonumber(f_data[10]))))*100
			else
				byAttackObjects[tonumber(v)].finalDamagePercent = tonumber(coefficientD)*100
			end

		    --最终减伤比例
		    local fL_data = zstring.split(coefficientE,",")
		    if table.nums(fL_data) > 1 then
		    	-- -2.548*10^(-12)*战力^2+2.47*10^(-6)*战力+2.1076*10^(-2)	
		    	byAttackObjects[tonumber(v)].finalLessenDamagePercent = string.format("%0.4f", math.floor(tonumber(f_data[1])*tonumber(f_data[2])^(tonumber(f_data[3]))*tonumber(all_fight[index].hero_fight)^tonumber(f_data[4])
		    		+tonumber(f_data[5])*tonumber(f_data[6])^(tonumber(f_data[7]))*tonumber(all_fight[index].hero_fight)+tonumber(f_data[8])*tonumber(f_data[9])^(tonumber(f_data[10]))))*100
		    else
		    	byAttackObjects[tonumber(v)].finalLessenDamagePercent = tonumber(coefficientE)*100
		    end
		end
	end

	self:writeBattleFieldInit(_ED.user_info.battleCache,  0,  1, resultBuffer)
	table.insert(resultBuffer, 1, 100)                   -- seq
	table.insert(resultBuffer, 2, IniUtil.enter)
	table.insert(resultBuffer, 3, "battle_field_init")   --cmdname
	table.insert(resultBuffer, 4, IniUtil.enter)
	table.insert(resultBuffer, 5, "0")                   -- result
	table.insert(resultBuffer, 6, IniUtil.enter)
	
	local protocalData = {}
	protocalData.resouce = table.concat(resultBuffer, "")
	NetworkProtocol.parser_func(protocalData)
end

function FightModule:initSpecialFight(npcId, difficulty, fightType,resultBuffer,eveNpc)
	-- local formulaUtil = FormulaUtil:new()
	-- formulaUtil:findFormulaByIndex(1)
	local npcObj = ConfigDB.load("npc", npcId)
	--_crint ("FightModule:initFight ", npcId, difficulty, fightType)
	if(resultBuffer == nil) then
		resultBuffer = {}
	end
	-- self:initSpecialBattleField(npcObj, difficulty, fightType, resultBuffer,eveNpc)
	self:initBattleField(npcObj, difficulty, fightType, resultBuffer,eveNpc, false)
	--试炼的npc属性加成公式
-- 61	【数码宝贝】数码试炼npc属性公式战力区间	61	1000,4000|4000,10000|10000,67128|67128,-1
-- 62	【数码宝贝】数码试炼npc属性公式系数A	62	0.1203,0.0468,0.62|0.1203,0.0468,0.62|0.1203,0.0468,0.62|8.802,0.2264,6.963
-- 63	【数码宝贝】数码试炼npc属性公式系数B	63	1,1,1|1,1,1|1,1,1|0.678,0.8897,0.8305
-- 64	【数码宝贝】数码试炼npc属性公式系数C	64	0,0,159.31|0,0,159.31|0,0,159.31|-8338,-1062,-28600
	local fight_interval_data = zstring.splits(dms.string(dms["play_config"], 61, play_config.param), "|", ",")
	--找到对应的区间
	local interval = 1
	for i,v in pairs(fight_interval_data) do
		if v[2] == "-1" then
			if tonumber(_ED.three_kingdoms_npc_fight) > tonumber(v[1]) then
				interval = i
				break
			end
		else
			if tonumber(_ED.three_kingdoms_npc_fight) > tonumber(v[1]) and tonumber(_ED.three_kingdoms_npc_fight) <= tonumber(v[2]) then
				interval = i
				break
			end
		end
	end
	--系数A
	local coefficientA = zstring.splits(dms.string(dms["play_config"], 62, play_config.param), "|", ",")[interval]
	--系数B
	local coefficientB = zstring.splits(dms.string(dms["play_config"], 63, play_config.param), "|", ",")[interval]
	--系数C
	local coefficientC = zstring.splits(dms.string(dms["play_config"], 64, play_config.param), "|", ",")[interval]
	--公式：攻击力 = coefficientA[1]*战力^coefficientB[1]+coefficientC[1]
	--		防御力 = coefficientA[2]*战力^coefficientB[2]+coefficientC[2]
	--		生命力 = coefficientA[3]*战力^coefficientB[3]+coefficientC[3]
	local byAttackObjects = _ED.user_info.battleCache.byAttackerObjectsList[1]
	--加属性
	for i,v in pairs(byAttackObjects) do
		v.attack = math.ceil(tonumber(coefficientA[1])*tonumber(_ED.three_kingdoms_npc_fight)^tonumber(coefficientB[1])+tonumber(coefficientC[1]))
		v.physicalDefence = math.ceil(tonumber(coefficientA[2])*tonumber(_ED.three_kingdoms_npc_fight)^tonumber(coefficientB[2])+tonumber(coefficientC[2]))
		v.healthPoint = math.ceil(tonumber(coefficientA[3])*tonumber(_ED.three_kingdoms_npc_fight)^tonumber(coefficientB[3])+tonumber(coefficientC[3]))
	end
 
	local try_ship_datas = zstring.split(_ED.user_try_ship_datas, "-")
	if try_ship_datas[2] ~= nil then
		local try_info = zstring.split(try_ship_datas[2], ",")
		if tonumber(_ED.integral_current_index) == tonumber(try_info[1]) and tonumber(_ED.three_kingdoms_battle_index) == tonumber(try_info[2]) then
			local ship_datas = zstring.split(try_ship_datas[3], "|")
			local byAttackObjects = _ED.user_info.battleCache.byAttackerObjectsList[1]
			for i,v in pairs(byAttackObjects) do
				for j,w in pairs(ship_datas) do
					local datas = zstring.split(w, ",")
					if tonumber(datas[1]) == tonumber(v.id) then
						if tonumber(datas[2]) > 0 then
							v.healthPoint = tonumber(datas[2])
						else
							v.healthPoint = 0
						end
					end
				end
			end
			for i,v in pairs(byAttackObjects) do
				if tonumber(v.healthPoint) == 0 then
					_ED.user_info.battleCache.byAttackerObjectsList[1][i] = nil
				end
			end
		end
	end

	self:writeBattleFieldInit(_ED.user_info.battleCache,  0,  1, resultBuffer)

	-----
	table.insert(resultBuffer, 1, 100)                   -- seq
	table.insert(resultBuffer, 2, IniUtil.enter)
	table.insert(resultBuffer, 3, "battle_field_init")   --cmdname
	table.insert(resultBuffer, 4, IniUtil.enter)
	table.insert(resultBuffer, 5, "0")                   -- result
	table.insert(resultBuffer, 6, IniUtil.enter)
	
	local protocalData = {}
	protocalData.resouce = table.concat(resultBuffer, "")
	
	--_crint ("Using client report data to init battle field \n" .. protocalData.resouce)
	NetworkProtocol.parser_func(protocalData)
end

function FightModule:doFight()
	local resultBuffer = {}
	
	self:fight(_ED.user_info, resultBuffer)
	
	table.insert(resultBuffer, 1, 100)                   -- seq
	table.insert(resultBuffer, 2, IniUtil.enter)
	table.insert(resultBuffer, 3, "environment_fight")   --cmdname
	table.insert(resultBuffer, 4, IniUtil.enter)
	table.insert(resultBuffer, 5, "0")                   -- result
	table.insert(resultBuffer, 6, IniUtil.enter)
	
	local reportString = "" --"100\r\nenvironment_fight\r\n0\r\n39\r\n1\r\n20\r\n3\r\n1\r\n0 1 0 1 3 893 0 1 248 0 0 1 2 -1 -1 0 1 0 2 2 0 0 0 0 1 2 1 0 101 1 0 0 0 0 0 0 0 2 0 1 0 1543 0 1 452 0 0 2 2 -1 -1 0 2 0 2 2 0 0 0 0 1 2 0 0 477 1 0 0 1 1 1 0 0 0 0 3 0 0 7 794 0 1 220 0 0 3 2 -1 -1 0 3 0 2 2 0 0 0 0 1 6 0 0 133 1 0 0 0 0 0 0 1 4 0 0 2 1282 0 1 361 0 1 4 2 -1 -1 1 4 0 2 2 0 0 0 0 0 1 0 0 192 1 0 0 0 0 0 0 1 5 0 0 3 1282 0 1 361 0 1 5 2 -1 -1 1 5 0 2 2 0 0 0 0 0 2 0 0 102 1 0 0 0 0 0 0 1 6 0 0 4 1282 0 1 361 0 1 6 2 -1 -1 1 6 0 2 2 0 0 0 0 0 3 0 0 172 1 0 0 0 0 0 1\r\n2\r\n0 1 0 0 5 893 0 1 248 0 0 1 2 -1 -1 0 1 0 2 2 0 0 0 0 1 4 0 0 107 1 0 0 0 0 0 0 0 2 0 0 0 1543 0 1 452 0 0 2 2 -1 -1 0 2 0 2 2 0 0 0 0 1 5 0 0 446 1 0 0 0 0 0 0 0 3 0 0 7 794 0 1 220 0 0 3 2 -1 -1 0 3 0 2 2 0 0 0 0 1 6 0 0 169 1 0 2 0 0 0 0 1 4 0 0 2 1282 0 1 361 0 1 4 2 -1 -1 1 4 0 2 2 0 0 0 0 0 1 0 0 201 1 0 0 0 0 0 0 1 5 0 0 3 1282 0 1 361 0 1 5 2 -1 -1 1 5 0 2 2 0 0 0 0 0 2 0 0 100 1 0 0 0 0 0 0 1 6 0 0 4 1282 0 1 361 0 1 6 2 -1 -1 1 6 0 2 2 0 0 0 0 0 3 0 0 163 1 0 0 0 0 0 1\r\n3\r\n0 1 0 0 2 894 0 2 249 0 0 1 2 0 1,4 0 1 0 3 5 0 0 0 0 1 4 0 0 204 1 0 0 0 250 0 0 1 1 -1 -1 0 1 0 12 0 1 2 0 0 0 0 0 0 2 0 0 0 1544 0 1 453 0 0 2 4 -1 -1 0 2 0 3 5 0 0 0 0 1 5 0 0 676 1 0 0 1 1 1 1 6 0 0 682 1 0 0 1 1 1 1 4 0 0 722 1 0 0 1 0 0 0 0 1\r\n"
	----_crint("Server report string: ")
	----_crint ("reportString)
	table.insert(resultBuffer, 7, "39")                   -- protocol number
	table.insert(resultBuffer, 8, IniUtil.enter)
	
	
	reportString = table.concat(resultBuffer, "")
	--_crint ("Battle report is: \n" .. reportString)

	local protocalData = {}
	protocalData.resouce = reportString
	
	--_crint ("Using client report data to replace server data xxxxxxxxxxxxxxxx")
	NetworkProtocol.parser_func(protocalData)
end

function FightModule:setFightIndex(idx)
	if  (_ED.user_info.battleCache ~= nil) then
		_ED.user_info.battleCache.currentBattleCount = idx
	else
		--_crint("Set setFightIndex failed")
	end
end

function FightModule:initDailyInstance()
	for i = 1, 6 do
		if(self.attackObjects[i] == nil) then
			--continue
		else
			self.attackObjects[i]:addHealthPoint(self.addHpoint)
			self.attackObjects[i]:addHealthMaxPoint(self.addHpoint)
			self.attackObjects[i]:addAttackValue(self.addAttack)
		end
	end
end

function FightModule:calculateRebelArmy(userRebelArmy)
	local deadCount = 0
	if(byAttackObjects[1] ~= nil and byAttackObjects[1].isDead ~= true) then
		userRebelArmy.setOne=byAttackObjects[1].healthPoint
		deadCount = deadCount + 1
	else
		userRebelArmy.setOne=0
	end
	if(byAttackObjects[2] ~= nil and byAttackObjects[2].isDead ~= true) then
		userRebelArmy.setTwo=byAttackObjects[2].healthPoint
		deadCount = deadCount + 1
	else
		userRebelArmy.setTwo=0
	end
	if(byAttackObjects[3] ~= nil and byAttackObjects[3].isDead ~= true)  then
		userRebelArmy.setThree=byAttackObjects[3].healthPoint
		deadCount = deadCount + 1
	else
		userRebelArmy.setThree=0
	end
	if(byAttackObjects[4] ~= nil and byAttackObjects[4].isDead ~= true)  then
		userRebelArmy.setFour=byAttackObjects[4].healthPoint
		deadCount = deadCount + 1
	else
		userRebelArmy.setFour=0
	end
	if(byAttackObjects[5] ~= nil and byAttackObjects[5].isDead ~= true)  then
		userRebelArmy.setFive=byAttackObjects[5].healthPoint
		deadCount = deadCount + 1
	else
		userRebelArmy.setFive=0
	end
	if(byAttackObjects[6] ~= nil and byAttackObjects[6].isDead ~= true)  then
		userRebelArmy.setSex=byAttackObjects[6].healthPoint
		deadCount = deadCount + 1
	else
		userRebelArmy.setSex=0
	end
	if(deadCount==0)  then
		userRebelArmy.share=0
		userRebelArmy.rebelArmyId=0
	end
end


local obj = FightModule:new()
