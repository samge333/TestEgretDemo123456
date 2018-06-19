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
        var dbData = RES.getRes("spirte_105201_ske_json");
        var textureData = RES.getRes("spirte_105201_tex_json");
        var texture = RES.getRes("spirte_105201_tex_png");
        var egretFactoryA = new dragonBones.EgretFactory();
        egretFactoryA.parseDragonBonesData(dbData);
        egretFactoryA.parseTextureAtlasData(textureData, texture);
        var armatureDisplay = egretFactoryA.buildArmatureDisplay("armatureName");
        armatureDisplay.scaleX = -1;
        this.addChild(armatureDisplay);
        armatureDisplay.x = this.width / 2 - 300;
        armatureDisplay.y = this.height / 2;
        armatureDisplay.animation.play("13_jueji", 0);
    };
    TestScene.prototype.initMaster = function () {
        var dbData = RES.getRes("spirte_106601_ske_json");
        var textureData = RES.getRes("spirte_106601_tex_json");
        var texture = RES.getRes("spirte_106601_tex_png");
        var egretFactoryB = new dragonBones.EgretFactory();
        egretFactoryB.parseDragonBonesData(dbData);
        egretFactoryB.parseTextureAtlasData(textureData, texture);
        var armatureDisplay = egretFactoryB.buildArmatureDisplay("armatureName");
        this.addChild(armatureDisplay);
        armatureDisplay.x = this.width / 2 + 300;
        armatureDisplay.y = this.height / 2;
        armatureDisplay.animation.play("01_qianchong", 0);
    };
    return TestScene;
}(eui.Component));
__reflect(TestScene.prototype, "TestScene");
//# sourceMappingURL=TestScene.js.map