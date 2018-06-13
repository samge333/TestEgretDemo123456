class FightUtil {
	public constructor() {
	}

	//计算移动位置
	public static computeMoveCoordinate(currentAttackerCoordinate: number, skillReleasePosion: number, byAttackObjects: Array<BattleObject>) {
		if (skillReleasePosion == SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_SPOT) {
			return SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_SPOT;
		}
		else if (skillReleasePosion == SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_CENTRE_SCREEN) {
			return SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_CENTRE_SCREEN;
		}
		//3移动到承受者前方(前排优先)
		else if (skillReleasePosion == SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_FRONT_FORWARD) {
			if (currentAttackerCoordinate == 1 || currentAttackerCoordinate == 4) {
				if (byAttackObjects[0] && byAttackObjects[0].isDead == false && byAttackObjects[0].revived == true) {
					return 2;
				}
				else if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == true) {
					return 3;
				}
				else if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == true) {
					return 4;
				}
				else if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == true) {
					return 5;
				}
				else if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == true) {
					return 6;
				}
				else if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == true) {
					return 7;
				}
			}
			else if (currentAttackerCoordinate == 2 || currentAttackerCoordinate == 5) {
				if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == true) {
					return 3;
				}
				else if (byAttackObjects[0] && byAttackObjects[0].isDead == false && byAttackObjects[0].revived == true) {
					return 2;
				}
				else if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == true) {
					return 4;
				}
				else if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == true) {
					return 6;
				}
				else if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == true) {
					return 5;
				}
				else if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == true) {
					return 7;
				}
			}
			else if (currentAttackerCoordinate == 3 || currentAttackerCoordinate == 6) {
				if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == true) {
					return 4;
				}
				else if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == true) {
					return 3;
				}
				else if (byAttackObjects[0] && byAttackObjects[0].isDead == false && byAttackObjects[0].revived == true) {
					return 2;
				}
				else if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == true) {
					return 7;
				}
				else if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == true) {
					return 6;
				}
				else if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == true) {
					return 5;
				}
			}
		}
		//4移动到承受者前方(后排优先)
		else if (skillReleasePosion == SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_FRONT_BACKWARD) {
			if (currentAttackerCoordinate == 1 || currentAttackerCoordinate == 4) {
				if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == true) {
					return 5;
				}
				else if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == true) {
					return 6;
				}
				else if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == true) {
					return 7;
				}
				else if (byAttackObjects[0] && byAttackObjects[0].isDead == false && byAttackObjects[0].revived == true) {
					return 2;
				}
				else if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == true) {
					return 3;
				}
				else if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == true) {
					return 4;
				}
			}
			else if (currentAttackerCoordinate == 2 || currentAttackerCoordinate == 5) {
				if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == true) {
					return 6;
				}
				else if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == true) {
					return 5;
				}
				else if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == true) {
					return 7;
				}
				else if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == true) {
					return 3;
				}
				else if (byAttackObjects[0] && byAttackObjects[0].isDead == false && byAttackObjects[0].revived == true) {
					return 2;
				}
				else if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == true) {
					return 4;
				}
			}
			else if (currentAttackerCoordinate == 3 || currentAttackerCoordinate == 6) {
				if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == true) {
					return 7;
				}
				else if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == true) {
					return 6;
				}
				else if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == true) {
					return 5;
				}
				else if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == true) {
					return 4;
				}
				else if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == true) {
					return 3;
				}
				else if (byAttackObjects[0] && byAttackObjects[0].isDead == false && byAttackObjects[0].revived == true) {
					return 2;
				}
			}
		}
		return skillReleasePosion;
	}

	public static computeEffectCoordinate(currentAttackerCoordinate: number, skillInfluence: SkillInfluence, battleObject: BattleObject, byAttackObjects: BattleObject, byAttackTargetTag: number): any {

	}

	//计算攻击位置类型、目标位置序列
	// _skf.attPosType = npos(list) -- 攻击位置类型
	// _skf.attTarList = zstring.split(npos(list), ",") -- 目标位置序列
	public static computeEndureDirection(currentAttackerCoordinate: number, skillInfluence: SkillInfluence, byAttackObjects: Array<BattleObject>) {
		if (skillInfluence.influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE) {
			if (skillInfluence.influenceRange == EFFECT_RANGE.EFFECT_RANGE_HORIZONAL) {
				if ( (byAttackObjects[0] && byAttackObjects[0].revived == false)
					|| (byAttackObjects[1] && byAttackObjects[1].revived == false)
					|| (byAttackObjects[2] && byAttackObjects[2].revived == false) ) {
					return ["3", "1,2,3"];
				}
				else {
					return ["4", "4,5,6"];
				}
			}
			else if (skillInfluence.influenceRange == EFFECT_RANGE.EFFECT_RANGE_HORIZONAL_BACK) {
				if ( (byAttackObjects[3] && byAttackObjects[3].revived == false)
					|| (byAttackObjects[4] && byAttackObjects[4].revived == false)
					|| (byAttackObjects[5] && byAttackObjects[5].revived == false) ) {
					return ["4", "4,5,6"];
				}
				else {
					return ["3", "1,2,3"];
				}
			}
			else if (skillInfluence.influenceRange == EFFECT_RANGE.EFFECT_RANGE_VERICAL) {
				if (currentAttackerCoordinate == 1 || currentAttackerCoordinate == 4) {
					if (byAttackObjects[0] && byAttackObjects[0].revived == false) {
						return ["0", "1,4"];
					}
					else if (byAttackObjects[1] && byAttackObjects[1].revived == false) {
						return ["1", "2,5"];
					}
					else if (byAttackObjects[2] && byAttackObjects[2].revived == false) {
						return ["2", "3,6"];
					}
					else if (byAttackObjects[3] && byAttackObjects[3].revived == false) {
						return ["0", "1,4"];
					}
					else if (byAttackObjects[4] && byAttackObjects[4].revived == false) {
						return ["1", "2,5"];
					}
					else if (byAttackObjects[5] && byAttackObjects[5].revived == false) {
						return ["2", "3,6"];
					}
				} 
				else if (currentAttackerCoordinate == 2 || currentAttackerCoordinate == 5) {
					if (byAttackObjects[1] && byAttackObjects[1].revived == false) {
						return ["1", "2,5"];
					}
					else if (byAttackObjects[0] && byAttackObjects[0].revived == false) {
						return ["0", "1,4"];
					}
					else if (byAttackObjects[2] && byAttackObjects[2].revived == false) {
						return ["2", "3,6"];
					}
					else if (byAttackObjects[4] && byAttackObjects[4].revived == false) {
						return ["1", "2,5"];
					}
					else if (byAttackObjects[3] && byAttackObjects[3].revived == false) {
						return ["0", "1,4"];
					}
					else if (byAttackObjects[5] && byAttackObjects[5].revived == false) {
						return ["2", "3,6"];
					}
				}
				else if (currentAttackerCoordinate == 3 || currentAttackerCoordinate == 6) {
					if (byAttackObjects[2] && byAttackObjects[2].revived == false) {
						return ["2", "3,6"];
					}
					else if (byAttackObjects[1] && byAttackObjects[1].revived == false) {
						return ["1", "2,5"];
					}
					else if (byAttackObjects[0] && byAttackObjects[0].revived == false) {
						return ["0", "1,4"];
					}
					else if (byAttackObjects[5] && byAttackObjects[5].revived == false) {
						return ["2", "3,6"];
					}
					else if (byAttackObjects[4] && byAttackObjects[4].revived == false) {
						return ["1", "2,5"];
					}
					else if (byAttackObjects[3] && byAttackObjects[3].revived == false) {
						return ["0", "1,4"];
					}
				}
			}
		}
		return ["-1", "-1"];
	}

	//公式1
	public computeCommonDamage(skillMould: SkillMould, skillInfluence: SkillInfluence, attackObject: BattleObject, byAttackObject: BattleObject, effectArray, battleSkill: BattleSkill, userInfo, fightModule: FightModule, effectBuffer) {
		effectArray[1] = 1000;
	}

	public computeSkillEffect(battleSkill: BattleSkill, skillMould: SkillMould, skillInfluence: SkillInfluence, attackObject: BattleObject, byAttackObject: BattleObject, userInfo, fightModule: FightModule, effectBuffer) {
		//0不用，只是为了索引加1，1影响值，2影响回合，3承受状态，4清除buff
		let effectArray = [-1, 0, 0, -1, 0];
		let formulaInfo = battleSkill.formulaInfo;

		//1
		if (formulaInfo == FORMULA_INFO.FORMULA_INFO_COMMON_DAMAGE) {
			this.computeCommonDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer);
		}
		//2
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SPECIAL_DAMAGE) {

		}
		//3
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CURE_HP) {

		}
		//4
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CURE_SP) {

		}
		//5
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DAMAGE_SP) {

		}
		//6
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SP_DISUP) {

		}
		//7
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DIZZY) {

		}
		//8
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_POSION) {

		}
		//9
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_Firing) {

		}
		//10
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_Explode) {

		}
		//11
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_PARALYSIS) {

		}
		//12
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_NO_SP) {

		}
		//13
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_RETAIN) {

		}
		//14
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_LESSEN_DAMAGE) {

		}
		//15
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_EVASION_SURELY) {

		}
		//16
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DRAINS) {

		}
		//17
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_BEAR_HP) {

		}
		//18
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_BLIND) {

		}
		//19
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CRIPPLE) {

		}
		//20没用到
		else if (formulaInfo == 20) {

		}
		//21
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_ATTACK) {

		}
		//22
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_ATTACK) {

		}
		//23
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_DEFENCE) {

		}
		//24
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_DEFENCE) {

		}
		//25
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_SELF_DAMAGE) {

		}
		//26
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_SELF_DAMAGE) {

		}
		//27
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_CRITICAL) {

		}
		//28
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_CRITICAL) {

		}
		//29
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_HIT) {

		}
		//30
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_DODGE) {

		}
		//31
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_ENDURANCE) {

		}
		//32
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CLEAR_BUFF) {

		}
		//33
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_DAMAGE) {

		}
		//34
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_KILL) {

		}
		//35
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_FIXED_DAMAGE) {

		}
		//36
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_FORTHWITH) {

		}
		//37
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_REANA_ATTACK_DAMAGE) {

		}
		//38
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_RETAIN_INTENSION) {

		}
		//39
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_LESSEN_RETAIN_PERCENT) {

		}
		//40
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_NORMAL_SKILL_DAMAGE) {

		}
		//41
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DAMAGE_REBOUND) {

		}
		//42
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_NORMAL_SKILL_ODDS) {

		}
		//43
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_FIRING_DAMAGE_UPPER_LIMIT) {

		}
		//44
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_RETAIN_BREAK_ODDS) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_45) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_46) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_47) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_48) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_49) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_50) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_51) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_52) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_53) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_54) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_55) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_56) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_57) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_58) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_59) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_60) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_61) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_62) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_63) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_64) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_65) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_66) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_67) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_68) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_69) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_70) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_71) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_72) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_73) {

		}
		else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_TYPE_74) {

		}

		return effectArray;
	}
}