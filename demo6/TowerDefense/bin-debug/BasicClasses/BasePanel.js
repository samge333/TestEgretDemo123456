var game;
(function (game) {
    var BasePanel = (function (_super) {
        __extends(BasePanel, _super);
        function BasePanel() {
            _super.call(this);
            this.isOpen = false;
        }
        var d = __define,c=BasePanel,p=c.prototype;
        p.backGround = function () {
            if (this.backBG) {
                return;
            }
            this.backBG = new egret.Bitmap();
            this.backBG.name = "panelbackground";
            this.backBG.texture = RES.getRes("panelbackground_jpg");
            this.backBG.alpha = 0.6;
            this.backBG.width = game.XFKLayer.Ins.Stage.width;
            this.backBG.height = game.XFKLayer.Ins.Stage.height;
            game.XFKLayer.Ins.UiLayer.addChild(this.backBG);
        };
        p.show = function (type) {
            if (type === void 0) { type = 0; }
            this.isOpen = true;
            //灰色遮罩层显示与否
            if (type == 0) {
                this.backGround();
            }
            game.XFKLayer.Ins.UiLayer.addChild(this);
        };
        p.close = function () {
            this.isOpen = false;
            //删除图片
            if (this.backBG && this.backBG.parent) {
                game.XFKLayer.Ins.UiLayer.removeChild(this.backBG);
                this.backBG = null;
            }
            //删除类对象
            if (this.parent) {
                this.parent.removeChild(this);
            }
        };
        p.setWindowCenter = function () {
            this.x = game.XFKLayer.Ins.Stage.width - this.width / 2;
            this.y = game.XFKLayer.Ins.Stage.height - this.height / 2;
        };
        p.setPoint = function (point) {
            this.x = point.x - this.width / 2;
            this.y = point.y - this.height / 2;
        };
        return BasePanel;
    }(egret.Sprite));
    game.BasePanel = BasePanel;
    egret.registerClass(BasePanel,'game.BasePanel');
})(game || (game = {}));
//# sourceMappingURL=BasePanel.js.map