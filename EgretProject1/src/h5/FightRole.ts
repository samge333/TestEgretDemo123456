class FightRole extends eui.Component {
	public constructor() {
		super();
		
		this.eventListen();
	}

	_info: any = {};
	_roleCamp = 0;
	dragonNode = null;
	//父节点
	parentNode: eui.Rect = null;
	//攻击时的位移坐标
	moveByPosition = {x: 0, y: 0};
	//角色受到的技能效用影响列表
	fight_cacher_pool = [];
	//是否开启监听并处理自己受到的效用影响
	run_fight_listener = false;
	//当前正在处理的效用影响
	current_fight_data: any = {};

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
		Display.initArmature(this.dragonNode, Display.DragonAnimationNames, this);
		// (this.dragonNode as any).mydata.setMovementEventCallFunc(Display.changeAction_animationEventCallFunc);
		this.dragonNode.mydata._startCallback = this.onChangeActionCallback;
		this.dragonNode.x = this.width / 2;
		this.dragonNode.y = this.height;
		this.addChild(this.dragonNode);
		
	}

	//监听攻击
	public attackListener() {
		if (this.run_fight_listener == true) {
			if (this.fight_cacher_pool.length == 0) {
				this.run_fight_listener = false;
			}
			else {
				this.current_fight_data = this.fight_cacher_pool[0];
				//如果当前fightRole发起攻击
				if (this.current_fight_data._state == 0) {
					this.executeAttackLogic();
				}
			}
		}
	}

	//执行攻击逻辑
	public executeAttackLogic() {
		let skfId = this.current_fight_data._skf.skillInfluenceId;
		let skfData = ConfigDB.loadConfig("skill_influence_txt", skfId);
		this.dragonNode.mydata.skfData = skfData;

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
	public onChangeActionCallback(thisObj, dragonNode, name: string) {
		// HLog.log("FightRole 开始执行动作 " +  thisObj._roleCamp + "," +  thisObj._info._pos, name);
		//普通攻击
		if (name == Display.DragonAnimationNames[DRAGON_ANIMAE_INDEX.animation_skill_attacking]) {
			dragonNode.mydata._nextAction = DRAGON_ANIMAE_INDEX.animation_standby;
			thisObj.executeAttacking();
		}
	}

	//显示攻击光效
	public executeAttacking() {
		this.executeAttackInfluence();
	}

	//显示攻击光效1
	public executeAttackInfluence() {
		this.executeEffectSkilling1();
	}

	//显示攻击光效2
	public executeEffectSkilling1() {
		let effectId = (this.dragonNode.mydata.skfData as SkillInfluence).posteriorLightingEffectId;
		if (effectId >= 0) {
			let attackEffect: any = this.createEffect(effectId);
			attackEffect.x = this.x;
			attackEffect.y = this.y;
			this.parent.addChild(attackEffect);
		}
		
	}

	//执行被攻击的逻辑
	public executeByAttackLogic() {

	}

	//创建打击光效
	public createEffect(effectId: number) {
		let effectNode: any = Display.newEffectById(effectId);
		Display.initArmature(effectNode, Display.effectAnimations, this);
		effectNode.mydata.loopTimes = 1;
		effectNode.mydata._completeCallback = this.onEffectAnimCompleteCallback;
		effectNode.mydata._eventCallback = this.onEffectAnimEventCallback;
		effectNode.mydata.playWithIndex(0);
		return effectNode;
	}

	// 攻击光效播完回调 executeEffectSkilling1Over->executeEffectSkillingOverEx
	public onEffectAnimCompleteCallback(thisObj, dragonNode, name: string) {
		thisObj.checkAttackEnd();
	}

	//攻击光效事件回调
	public onEffectAnimEventCallback(thisObj, dragonNode, event: dragonBones.EgretEvent) {
		if (event.eventObject.data && event.eventObject.data.strings && event.eventObject.data.strings.length) {
			HLog.log("onEffectAnimEventCallback: ", event.eventObject.data.strings[0]);
		}
	}

	//攻击光效播完
	public executeEffectSkillingOverEx() {

	}

	//检查攻击结束
	public checkAttackEnd() {
		//删除第一个元素
		this.fight_cacher_pool.splice(0);
	}
}