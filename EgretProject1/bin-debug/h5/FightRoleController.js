var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var __extends = this && this.__extends || function __extends(t, e) { 
 function r() { 
 this.constructor = t;
}
for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i]);
r.prototype = e.prototype, t.prototype = new r();
};
var FightRoleController = (function (_super) {
    __extends(FightRoleController, _super);
    function FightRoleController() {
        var _this = _super.call(this) || this;
        _this.byAttackTargetTag = 1;
        //我方角色列表
        _this._hero_formation_ex = [];
        //地方角色列表
        _this._master_formation_ex = [];
        //第几波
        _this.fightIndex = 0;
        //位置节点列表
        _this.hero_slots = {};
        _this.master_slots = {};
        //eui
        _this.pos01 = null;
        _this.pos02 = null;
        _this.pos03 = null;
        _this.pos04 = null;
        _this.pos05 = null;
        _this.pos06 = null;
        _this.pos11 = null;
        _this.pos12 = null;
        _this.pos13 = null;
        _this.pos14 = null;
        _this.pos15 = null;
        _this.pos16 = null;
        _this.skinName = "resource/exml/test1.exml";
        _this.addEventListener(eui.UIEvent.CREATION_COMPLETE, _this.onCreationComplete, _this);
        _this.init();
        return _this;
    }
    FightRoleController.prototype.onCreationComplete = function () {
        this.width = this.parent.width;
        this.height = this.parent.height;
    };
    FightRoleController.prototype.init = function () {
        //获取位置节点
        var posHero = [this.pos01, this.pos02, this.pos03, this.pos04, this.pos05, this.pos06];
        var posMaster = [this.pos11, this.pos12, this.pos13, this.pos14, this.pos15, this.pos16];
        for (var i = 0; i < 6; i++) {
            var rect = posHero[i];
            if (rect) {
                this.hero_slots[i + 1] = rect;
            }
        }
        for (var i = 0; i < 6; i++) {
            var rect = posMaster[i];
            if (rect) {
                this.master_slots[i + 1] = rect;
            }
        }
    };
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
        HLog.log("进入下一场");
        HLog.log(this.width);
        HLog.log(this.height);
        this.initHero();
        this.initMaster();
        this.moveToScene();
        this.changeToNextAttackRole();
    };
    FightRoleController.prototype.initHero = function () {
        for (var k in this.hero_slots) {
            var v = this.hero_slots[k];
            var heroData = ED.data.battleData._heros[k];
            if (heroData) {
                var role = new FightRole;
                role.init(heroData, 0, v);
                v.addChild(role);
                this._hero_formation_ex.push(role);
            }
        }
    };
    FightRoleController.prototype.initMaster = function () {
        for (var k in this.master_slots) {
            var v = this.master_slots[k];
            var masterData = ED.data.battleData._armys[this.fightIndex]._data[k];
            if (masterData) {
                var role = new FightRole;
                role.init(masterData, 1, v);
                v.addChild(role);
                this._master_formation_ex.push(role);
            }
        }
    };
    //走进场景
    FightRoleController.prototype.moveToScene = function () {
        var offsetInfo = [
            [0, 200, 0, 0, 0, 0],
            [0, 300, 0, 0, 0, 0],
        ];
        var _loop_1 = function (i) {
            var role = this_1._hero_formation_ex[i];
            if (role) {
                var offsetX = offsetInfo[0][role._info._pos - 1];
                role.x = 0 - offsetX;
                var actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
                Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                egret.Tween.get(role).to({ x: 0 }, 1500).call(function () {
                    var actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
                    Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                });
                ;
            }
        };
        var this_1 = this;
        for (var i = 0; i < this._hero_formation_ex.length; i++) {
            _loop_1(i);
        }
        var _loop_2 = function (i) {
            var role = this_2._master_formation_ex[i];
            if (role) {
                var offsetX = offsetInfo[1][role._info._pos - 1];
                role.x = 0 + offsetX;
                var actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
                Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                egret.Tween.get(role).to({ x: 0 }, 1500).call(function () {
                    var actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
                    Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                });
                ;
            }
        };
        var this_2 = this;
        for (var i = 0; i < this._master_formation_ex.length; i++) {
            _loop_2(i);
        }
    };
    return FightRoleController;
}(eui.Component));
__reflect(FightRoleController.prototype, "FightRoleController");
//# sourceMappingURL=FightRoleController.js.map