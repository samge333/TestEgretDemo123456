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
var FightRole = (function (_super) {
    __extends(FightRole, _super);
    function FightRole() {
        var _this = _super.call(this) || this;
        _this._info = {};
        _this._roleCamp = 0;
        _this.dragonNode = null;
        //父节点
        _this.parentNode = null;
        //攻击时的位移坐标
        _this.moveByPosition = { x: 0, y: 0 };
        //角色受到的技能效用列表
        _this.fight_cacher_pool = [];
        //是否开启监听并处理自己受到的效用影响
        _this.run_fight_listener = false;
        //当前正在处理的效用影响
        _this.current_fight_data = {};
        _this.eventListen();
        return _this;
    }
    FightRole.prototype.eventListen = function () {
        this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
        this.addEventListener(egret.Event.ENTER_FRAME, this.update, this);
    };
    FightRole.prototype.onCreationComplete = function () {
        HLog.log("FightRole创建成功");
    };
    FightRole.prototype.update = function () {
    };
    FightRole.prototype.init = function (data, roleCamp, parentNode, roleCtrl) {
        HLog.log("创建角色" + roleCamp, data);
        this._info = data;
        this._roleCamp = roleCamp;
        this.parentNode = parentNode;
        this.roleCtrl = roleCtrl;
        this.width = parentNode.width;
        this.height = parentNode.height;
        //测试数据
        var imgId = 105201;
        if (this._roleCamp == 1) {
            imgId = 106601;
        }
        this.dragonNode = Display.newDragonById(imgId);
        if (this._roleCamp == 0) {
            this.dragonNode.scaleX = -1;
        }
        Display.initArmature(this.dragonNode, Display.DragonAnimationNames, this);
        this.dragonNode.mydata._startCallback = this.onChangeActionCallback;
        // this.dragonNode.mydata.fightRole = this;
        this.dragonNode.x = this.width / 2;
        this.dragonNode.y = this.height;
        this.addChild(this.dragonNode);
    };
    //监听攻击
    FightRole.prototype.attackListener = function () {
        if (this.run_fight_listener == true) {
            if (this.fight_cacher_pool.length == 0) {
                this.run_fight_listener = false;
            }
            else {
                this.current_fight_data = this.fight_cacher_pool[0];
                //如果当前fightRole发起攻击
                if (this.current_fight_data._state == 0) {
                    this.executeAttackLogic();
                }
            }
        }
    };
    //执行攻击逻辑
    FightRole.prototype.executeAttackLogic = function () {
        var skfId = this.current_fight_data._skf.skillInfluenceId;
        var skfData = ConfigDB.loadConfig("skill_influence_txt", skfId);
        this.dragonNode.mydata.skfData = skfData;
        this.executeAttackLogicing();
    };
    FightRole.prototype.executeAttackLogicing = function () {
        this.executeHeroMoveToTarget();
    };
    //移动攻击目标
    FightRole.prototype.executeHeroMoveToTarget = function () {
        if (this.getAttackMovePosition() == true) {
            this.changeActtackToAttackMoving();
        }
        else {
            this.changeActtackToAttackBegan();
        }
    };
    //获取这次攻击的移动位置
    FightRole.prototype.getAttackMovePosition = function () {
        if (this._roleCamp == 0) {
            this.moveByPosition.x = 200;
        }
        else {
            this.moveByPosition.x = -200;
        }
        return true;
    };
    //攻击时，向对方移动
    FightRole.prototype.changeActtackToAttackMoving = function () {
        //切换到前冲动作
        var actionIndex = DRAGON_ANIMAE_INDEX.animation_onrush;
        Display.animationChangeToAction(this.dragonNode, actionIndex, actionIndex);
        //开始位移
        var posx = this.parent.x + this.moveByPosition.x;
        egret.Tween.get(this.parent).to({ x: posx }, 1000).call(function () {
            this.changeActtackToAttackBegan();
        }, this);
    };
    //攻击时，出手
    FightRole.prototype.changeActtackToAttackBegan = function () {
        var actionIndex = DRAGON_ANIMAE_INDEX.animation_skill_attacking;
        Display.animationChangeToAction(this.dragonNode, actionIndex, actionIndex);
    };
    //骨骼动画开始的回调
    FightRole.prototype.onChangeActionCallback = function (thisObj, dragonNode, name) {
        // HLog.log("FightRole 开始执行动作 " +  thisObj._roleCamp + "," +  thisObj._info._pos, name);
        //普通攻击
        if (name == Display.DragonAnimationNames[DRAGON_ANIMAE_INDEX.animation_skill_attacking]) {
            dragonNode.mydata._nextAction = DRAGON_ANIMAE_INDEX.animation_standby;
            thisObj.executeAttacking();
        }
    };
    //显示攻击光效
    FightRole.prototype.executeAttacking = function () {
        this.executeAttackInfluence();
    };
    //显示攻击光效1
    FightRole.prototype.executeAttackInfluence = function () {
        this.executeEffectSkilling1();
    };
    //显示攻击光效2
    FightRole.prototype.executeEffectSkilling1 = function () {
        var effectId = this.dragonNode.mydata.skfData.posteriorLightingEffectId;
        if (effectId >= 0) {
            var attackEffect = this.createEffect(effectId);
            attackEffect.x = this.x;
            attackEffect.y = this.y;
            this.parent.addChild(attackEffect);
        }
    };
    //创建打击光效
    FightRole.prototype.createEffect = function (effectId) {
        var effectNode = Display.newEffectById(effectId);
        Display.initArmature(effectNode, Display.effectAnimations, this);
        effectNode.mydata.loopTimes = 1;
        effectNode.mydata._completeCallback = this.onEffectAnimCompleteCallback;
        effectNode.mydata._eventCallback = this.onEffectAnimEventCallback;
        // effectNode.mydata.fightRole = this;
        effectNode.mydata.playWithIndex(0);
        return effectNode;
    };
    //检查攻击光效事件字符串是否包含指定事件名
    FightRole.prototype.checkFrameEvent = function (arr, event) {
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] == event) {
                return true;
            }
        }
        return false;
    };
    // 攻击光效播完回调 executeEffectSkilling1Over->executeEffectSkillingOverEx
    FightRole.prototype.onEffectAnimCompleteCallback = function (thisObj, dragonNode, name) {
        thisObj.checkAttackEnd();
    };
    //攻击光效事件回调
    FightRole.prototype.onEffectAnimEventCallback = function (thisObj, dragonNode, event) {
        if (event.eventObject.data && event.eventObject.data.strings && event.eventObject.data.strings.length) {
            // HLog.log("onEffectAnimEventCallback: ", event.eventObject.data.strings[0]);
            var strings = event.eventObject.data.strings[0].split("_");
            if (thisObj.checkFrameEvent(strings, "hurt") == true) {
            }
            var defenderList = thisObj.current_fight_data._defenderList;
            var skf = thisObj.current_fight_data._skf;
            for (var i = 0; i < skf._defenders.length; i++) {
                var def = skf._defenders[i];
                //找到受效用影响的fightRole
                var fightRole = (defenderList[def.defender + "t" + def.defenderPos]);
                //承受到的影响
                fightRole.current_fight_data._def = def;
                fightRole.executeByAttackLogic(strings, thisObj);
            }
            if (thisObj.checkFrameEvent(strings, "after") == true) {
            }
            if (thisObj.checkFrameEvent(strings, "next") == true) {
                // //切换到本阵营的下一个角色发起攻击，或者检查回合是否完了，如果回合完了，就轮到对方发起攻击
                // thisObj.roleCtrl.changeToNextAttackRole();
                // thisObj.roleCtrl.checkNextRoundFight();
            }
        }
    };
    //攻击光效播完
    FightRole.prototype.executeEffectSkillingOverEx = function () {
    };
    //检查攻击结束
    FightRole.prototype.checkAttackEnd = function () {
        //删除第一个元素
        this.fight_cacher_pool.splice(0, 1);
        this.moveEventEx();
        if (this._roleCamp == 0) {
            this.roleCtrl.executeCurrentRountFightData();
        }
        else {
            this.roleCtrl.checkNextRoundFight();
        }
    };
    //执行被攻击的逻辑
    FightRole.prototype.executeByAttackLogic = function (eventStrings, attacker) {
        if (this.checkFrameEvent(eventStrings, "after") == true) {
            if (this.dragonNode.mydata._actionIndex != DRAGON_ANIMAE_INDEX.animation_normal_be_attaked) {
                if (attacker != null && attacker._roleCamp != this._roleCamp) {
                    var actionIndex = DRAGON_ANIMAE_INDEX.animation_normal_be_attaked;
                    var nextAction = DRAGON_ANIMAE_INDEX.animation_standby;
                    Display.animationChangeToAction(this.dragonNode, actionIndex, nextAction);
                }
            }
        }
        if (this.checkFrameEvent(eventStrings, "next") == true) {
        }
    };
    //角色回位
    FightRole.prototype.moveEventEx = function () {
        var offsetX = this.parentNode.x - this.parentNode.initX;
        var offsetY = this.parentNode.y - this.parentNode.initY;
        //角色不在初始位置
        if (offsetX != 0 || offsetY != 0) {
            egret.Tween.get(this.parent).to({ x: this.parentNode.initX }, 500).call(function () {
            }, this);
        }
    };
    return FightRole;
}(eui.Component));
__reflect(FightRole.prototype, "FightRole");
//# sourceMappingURL=FightRole.js.map