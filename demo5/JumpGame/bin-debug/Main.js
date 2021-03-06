//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2014-2015, Egret Technology Inc.
//  All rights reserved.
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the Egret nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY EGRET AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
//  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL EGRET AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;LOSS OF USE, DATA,
//  OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//////////////////////////////////////////////////////////////////////////////////////
var Main = (function (_super) {
    __extends(Main, _super);
    function Main() {
        _super.apply(this, arguments);
        this.player_vx = 32;
        this.player_vy = -50;
        this.isThemeLoadEnd = false;
        this.isResourceLoadEnd = false;
    }
    var d = __define,c=Main,p=c.prototype;
    p.createChildren = function () {
        _super.prototype.createChildren.call(this);
        //inject the custom material parser
        //注入自定义的素材解析器
        var assetAdapter = new AssetAdapter();
        this.stage.registerImplementation("eui.IAssetAdapter", assetAdapter);
        this.stage.registerImplementation("eui.IThemeAdapter", new ThemeAdapter());
        //Config loading process interface
        //设置加载进度界面
        this.loadingView = new LoadingUI();
        this.stage.addChild(this.loadingView);
        // initialize the Resource loading library
        //初始化Resource资源加载库
        RES.addEventListener(RES.ResourceEvent.CONFIG_COMPLETE, this.onConfigComplete, this);
        RES.loadConfig("resource/default.res.json", "resource/");
    };
    /**
     * 配置文件加载完成,开始预加载皮肤主题资源和preload资源组。
     * Loading of configuration file is complete, start to pre-load the theme configuration file and the preload resource group
     */
    p.onConfigComplete = function (event) {
        RES.removeEventListener(RES.ResourceEvent.CONFIG_COMPLETE, this.onConfigComplete, this);
        // load skin theme configuration file, you can manually modify the file. And replace the default skin.
        //加载皮肤主题配置文件,可以手动修改这个文件。替换默认皮肤。
        var theme = new eui.Theme("resource/default.thm.json", this.stage);
        theme.addEventListener(eui.UIEvent.COMPLETE, this.onThemeLoadComplete, this);
        RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
        RES.addEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR, this.onResourceLoadError, this);
        RES.addEventListener(RES.ResourceEvent.GROUP_PROGRESS, this.onResourceProgress, this);
        RES.addEventListener(RES.ResourceEvent.ITEM_LOAD_ERROR, this.onItemLoadError, this);
        RES.loadGroup("preload");
    };
    /**
     * 主题文件加载完成,开始预加载
     * Loading of theme configuration file is complete, start to pre-load the
     */
    p.onThemeLoadComplete = function () {
        this.isThemeLoadEnd = true;
        this.createScene();
    };
    /**
     * preload资源组加载完成
     * preload resource group is loaded
     */
    p.onResourceLoadComplete = function (event) {
        if (event.groupName == "preload") {
            this.stage.removeChild(this.loadingView);
            RES.removeEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
            RES.removeEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR, this.onResourceLoadError, this);
            RES.removeEventListener(RES.ResourceEvent.GROUP_PROGRESS, this.onResourceProgress, this);
            RES.removeEventListener(RES.ResourceEvent.ITEM_LOAD_ERROR, this.onItemLoadError, this);
            this.isResourceLoadEnd = true;
            this.createScene();
        }
    };
    p.createScene = function () {
        if (this.isThemeLoadEnd && this.isResourceLoadEnd) {
            this.startCreateScene();
        }
    };
    /**
     * 资源组加载出错
     *  The resource group loading failed
     */
    p.onItemLoadError = function (event) {
        console.warn("Url:" + event.resItem.url + " has failed to load");
    };
    /**
     * 资源组加载出错
     * Resource group loading failed
     */
    p.onResourceLoadError = function (event) {
        //TODO
        console.warn("Group:" + event.groupName + " has failed to load");
        //忽略加载失败的项目
        //ignore loading failed projects
        this.onResourceLoadComplete(event);
    };
    /**
     * preload资源组加载进度
     * loading process of preload resource
     */
    p.onResourceProgress = function (event) {
        if (event.groupName == "preload") {
            this.loadingView.setProgress(event.itemsLoaded, event.itemsTotal);
        }
    };
    /**
     * 创建场景界面
     * Create scene interface
     */
    p.startCreateScene = function () {
        this.startGameView = new StartGameUI;
        this.stage.addChild(this.startGameView);
        this.startGameView.addEventListener(this.startGameView.START_GAME, this.onStart, this);
    };
    p.onStart = function () {
        this.stage.removeChild(this.startGameView);
        var bg = new eui.Image();
        bg.source = RES.getRes("gameback_png");
        this.addChild(bg);
        console.log("gameStart");
        this.floatLimitLeft = -100;
        this.floatLimitRight = this.stage.stageWidth + 100;
        this.addEventListener(egret.Event.ENTER_FRAME, this.run, this);
        this.createWorld();
        this.groundFixed = [
            this.createGround(this.world, this, 1, 0, this.stage.stageWidth, 100, null, 0, this.stage.stageHeight - 60),
            this.createGround(this.world, this, 2, 0, 30, this.stage.stageHeight, null, 0, 0),
            this.createGround(this.world, this, 3, 0, 30, this.stage.stageHeight, null, this.stage.stageWidth - 30, 0)
        ];
        this.groundFloat = [
            this.createGround(this.world, this, 4, 0.6, 120, 20, "bar_png", this.floatLimitLeft, 600),
            this.createGround(this.world, this, 5, -0.8, 90, 20, "bar_png", this.floatLimitRight, 450),
            this.createGround(this.world, this, 6, 1.2, 80, 20, "bar_png", this.floatLimitLeft, 300)
        ];
        this.createPlayer();
        //添加弹力碰撞效果
        var materialA = new p2.Material(1);
        var materialB = new p2.Material(2);
        this.groundFloat[0].shapes[0].material = materialA;
        this.player.shapes[0].material = materialB;
        var contactMaterial = new p2.ContactMaterial(materialA, materialB);
        contactMaterial.restitution = 1;
        this.world.addContactMaterial(contactMaterial);
        this.stage.addEventListener(egret.TouchEvent.TOUCH_BEGIN, this.onTouchJump, this, false);
    };
    p.onTouchJump = function (e) {
        //在场景左半侧点击
        if (this.checkIfCanJump(this.world, this.player) == true) {
            if (e.stageX < this.player.position[0] - 50) {
                this.player.applyForce([-5, -15], this.player.position);
            }
            else if (e.stageX > this.player.position[0] + 50) {
                this.player.applyForce([5, -15], this.player.position);
            }
            else {
                this.player.applyForce([0, -15], this.player.position);
            }
        }
    };
    //private result = true;
    p.checkIfCanJump = function (world, body) {
        var yAxis = [0, 1];
        /********事件方法****************/
        /*var _this = this;
        _this.world.on("preSolve",function(evt): void {
            for(var i = 0;i < evt.contactEquations.length;i++) {
                var a = p2.ContactEquation = evt.contactEquations[i];
                if(a.bodyA === body || a.bodyB === body) {
                    var d = p2.vec2.dot(a.normalA,yAxis);
                    if(a.bodyA === body) d *= -1;
                }
            }
            if(d < -0.5) _this.result = true;
            else _this.result = false;
        });
        return _this.result;*/
        /********碰撞信息法*************/
        var result = false;
        //console.log(world.broadphase.getCollisionPairs[0]);
        for (var i = 0; i < world.narrowphase.contactEquations.length; i++) {
            var c = world.narrowphase.contactEquations[i];
            if (c.bodyA === body || c.bodyB === body) {
                var d = p2.vec2.dot(c.normalA, yAxis); // Normal dot Y-axis
                if (c.bodyA === body)
                    d *= -1;
                egret.log("d value:" + d);
                if (d < -0.5)
                    result = true;
            }
        }
        return result;
    };
    p.createWorld = function () {
        var wrd = new p2.World();
        wrd = new p2.World();
        //wrd.sleepMode=p2.World.BODY_SLEEPING;
        wrd.gravity = [0, 1];
        this.world = wrd;
    };
    /*
     * 创建地面，包括墙面、移动地面和固定地面
     * @param world
     * @param container
     * @param id
     * @param vx     x方向上的速度，vx=0则为固定地面
     * @param w       宽度
     * @param h       高度
     * @param resid   资源名
     * @param x0      position：x
     * @param y0      position：y
     * @returns       返回值{p2.Body}
     */
    p.createGround = function (world, container, id, vx, w, h, resid, x0, y0) {
        var groundShape = new p2.Box({
            width: w,
            height: h
        });
        var groundBody = new p2.Body({
            mass: 1,
            fixedRotation: true,
            type: vx == 0 ? p2.Body.STATIC : p2.Body.KINEMATIC,
            velocity: [vx, 0]
        });
        groundBody.id = id;
        groundBody.position[0] = x0 + w / 2;
        groundBody.position[1] = y0 + h / 2;
        groundBody.addShape(groundShape);
        this.world.addBody(groundBody);
        this.bindAsset(groundBody, groundShape, resid);
        return groundBody;
    };
    p.createPlayer = function () {
        var boxShape = new p2.Box({ width: 63, height: 110 });
        this.player = new p2.Body({ mass: 1, position: [240, 640], fixedRotation: true, type: p2.Body.DYNAMIC });
        this.player.addShape(boxShape);
        this.world.addBody(this.player);
        this.bindAsset(this.player, boxShape, "bird_png");
    };
    p.run = function () {
        this.world.step(2.5);
        this.world.bodies.forEach(function (b) {
            if (b.displays != null) {
                b.displays[0].x = b.position[0];
                b.displays[0].y = b.position[1];
            }
        });
        //浮动平台位置更新
        if (this.groundFloat[0].position[0] > this.floatLimitRight) {
            this.groundFloat[0].position[0] = this.floatLimitLeft;
        }
        if (this.groundFloat[1].position[0] < this.floatLimitLeft) {
            this.groundFloat[1].position[0] = this.floatLimitRight;
        }
        if (this.groundFloat[2].position[0] > this.floatLimitRight) {
            this.groundFloat[2].position[0] = this.floatLimitLeft;
        }
        //console.log("!" + this.world.narrowphase.contactEquations.length);
        //this.debugDraw.drawDebug();
    };
    p.bindAsset = function (body, shape, asset) {
        var img = this.getBitmapByRes(asset);
        img.scaleX = shape.width / img.width;
        img.scaleY = shape.height / img.height;
        this.addChild(img);
        img.x = body.position[0];
        img.y = body.position[1];
        body.displays = [img];
    };
    p.getBitmapByRes = function (resName) {
        var bitmap = new egret.Bitmap();
        bitmap.texture = RES.getRes(resName);
        bitmap.anchorOffsetX = bitmap.width / 2;
        bitmap.anchorOffsetY = bitmap.height / 2;
        return bitmap;
    };
    p.createDebug = function () {
        var sprite = new egret.Sprite();
        this.addChild(sprite);
        this.debugDraw = new P2DebugPainter(this.world, sprite);
    };
    return Main;
}(eui.UILayer));
egret.registerClass(Main,'Main');
//# sourceMappingURL=Main.js.map