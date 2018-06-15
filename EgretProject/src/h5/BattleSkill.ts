//用于处理技能效用的类，每个BattleObject包含普通技能，小技能，必杀技，每种技能又包含多种技能效用，一个BattleSkill对应一个技能效用，每一个技能效用可能有多个承受者的hp和sp受影响，比如自己加减怒，对方加怒，对方掉血
class BattleSkill {
	public constructor() {
	}

	//效用发起阵营
	attackerTag = 0;
	//效用发起位置
	attacterCoordinate = 0;
	//技能模板
	skillMould: SkillMould;
	//技能效用模板
	skillInfluence: SkillInfluence;
	//效用作用阵营
	byAttackerTag = 0;
	//效用种类 skillInfluence.skillCategory
	effectType = 0;
	//效用影响值
	effectValue = 0;
	//效用作用时长 skillInfluence.influenceDuration
	effectRound = 0;
	//技能效用的索引公式
	formulaInfo = 0;
	//承受方的位置
	byAttackerCoordinate = 0;
	//相克状态
	restrain = 0;
	//是否显示
	isDisplay = 1;
	//承受状态(0:命中 1:闪避 2:暴击 3:格挡 4:暴击加格挡)
	bearState = 0;
	//生存状态(0:存活 1:死亡 2:反击 3:复活)
    aliveState = 0;
	//作用数量
	effectAmount = 0;
	//清除的BUFF类型
    clearBuffState = 0;

