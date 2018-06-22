class FightRoleController extends eui.Component {
	public constructor() {
		super();
		this.skinName = "resource/exml/test1.exml";
		
		this.eventListen();
		this.init();
	}

	byAttackTargetTag = 1;
	//我方角色列表
	_hero_formation_arr: Array<FightRole> = [];
	//我方带位置表
	_hero_formation_pos: {[key: number]: FightRole} = {};
	//敌方角色列表
	_master_formation_arr: Array<FightRole> = [];
	//敌方带位置表
	_master_formation_pos: {[key: number]: FightRole} = {};
	//第几波
	fightIndex = 0;
	//敌方的攻击列表，依次发起攻击
	attack_list: Array<FightRole> = [];

	//位置节点列表
	hero_slots: {[key: number]: eui.Rect} = {};
	master_slots: {[key: number]: eui.Rect} = {};

	//exml
	pos01: eui.Rect = null;
	pos02: eui.Rect = null;
	pos03: eui.Rect = null;
	pos04: eui.Rect = null;
	pos05: eui.Rect = null;
	pos06: eui.Rect = null;
	pos11: eui.Rect = null;
	pos12: eui.Rect = null;
	pos13: eui.Rect = null;
	pos14: eui.Rect = null;
	pos15: eui.Rect = null;
	pos16: eui.Rect = null;

	public onCreationComplete() {
		this.width = this.parent.width;
		this.height = this.parent.height;
	}

	public eventListen() {
		this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
		// HEvent.listener(EvtName.RoleCtrlNextAttackRole, this.onRoleCtrlNextAttackRole);
		
	}

	public init() {

		//获取位置节点
		let posHero = [this.pos01, this.pos02, this.pos03, this.pos04, this.pos05, this.pos06];
		let posMaster = [this.pos11, this.pos12, this.pos13, this.pos14, this.pos15, this.pos16];

		for (let i = 0; i < 6; i++) {
			let rect: any = posHero[i];
			if (rect) {
				rect.initX = rect.x;
				rect.initY = rect.y;
				this.hero_slots[i + 1] = rect;
			}
		}

		for (let i = 0; i < 6; i++) {
			let rect: any = posMaster[i];
			if (rect) {
				rect.initX = rect.x;
				rect.initY = rect.y;
				this.master_slots[i + 1] = rect;
			}
		}
	}

	public qteAddAttackRole(selectRole: FightRole) {
		let data = this.getFightData(selectRole, 1);
		if (data) {
			this.executeCurrentSelectRoleFightData(data);
		}
	}

	//执行指定对象战斗数据attData，然后给到指定的角色fightRole的fight_cacher_pool
	public executeCurrentSelectRoleFightData(data) {
		// let fightRole: FightRole = null;
		// if (data.attacker == 0) {
		// 	fightRole = this._hero_formation_pos[data.attackerPos];
		// } else {
		// 	fightRole = this._hero_formation_pos[data.attackerPos];
		// }

		// fightRole.attackListener();

		//将战斗数据中的 技能效用数据 给到fightRole
		for (let i = 0; i < data.skillInfluences.length; i++) {
			//获取第i个技能效用
			let skf = data.skillInfluences[i];
			//获取出手的fightRole
			let attackRole: FightRole = null;
			if (skf.attackerType == 0) {
				attackRole = this._hero_formation_pos[skf.attackerPos];
			} else {
				attackRole = this._master_formation_pos[skf.attackerPos];
			}

			//受到效用影响的的fightRole
			let defenderList: {[key: string]: FightRole} = {};

			for (let j = 0; j < skf._defenders.length; j++) {
				let _def = skf._defenders[j];
				//获取受影响的fightRole
				let defendRole: FightRole = null;
				if (_def.defender == 0) {
					defendRole = this._hero_formation_pos[_def.defenderPos];
				} else {
					defendRole = this._master_formation_pos[_def.defenderPos];
				}

				defenderList[_def.defender + "t" + _def.defenderPos] = defendRole;
			}

			if (skf._defenders.length > 0) {
				//打开开关，fightRole会自行处理自己接收到的效用数据
				attackRole.run_fight_listener = true;
				attackRole.fight_cacher_pool.push({
					_state: 0,						//为0表示是发起攻击的fighRole
					_attData: data,					//攻击数据
					_skf: skf,						//单个技能效用
					_defenderList: defenderList		//承受技能的fightRole列表
				});

				attackRole.attackListener();
			}

		}

	}

	public getFightData(fightRole: FightRole, grade: number) {
    	let resultBuffer = {};

		//我方
		if (fightRole) {
			let attackObj = ED.data.fightModule.getAppointFightObject(0, fightRole._info._pos);
			if (attackObj == null) {
				return null
			}

			ED.data.fightModule.setByAttackTargetTag(this.byAttackTargetTag);

			ED.data.fightModule.fightObjectAttack(attackObj, resultBuffer);

			HLog.log("获取这个BattleObject的攻击数据", resultBuffer);

			let jsonStr = JSON.stringify(resultBuffer);
			ED.parse_environment_fight_role_round_attack_data(jsonStr);
		}
		//敌方
		else {
			ED.data.fightModule.rountdFight(resultBuffer);
		}

		return resultBuffer;
	}

	//进入下一场战斗
	public nextBattle() {
		HLog.log("进入下一场");

		this.initHero();
		this.initMaster();
		this.moveToScene();

		// this.changeToNextAttackRole();
	}

	//生成我方FightRole
	public initHero() {
		for (let k in this.hero_slots) {
			let v = this.hero_slots[k];
			let heroData = ED.data.battleData._heros[k];
			if (heroData) {
				let role = new FightRole;
				role.init(heroData, 0, v, this);
				v.addChild(role);
				this._hero_formation_arr.push(role);
				this._hero_formation_pos[k] = role;
			}
		}
	}

	//生成敌方FightRole
	public initMaster() {
		for (let k in this.master_slots) {
			let v = this.master_slots[k];
			let masterData = ED.data.battleData._armys[this.fightIndex]._data[k];
			if (masterData) {
				let role = new FightRole;
				role.init(masterData, 1, v, this);
				v.addChild(role);
				this._master_formation_arr.push(role);
				this._master_formation_pos[k] = role;
			}
		}
	}

	//入场
	public moveToScene() {
		let offsetInfo = [
			[0, 200, 0, 0, 0, 0],
			[0, 300, 0, 0, 0, 0],
		];

		for (let i = 0; i < this._hero_formation_arr.length; i++) {
			let role = this._hero_formation_arr[i];
			if (role) {
				let offsetX = offsetInfo[0][role._info._pos - 1];
				role.x = 0 - offsetX;
				let actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
				Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
				egret.Tween.get(role).to({x: 0}, 1500).call(function() {
					let actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
					Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);

					this.nextRoundFight();
				}, this);
			}
		}

		for (let i = 0; i < this._master_formation_arr.length; i++) {
			let role = this._master_formation_arr[i];
			if (role) {
				let offsetX = offsetInfo[1][role._info._pos - 1];
				role.x = 0 + offsetX;
				let actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
				Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
				egret.Tween.get(role).to({x: 0}, 1500).call(function() {
					let actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
					Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
				}, this);
			}		
		}
	} 

	//开始一下回合战斗，我方打完，敌方打完，算一个回合，下一回合我方出手
	public nextRoundFight() {
		// HEvent.dispatch(EvtName.QteCtrlNextAttackRole);

		//自动战斗的情况下
		let role = this._hero_formation_arr[0];
		this.qteAddAttackRole(role);
	}

	// public onRoleCtrlNextAttackRole(param) {
	// 	this.qteAddAttackRole();
	// }

	//获取敌方所有人的攻击数据，然后生成攻击fightRole列表，赋值给fightRole去处理
	public executeCurrentRountFightData() {
		let roundData: any = this.getFightData(null, 0);
		HLog.log("获取敌方所有的攻击数据", roundData);

		//循环敌方所有人，生成fightRole列表
		for (let i = 0; i < roundData.data.length; i++) {
			let attData = roundData.data[i];

			let fightRole: any;
			if (attData.attacker == 0) {
				fightRole = this._hero_formation_pos[attData.attackerPos];
			} else {
				fightRole = this._master_formation_pos[attData.attackerPos];
			}

			//给没个角色他当前的攻击数据
			fightRole.attData = attData;
			this.attack_list.push(fightRole);
		}

		this.changeToNextAttackRole();
	}

	//切换到本阵营的下一个攻击角色，本阵营
	public changeToNextAttackRole() {
		// let role = this._hero_formation_arr[0];
		// this.qteAddAttackRole(role);

		let currentRole: any = this.attack_list[0];
		if (currentRole != null) {
			this.executeCurrentSelectRoleFightData(currentRole.attData);
		}
	}

	//检查是否可以开始下一回合战斗
	public checkNextRoundFight() {
		let heroAttackOver = true;
		let masterAttackOver = true;

		for (let i = 0; i < this._hero_formation_arr.length; i++) {
			let hero = this._hero_formation_arr[i];
			if (hero && hero.fight_cacher_pool.length > 0) {
				heroAttackOver = false;
			}
		}

		for (let i = 0; i < this._master_formation_arr.length; i++) {
			let master = this._master_formation_arr[i];
			if (master && master.fight_cacher_pool.length > 0) {
				masterAttackOver = false;
			}
		}

		// if (this.attack_list.length > 0) {
		// 	masterAttackOver = false;
		// }

		if (heroAttackOver == true && masterAttackOver == true) {
			this.nextRoundFight();
		}

	}
}