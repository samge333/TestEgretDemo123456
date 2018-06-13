var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
//用于处理技能效用的类，每个BattleObject包含普通技能，小技能，必杀技，每种技能又包含多种技能效用
var BattleSkill = (function () {
    function BattleSkill() {
        //效用发起阵营
        this.attackerTag = 0;
        //效用发起位置
        this.attacterCoordinate = 0;
        //效用作用阵营
        this.byAttackerTag = 0;
        //效用种类 skillInfluence.skillCategory
        this.effectType = 0;
        //效用影响值
        this.effectValue = 0;
        //效用作用时长 skillInfluence.influenceDuration
        this.effectRound = 0;
        //技能效用的索引公式
        this.formulaInfo = 0;
        //承受方的位置
        this.byAttackerCoordinate = 0;
        //相克状态
        this.restrain = 0;
        //是否显示
        this.isDisplay = 1;
        //承受状态(0:命中 1:闪避 2:暴击 3:格挡 4:暴击加格挡)
        this.bearState = 0;
        //生存状态(0:存活 1:死亡 2:反击 3:复活)
        this.aliveState = 0;
        //作用数量
        this.effectAmount = 0;
    }
    BattleSkill.prototype.processAttack = function (userInfo, byAttackCoordinates, attackObject, byAttackObjects, fightModule, resultBuffer) {
        var effectBuffer;
        // if (attackObject.isAction == false) {
        // 	attackObject.isAction = true;
        // 	this.byAttackerTag = attackObject.battleTag;
        // 	this.byAttackerCoordinate = attackObject.coordinate;
        // 	this.writeSkillAttack(userInfo, attackObject, attackObject, fightModule, effectBuffer);
        // }
        for (var i = 0; i < byAttackCoordinates.length; i++) {
            var byAttackObject = byAttackObjects[byAttackCoordinates[i]];
            if (byAttackObject == null || byAttackObject.isDead == true || byAttackObject.revived == true) {
            }
            else {
                var effectArray = void 0;
                if (effectArray[3] != 1) {
                    var buffer = this.writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule);
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
            var endureDirection = FightUtil.computeEndureDirection(attackObject.coordinate, this.skillInfluence, byAttackObjects);
            resultBuffer.attPosType = endureDirection[0];
            resultBuffer.attTarList = endureDirection[1];
            resultBuffer.effectBuffer = effectBuffer;
        }
    };
    //写效用数据
    BattleSkill.prototype.writeSkillAttack = function (userInfo, attackObject, byAttackObject, fightModule) {
        var resultBuffer;
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
    };
    return BattleSkill;
}());
__reflect(BattleSkill.prototype, "BattleSkill");
//# sourceMappingURL=BattleSkill.js.map