	public processAttack(userInfo, byAttackCoordinates: Array<number>, attackObject: BattleObject, byAttackObjects: {[key: number]: BattleObject}, fightModule: FightModule, resultBuffer) {
		let effectBuffer: Array<any> = [];
	
		//我方的效用承受情况
		if (attackObject.isAction == false) {
			attackObject.isAction = true;
			//承受方是攻击方
			this.byAttackerTag = attackObject.battleTag;
			this.byAttackerCoordinate = attackObject.coordinate;

			//减怒
			if (attackObject.skillPoint >= FightModule.MAX_SP) {
				this.effectType = SKILL_INFUENCE_RESULT.SKILL_INFLUENCE_DAMAGESP;
				this.effectValue = attackObject.skillPoint * 1000;
				attackObject.subSkillPoint(this.effectValue);
			}
			//加怒 
			else {
				this.effectType = SKILL_INFUENCE_RESULT.SKILL_INFLUENCE_ADDSP;
				let addSpValue = FightModule.ATTACK_SP_ADD_VAULE + attackObject.attackAdditionSpValue;
				this.effectValue = attackObject.addSkillPoint(addSpValue, true);
			}
			let buffer = this.writeSkillAttack(userInfo, attackObject, attackObject, fightModule);
			effectBuffer.push(buffer);
		}

		//敌方的效用承受情况
		for (let i = 0; i < byAttackCoordinates.length; i++) {
			let byAttackObject = byAttackObjects[byAttackCoordinates[i]];
			if (byAttackObject && byAttackObject.isDead == false && byAttackObject.revived == false) {
				//记录被击前的血量，后面会经过公式计算，血量会有变化
				let currentHp = byAttackObject.healthPoint;
				this.byAttackerTag = byAttackObject.battleTag;
				this.byAttackerCoordinate = byAttackObject.coordinate;
				this.effectType = this.skillInfluence.skillCategory;

				if (this.effectType == SKILL_INFUENCE_RESULT.SKILL_INFLUENCE_DAMAGEHP) {
					//是否闪避
					if (byAttackObject.isEvasion == false) {
						if (attackObject.isCritical == true) {
							//暴击
							this.bearState = 2;
						}

						if (byAttackObject.isRetain == true) {
							if (this.bearState == 2) {
								//暴击加格挡
								this.bearState = 4;
							}
							else {
								//格挡
								this.bearState = 3;
							}
						}
					}
					else {
						//闪避
						this.bearState = 1;
					}
				}
				else {
					//命中
					this.bearState = 0;
				}

				let effectArray: Array<number> = [];
				
				if (this.skillInfluence.skillCategory == SKILL_INFUENCE_RESULT.SKILL_INFUENCE_CLEAR_BUFF) {

				}
				else {
					effectArray = FightUtil.computeSkillEffect(this, this.skillMould, this.skillInfluence, attackObject, byAttackObject, userInfo, fightModule);
				}

				this.effectValue = effectArray[1];
				this.effectRound = effectArray[2];
				this.clearBuffState = effectArray[4];
				if (effectArray[3] > 0) {
					this.bearState =  effectArray[3];
				}

				let dspValue = 0;
				if (byAttackObject.byAttackDamageAddSp == 1) {
					dspValue = (currentHp - byAttackObject.healthPoint) / byAttackObject.healthMaxPoint * FightModule.MAX_SP;
				}

				// if byAttackObject.skillPoint <= FightModule.MAX_SP then
				// 	if dspValue > 0 then
				// 		local bs = BattleSkill:new()
				// 		bs.byAttackerTag = byAttackObject.battleTag
				// 		bs.byAttackerCoordinate = byAttackObject.coordinate
				// 		bs.isDisplay = 0
				// 		bs.effectType = BattleSkill.SKILL_INFLUENCE_ADDSP
				// 		bs.effectValue = dspValue
				// 		bs.effectValue = byAttackObject:addSkillPoint(dspValue, true)
				// 		debug.print_r(effectBuffer, "BattleSkill:processAttack 3-11---- start")
				// 		bs:writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule, effectBuffer)
				// 		debug.print_r(effectBuffer, "BattleSkill:processAttack 3-11 ---- end")
				// 		self.effectAmount = self.effectAmount + 1
				// 	end
				// end

				//敌方加怒
				if (byAttackObject.skillPoint <= FightModule.MAX_SP) {
					if (dspValue > 0) {
						let bs = new BattleSkill;
						bs.byAttackerTag = byAttackObject.battleTag;
						bs.byAttackerCoordinate = byAttackObject.coordinate;
						bs.effectType = SKILL_INFUENCE_RESULT.SKILL_INFLUENCE_ADDSP;
						bs.effectValue = byAttackObject.addSkillPoint(dspValue, true);
						let buffer = this.writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule);
						effectBuffer.push(buffer);
					}
				}

				//敌方减血，没闪避
				if (effectArray[3] != 1) {
					let buffer = this.writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule);
					effectBuffer.push(buffer);
				}
				

			}
		}

		this.effectAmount = effectBuffer.length;
		if (this.effectAmount > 0) {
			resultBuffer.skillInfluenceid = this.skillInfluence.id;
			resultBuffer.influenceType = 0;
			resultBuffer.battleTag = attackObject.battleTag;
			resultBuffer.coordinate = attackObject.coordinate;
			resultBuffer.effectAmount = this.effectAmount;
			let endureDirection = FightUtil.computeEndureDirection(attackObject.coordinate, this.skillInfluence, byAttackObjects);
			resultBuffer.attPosType = endureDirection[0];
			resultBuffer.attTarList = endureDirection[1];
			resultBuffer.effectBuffer = effectBuffer;
		}

	}

	//写效用数据
	public writeSkillAttack(userInfo, attackObject: BattleObject, byAttackObject: BattleObject, fightModule: FightModule) {
		let resultBuffer: any = {};
		resultBuffer.byAttackerTag = this.byAttackerTag;
		resultBuffer.byAttackerCoordinate = this.byAttackerCoordinate;
		resultBuffer.restrain = this.restrain;
		resultBuffer.effectType = this.effectType;
		resultBuffer.effectValue = this.effectValue;
		resultBuffer.isDisplay = this.isDisplay;
		resultBuffer.effectRound = this.effectRound;
		resultBuffer.bearState = this.bearState;
		resultBuffer.aliveState = this.aliveState;
		resultBuffer.healthPoint = byAttackObject.healthPoint;
		resultBuffer.skillPoint = byAttackObject.skillPoint;
		return resultBuffer;
	}
}