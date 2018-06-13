module game {
	/**
	 *
	 * @author 
	 *
	 */
	export class ModuleManager extends egret.EventDispatcher{
        public IsStop: boolean = false;
        
    	private static instance:ModuleManager;
		private dicData=new Object();
		private lastTime:number=0;
		
    	public constructor() {
    		super();
    		game.XFKLayer.Ins.Stage.addEventListener(egret.Event.ENTER_FRAME,this.update,this);
		}
		public static get Instance():ModuleManager{
		    if(this.instance==null) this.instance=new ModuleManager();
		    return this.instance;
		}
		public GetModuleList():Object{
		    return this.dicData;
		}
		public RegisterModule(object:game.IObject):void{
		    this.dicData[object.ID.toString()]=object;
		}
		public UnRegisterModule(object:game.IObject):void{
		    delete this.dicData[object.ID.toString()];
		}
		private update(e:egret.Event):void{
		    if(this.IsStop){
		        return;
		    }
		    for(var key in this.dicData){
		        //传回当前时间
    		    //var nowTime:number=Math.abs(performance.now());
    		    //var passTime:number=nowTime-this.lastTime;
    		    //this.lastTime=nowTime;
    		    (<game.IObject>this.dicData[key]).OnUpdate(egret.getTimer());
		    }
		}
		
	}
}
