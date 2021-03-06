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
        _this._hero_formation_arr = [];
        //我方带位置表
        _this._hero_formation_pos = {};
        //敌方角色列表
        _this._master_formation_arr = [];
        //敌方带位置表
        _this._master_formation_pos = {};
        //第几波
        _this.fightIndex = 0;
        //敌方的攻击列表，依次发起攻击
        _this.attack_list = [];
        //位置节点列表
        _this.hero_slots = {};
        _this.master_slots = {};
        //exml
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
        _this.eventListen();
        _this.init();
        return _this;
    }
    FightRoleController.prototype.onCreationComplete = function () {
        this.width = this.parent.width;
        this.height = this.parent.height;
    };
    FightRoleController.prototype.eventListen = function () {
        this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
        // HEvent.listener(EvtName.RoleCtrlNextAttackRole, this.onRoleCtrlNextAttackRole);
    };
    FightRoleController.prototype.init = function () {
        //获取位置节点
        var posHero = [this.pos01, this.pos02, this.pos03, this.pos04, this.pos05, this.pos06];
        var posMaster = [this.pos11, this.pos12, this.pos13, this.pos14, this.pos15, this.pos16];
        for (var i = 0; i < 6; i++) {
            var rect = posHero[i];
            if (rect) {
                rect.initX = rect.x;
                rect.initY = rect.y;
                this.hero_slots[i + 1] = rect;
            }
        }
        for (var i = 0; i < 6; i++) {
            var rect = posMaster[i];
            if (rect) {
                rect.initX = rect.x;
                rect.initY = rect.y;
                this.master_slots[i + 1] = rect;
            }
        }
    };
    FightRoleController.prototype.qteAddAttackRole = function (selectRole) {
        var data = this.getFightData(selectRole, 1);
        if (data) {
            this.executeCurrentSelectRoleFightData(data);
        }
    };
    //执行指定对象战斗数据attData，然后给到指定的角色fightRole的fight_cacher_pool
    FightRoleController.prototype.executeCurrentSelectRoleFightData = function (data) {
        // let fightRole: FightRole = null;
        // if (data.attacker == 0) {
        // 	fightRole = this._hero_formation_pos[data.attackerPos];
        // } else {
        // 	fightRole = this._hero_formation_pos[data.attackerPos];
        // }
        // fightRole.attackListener();
        //将战斗数据中的 技能效用数据 给到fightRole
        for (var i = 0; i < data.skillInfluences.length; i++) {
            //获取第i个技能效用
            var skf = data.skillInfluences[i];
            //获取出手的fightRole
            var attackRole = null;
            if (skf.attackerType == 0) {
                attackRole = this._hero_formation_pos[skf.attackerPos];
            }
            else {
                attackRole = this._master_formation_pos[skf.attackerPos];
            }
            //受到效用影响的的fightRole
            var defenderList = {};
            for (var j = 0; j < skf._defenders.length; j++) {
                var _def = skf._defenders[j];
                //获取受影响的fightRole
                var defendRole = null;
                if (_def.defender == 0) {
                    defendRole = this._hero_formation_pos[_def.defenderPos];
                }
                else {
                    defendRole = this._master_formation_pos[_def.defenderPos];
                }
                defenderList[_def.defender + "t" + _def.defenderPos] = defendRole;
            }
            if (skf._defenders.length > 0) {
                //打开开关，fightRole会自行处理自己接收到的效用数据
                attackRole.run_fight_listener = true;
                attackRole.fight_cacher_pool.push({
                    _state: 0,
                    _attData: data,
                    _skf: skf,
                    _defenderList: defenderList //承受技能的fightRole列表
                });
                attackRole.attackListener();
            }
        }
    };
    FightRoleController.prototype.getFightData = function (fightRole, grade) {
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
            ED.parse_environment_fight_role_round_attack_data(jsonStr);
        }
        else {
            ED.data.fightModule.rountdFight(resultBuffer);
        }
        return resultBuffer;
    };
    //进入下一场战斗
    FightRoleController.prototype.nextBattle = function () {
        HLog.log("进入下一场");
        this.initHero();
        this.initMaster();
        this.moveToScene();
        // this.changeToNextAttackRole();
    };
    //生成我方FightRole
    FightRoleController.prototype.initHero = function () {
        for (var k in this.hero_slots) {
            var v = this.hero_slots[k];
            var heroData = ED.data.battleData._heros[k];
            if (heroData) {
                var role = new FightRole;
                role.init(heroData, 0, v, this);
                v.addChild(role);
                this._hero_formation_arr.push(role);
                this._hero_formation_pos[k] = role;
            }
        }
    };
    //生成敌方FightRole
    FightRoleController.prototype.initMaster = function () {
        for (var k in this.master_slots) {
            var v = this.master_slots[k];
            var masterData = ED.data.battleData._armys[this.fightIndex]._data[k];
            if (masterData) {
                var role = new FightRole;
                role.init(masterData, 1, v, this);
                v.addChild(role);
                this._master_formation_arr.push(role);
                this._master_formation_pos[k] = role;
            }
        }
    };
    //入场
    FightRoleController.prototype.moveToScene = function () {
        var offsetInfo = [
            [200, 200, 0, 0, 0, 0],
            [300, 300, 0, 0, 0, 0],
        ];
        var _loop_1 = function (i) {
            var role = this_1._hero_formation_arr[i];
            if (role) {
                var offsetX = offsetInfo[0][role._info._pos - 1];
                role.x = 0 - offsetX;
                var actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
                Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                egret.Tween.get(role).to({ x: 0 }, 1500).call(function () {
                    var actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
                    Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                    this.nextRoundFight();
                }, this_1);
            }
        };
        var this_1 = this;
        for (var i = 0; i < this._hero_formation_arr.length; i++) {
            _loop_1(i);
        }
        var _loop_2 = function (i) {
            var role = this_2._master_formation_arr[i];
            if (role) {
                var offsetX = offsetInfo[1][role._info._pos - 1];
                role.x = 0 + offsetX;
                var actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
                Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                egret.Tween.get(role).to({ x: 0 }, 1500).call(function () {
                    var actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
                    Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
                }, this_2);
            }
        };
        var this_2 = this;
        for (var i = 0; i < this._master_formation_arr.length; i++) {
            _loop_2(i);
        }
    };
    //开始一下回合战斗，我方打完，敌方打完，算一个回合，下一回合我方出手
    FightRoleController.prototype.nextRoundFight = function () {
        // HEvent.dispatch(EvtName.QteCtrlNextAttackRole);
        //自动战斗的情况下
        var role = this._hero_formation_arr[0];
        this.qteAddAttackRole(role);
    };
    // public onRoleCtrlNextAttackRole(param) {
    // 	this.qteAddAttackRole();
    // }
    //获取敌方所有人的攻击数据，然后生成攻击fightRole列表，赋值给fightRole去处理
    FightRoleController.prototype.executeCurrentRountFightData = function () {
        var roundData = this.getFightData(null, 0);
        HLog.log("获取敌方所有的攻击数据", roundData);
        //循环敌方所有人，生成fightRole列表
        for (var i = 0; i < roundData.data.length; i++) {
            var attData = roundData.data[i];
            var fightRole = void 0;
            if (attData.attacker == 0) {
                fightRole = this._hero_formation_pos[attData.attackerPos];
            }
            else {
                fightRole = this._master_formation_pos[attData.attackerPos];
            }
            //给没个角色他当前的攻击数据
            fightRole.attData = attData;
            this.attack_list.push(fightRole);
        }
        this.changeToNextAttackRole();
    };
    //切换到本阵营的下一个攻击角色，本阵营
    FightRoleController.prototype.changeToNextAttackRole = function () {
        // let role = this._hero_formation_arr[0];
        // this.qteAddAttackRole(role);
        var currentRole = this.attack_list[0];
        if (currentRole != null) {
            this.executeCurrentSelectRoleFightData(currentRole.attData);
        }
    };
    //检查是否可以开始下一回合战斗
    FightRoleController.prototype.checkNextRoundFight = function () {
        var heroAttackOver = true;
        var masterAttackOver = true;
        for (var i = 0; i < this._hero_formation_arr.length; i++) {
            var hero = this._hero_formation_arr[i];
            if (hero && hero.fight_cacher_pool.length > 0) {
                heroAttackOver = false;
            }
        }
        for (var i = 0; i < this._master_formation_arr.length; i++) {
            var master = this._master_formation_arr[i];
            if (master && master.fight_cacher_pool.length > 0) {
                masterAttackOver = false;
            }
        }
        // if (this.attack_list.length > 0) {
        // 	masterAttackOver = false;
        // }
        if (heroAttackOver == true && masterAttackOver == true) {
            this.nextRoundFight();
        }
    };
    return FightRoleController;
}(eui.Component));
__reflect(FightRoleController.prototype, "FightRoleController");
//# sourceMappingURL=FightRoleController.js.map