var game;
(function (game) {
    var XFKBullet = (function (_super) {
        __extends(XFKBullet, _super);
        function XFKBullet() {
            _super.call(this);
        }
        var d = __define,c=XFKBullet,p=c.prototype;
        p.setTarget = function (source, target) {
            this.x = source.x;
            this.y = source.y;
            this.target = target;
            var bitmap = new egret.Bitmap();
            bitmap.texture = RES.getRes("bullet1_png");
            bitmap.x = -bitmap.width / 2;
            bitmap.y = -bitmap.height / 2;
            this.addChild(bitmap);
            this.radius = 10;
            this.MoveSpeed = 1;
        };
        p.OnLoad = function (parent) {
            parent.addChild(this);
            game.ModuleManager.Instance.RegisterModule(this);
        };
        p.OnRelease = function () {
            if (this.parent != null) {
                this.parent.removeChild(this);
            }
            game.ModuleManager.Instance.UnRegisterModule(this);
        };
        /*
         * 虚方法，需要Override
         */
        p.OnUpdate = function (passTime) {
            _super.prototype.OnUpdate.call(this, passTime);
            this.move(passTime);
        };
        p.move = function (passTime) {
            var distance = game.CommonFuntion.GetDistance(this.Point, this.target.Point);
            if (distance <= this.radius) {
                this.target.setHp(this.target.Hp - this.Atk);
                this.target = null;
                this.OnRelease();
            }
            else {
                var targetSpeed = game.CommonFuntion.GetSpeed(this.target.Point, this.Point, this.MoveSpeed);
                var xDistance = 10 * targetSpeed.x;
                var yDistance = 10 * targetSpeed.y;
                this.x = this.x + xDistance;
                this.y = this.y + yDistance;
            }
        };
        return XFKBullet;
    }(game.BaseSprite));
    game.XFKBullet = XFKBullet;
    egret.registerClass(XFKBullet,'game.XFKBullet');
})(game || (game = {}));
//# sourceMappingURL=XFKBullet.js.map