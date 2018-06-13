var game;
(function (game) {
    /**
     *
     * @author
     *
     */
    var ModuleManager = (function (_super) {
        __extends(ModuleManager, _super);
        function ModuleManager() {
            _super.call(this);
            this.IsStop = false;
            this.dicData = new Object();
            this.lastTime = 0;
            game.XFKLayer.Ins.Stage.addEventListener(egret.Event.ENTER_FRAME, this.update, this);
        }
        var d = __define,c=ModuleManager,p=c.prototype;
        d(ModuleManager, "Instance"
            ,function () {
                if (this.instance == null)
                    this.instance = new ModuleManager();
                return this.instance;
            }
        );
        p.GetModuleList = function () {
            return this.dicData;
        };
        p.RegisterModule = function (object) {
            this.dicData[object.ID.toString()] = object;
        };
        p.UnRegisterModule = function (object) {
            delete this.dicData[object.ID.toString()];
        };
        p.update = function (e) {
            if (this.IsStop) {
                return;
            }
            for (var key in this.dicData) {
                //传回当前时间
                //var nowTime:number=Math.abs(performance.now());
                //var passTime:number=nowTime-this.lastTime;
                //this.lastTime=nowTime;
                this.dicData[key].OnUpdate(egret.getTimer());
            }
        };
        return ModuleManager;
    }(egret.EventDispatcher));
    game.ModuleManager = ModuleManager;
    egret.registerClass(ModuleManager,'game.ModuleManager');
})(game || (game = {}));
//# sourceMappingURL=ModuleManager.js.map