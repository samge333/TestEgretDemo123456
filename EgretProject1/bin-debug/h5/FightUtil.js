var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightUtil = (function () {
    function FightUtil() {
    }
    //计算移动位置
    FightUtil.computeMoveCoordinate = function (currentAttackerCoordinate, skillReleasePosion, byAttackObjects) {
        if (skillReleasePosion == SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_SPOT) {
            return SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_SPOT;
        }
        else if (skillReleasePosion == SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_CENTRE_SCREEN) {
            return SKILL_RELEASE_POSION.SKILL_RELEASE_POSION_CENTRE_SCREEN;
        }
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
    };
    FightUtil.computeEffectCoordinate = function (currentAttackerCoordinate, skillInfluence, battleObject, byAttackObjects, byAttackTargetTag) {
        var influenceRange = skillInfluence.influenceRange;
        var headCoordinate = -1;
        var backCoordinate = -1;
        //找出打单个目标的位置
        if (byAttackObjects[1] && byAttackObjects[1].isDead == false && byAttackObjects[1].revived == false) {
            headCoordinate = 1;
        }
        else if (byAttackObjects[2] && byAttackObjects[2].isDead == false && byAttackObjects[2].revived == false) {
            headCoordinate = 2;
        }
        else if (byAttackObjects[3] && byAttackObjects[3].isDead == false && byAttackObjects[3].revived == false) {
            headCoordinate = 3;
        }
        else if (byAttackObjects[4] && byAttackObjects[4].isDead == false && byAttackObjects[4].revived == false) {
            headCoordinate = 4;
        }
        else if (byAttackObjects[5] && byAttackObjects[5].isDead == false && byAttackObjects[5].revived == false) {
            headCoordinate = 5;
        }
        else if (byAttackObjects[6] && byAttackObjects[6].isDead == false && byAttackObjects[6].revived == false) {
            headCoordinate = 6;
        }
        if (byAttackTargetTag && byAttackTargetTag > 0) {
            if (byAttackObjects[byAttackTargetTag] && byAttackObjects[byAttackTargetTag].isDead == false && byAttackObjects[byAttackTargetTag].revived == false) {
                headCoordinate = byAttackTargetTag;
            }
        }
        var byEffectCoordinateList = [];
        if (influenceRange == EFFECT_RANGE.EFFECT_RANGE_SINGLE) {
            byEffectCoordinateList.push(headCoordinate);
        }
        return byEffectCoordinateList;
    };
    //计算攻击位置类型、目标位置序列
    // _skf.attPosType = npos(list) -- 攻击位置类型
    // _skf.attTarList = zstring.split(npos(list), ",") -- 目标位置序列
    FightUtil.computeEndureDirection = function (currentAttackerCoordinate, skillInfluence, byAttackObjects) {
        if (skillInfluence.influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE) {
            if (skillInfluence.influenceRange == EFFECT_RANGE.EFFECT_RANGE_HORIZONAL) {
                if ((byAttackObjects[0] && byAttackObjects[0].revived == false)
                    || (byAttackObjects[1] && byAttackObjects[1].revived == false)
                    || (byAttackObjects[2] && byAttackObjects[2].revived == false)) {
                    return ["3", "1,2,3"];
                }
                else {
                    return ["4", "4,5,6"];
                }
            }
            else if (skillInfluence.influenceRange == EFFECT_RANGE.EFFECT_RANGE_HORIZONAL_BACK) {
                if ((byAttackObjects[3] && byAttackObjects[3].revived == false)
                    || (byAttackObjects[4] && byAttackObjects[4].revived == false)
                    || (byAttackObjects[5] && byAttackObjects[5].revived == false)) {
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
    };
    //公式1
    FightUtil.computeCommonDamage = function (skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule) {
        byAttackObject.subHealthPoint(689.00689);
        effectArray[1] = 689.00689;
    };
    FightUtil.computeSkillEffect = function (battleSkill, skillMould, skillInfluence, attackObject, byAttackObject, userInfo, fightModule) {
        //0不用，只是为了索引加1，1影响值，2影响回合，3承受状态，4清除buff
        var effectArray = [-1, 0, 0, -1, 0];
        var formulaInfo = battleSkill.formulaInfo;
        //1
        if (formulaInfo == FORMULA_INFO.FORMULA_INFO_COMMON_DAMAGE) {
            FightUtil.computeCommonDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule);
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SPECIAL_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CURE_HP) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CURE_SP) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DAMAGE_SP) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SP_DISUP) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DIZZY) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_POSION) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_Firing) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_Explode) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_PARALYSIS) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_NO_SP) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_RETAIN) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_LESSEN_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_EVASION_SURELY) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DRAINS) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_BEAR_HP) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_BLIND) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CRIPPLE) {
        }
        else if (formulaInfo == 20) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_ATTACK) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_ATTACK) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_DEFENCE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_DEFENCE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_SELF_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_SELF_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_CRITICAL) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_SUB_CRITICAL) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_HIT) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_DODGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_ENDURANCE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_CLEAR_BUFF) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_KILL) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_FIXED_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_FORTHWITH) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_REANA_ATTACK_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_RETAIN_INTENSION) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_LESSEN_RETAIN_PERCENT) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_NORMAL_SKILL_DAMAGE) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_DAMAGE_REBOUND) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_ADD_NORMAL_SKILL_ODDS) {
        }
        else if (formulaInfo == FORMULA_INFO.FORMULA_INFO_FIRING_DAMAGE_UPPER_LIMIT) {
        }
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
    };
    return FightUtil;
}());
__reflect(FightUtil.prototype, "FightUtil");
//# sourceMappingURL=FightUtil.js.map