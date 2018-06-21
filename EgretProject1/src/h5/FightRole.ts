class FightRole extends eui.Component {
	public constructor() {
		super();
		
		this.eventListen();
	}

	_info: any = {};
	_roleCamp = 0;
	dragonNode:dragonBones.EgretArmatureDisplay = null;
	//父节点
	parentNode: eui.Rect = null;
	//攻击时的位移坐标
	moveByPosition = {x: 0, y: 0};

	public eventListen() {
		this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
		this.addEventListener(egret.Event.ENTER_FRAME, this.update, this);
	}

	public onCreationComplete() {
		HLog.log("FightRole创建成功");
	}

	public update() {
		
	}

	public init(data: any, roleCamp: number, parentNode: eui.Rect) {
		HLog.log("创建角色" + roleCamp, data);
		this._info = data;
		this._roleCamp = roleCamp
		this.parentNode = parentNode;
		
		this.width = parentNode.width;
		this.height = parentNode.height;

		//测试数据
		let imgId = 105201;
		if (this._roleCamp == 1) {
			imgId = 106601;
		}

		this.dragonNode = Display.newDragonById(imgId);
		if (this._roleCamp == 0) {
			this.dragonNode.scaleX = -1;
		}

		// HLog.log(this.dragonNode.anchorOffsetX);
		// HLog.log(this.dragonNode.anchorOffsetY);
		// HLog.log(this.anchorOffsetX);
		// HLog.log(this.anchorOffsetY);
		Display.initArmature(this.dragonNode, this);
		// (this.dragonNode as any).mydata.setMovementEventCallFunc(Display.changeAction_animationEventCallFunc);
		(this.dragonNode as any).mydata._invoke = this.changeActionCallback;
		this.dragonNode.x = this.width / 2;
		this.dragonNode.y = this.height;
		this.addChild(this.dragonNode);
		
	}

	//监听攻击
	public attackListener() {
		this.executeAttackLogic();
	}

	//执行攻击逻辑
	public executeAttackLogic() {
		this.executeAttackLogicing();
	}

	public executeAttackLogicing() {
		this.executeHeroMoveToTarget();
	}

	//移动攻击目标
	public executeHeroMoveToTarget() {
		if (this.getAttackMovePosition() == true) {
			this.changeActtackToAttackMoving();
		} 
		else {
			this.changeActtackToAttackBegan();
		}
	}

	//获取这次攻击的移动位置
	public getAttackMovePosition() {
		this.moveByPosition.x = 200;
		return true;
	}

	//攻击时，向对方移动
	public changeActtackToAttackMoving() {
		//切换到前冲动作
		let actionIndex = DRAGON_ANIMAE_INDEX.animation_onrush;
		Display.animationChangeToAction(this.dragonNode, actionIndex, actionIndex);

		//开始位移
		let posx = this.parent.x + this.moveByPosition.x;
		egret.Tween.get(this.parent).to({x: posx}, 1000).call(function() {
			this.changeActtackToAttackBegan();
		}, this);

	}

	//攻击时，出手
	public changeActtackToAttackBegan() {
		let actionIndex = DRAGON_ANIMAE_INDEX.animation_skill_attacking;
		Display.animationChangeToAction(this.dragonNode, actionIndex, actionIndex);
	}

	//动作开始的回调
	public changeActionCallback(thisObj, dragonNode, name: string) {
		// HLog.log("FightRole 开始执行动作 " +  thisObj._roleCamp + "," +  thisObj._info._pos, name);
		//普通攻击
		if (name == Display.DragonAnimationNames[DRAGON_ANIMAE_INDEX.animation_skill_attacking]) {
			dragonNode.mydata._nextAction = DRAGON_ANIMAE_INDEX.animation_standby;
		}
	}

	//执行被攻击的逻辑
	public executeByAttackLogic() {

	}

	//创建打击光效
	public createEffect() {
		
	}

}