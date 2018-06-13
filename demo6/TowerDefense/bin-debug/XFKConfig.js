var game;
(function (game) {
    var XFKConfig = (function () {
        function XFKConfig() {
            /*
             * 用户金钱
             */
            this.Glob = 0;
            /*
             * 当前怪物的进度
             */
            this.Count = 0;
        }
        var d = __define,c=XFKConfig,p=c.prototype;
        d(XFKConfig, "Ins"
            ,function () {
                if (this.ins == null)
                    this.ins = new XFKConfig();
                return this.ins;
            }
        );
        p.addGlob = function (value) {
            this.Glob = this.Glob + value;
        };
        return XFKConfig;
    }());
    game.XFKConfig = XFKConfig;
    egret.registerClass(XFKConfig,'game.XFKConfig');
})(game || (game = {}));
//# sourceMappingURL=XFKConfig.js.map