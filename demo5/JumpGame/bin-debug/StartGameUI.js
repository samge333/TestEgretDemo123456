/**
 *
 * @author
 *
 */
var StartGameUI = (function (_super) {
    __extends(StartGameUI, _super);
    function StartGameUI() {
        _super.call(this);
        this.START_GAME = "startgame";
        this.skinName = "resource/eui_skins/StartGameSkin.exml";
        this.btn_StartGame.addEventListener(egret.TouchEvent.TOUCH_TAP, this.onButtonClick, this);
    }
    var d = __define,c=StartGameUI,p=c.prototype;
    p.onButtonClick = function (e) {
        var startEvent = new egret.Event(this.START_GAME);
        this.dispatchEvent(startEvent);
    };
    return StartGameUI;
}(eui.Component));
egret.registerClass(StartGameUI,'StartGameUI');
//# sourceMappingURL=StartGameUI.js.map