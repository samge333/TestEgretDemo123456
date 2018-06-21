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
    FightRole.prototype.init = function (data, roleCamp, parentNode) {
        HLog.log("创建角色" + roleCamp, data);
        this._info = data;
        this._roleCamp = roleCamp;
        this.parentNode = parentNode;
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
        // HLog.log(this.dragonNode.anchorOffsetX);
        // HLog.log(this.dragonNode.anchorOffsetY);
        // HLog.log(this.anchorOffsetX);
        // HLog.log(this.anchorOffsetY);
        Display.initArmature(this.dragonNode, this);
        // (this.dragonNode as any).mydata.setMovementEventCallFunc(Display.changeAction_animationEventCallFunc);
        this.dragonNode.mydata._invoke = this.changeActionCallback;
        this.dragonNode.x = this.width / 2;
        this.dragonNode.y = this.height;
        this.addChild(this.dragonNode);
    };
    //监听攻击
    FightRole.prototype.attackListener = function () {
        this.executeAttackLogic();
    };
    //执行攻击逻辑
    FightRole.prototype.executeAttackLogic = function () {
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
        this.moveByPosition.x = 200;
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
    //动作开始的回调
    FightRole.prototype.changeActionCallback = function (thisObj, dragonNode, name) {
        HLog.log("FightRole 开始执行动作 " + thisObj._roleCamp + "," + thisObj._info._pos, name);
        //普通攻击
        if (name == Display.DragonAnimationNames[DRAGON_ANIMAE_INDEX.animation_skill_attacking]) {
            dragonNode.mydata._nextAction = DRAGON_ANIMAE_INDEX.animation_standby;
        }
    };
    return FightRole;
}(eui.Component));
__reflect(FightRole.prototype, "FightRole");
//# sourceMappingURL=FightRole.js.map