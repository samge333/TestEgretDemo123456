var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var Display = (function () {
    function Display() {
    }
    Display.newDragonByNumber = function (imgId, armatureName, scale) {
        if (armatureName === void 0) { armatureName = "armatureName"; }
        if (scale === void 0) { scale = 1; }
        if (imgId == null) {
            return null;
        }
        var skeFile = "spirte_" + imgId + "_ske_json";
        var texFile = "spirte_" + imgId + "_tex_json";
        var texPng = "spirte_" + imgId + "_tex_png";
        return Display.newDragon(skeFile, texFile, texPng, armatureName, scale);
    };
    //返回一个骨架显示对象
    Display.newDragon = function (skeFile, texFile, texPng, armatureName, scale) {
        if (armatureName === void 0) { armatureName = "armatureName"; }
        if (scale === void 0) { scale = 1; }
        if (skeFile == null || texFile == null || texPng == null) {
            return null;
        }
        var dbData = RES.getRes(skeFile);
        var textureData = RES.getRes(texFile);
        var texture = RES.getRes(texPng);
        var egretFactory = new dragonBones.EgretFactory();
        egretFactory.parseDragonBonesData(dbData);
        egretFactory.parseTextureAtlasData(textureData, texture);
        var armatureDisplay = egretFactory.buildArmatureDisplay(armatureName);
        armatureDisplay.scaleX = scale;
        armatureDisplay.scaleY = scale;
        return armatureDisplay;
    };
    Display.initArmature = function (dragonNode, index) {
        dragonNode.playWithIndex = function () {
            // (dragonNode as dragonBones.EgretArmatureDisplay).animation.animationNames;
        };
    };
    return Display;
}());
__reflect(Display.prototype, "Display");
//# sourceMappingURL=Display.js.map