class FightRoleController {
	public constructor() {
	}

	byAttackTargetTag = 0;

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
		
	}

	public initHero() {

	}

	public initMaster() {
		
	}
}