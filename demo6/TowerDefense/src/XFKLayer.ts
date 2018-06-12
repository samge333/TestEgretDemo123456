module game {
	/**
	 *
	 * @author 
	 *
	 */
	export class XFKLayer {
		private static ins:XFKLayer;
    	public constructor() {
		}
		public static get Ins():XFKLayer{
		    if(this.ins==null) this.ins=new XFKLayer();
		    return this.ins;
		}
		public Stage:egret.DisplayObjectContainer;
		//游戏基础层
		public GameLayer:egret.DisplayObjectContainer;
		//场景层
		public BgLayer:egret.DisplayObjectContainer;
		//精灵层  
		public NpcLayer:egret.DisplayObjectContainer; 
		//没法归类的精灵
		public DecorationLayer:egret.DisplayObjectContainer;
		//官方GUI
		public GuiLayer:egret.DisplayObjectContainer;
		//自定义ui
		public UiLayer:egret.DisplayObjectContainer;
		//加载进度
		public LoadingView:LoadingUI=new LoadingUI();
		public LoadingViewOnOff():void{
		    if(this.Stage.contains(this.LoadingView)){
		        this.Stage.removeChild(this.LoadingView);
		    }
		    else{
		        this.Stage.addChild(this.LoadingView);
		        this.LoadingView.x=(this.Stage.width-this.LoadingView.width)/2; //居中显示
		    }
		}
		public SetLoadingView(current,total){
		    this.LoadingView.setProgress(current,total);
		}
		private init():void{
		    this.GameLayer=new egret.DisplayObjectContainer();
		    this.GameLayer.name="gameLayer";
		    this.Stage.addChild(this.GameLayer);
		    
		    this.BgLayer=new egret.DisplayObjectContainer();
		    this.BgLayer.name="bgLayer";
		    this.GameLayer.addChild(this.BgLayer);
		    
		    this.NpcLayer=new egret.DisplayObjectContainer();
		    this.NpcLayer.name="NpcLayer";
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
		}
		public OnLoad(parent:egret.DisplayObjectContainer):void{
		    this.Stage=parent;
		    this.init();
		}
	}
}
