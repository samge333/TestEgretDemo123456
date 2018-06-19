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
var MainUI = (function (_super) {
    __extends(MainUI, _super);
    function MainUI() {
        return _super.call(this) || this;
    }
    MainUI.prototype.createChildren = function () {
        RES.addEventListener(RES.ResourceEvent.CONFIG_COMPLETE, this.onConfigComplete, this);
        RES.loadConfig("resource/default.res.json", "resource/");
    };
    MainUI.prototype.onConfigComplete = function (event) {
        RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
        RES.loadGroup("preload");
    };
    MainUI.prototype.onResourceLoadComplete = function (event) {
        switch (event.groupName) {
            case "preload":
                // Dms.loadTxt("npc_txt");
                // Dms.loadTxt("talent_mould_txt");
                // Dms.loadTxt("ship_mould_txt");
                // Dms.loadTxt("skill_influence_txt");
                // Dms.loadTxt("skill_mould_txt");
                // Dms.loadTxt("environment_ship_txt");
                // let fightModule = new FightModule;
                // fightModule.initFight(58, 1, 0);
                // ED.data.fightModule = fightModule;
                // fightModule.initFightOrder();
                // //测试攻击数据
                // let fightRoleController = new FightRoleController;
                // fightRoleController.nextBattle();
                // this.runGame();
                // let testScene = new TestScene;
                // testScene.skinName = "resource/skins/test.exml";
                // this.addChild(testScene);
                EXML.load("resource/skins/test.exml", this.onLoaded, this);
                break;
        }
    };
    MainUI.prototype.onLoaded = function (clazz, url) {
        var testScene = new TestScene;
        testScene.skinName = "resource/skins/test.exml";
        this.addChild(testScene);
    };
    return MainUI;
}(eui.UILayer));
__reflect(MainUI.prototype, "MainUI");
//# sourceMappingURL=MainUI.js.map