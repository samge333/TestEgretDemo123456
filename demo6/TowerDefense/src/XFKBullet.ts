module game {
	export class XFKBullet extends BaseSprite{
		public constructor() {
    		super();
		}
		private radius:number;
		private target:game.BaseSprite;
		public setTarget(source:BaseSprite,target:game.BaseSprite):void{
		    this.x=source.x;
		    this.y=source.y;
		    this.target=target;
		    
		    var bitmap:egret.Bitmap=new egret.Bitmap();
		    bitmap.texture=RES.getRes("bullet1_png");
		    bitmap.x=-bitmap.width/2;
		    bitmap.y=-bitmap.height/2;
		    this.addChild(bitmap);
		    
		    this.radius=10;
		    this.MoveSpeed=1;
		}
		public OnLoad(parent:egret.DisplayObjectContainer):void{
		    parent.addChild(this);
		    game.ModuleManager.Instance.RegisterModule(this);
		}
		public OnRelease():void{
		    if(this.parent!=null){
		        this.parent.removeChild(this);
		    }
		    game.ModuleManager.Instance.UnRegisterModule(this);
		}
		/*
		 * 虚方法，需要Override
		 */ 
		public OnUpdate(passTime:number):void{
		    super.OnUpdate(passTime);
		    this.move(passTime);
		}
		private move(passTime:number):void{
		    var distance:number=game.CommonFuntion.GetDistance(this.Point,this.target.Point);
		    if(distance<=this.radius){
		        this.target.setHp(this.target.Hp-this.Atk);
		        this.target=null;
		        this.OnRelease();
		    }
		    else{
		        var targetSpeed:egret.Point=game.CommonFuntion.GetSpeed(this.target.Point,this.Point,this.MoveSpeed);
		        var xDistance:number=10*targetSpeed.x;
		        var yDistance:number=10*targetSpeed.y;
		        this.x=this.x+xDistance;
		        this.y=this.y+yDistance;
		    }
		}
	}
}
