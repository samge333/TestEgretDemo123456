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
        return _super.call(this) || this;
        // this.addEventListener(eui.UIEvent.COMPLETE, this.uiCompHandler, this);
        // this.skinName = "test.exml";
    }
    TestScene.prototype.uiCompHandler = function () {
        // HLog.log("uiCompHandler111222");
    };
    return TestScene;
}(eui.Component));
__reflect(TestScene.prototype, "TestScene");
//# sourceMappingURL=TestScene.js.map