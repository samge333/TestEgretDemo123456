class FightRoleController extends eui.Component {
	public constructor() {
		super();
		this.skinName = "resource/exml/test1.exml";
		
		this.eventListen();
		this.init();
	}

	byAttackTargetTag = 1;
	//我方角色列表
	_hero_formation_ex: Array<FightRole> = [];
	//地方角色列表
	_master_formation_ex: Array<FightRole> = [];
	//第几波
	fightIndex = 0;

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
			let rect = posHero[i];
			if (rect) {
				this.hero_slots[i + 1] = rect;
			}
		}

		for (let i = 0; i < 6; i++) {
			let rect = posMaster[i];
			if (rect) {
				this.master_slots[i + 1] = rect;
			}
		}
	}

	public changeToNextAttackRole() {
		let role = this._hero_formation_ex[0];
		this.qteAddAttackRole(role);
	}

	public qteAddAttackRole(selectRole: FightRole) {
		let data = this.getFightData(selectRole, 1);
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

		}

		return resultBuffer;
	}

	//进入下一场战斗
	public nextBattle() {
		HLog.log("进入下一场");

		this.initHero();
		this.initMaster();
		this.moveToScene();

		this.changeToNextAttackRole();
	}

	//生成我方FightRole
	public initHero() {
		for (let k in this.hero_slots) {
			let v = this.hero_slots[k];
			let heroData = ED.data.battleData._heros[k];
			if (heroData) {
				let role = new FightRole;
				role.init(heroData, 0, v);
				v.addChild(role);
				this._hero_formation_ex.push(role);
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
				role.init(masterData, 1, v);
				v.addChild(role);
				this._master_formation_ex.push(role);
			}
		}
	}

	//入场
	public moveToScene() {
		let offsetInfo = [
			[0, 200, 0, 0, 0, 0],
			[0, 300, 0, 0, 0, 0],
		];

		for (let i = 0; i < this._hero_formation_ex.length; i++) {
			let role = this._hero_formation_ex[i];
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

		for (let i = 0; i < this._master_formation_ex.length; i++) {
			let role = this._master_formation_ex[i];
			if (role) {
				let offsetX = offsetInfo[1][role._info._pos - 1];
				role.x = 0 + offsetX;
				let actionIndex = DRAGON_ANIMAE_INDEX.animation_move;
				Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
				egret.Tween.get(role).to({x: 0}, 1500).call(function() {
					let actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
					Display.animationChangeToAction(role.dragonNode, actionIndex, actionIndex);
				});;
			}		
		}
	} 

	//开始一下波战斗
	public nextRoundFight() {
		// HEvent.dispatch(EvtName.QteCtrlNextAttackRole);

		//自动战斗的情况下
		let role = this._hero_formation_ex[0];
		this.qteAddAttackRole(role);
	}

	// public onRoleCtrlNextAttackRole(param) {
	// 	this.qteAddAttackRole();
	// }

}