var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
//用于处理技能效用的类，每个BattleObject包含普通技能，小技能，必杀技，每种技能又包含多种技能效用，一个BattleSkill对应一个技能效用，每一个技能效用可能有多个承受者的hp和sp受影响，比如自己加减怒，对方加怒，对方掉血
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
        //清除的BUFF类型
        this.clearBuffState = 0;
    }
    BattleSkill.prototype.processAttack = function (userInfo, byAttackCoordinates, attackObject, byAttackObjects, fightModule, resultBuffer) {
        var effectBuffer = [];
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
            else {
                this.effectType = SKILL_INFUENCE_RESULT.SKILL_INFLUENCE_ADDSP;
                var addSpValue = FightModule.ATTACK_SP_ADD_VAULE + attackObject.attackAdditionSpValue;
                this.effectValue = attackObject.addSkillPoint(addSpValue, true);
            }
            var buffer = this.writeSkillAttack(userInfo, attackObject, attackObject, fightModule);
            effectBuffer.push(buffer);
        }
        //承受方的效用承受情况，包含我方和地方
        for (var i = 0; i < byAttackCoordinates.length; i++) {
            var byAttackObject = byAttackObjects[byAttackCoordinates[i]];
            if (byAttackObject && byAttackObject.isDead == false && byAttackObject.revived == false) {
                //记录被击前的血量，后面会经过公式计算，血量会有变化
                var currentHp = byAttackObject.healthPoint;
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
                var effectArray = [];
                if (this.skillInfluence.skillCategory == SKILL_INFUENCE_RESULT.SKILL_INFUENCE_CLEAR_BUFF) {
                }
                else {
                    effectArray = FightUtil.computeSkillEffect(this, this.skillMould, this.skillInfluence, attackObject, byAttackObject, userInfo, fightModule);
                }
                this.effectValue = effectArray[1];
                this.effectRound = effectArray[2];
                this.clearBuffState = effectArray[4];
                if (effectArray[3] > 0) {
                    this.bearState = effectArray[3];
                }
                var dspValue = 0;
                if (byAttackObject.byAttackDamageAddSp == 1) {
                    dspValue = (currentHp - byAttackObject.healthPoint) / byAttackObject.healthMaxPoint * FightModule.MAX_SP;
                }
                //敌方加怒
                if (byAttackObject.skillPoint <= FightModule.MAX_SP) {
                    if (dspValue > 0) {
                        var bs = new BattleSkill;
                        bs.byAttackerTag = byAttackObject.battleTag;
                        bs.byAttackerCoordinate = byAttackObject.coordinate;
                        bs.effectType = SKILL_INFUENCE_RESULT.SKILL_INFLUENCE_ADDSP;
                        bs.effectValue = byAttackObject.addSkillPoint(dspValue, true);
                        var buffer = bs.writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule);
                        effectBuffer.push(buffer);
                    }
                }
                //敌方减血，没闪避
                if (effectArray[3] != 1) {
                    var buffer = this.writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule);
                    effectBuffer.push(buffer);
                }
            }
        }
        this.effectAmount = effectBuffer.length;
        if (this.effectAmount > 0) {
            resultBuffer.skillInfluenceId = this.skillInfluence.id;
            resultBuffer.influenceType = 0;
            resultBuffer.attackerType = attackObject.battleTag;
            resultBuffer.attackerPos = attackObject.coordinate;
            resultBuffer.defenderCount = this.effectAmount;
            var endureDirection = FightUtil.computeEndureDirection(attackObject.coordinate, this.skillInfluence, byAttackObjects);
            resultBuffer.attPosType = endureDirection[0];
            resultBuffer.attTarList = endureDirection[1];
            resultBuffer.effectBuffer = effectBuffer;
        }
    };
    //写效用数据
    BattleSkill.prototype.writeSkillAttack = function (userInfo, attackObject, byAttackObject, fightModule) {
        var resultBuffer = {};
        resultBuffer.defender = this.byAttackerTag;
        resultBuffer.defenderPos = this.byAttackerCoordinate;
        resultBuffer.restrainState = this.restrain;
        resultBuffer.defenderST = this.effectType;
        resultBuffer.stValue = this.effectValue;
        resultBuffer.stVisible = this.isDisplay;
        resultBuffer.stRound = this.effectRound;
        resultBuffer.defState = this.bearState;
        resultBuffer.defAState = this.aliveState;
        resultBuffer.aliveHP = byAttackObject.healthPoint;
        resultBuffer.aliveSP = byAttackObject.skillPoint;
        return resultBuffer;
    };
    return BattleSkill;
}());
__reflect(BattleSkill.prototype, "BattleSkill");
//# sourceMappingURL=BattleSkill.js.map