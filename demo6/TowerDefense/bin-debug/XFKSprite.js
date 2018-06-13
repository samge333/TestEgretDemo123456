var game;
(function (game) {
    /**
     *
     * @author
     *
     */
    var XFKSprite = (function (_super) {
        __extends(XFKSprite, _super);
        function XFKSprite() {
            _super.call(this);
            /*
             * 路径存放的列表
             */
            this.Path = [];
            this.hpImg = new game.XFKHpImg();
            this.addEventListener(egret.Event.ADDED_TO_STAGE, this.onAddToStage, this);
        }
        var d = __define,c=XFKSprite,p=c.prototype;
        p.onAddToStage = function (event) {
            this.removeEventListener(egret.Event.ADDED_TO_STAGE, this.onAddToStage, this);
            this.addEventListener("gm_directionChange", this.onDirectionChange, this);
            this.addEventListener("gm_hpChange", this.onHpChange, this);
            this.x = this.Path[0].x;
            this.y = this.Path[0].y;
            this.setDirection(this.Path[1]);
        };
        p.OnLoad = function (parent) {
            _super.prototype.OnLoad.call(this, parent);
            parent.addChild(this);
            game.ModuleManager.Instance.RegisterModule(this);
            this.hpImg.OnLoad(this);
        };
        p.OnRelease = function () {
            _super.prototype.OnRelease.call(this);
            if (this.sp != null) {
                this.sp.stop();
            }
            this.removeEventListener("gm_directionChange", this.onDirectionChange, this);
            this.removeEventListener("gm_hpChange", this.onHpChange, this);
            if (this.parent != null) {
                this.parent.removeChild(this);
            }
            game.ModuleManager.Instance.UnRegisterModule(this);
            this.hpImg.OnRelease();
        };
        p.OnUpdate = function (passTime) {
            _super.prototype.OnUpdate.call(this, passTime);
            this.move(passTime);
        };
        p.onDirectionChange = function (e) {
            //var _this:XFKSprite=(<game.XFKSprite>e.target);
            var data = RES.getRes(this.Type + "_" + this.Direction + "_json"); //获取描述
            var texture = RES.getRes(this.Type + "_" + this.Direction + "_png"); //获取图片
            var mcFactory = new egret.MovieClipDataFactory(data, texture); //获取MovieClipData工厂类
            if (this.sp != null) {
                this.sp.parent.removeChild(this.sp);
                this.sp.stop();
            }
            //创建一个MovieClip
            this.sp = new egret.MovieClip(mcFactory.generateMovieClipData(this.Type + "_" + this.Direction));
            this.addChild(this.sp);
            this.sp.x = -20;
            this.sp.y = -30;
            this.sp.gotoAndPlay(1, -1); //-1表示循环播放
            //创建一个圆心 主要用来对点
            var shap = new egret.Shape();
            shap.graphics.beginFill(0xffff60, 1);
            shap.graphics.drawRect(0, 0, 3, 3);
            shap.graphics.endFill();
            this.addChild(shap);
        };
        p.onHpChange = function (e) {
            this.hpImg.sethp(this.Hp, this.HpMax);
            if (this.Hp <= 0) {
                game.XFKControls.dispatchEvent(game.BaseEvent.gm_monster_death, this);
                this.OnRelease();
            }
        };
        /*
         *
         */
        p.move = function (passTime) {
            //console.log(this.hpImg.x);
            if (this.Path.length == 0) {
                return;
            }
            var point = this.Path[0]; //下一个节点
            //根据两点距离，计算特定时间速度所需要移动的距离。
            var targetSpeed = game.CommonFuntion.GetSpeed(point, new egret.Point(this.x, this.y), this.MoveSpeed);
            var xDistance = 10 * targetSpeed.x; //每次向x方向走10
            var yDistance = 10 * targetSpeed.y; //向y方向移动距离10
            if (Math.abs(point.x - this.x) <= Math.abs(xDistance) && Math.abs(point.y - this.y) <= Math.abs(yDistance)) {
                this.x = point.x;
                this.y = point.y;
                this.Path.shift(); //去掉第一个节点
                if (this.Path.length == 0) {
                    game.XFKControls.dispatchEvent(game.BaseEvent.gm_moveEnd, this);
                    this.OnRelease();
                    return;
                }
                else {
                    this.setDirection(this.Path[0]);
                }
            }
            else {
                this.x = this.x + xDistance;
                this.y = this.y + yDistance;
            }
        };
        /*
         * 读取配置表中精灵的默认属性
         */
        p.Parse = function (obj) {
            this.Hp = parseInt(obj.hp);
            this.HpMax = parseInt(obj.hp);
            this.Glob = parseInt(obj.glob);
            this.MoveSpeed = parseFloat(obj.speed);
            this.Type = obj.type;
            this.Path = [];
            for (var i = 0; i < obj.path.length; i++) {
                this.Path.push(new egret.Point(parseInt(obj.path[i].x), parseInt(obj.path[i].y)));
            }
        };
        return XFKSprite;
    }(game.BaseSprite));
    game.XFKSprite = XFKSprite;
    egret.registerClass(XFKSprite,'game.XFKSprite');
})(game || (game = {}));
//# sourceMappingURL=XFKSprite.js.map