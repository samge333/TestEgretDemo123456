var game;
(function (game) {
    var BaseSprite = (function (_super) {
        __extends(BaseSprite, _super);
        function BaseSprite() {
            _super.call(this);
            this.Type = "sprite1";
            //精灵的移动速度
            this.MoveSpeed = 0.1;
            //精灵当前的血量
            this.Hp = 100;
            //精灵最大血量
            this.HpMax = 100;
            //攻击力
            this.Atk = 1;
            //精灵方向（默认向下）
            this.direction = "";
            this.id = game.CommonFuntion.Token;
        }
        var d = __define,c=BaseSprite,p=c.prototype;
        d(p, "ID"
            ,function () {
                return this.id;
            }
        );
        d(p, "Direction"
            ,function () {
                return this.direction;
            }
        );
        p.setHp = function (value) {
            this.Hp = value;
            this.dispatchEvent(new egret.Event("gm_hpChange"));
        };
        /*设定朝向
         * @param p:要朝向的点
         */
        p.setDirection = function (p) {
            var xNum = p.x - this.x;
            var yNum = p.y - this.y;
            var tempDirection;
            if (xNum == 0) {
                if (yNum > 0) {
                    tempDirection = "down";
                }
                if (yNum < 0) {
                    tempDirection = "up";
                }
            }
            if (yNum == 0) {
                if (xNum > 0) {
                    tempDirection = "right";
                }
                if (xNum < 0) {
                    tempDirection = "left";
                }
            }
            if (tempDirection != this.direction) {
                this.direction = tempDirection;
                this.dispatchEvent(new egret.Event("gm_directionChange"));
            }
            return;
        };
        /*
         * 虚方法 需要override
         */
        p.OnUpdate = function (passTime) {
        };
        p.OnLoad = function (parent) {
        };
        p.OnRelease = function () {
        };
        d(p, "Point"
            ,function () {
                return new egret.Point(this.x, this.y);
            }
        );
        return BaseSprite;
    }(egret.Sprite));
    game.BaseSprite = BaseSprite;
    egret.registerClass(BaseSprite,'game.BaseSprite',["game.IObject","game.ILoad","game.IUpdate"]);
})(game || (game = {}));
//# sourceMappingURL=BaseSprite.js.map