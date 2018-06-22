var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var Display = (function () {
    function Display() {
    }
    //创建一个角色骨骼
    Display.newDragonById = function (imgId, armatureName, scale) {
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
    //创建一个光效骨骼
    Display.newEffectById = function (nameIndex, armatureName, scale) {
        if (armatureName === void 0) { armatureName = "armatureName"; }
        if (scale === void 0) { scale = 1; }
        if (nameIndex == null) {
            return null;
        }
        // effice_105211_tex_json
        var skeFile = "effice_" + nameIndex + "_ske_json";
        var texFile = "effice_" + nameIndex + "_tex_json";
        var texPng = "effice_" + nameIndex + "_tex_png";
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
    //为dragonNode增加功能
    Display.initArmature = function (dragonNode, animNameArr, thisObj) {
        dragonNode.mydata = {};
        dragonNode.mydata._actionIndex = 0;
        dragonNode.mydata._nextAction = 0;
        dragonNode.mydata.loopTimes = 0;
        //播放指定index的动作
        dragonNode.mydata.playWithIndex = function (actionIndex) {
            var animName = animNameArr[actionIndex];
            if (animName) {
                // HLog.log("执行动作", animName);
                dragonNode.animation.play(animName, dragonNode.mydata.loopTimes);
            }
        };
        //动作完成回调
        dragonNode.addEventListener(dragonBones.EventObject.LOOP_COMPLETE, function (event) {
            if (dragonNode.mydata._actionIndex != dragonNode.mydata._nextAction) {
                dragonNode.mydata._actionIndex = dragonNode.mydata._nextAction;
                dragonNode.mydata.playWithIndex(dragonNode.mydata._nextAction);
            }
            if (dragonNode.mydata._completeCallback) {
                dragonNode.mydata._completeCallback(thisObj, dragonNode, event.animationState.name);
            }
        }, this);
        //动作开始回调
        dragonNode.addEventListener(dragonBones.EventObject.START, function (event) {
            if (dragonNode.mydata._startCallback) {
                dragonNode.mydata._startCallback(thisObj, dragonNode, event.animationState.name);
            }
        }, this);
        //事件回调
        dragonNode.addEventListener(dragonBones.EventObject.FRAME_EVENT, function (event) {
            if (dragonNode.mydata._eventCallback) {
                dragonNode.mydata._eventCallback(thisObj, dragonNode, event);
            }
        }, this);
    };
    //立即切换到指定动作
    Display.animationChangeToAction = function (dragonNode, changeToAction, nextAction) {
        if (dragonNode == null || changeToAction == null || nextAction == null) {
            return;
        }
        dragonNode.mydata._actionIndex = changeToAction;
        dragonNode.mydata._nextAction = nextAction;
        dragonNode.mydata.playWithIndex(changeToAction);
    };
    //骨骼动画名称
    Display.DragonAnimationNames = [
        "00_daiji",
        "01_qianchong",
        "02_huichong",
        "01_qianchong",
        "00_daiji",
        "03_beiji",
        "03_beiji",
        "04_kbeiji",
        "04_kbeiji",
        "02_huichong",
        "05_xuanyun",
        "06_siwang",
        "06_siwang",
        "06_siwang",
        "07_pugong",
        "08_jineng",
        "12_heti",
        "00_daiji",
        "01_qianchong",
        "11_xialuo",
        "00_daiji",
        "01_qianchong",
        "02_huichong",
        "02_huichong",
        "00_daiji",
        "09_kzputong",
        "10_kzjineng",
        "28_ddsiwang",
        "31_ji1",
        "32_ji2",
        "33_ji3",
        "34_ji4",
        "35_ji5",
        "36_ji1",
        "37_ji2",
        "38_ji3",
        "39_ji4",
        "40_ji5",
        "13_jueji",
        "29_daodi",
    ];
    Display.effectAnimations = [
        "animation",
        "animation2",
        "animation3",
    ];
    return Display;
}());
__reflect(Display.prototype, "Display");
//# sourceMappingURL=Display.js.map