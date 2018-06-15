var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightRoleController = (function () {
    function FightRoleController() {
        this.byAttackTargetTag = 1;
        //我方角色列表
        this._hero_formation_ex = [];
        //地方角色列表
        this._master_formation_ex = [];
        //第几波
        this.fightIndex = 0;
    }
    FightRoleController.prototype.changeToNextAttackRole = function () {
        var role = this._hero_formation_ex[0];
        this.qteAddAttackRole(role);
    };
    FightRoleController.prototype.qteAddAttackRole = function (selectRole) {
        var data = this.getFightData(selectRole, 1);
    };
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
            HLog.log("获取这个BattleObject的攻击数据", resultBuffer);
            var jsonStr = JSON.stringify(resultBuffer);
            ED.parse_environment_fight_role_round_attack_data(jsonStr, attData);
        }
        else {
        }
    };
    //进入下一场战斗
    FightRoleController.prototype.nextBattle = function () {
        this.initHero();
        this.initMaster();
        this.changeToNextAttackRole();
    };
    FightRoleController.prototype.initHero = function () {
        for (var i = 0; i < 6; i++) {
            var heroData = ED.data.battleData._heros[i + 1];
            if (heroData) {
                var role = new FightRole;
                role.init(heroData, 0);
                this._hero_formation_ex.push(role);
            }
        }
    };
    FightRoleController.prototype.initMaster = function () {
        for (var i = 0; i < 6; i++) {
            var masterData = ED.data.battleData._armys[this.fightIndex]._data[i + 1];
            if (masterData) {
                var role = new FightRole;
                role.init(masterData, 1);
                this._master_formation_ex.push(role);
            }
        }
    };
    return FightRoleController;
}());
__reflect(FightRoleController.prototype, "FightRoleController");
//# sourceMappingURL=FightRoleController.js.map