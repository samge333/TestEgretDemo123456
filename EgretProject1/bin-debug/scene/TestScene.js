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
var TestScene = (function (_super) {
    __extends(TestScene, _super);
    function TestScene() {
        var _this = _super.call(this) || this;
        _this.skinName = "resource/exml/test.exml";
        _this.initHero();
        _this.initMaster();
        return _this;
    }
    TestScene.prototype.initHero = function () {
        var armatureDisplay = Display.newDragonByNumber(105201);
        this.addChild(armatureDisplay);
        armatureDisplay.x = this.width / 2 - 300;
        armatureDisplay.y = this.height / 2;
        armatureDisplay.animation.play("13_jueji");
        var sa = armatureDisplay.animation.animationNames;
        armatureDisplay.addEventListener(dragonBones.EventObject.COMPLETE, this.animationEventHandler, this);
        armatureDisplay.addEventListener(dragonBones.EventObject.FRAME_EVENT, this.animationEventHandler, this);
    };
    TestScene.prototype.animationEventHandler = function (event) {
        var eventObject = event.eventObject;
        console.log("animationEventHandler112233");
        console.log(eventObject.animationState.name, event.type, eventObject.name ? eventObject.name : "");
    };
    TestScene.prototype.initMaster = function () {
        var armatureDisplay = Display.newDragonByNumber(106601);
        this.addChild(armatureDisplay);
        armatureDisplay.x = this.width / 2 + 300;
        armatureDisplay.y = this.height / 2;
        armatureDisplay.animation.play("01_qianchong");
    };
    return TestScene;
}(eui.Component));
__reflect(TestScene.prototype, "TestScene");
//# sourceMappingURL=TestScene.js.map