var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightRoleController = (function () {
    function FightRoleController() {
        this.byAttackTargetTag = 0;
    }
    FightRoleController.prototype.getFightData = function (fightRole, grade) {
        var attData = {};
        var resultBuffer = {};
        //我方
        if (fightRole) {
            var attackObj = ED.data.fightModule.getAppointFightObject(0, fightRole._info._pos);
            if (attackObj == null) {
                return null;
            }
            ED.data.fightModule.setByAttackTargetTag(this.byAttackTargetTag);
            ED.data.fightModule.fightObjectAttack(attackObj, resultBuffer);
            var jsonStr = JSON.stringify(resultBuffer);
            ED.parse_environment_fight_role_round_attack_data(jsonStr, attData);
        }
        else {
        }
    };
    //进入下一场战斗
    FightRoleController.prototype.nextBattle = function () {
    };
    FightRoleController.prototype.initHero = function () {
    };
    FightRoleController.prototype.initMaster = function () {
    };
    return FightRoleController;
}());
__reflect(FightRoleController.prototype, "FightRoleController");
//# sourceMappingURL=FightRoleController.js.map