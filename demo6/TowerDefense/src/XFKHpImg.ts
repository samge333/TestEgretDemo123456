module game {
	
	export class XFKHpImg extends egret.Sprite{
        private parentSprite: egret.DisplayObjectContainer;
        private progressbar: eui.ProgressBar;
		public constructor() {
    		super();
		}
		public OnLoad(parent:egret.DisplayObjectContainer):void{
		    this.parentSprite=parent;
		    this.init();
		}
		public OnRelease():void{
		    if(this.parent!=null){
		        this.parent.removeChild(this);
		    }
		    while(this.numChildren>0){
		        this.removeChildAt(0);
		    }
		    this.parentSprite=null;
		}
		private init():void{
    		this.progressbar=new eui.ProgressBar();
    		this.progressbar.skinName = "resource/eui_skins/ProgressBarSkin.exml";
            
            this.sethp(100,100);
            this.progressbar.x=-20;
            this.progressbar.y=-40;
            this.parentSprite.addChild(this.progressbar);
		}
		public sethp(cnum:number,mnum:number):void{
            var i = Math.round((cnum / mnum) * 100);
    		this.progressbar.value=i;
		}
	}
}
