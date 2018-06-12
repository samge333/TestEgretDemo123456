var game;
(function (game) {
    /**
     *
     * @author
     *
     */
    var XFKLayer = (function () {
        function XFKLayer() {
            //加载进度
            this.LoadingView = new LoadingUI();
        }
        var d = __define,c=XFKLayer,p=c.prototype;
        d(XFKLayer, "Ins"
            ,function () {
                if (this.ins == null)
                    this.ins = new XFKLayer();
                return this.ins;
            }
        );
        p.LoadingViewOnOff = function () {
            if (this.Stage.contains(this.LoadingView)) {
                this.Stage.removeChild(this.LoadingView);
            }
            else {
                this.Stage.addChild(this.LoadingView);
                this.LoadingView.x = (this.Stage.width - this.LoadingView.width) / 2; //居中显示
            }
        };
        p.SetLoadingView = function (current, total) {
            this.LoadingView.setProgress(current, total);
        };
        p.init = function () {
            this.GameLayer = new egret.DisplayObjectContainer();
            this.GameLayer.name = "gameLayer";
            this.Stage.addChild(this.GameLayer);
            this.BgLayer = new egret.DisplayObjectContainer();
            this.BgLayer.name = "bgLayer";
            this.GameLayer.addChild(this.BgLayer);
            this.NpcLayer = new egret.DisplayObjectContainer();
            this.NpcLayer.name = "NpcLayer";
            this.GameLayer.addChild(this.NpcLayer);
            this.DecorationLayer = new egret.DisplayObjectContainer();
            this.DecorationLayer.name = "DecorationLayer";
            this.GameLayer.addChild(this.DecorationLayer);
            this.UiLayer = new egret.DisplayObjectContainer();
            this.UiLayer.name = "UiLayer";
            this.Stage.addChild(this.UiLayer);
            this.GuiLayer = new egret.DisplayObjectContainer();
            this.GuiLayer.name = "GuiLayer";
            this.Stage.addChild(this.GuiLayer);
        };
        p.OnLoad = function (parent) {
            this.Stage = parent;
            this.init();
        };
        return XFKLayer;
    }());
    game.XFKLayer = XFKLayer;
    egret.registerClass(XFKLayer,'game.XFKLayer');
})(game || (game = {}));
//# sourceMappingURL=XFKLayer.js.map