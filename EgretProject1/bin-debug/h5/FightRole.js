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
        _this.addEventListener(eui.UIEvent.CREATION_COMPLETE, _this.onCreationComplete, _this);
        return _this;
    }
    FightRole.prototype.onCreationComplete = function () {
        HLog.log("FightRole创建成功");
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
        HLog.log(this.dragonNode.anchorOffsetX);
        HLog.log(this.dragonNode.anchorOffsetY);
        HLog.log(this.anchorOffsetX);
        HLog.log(this.anchorOffsetY);
        Display.initArmature(this.dragonNode);
        this.dragonNode.mydata.setMovementEventCallFunc(Display.changeAction_animationEventCallFunc);
        this.dragonNode.x = this.width / 2;
        this.dragonNode.y = this.height;
        this.addChild(this.dragonNode);
    };
    return FightRole;
}(eui.Component));
__reflect(FightRole.prototype, "FightRole");
//# sourceMappingURL=FightRole.js.map