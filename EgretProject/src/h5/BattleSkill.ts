//用于处理技能效用的类，每个BattleObject包含普通技能，小技能，必杀技，每种技能又包含多种技能效用
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

	public processAttack(userInfo, byAttackCoordinates: Array<any>, attackObject: BattleObject, byAttackObjects: Array<BattleObject>, fightModule: FightModule, resultBuffer) {
		let effectBuffer: Array<any>;
	
		// if (attackObject.isAction == false) {
		// 	attackObject.isAction = true;
		// 	this.byAttackerTag = attackObject.battleTag;
		// 	this.byAttackerCoordinate = attackObject.coordinate;
		// 	this.writeSkillAttack(userInfo, attackObject, attackObject, fightModule, effectBuffer);
		// }

		for (let i = 0; i < byAttackCoordinates.length; i++) {
			let byAttackObject = byAttackObjects[byAttackCoordinates[i]];
			if (byAttackObject == null || byAttackObject.isDead == true || byAttackObject.revived == true) {

			}
			else {
				let effectArray: Array<number>;
				if (effectArray[3] != 1) {
					let buffer = this.writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule);
					effectBuffer.push(buffer);
					this.effectAmount = this.effectAmount + 1;
				} 
			}
		}

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
		let resultBuffer;
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