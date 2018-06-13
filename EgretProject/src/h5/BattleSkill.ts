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
	//效用作用时长 skillInfluence.influenceDuration
	effectRound = 0;
	//技能效用的索引公式
	formulaInfo = 0;

	public processAttack(userInfo, byAttackCoordinates: Array<any>, attackObject: BattleObject, byAttackObjects: BattleObject, fightModule: FightModule, resultBuffer) {

	}
}