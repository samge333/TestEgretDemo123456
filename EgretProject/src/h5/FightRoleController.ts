class FightRoleController {
	public constructor() {
	}

	byAttackTargetTag = 0;
	//我方角色列表
	_hero_formation_ex: Array<FightRole> = [];
	//地方角色列表
	_master_formation_ex: Array<FightRole> = [];
	//第几波
	fightIndex = 0;

	public changeToNextAttackRole() {
		let role = this._hero_formation_ex[0];
		this.qteAddAttackRole(role);
	}

	public qteAddAttackRole(selectRole: FightRole) {
		let data = this.getFightData(selectRole, 1);
	}

	public getFightData(fightRole: FightRole, grade: number) {
		let attData = {};
    	let resultBuffer = {};

		//我方
		if (fightRole) {
			let attackObj = ED.data.fightModule.getAppointFightObject(0, fightRole._info._pos);
			if (attackObj == null) {
				return null
			}

			ED.data.fightModule.setByAttackTargetTag(this.byAttackTargetTag);

			ED.data.fightModule.fightObjectAttack(attackObj, resultBuffer);

			let jsonStr = JSON.stringify(resultBuffer);
			ED.parse_environment_fight_role_round_attack_data(jsonStr, attData);
		}
		//敌方
		else {

		}
	}

	//进入下一场战斗
	public nextBattle() {
		this.initHero();
		this.initMaster();

		this.changeToNextAttackRole();
	}

	public initHero() {
		for (let i = 0; i < 6; i++) {
			let heroData = ED.data.battleData._heros[i + 1];
			if (heroData) {
				let role = new FightRole;
				role.init(heroData, 0);
				this._hero_formation_ex.push(role);
			}
		}
	}

	public initMaster() {
		for (let i = 0; i < 6; i++) {
			let masterData = ED.data.battleData._armys[this.fightIndex]._data[i + 1];
			if (masterData) {
				let role = new FightRole;
				role.init(masterData, 1);
				this._master_formation_ex.push(role);
			}
		}
	}

	// public 
}