var game;
(function (game) {
    var XFKHpImg = (function (_super) {
        __extends(XFKHpImg, _super);
        function XFKHpImg() {
            _super.call(this);
        }
        var d = __define,c=XFKHpImg,p=c.prototype;
        p.OnLoad = function (parent) {
            this.parentSprite = parent;
            this.init();
        };
        p.OnRelease = function () {
            if (this.parent != null) {
                this.parent.removeChild(this);
            }
            while (this.numChildren > 0) {
                this.removeChildAt(0);
            }
            this.parentSprite = null;
        };
        p.init = function () {
            this.progressbar = new eui.ProgressBar();
            this.progressbar.skinName = "resource/eui_skins/ProgressBarSkin.exml";
            this.sethp(100, 100);
            this.progressbar.x = -20;
            this.progressbar.y = -40;
            this.parentSprite.addChild(this.progressbar);
        };
        p.sethp = function (cnum, mnum) {
            var i = Math.round((cnum / mnum) * 100);
            this.progressbar.value = i;
        };
        return XFKHpImg;
    }(egret.Sprite));
    game.XFKHpImg = XFKHpImg;
    egret.registerClass(XFKHpImg,'game.XFKHpImg');
})(game || (game = {}));
//# sourceMappingURL=XFKHpImg.js.map