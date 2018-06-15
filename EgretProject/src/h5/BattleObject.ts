class BattleObject {
	public constructor() {
	}

	//生命加成百分比
    powerAdditionalPercent = 0;
    //攻击加成百分比
    courageAdditionalPercent = 0;
    //物理防御加成百分比
    intellectAdditionalPercent = 0;
	//法防加成百分比
    nimableAdditionalPercent = 0;
    //暴击加成百分比
    criticalAdditionalPercent = 0;
    //抗暴加成百分比
    criticalResistAdditionalPercent = 0;
    //闪避加成百分比
    evasionAdditionalPercent = 0;
    //命中加成百分比
	accuracyAdditionalPercent = 0;
    //挡格加成百分比
    retainAdditionalPercent = 0;
    //破击加成百分比
    retainBreakAdditionalPercent = 0;
    //物理免伤加成百分比
	physicalLessenDamagePercent = 0;
    //法术免伤加成百分比
    skillLessenDamagePercent = 0;
	//38.每次出手增加的怒气
	everyAttackAddSp = 0;
	//39.灼烧伤害% 
	firingDamagePercent = 0;
	//40.吸血率%
	inhaleHpDamagePercent = 0;
	//41.怒气
	addSpValue = 0;
	//42.反弹%  
	reboundDamageValue = 0;
	//43.暴伤加成%	   
	uniqueSkillDamagePercent = 0;
	//44.免控率%  
	avoidControlPercent = 0;
	//45.小技能触发概率%  
	normatinSkillTriggerPercent = 0;
	//46.格挡强度% 
	uniqueSkillResistancePercent = 0;
	//47.控制率%
	controlPercent = 0;
	//48.治疗效果% 
	cureEffectPercent = 0;
	//49.暴击强化% 
	criticalAdditionPercent = 0;
    //50.数码兽类型克制伤害%   (可为负数)
    heroRestrainDamagePercent = 0;
    //51.溅射伤害%
    sputteringAttackAddDamagePercent = 0;
    //52.技能伤害%
    skillAttackAddDamagePercent = 0;
    //53.被治疗减少%
    byCureLessenPercent = 0;
    //54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
    ptvf54 = 0;
	//55.必杀伤害率%
	ptvf55 = 0;
	//56.增加必杀伤害%
	ptvf56 = 0;
	//57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
	ptvf57 = 0;
	//58.增加暴击伤害%
	ptvf58 = 0;
	//59.减少暴击伤害%
	ptvf59 = 0;
	//60.受到的必杀伤害增加%
	ptvf60 = 0;
	//61.怒气回复速度%
	ptvf61 = 0;
	//62.受到伤害降低%
	ptvf62 = 0;
	//63.降低攻击(%)	
	ptvf63 = 0;
	//64.降低防御
	ptvf64 = 0;
	//65降低必杀伤害率%	
	ptvf65 = 0;
	//66降低必杀伤害率%
	ptvf66 = 0;
	//67降低伤害减免%
	ptvf67 = 0;
	//68降低防御（%）
	ptvf68 = 0;
	//69降低怒气回复速度
	ptvf69 = 0;
	//70数码兽类型克制伤害加成%	
	ptvf70 = 0;
	//71数码兽类型克制伤害减免%	
	ptvf71 = 0;
    //72.降低攻击
    ptvf72 = 0;
    //73.增加必杀抗性%
    ptvf73 = 0;
    //74.减少必杀抗性%
    ptvf74 = 0;
    //75降低免控率%
    ptvf75 = 0;
    //76复活概率%
    ptvf76 = 0;
    //77被复活概率%
    ptvf77 = 0;
    //78复活继承血量%    
    ptvf78 = 0;
    //79复活继承怒气%    
    ptvf79 = 0;
    //80被复活继承血量%   
    ptvf80 = 0;
    //81被复活继承怒气%   
    ptvf81 = 0;
    //82增加复活概率%   
    ptvf82 = 0;
    //83增加复活继承血量% 
    ptvf83 = 0;
    //84小技能伤害提升% 
    ptvf84 = 0;

	//阵营
	battleTag = 0;
	//位置
	coordinate = 0;
	healthPoint = 0;
	healthMaxPoint = 0;
	skillPoint = 0;
	//对象id
	id = 0;
	//模板id
	shipMould = 0;
	capacity = 0;
	//是否死亡
	isDead = false;
	//普通攻击效用列表
	commonBattleSkill: Array<BattleSkill> = [];
	//小技能攻击效用列表
	normalBattleSkill: Array<BattleSkill> = [];
	//当前battleObject对应的fightObject
	fightObject: FightObject;
	//普攻
	commonSkillMould:SkillMould;
	//小技能
	normalSkillMould: SkillMould;
	//是否是否是小技能
	normalSkillMouldOpened = false;
	//记录小技能使用次数
	normalSkillUseCount = 0;
	//是否复活
	revived = false;
	//是否已经出过手
	isAction = false;
	//用户信息
	userInfo = -1;
	//攻击时附加怒气
	attackAdditionSpValue = 0;
	//被击时是否增加怒气，1表示是
	byAttackDamageAddSp = 1;
	//是否闪避
	isEvasion = false;
	//是否格挡
	isRetain = false;
	//是否暴击
	isCritical = false;

	public initWithAttackObject(fightObj: FightObject) {
		this.resetSkillAndTalentInfo();
		this.initProperty(fightObj);
		this.initSkillAndTalentInfo();
	}

	public resetSkillAndTalentInfo() {

	}

	public initProperty(fightObj: FightObject) {
		this.fightObject = fightObj;
		this.battleTag = fightObj.battleTag;
		this.coordinate = fightObj.coordinate;
		this.id = fightObj.id;
		this.shipMould = fightObj.shipMould;
		this.capacity = fightObj.capacity;
		
		this.commonSkillMould = fightObj.commonSkill;
	
	}

	//初始化技能和天赋信息
	public initSkillAndTalentInfo() {
		let fightObject = this.fightObject;

		//普通攻击的技能效用id数组
		let commonSkillArray = fightObject.commonSkill.health_affect.split(",");

		this.normalSkillMould = ConfigDB.loadConfig("skill_mould_txt", fightObject.normalSkillMould);
		//小技能效用id数组
		let normalSkillArray = this.normalSkillMould.health_affect.split(",");

		//生成普通攻击效用列表
		for (let i = 0; i < commonSkillArray.length; i++) {
			let skillInfluence: SkillInfluence = ConfigDB.loadConfig("skill_influence_txt", commonSkillArray[i]);
			let battleSkill = new BattleSkill;
			battleSkill.attackerTag = this.battleTag;
			battleSkill.attacterCoordinate = this.coordinate;
			battleSkill.skillMould = fightObject.commonSkill;
			battleSkill.skillInfluence = skillInfluence;
			if (this.battleTag == 0) {
				if (skillInfluence.influenceGroup == 0) {
					battleSkill.byAttackerTag = 0;
				}
				else {
					battleSkill.byAttackerTag = 1;
				}
			}
			else {
				if (skillInfluence.influenceGroup == 0) {
					battleSkill.byAttackerTag = 1;
				}
				else {
					battleSkill.byAttackerTag = 0;
				}
			}
			battleSkill.effectType = skillInfluence.skillCategory;
			battleSkill.effectRound = skillInfluence.influenceDuration;
			this.commonBattleSkill.push(battleSkill);
		}

		//生成小技能效用列表
		for (let i = 0; i < normalSkillArray.length; i++) {
			let skillInfluence: SkillInfluence = ConfigDB.loadConfig("skill_influence_txt", normalSkillArray[i]);
			let battleSkill = new BattleSkill;
			battleSkill.attackerTag = this.battleTag;
			battleSkill.attacterCoordinate = this.coordinate;
			battleSkill.skillMould = this.normalSkillMould;
			battleSkill.skillInfluence = skillInfluence;
			if (this.battleTag == 0) {
				if (skillInfluence.influenceGroup == 0) {
					battleSkill.byAttackerTag = 0;
				}
				else {
					battleSkill.byAttackerTag = 1;
				}
			}
			else {
				if (skillInfluence.influenceGroup == 0) {
					battleSkill.byAttackerTag = 1;
				}
				else {
					battleSkill.byAttackerTag = 0;
				}
			}
			battleSkill.effectType = skillInfluence.skillCategory;
			battleSkill.effectRound = skillInfluence.influenceDuration;
			this.normalBattleSkill.push(battleSkill);
		}
	}

	public nextBattleInfo() {

	}

	//减怒气
	public subSkillPoint(skillPoint: number) {
		this.skillPoint = this.skillPoint - skillPoint;
		if (this.skillPoint < 0) {
			this.skillPoint = 0;
		}
	}

	//加怒气
	public addSkillPoint(skillPoint: number, needCallFormula: boolean) {
		if (needCallFormula == true) {
			skillPoint = skillPoint * (Math.max(0, (1 + this.ptvf61 - this.ptvf69)));
		}

		this.skillPoint = this.skillPoint + skillPoint;
		if (this.skillPoint > FightModule.MAX_SP) {
			this.skillPoint = FightModule.MAX_SP;
		}

		if (this.skillPoint < 0) {
			this.skillPoint = 0;
		}
		return skillPoint;
	}

	//加血
	public addHealthPoint(healthPoint: number) {
		this.healthPoint = this.healthPoint + healthPoint;
		if (this.healthPoint > this.healthMaxPoint) {
			this.healthPoint = this.healthMaxPoint;
		}
	}

	//减血
	public subHealthPoint(healthPoint: number) {
		this.healthPoint = this.healthPoint - healthPoint;
	}
}