module game {
	/**
	 *
	 * @author 
	 *
	 */
	export interface ILoad {
    	OnLoad(layer:egret.DisplayObjectContainer):void;
    	OnRelease():void;
	}
}
