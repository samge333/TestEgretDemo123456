var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var BattleCache = (function () {
    function BattleCache() {
        //攻击方名称
        this.attackName = "";
        //被攻击方名称
        this.byAttackName = "";
        //战斗类型
        this.battleType = FightModuleEnum.FIGHT_TYPE_PVE_NORMAL;
        //攻击方战力
        this.attackCombatForce = 0;
        //被攻击方战力
        this.byAttackComobatForce = 0;
        //被攻击者Id
        this.byAttackerId = 0;
        //当前战斗场次
        this.currentBattleCount = 0;
        //最大战斗场次
        this.maxBattleCount = 0;
        //难度
        this.difficulty = 1;
        //阵型战斗对象
        this.attackerObjects = {};
        //被攻击者战斗对象队列
        this.byAttackerObjectsList = [];
        //战斗中奖励卡牌
        this.battleReward = null;
        //战斗中奖励道具
        this.battleRewardProp = null;
        //战斗中奖励装备
        this.battleRewardEquipment = null;
        //总伤害
        this.totalDamage = 0;
        this.userViceCaptainInfo = null;
        this.byUserViceCaptainInfo = null;
        this.attacker_priority = 0;
        this.defender_priority = 0;
        this.attackerSpeedValue = 0;
        this.attacker_head_pic = 0;
        this.defender_head_pic = 0;
    }
    return BattleCache;
}());
__reflect(BattleCache.prototype, "BattleCache");
//# sourceMappingURL=BattleCache.js.map