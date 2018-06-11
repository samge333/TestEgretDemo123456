class BattleCache {
	public constructor() {
	}

	//用户信息
	userInfo: any = null;
    //攻击方名称
    attackName =  "";
    //被攻击方名称
	byAttackName = "";
    //战斗类型
    battleType = FightModuleEnum.FIGHT_TYPE_PVE_NORMAL;
    //攻击方战力
    attackCombatForce = 0;
    //被攻击方战力
    byAttackComobatForce = 0;
    //被攻击者Id
    byAttackerId: any = null;
    //当前战斗场次
    currentBattleCount = 0;
    //最大战斗场次
    maxBattleCount = 0;
    //难度
    difficulty = 1;
    //阵型战斗对象
    attackerObjects: any = null;
    //被攻击者战斗对象队列
	byAttackerObjectsList: any = null;
    //战斗中奖励卡牌
    battleReward: any = null;
    //战斗中奖励道具
    battleRewardProp: any = null;
    //战斗中奖励装备
    battleRewardEquipment: any = null;
    //总伤害
    totalDamage = 0;
    userViceCaptainInfo: any = null;
    byUserViceCaptainInfo: any = null;

	attackerSpeedValue = 0;

}