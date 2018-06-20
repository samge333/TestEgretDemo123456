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
var FightQTEController = (function (_super) {
    __extends(FightQTEController, _super);
    function FightQTEController() {
        var _this = _super.call(this) || this;
        _this.addEventListener(eui.UIEvent.CREATION_COMPLETE, _this.onCreationComplete, _this);
        _this.eventListen();
        return _this;
    }
    FightQTEController.prototype.onCreationComplete = function () {
        this.width = this.parent.width;
        this.height = this.parent.height;
    };
    FightQTEController.prototype.eventListen = function () {
        // HEvent.listener(EvtName.QteCtrlNextAttackRole, this.onQteCtrlNextAttackRole);
    };
    return FightQTEController;
}(eui.Component));
__reflect(FightQTEController.prototype, "FightQTEController");
//# sourceMappingURL=FightQTEController.js.map