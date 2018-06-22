class FightRole extends eui.Component {
	public constructor() {
		super();
		
		this.eventListen();
	}

	_info: any = {};
	_roleCamp = 0;
	dragonNode = null;
	//父节点
	parentNode: any = null;
	//攻击时的位移坐标
	moveByPosition = {x: 0, y: 0};
	//角色受到的技能效用列表
	fight_cacher_pool = [];
	//是否开启监听并处理自己受到的效用影响
	run_fight_listener = false;
	//当前正在处理的效用影响
	current_fight_data: any = {};
	//FightRoleController的引用
	roleCtrl: FightRoleController;

	public eventListen() {
		this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
		this.addEventListener(egret.Event.ENTER_FRAME, this.update, this);
	}

	public onCreationComplete() {
		HLog.log("FightRole创建成功");
	}

	public update() {
		
	}

	public init(data: any, roleCamp: number, parentNode: eui.Rect, roleCtrl: FightRoleController) {
		HLog.log("创建角色" + roleCamp, data);
		this._info = data;
		this._roleCamp = roleCamp;
		this.parentNode = parentNode;
		this.roleCtrl = roleCtrl;
		
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

		Display.initArmature(this.dragonNode, Display.DragonAnimationNames, this);
		this.dragonNode.mydata._startCallback = this.onChangeActionCallback;
		// this.dragonNode.mydata.fightRole = this;
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
		if (this._roleCamp == 0) {
			this.moveByPosition.x = 200;
		} else {
			this.moveByPosition.x = -200;
		}
		
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

	//骨骼动画开始的回调
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

	//创建打击光效
	public createEffect(effectId: number) {
		let effectNode: any = Display.newEffectById(effectId);
		Display.initArmature(effectNode, Display.effectAnimations, this);
		effectNode.mydata.loopTimes = 1;
		effectNode.mydata._completeCallback = this.onEffectAnimCompleteCallback;
		effectNode.mydata._eventCallback = this.onEffectAnimEventCallback;
		// effectNode.mydata.fightRole = this;
		effectNode.mydata.playWithIndex(0);
		return effectNode;
	}

	//检查攻击光效事件字符串是否包含指定事件名
	public checkFrameEvent(arr: Array<string>, event: string) {
		for (let i = 0; i < arr.length; i++) {
			if (arr[i] == event) {
				return true;
			}
		}
		return false;
	}

	// 攻击光效播完回调 executeEffectSkilling1Over->executeEffectSkillingOverEx
	public onEffectAnimCompleteCallback(thisObj, dragonNode, name: string) {
		thisObj.checkAttackEnd();
	}

	//攻击光效事件回调
	public onEffectAnimEventCallback(thisObj, dragonNode, event: dragonBones.EgretEvent) {
		if (event.eventObject.data && event.eventObject.data.strings && event.eventObject.data.strings.length) {
			// HLog.log("onEffectAnimEventCallback: ", event.eventObject.data.strings[0]);
			let strings = event.eventObject.data.strings[0].split("_");

			if (thisObj.checkFrameEvent(strings, "hurt") == true) {

			}

			let defenderList = thisObj.current_fight_data._defenderList;
			let skf = thisObj.current_fight_data._skf;
			for (let i = 0; i < skf._defenders.length; i++) {
				let def = skf._defenders[i];
				//找到受效用影响的fightRole
				let fightRole = (defenderList[def.defender + "t" + def.defenderPos]) as FightRole;
				//承受到的影响
				fightRole.current_fight_data._def = def;
				fightRole.executeByAttackLogic(strings, thisObj);
			}

			if (thisObj.checkFrameEvent(strings, "after") == true) {

			}

			if (thisObj.checkFrameEvent(strings, "next") == true) {
				// //切换到本阵营的下一个角色发起攻击，或者检查回合是否完了，如果回合完了，就轮到对方发起攻击
				// thisObj.roleCtrl.changeToNextAttackRole();
				// thisObj.roleCtrl.checkNextRoundFight();
			}
		}
	}

	//攻击光效播完
	public executeEffectSkillingOverEx() {

	}

	//检查攻击结束
	public checkAttackEnd() {
		//删除第一个元素
		this.fight_cacher_pool.splice(0, 1);

		this.moveEventEx();

		this.roleCtrl.executeCurrentRountFightData();
	}

	//执行被攻击的逻辑
	public executeByAttackLogic(eventStrings, attacker) {
		if (this.checkFrameEvent(eventStrings, "after") == true) {
			if (this.dragonNode.mydata._actionIndex != DRAGON_ANIMAE_INDEX.animation_normal_be_attaked) {
				if (attacker != null && attacker._roleCamp != this._roleCamp) {
					let actionIndex = DRAGON_ANIMAE_INDEX.animation_normal_be_attaked;
					let nextAction = DRAGON_ANIMAE_INDEX.animation_standby;
					Display.animationChangeToAction(this.dragonNode, actionIndex, nextAction);
				}
			}
		}

		if (this.checkFrameEvent(eventStrings, "next") == true) {

		}
	}

	//角色回位
	public moveEventEx() {
		let offsetX = this.parentNode.x - this.parentNode.initX;
		let offsetY = this.parentNode.y - this.parentNode.initY;

		//角色不在初始位置
		if (offsetX != 0 || offsetY != 0) {
			egret.Tween.get(this.parent).to({x: this.parentNode.initX}, 500).call(function() {
				
			}, this);
		}
	}



}