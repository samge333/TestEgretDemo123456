var game;
(function (game) {
    var XFKScene = (function () {
        function XFKScene() {
            this.sceneKey = "scene1";
            this.isInit = false;
            this.lasttime = 0;
            this.id = game.CommonFuntion.Token;
        }
        var d = __define,c=XFKScene,p=c.prototype;
        d(p, "ID"
            ,function () {
                return this.id;
            }
        );
        p.OnLoad = function (obj) {
            this.OnRelease();
            game.ModuleManager.Instance.RegisterModule(this);
            this.sceneKey = obj;
            this.startTime = egret.getTimer();
            game.XFKControls.addEventListener(game.BaseEvent.gm_headquaters_hpChange, this.gm_geadquaters_hpChange, this);
            game.XFKControls.addEventListener(game.BaseEvent.gm_activation_bullet, this.gm_activation_bullet, this);
            game.XFKControls.addEventListener(game.BaseEvent.gm_monster_death, this.gm_monster_death, this);
            this.resLoad();
        };
        p.OnRelease = function () {
            game.ModuleManager.Instance.UnRegisterModule(this);
            game.XFKControls.removeEventListener(game.BaseEvent.gm_headquaters_hpChange, this.gm_geadquaters_hpChange, this);
            game.XFKControls.removeEventListener(game.BaseEvent.gm_activation_bullet, this.gm_activation_bullet, this);
            game.XFKControls.removeEventListener(game.BaseEvent.gm_monster_death, this.gm_monster_death, this);
            this.removeAll();
        };
        /*
         * 配置文件加载完成，开始预加载preload资源组
         */
        p.resLoad = function () {
            game.XFKLayer.Ins.LoadingViewOnOff();
            RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
            RES.addEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR, this.onResourceLoadError, this);
            RES.addEventListener(RES.ResourceEvent.GROUP_PROGRESS, this.onResourceProgress, this);
            RES.loadGroup(this.sceneKey);
        };
        /*
         * 场景资源组加载完成
         */
        p.onResourceLoadComplete = function (event) {
            if (event.groupName == this.sceneKey) {
                game.XFKLayer.Ins.LoadingViewOnOff();
                RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
                RES.addEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR, this.onResourceLoadError, this);
                RES.addEventListener(RES.ResourceEvent.GROUP_PROGRESS, this.onResourceProgress, this);
                this.init();
            }
        };
        /*
         * 资源组加载出错
         */
        p.onResourceLoadError = function (event) {
            console.warn("Group:" + event.groupName + "中有加载失败的项目");
            //忽略加载失败的项目
            this.onResourceLoadComplete(event);
        };
        /*
         * 资源组加载进度
         */
        p.onResourceProgress = function (event) {
            if (event.groupName == this.sceneKey) {
                game.XFKLayer.Ins.SetLoadingView(event.itemsLoaded, event.itemsTotal);
            }
        };
        p.init = function () {
            this.createBG();
            this.createTurret();
            this.createAction();
            this.isInit = true;
        };
        //创建背景图
        p.createBG = function () {
            var bitmap = new egret.Bitmap();
            bitmap.texture = RES.getRes(this.sceneKey + "bg_jpg");
            game.XFKLayer.Ins.BgLayer.addChild(bitmap);
        };
        //建立塔防
        p.createTurret = function () {
            var data = RES.getRes(this.sceneKey + "turret_json");
            var td;
            for (var i = 0; i < data.turret.length; i++) {
                td = new game.XFKTurret;
                td.Parse(data.turret[i]);
                td.OnLoad(game.XFKLayer.Ins.NpcLayer);
            }
        };
        //创建精灵,放在action数组内
        p.createAction = function () {
            var data = RES.getRes(this.sceneKey + "sprite_json");
            this.action = new Array();
            var index;
            //遍历波数
            for (var i = 0; i < data.sprite.length; i++) {
                data.sprite[i].path = data.Path;
                data.sprite[i].delay = parseInt(data.sprite[i].delay);
                //遍历一波有多少个怪物
                for (var j = 0; j < data.sprite[i].count; j++) {
                    index = this.action.push(data.sprite[i]);
                }
            }
        };
        //创建精灵
        p.createSp = function () {
            if (this.action.length > 0) {
                //console.log(this.startTime+this.action[0].delay,egret.getTimer());
                if ((this.startTime + this.action[0].delay) <= egret.getTimer()) {
                    var sp;
                    sp = new game.XFKSprite();
                    sp.Parse(this.action.shift());
                    sp.OnLoad(game.XFKLayer.Ins.NpcLayer);
                }
            }
        };
        //总部血量变化 总部血量为0时GAMEOVER
        p.gm_geadquaters_hpChange = function (e) {
            game.ModuleManager.Instance.IsStop = true;
            console.log("GAME OVER!");
        };
        p.gm_activation_bullet = function (e) {
            var bullet = new game.XFKBullet();
            bullet.setTarget(e.object[0], e.object[1]);
            bullet.OnLoad(game.XFKLayer.Ins.NpcLayer);
        };
        p.gm_monster_death = function (e) {
            var sp = new game.XFKSprite();
            game.XFKConfig.Ins.addGlob(sp.Glob);
        };
        p.removeAll = function () {
            while (game.XFKLayer.Ins.NpcLayer.numChildren > 0) {
                var obj = game.XFKLayer.Ins.NpcLayer.removeChildAt(0);
                obj.OnRelease();
            }
        };
        p.OnUpdate = function (passTime) {
            if (this.isInit && passTime > this.lasttime) {
                this.createSp();
                this.lasttime = passTime + 800;
            }
        };
        return XFKScene;
    }());
    game.XFKScene = XFKScene;
    egret.registerClass(XFKScene,'game.XFKScene',["game.IObject","game.ILoad","game.IUpdate"]);
})(game || (game = {}));
//# sourceMappingURL=XFKScene.js.map