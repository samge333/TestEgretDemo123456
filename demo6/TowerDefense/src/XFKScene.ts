module game {
	export class XFKScene implements game.IObject{
		private id:number;
        private sceneKey: string = "scene1";
        private startTime: number;
        private isInit: boolean = false;
    	public constructor() {
    		this.id=game.CommonFuntion.Token;
		}
		public get ID():number{
		    return this.id;
		}
		public OnLoad(obj:any):void{
		    this.OnRelease();
		    game.ModuleManager.Instance.RegisterModule(this);
		    this.sceneKey=obj;
		    this.startTime=egret.getTimer();
		    game.XFKControls.addEventListener(game.BaseEvent.gm_headquaters_hpChange,this.gm_geadquaters_hpChange,this);
		    game.XFKControls.addEventListener(game.BaseEvent.gm_activation_bullet,this.gm_activation_bullet,this);
		    game.XFKControls.addEventListener(game.BaseEvent.gm_monster_death,this.gm_monster_death,this);
		    
		    this.resLoad();
		}
		public OnRelease():void{
		    game.ModuleManager.Instance.UnRegisterModule(this);
            game.XFKControls.removeEventListener(game.BaseEvent.gm_headquaters_hpChange,this.gm_geadquaters_hpChange,this);
            game.XFKControls.removeEventListener(game.BaseEvent.gm_activation_bullet,this.gm_activation_bullet,this);
            game.XFKControls.removeEventListener(game.BaseEvent.gm_monster_death,this.gm_monster_death,this);
		    this.removeAll();
		}
		/*
		 * 配置文件加载完成，开始预加载preload资源组
		 */ 
		private resLoad():void{
		    game.XFKLayer.Ins.LoadingViewOnOff();
		    RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE,this.onResourceLoadComplete,this);
		    RES.addEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR,this.onResourceLoadError,this);
		    RES.addEventListener(RES.ResourceEvent.GROUP_PROGRESS,this.onResourceProgress,this);
		    RES.loadGroup(this.sceneKey);
		}
		/*
		 * 场景资源组加载完成
		 */ 
		private onResourceLoadComplete(event:RES.ResourceEvent):void{
		    if(event.groupName==this.sceneKey){
		        game.XFKLayer.Ins.LoadingViewOnOff();
                RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE,this.onResourceLoadComplete,this);
                RES.addEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR,this.onResourceLoadError,this);
                RES.addEventListener(RES.ResourceEvent.GROUP_PROGRESS,this.onResourceProgress,this);
		        this.init();
		    }
		}
		/*
		 * 资源组加载出错
		 */ 
		private onResourceLoadError(event:RES.ResourceEvent):void{
		    console.warn("Group:"+event.groupName+"中有加载失败的项目");
		   //忽略加载失败的项目
		    this.onResourceLoadComplete(event);
		}
		/*
		 * 资源组加载进度
		 */ 
		private onResourceProgress(event:RES.ResourceEvent):void{
		    if(event.groupName==this.sceneKey){
		        game.XFKLayer.Ins.SetLoadingView(event.itemsLoaded,event.itemsTotal);
		    }
		}
		private init():void{
		    this.createBG();
		    this.createTurret();
		    this.createAction();
		    this.isInit=true;
		}
		//创建背景图
		private createBG():void{
		    var bitmap:egret.Bitmap=new egret.Bitmap();
		    bitmap.texture=RES.getRes(this.sceneKey+"bg_jpg");
		    game.XFKLayer.Ins.BgLayer.addChild(bitmap);
		}
		//建立塔防
		private createTurret():void{
		    var data=RES.getRes(this.sceneKey+"turret_json");
		    var td:game.XFKTurret;
		    for(var i:number=0;i<data.turret.length;i++){
		        td=new game.XFKTurret;
		        td.Parse(data.turret[i]);
		        td.OnLoad(game.XFKLayer.Ins.NpcLayer);
		    }
		}
		private action:any[];
		//创建精灵,放在action数组内
		private createAction():void{
		    var data=RES.getRes(this.sceneKey+"sprite_json");
		    this.action=new Array();
		    var index:number;
		    //遍历波数
		    for(var i:number=0;i<data.sprite.length;i++){
		        data.sprite[i].path = data.Path;
		        data.sprite[i].delay=parseInt(data.sprite[i].delay);
		        //遍历一波有多少个怪物
		        for(var j:number=0;j<data.sprite[i].count;j++){
		            index=this.action.push(data.sprite[i]);
		        }
		    }
		}
		//创建精灵
		private createSp():void{
		    if(this.action.length>0){
		        //console.log(this.startTime+this.action[0].delay,egret.getTimer());
		        if((this.startTime+this.action[0].delay)<=egret.getTimer()){
		            var sp:game.XFKSprite;
		            sp=new game.XFKSprite();
		            sp.Parse(this.action.shift());
		            sp.OnLoad(game.XFKLayer.Ins.NpcLayer);
		        }
		    }
		}
		//总部血量变化 总部血量为0时GAMEOVER
		private gm_geadquaters_hpChange(e:game.BaseEvent):void{
		    game.ModuleManager.Instance.IsStop=true;
		    
		    console.log("GAME OVER!");
		    
		}
		private gm_activation_bullet(e:game.BaseEvent):void{
		    var bullet:game.XFKBullet=new XFKBullet();
		    bullet.setTarget(e.object[0],e.object[1]);
		    bullet.OnLoad(game.XFKLayer.Ins.NpcLayer);
		}
		private gm_monster_death(e:game.BaseEvent):void{
		     var sp:game.XFKSprite = new game.XFKSprite();
		     game.XFKConfig.Ins.addGlob(sp.Glob);
		}
		private removeAll():void{
		    while(game.XFKLayer.Ins.NpcLayer.numChildren>0){
		        var obj:any = game.XFKLayer.Ins.NpcLayer.removeChildAt(0);
		        (<ILoad>obj).OnRelease();
		    }
		}
		private lasttime:number=0;
	    public OnUpdate(passTime:number):void{
	        if(this.isInit && passTime>this.lasttime){
	            this.createSp();
	            this.lasttime = passTime + 800;
	        }
	    }
	}
}
