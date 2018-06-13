module game {
	/**
	 *
	 * @author 
	 *
	 */
	export class CommonFuntion {
		public constructor() { 
		}
		private static token:number=0;
		public static get Token():number{
		    return this.token++;
		}
		public static GetDistance(p1:egret.Point,p2:egret.Point):number{
		    return Math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
		}
		//获得从P1到P2的速度向量
		public static GetSpeed(targetP2:egret.Point,currentP1:egret.Point,SpeedNum:number):egret.Point{
		    var speed:egret.Point=new egret.Point();
		    var hypotenuse:number=game.CommonFuntion.GetDistance(targetP2,currentP1);   //斜边
		    if(hypotenuse==0){
		        speed.x=0;
		        speed.y=0;
		        return speed;
		    }
		    speed.x=SpeedNum*(targetP2.x-currentP1.x)/hypotenuse;   //转化为单位向量*速度
		    speed.y=SpeedNum*(targetP2.y-currentP1.y)/hypotenuse;
		    return speed;
		}
		//
		public static numPrecentage(cint:number,mint:number,countCop:number):number{
		    var value:number=Math.floor(cint/mint*countCop);
		    if(value>countCop){
		        value=countCop;
		    }
		    return value;
		}
	}
}
