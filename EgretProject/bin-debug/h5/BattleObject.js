var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var BattleObject = (function () {
    function BattleObject() {
        //生命加成百分比
        this.powerAdditionalPercent = 0;
        //攻击加成百分比
        this.courageAdditionalPercent = 0;
        //物理防御加成百分比
        this.intellectAdditionalPercent = 0;
        //法防加成百分比
        this.nimableAdditionalPercent = 0;
        //暴击加成百分比
        this.criticalAdditionalPercent = 0;
        //抗暴加成百分比
        this.criticalResistAdditionalPercent = 0;
        //闪避加成百分比
        this.evasionAdditionalPercent = 0;
        //命中加成百分比
        this.accuracyAdditionalPercent = 0;
        //挡格加成百分比
        this.retainAdditionalPercent = 0;
        //破击加成百分比
        this.retainBreakAdditionalPercent = 0;
        //物理免伤加成百分比
        this.physicalLessenDamagePercent = 0;
        //法术免伤加成百分比
        this.skillLessenDamagePercent = 0;
        //38.每次出手增加的怒气
        this.everyAttackAddSp = 0;
        //39.灼烧伤害% 
        this.firingDamagePercent = 0;
        //40.吸血率%
        this.inhaleHpDamagePercent = 0;
        //41.怒气
        this.addSpValue = 0;
        //42.反弹%  
        this.reboundDamageValue = 0;
        //43.暴伤加成%	   
        this.uniqueSkillDamagePercent = 0;
        //44.免控率%  
        this.avoidControlPercent = 0;
        //45.小技能触发概率%  
        this.normatinSkillTriggerPercent = 0;
        //46.格挡强度% 
        this.uniqueSkillResistancePercent = 0;
        //47.控制率%
        this.controlPercent = 0;
        //48.治疗效果% 
        this.cureEffectPercent = 0;
        //49.暴击强化% 
        this.criticalAdditionPercent = 0;
        //50.数码兽类型克制伤害%   (可为负数)
        this.heroRestrainDamagePercent = 0;
        //51.溅射伤害%
        this.sputteringAttackAddDamagePercent = 0;
        //52.技能伤害%
        this.skillAttackAddDamagePercent = 0;
        //53.被治疗减少%
        this.byCureLessenPercent = 0;
        //54.伤害提升%（数码大冒险中的说法：伤害提升、额外造成伤害、额外增加伤害、伤害翻倍都属于这类）
        this.ptvf54 = 0;
        //55.必杀伤害率%
        this.ptvf55 = 0;
        //56.增加必杀伤害%
        this.ptvf56 = 0;
        //57.减少必杀伤害%（数码大冒险中的说法：增加必杀伤害、必杀伤害抗性都属于这类）
        this.ptvf57 = 0;
        //58.增加暴击伤害%
        this.ptvf58 = 0;
        //59.减少暴击伤害%
        this.ptvf59 = 0;
        //60.受到的必杀伤害增加%
        this.ptvf60 = 0;
        //61.怒气回复速度%
        this.ptvf61 = 0;
        //62.受到伤害降低%
        this.ptvf62 = 0;
        //63.降低攻击(%)	
        this.ptvf63 = 0;
        //64.降低防御
        this.ptvf64 = 0;
        //65降低必杀伤害率%	
        this.ptvf65 = 0;
        //66降低必杀伤害率%
        this.ptvf66 = 0;
        //67降低伤害减免%
        this.ptvf67 = 0;
        //68降低防御（%）
        this.ptvf68 = 0;
        //69降低怒气回复速度
        this.ptvf69 = 0;
        //70数码兽类型克制伤害加成%	
        this.ptvf70 = 0;
        //71数码兽类型克制伤害减免%	
        this.ptvf71 = 0;
        //72.降低攻击
        this.ptvf72 = 0;
        //73.增加必杀抗性%
        this.ptvf73 = 0;
        //74.减少必杀抗性%
        this.ptvf74 = 0;
        //75降低免控率%
        this.ptvf75 = 0;
        //76复活概率%
        this.ptvf76 = 0;
        //77被复活概率%
        this.ptvf77 = 0;
        //78复活继承血量%    
        this.ptvf78 = 0;
        //79复活继承怒气%    
        this.ptvf79 = 0;
        //80被复活继承血量%   
        this.ptvf80 = 0;
        //81被复活继承怒气%   
        this.ptvf81 = 0;
        //82增加复活概率%   
        this.ptvf82 = 0;
        //83增加复活继承血量% 
        this.ptvf83 = 0;
        //84小技能伤害提升% 
        this.ptvf84 = 0;
        this.battleTag = 0;
        this.coordinate = 0;
        this.healthPoint = 0;
        this.healthMaxPoint = 0;
        this.skillPoint = 0;
        //数码兽id
        this.shipMould = 0;
        this.capacity = 0;
    }
    BattleObject.prototype.initWithAttackObject = function (fightObj) {
        this.resetSkillAndTalentInfo();
        this.initProperty(fightObj);
        this.initSkillAndTalentInfo();
    };
    BattleObject.prototype.resetSkillAndTalentInfo = function () {
    };
    BattleObject.prototype.initProperty = function (fightObj) {
        this.shipMould = fightObj.shipMould;
        this.capacity = fightObj.capacity;
    };
    BattleObject.prototype.initSkillAndTalentInfo = function () {
    };
    BattleObject.prototype.nextBattleInfo = function () {
    };
    return BattleObject;
}());
__reflect(BattleObject.prototype, "BattleObject");
//# sourceMappingURL=BattleObject.js.map