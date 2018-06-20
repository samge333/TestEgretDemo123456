var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var EnumDef = (function () {
    function EnumDef() {
    }
    return EnumDef;
}());
__reflect(EnumDef.prototype, "EnumDef");
//FightModule
var FightModuleEnum;
(function (FightModuleEnum) {
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_NORMAL"] = 0] = "FIGHT_TYPE_PVE_NORMAL";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_ELIT"] = 1] = "FIGHT_TYPE_PVE_ELIT";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_MONEY_TREE"] = 2] = "FIGHT_TYPE_PVE_MONEY_TREE";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_TREASURE_EXPERIENCE"] = 3] = "FIGHT_TYPE_PVE_TREASURE_EXPERIENCE";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_PANDA_EXPERIENCE"] = 4] = "FIGHT_TYPE_PVE_PANDA_EXPERIENCE";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_WORLD_BOSS"] = 5] = "FIGHT_TYPE_PVE_WORLD_BOSS";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_TRANS_TOWER"] = 6] = "FIGHT_TYPE_TRANS_TOWER";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_COUNTERPART"] = 7] = "FIGHT_TYPE_PVP_COUNTERPART";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_BATTLEGROUND"] = 8] = "FIGHT_TYPE_PVP_BATTLEGROUND";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_GREAT_SOLDIER"] = 9] = "FIGHT_TYPE_GREAT_SOLDIER";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_GRAB"] = 10] = "FIGHT_TYPE_PVP_GRAB";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_ARENA"] = 11] = "FIGHT_TYPE_PVP_ARENA";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_DUEL"] = 12] = "FIGHT_TYPE_PVP_DUEL";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_UNIO"] = 13] = "FIGHT_TYPE_PVP_UNIO";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_RESOURCE_MINE"] = 14] = "FIGHT_TYPE_PVP_RESOURCE_MINE";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_SPIRITE_PALACE"] = 15] = "FIGHT_TYPE_PVP_SPIRITE_PALACE";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVP_CROSS_SERVER"] = 16] = "FIGHT_TYPE_PVP_CROSS_SERVER";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_51"] = 51] = "FIGHT_TYPE_51";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_52"] = 52] = "FIGHT_TYPE_52";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_DAILY_INSTANCE"] = 101] = "FIGHT_TYPE_DAILY_INSTANCE";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_THREE_KING"] = 102] = "FIGHT_TYPE_PVE_THREE_KING";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_MANOR"] = 103] = "FIGHT_TYPE_PVE_MANOR";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_PVE_REBELARMY"] = 104] = "FIGHT_TYPE_PVE_REBELARMY";
    FightModuleEnum[FightModuleEnum["FIGHT_TYPE_GREAT_SOLDIER_B"] = 105] = "FIGHT_TYPE_GREAT_SOLDIER_B";
})(FightModuleEnum || (FightModuleEnum = {}));
//TalentConstant 天赋触发时机
var JUDGE_OPPORTUNITY;
(function (JUDGE_OPPORTUNITY) {
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_BY_ATTACK"] = 0] = "JUDGE_OPPORTUNITY_BY_ATTACK";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_ATTACK"] = 1] = "JUDGE_OPPORTUNITY_ATTACK";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_SELF_DEAD"] = 2] = "JUDGE_OPPORTUNITY_SELF_DEAD";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_OPPONENT_DEAD"] = 3] = "JUDGE_OPPORTUNITY_OPPONENT_DEAD";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_EMAMY_ATTACK"] = 4] = "JUDGE_OPPORTUNITY_EMAMY_ATTACK";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_OWER_ATTACK"] = 5] = "JUDGE_OPPORTUNITY_OWER_ATTACK";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_BATTLE_ROUND_START"] = 6] = "JUDGE_OPPORTUNITY_BATTLE_ROUND_START";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_CAMP_ROLE_DEATH"] = 7] = "JUDGE_OPPORTUNITY_CAMP_ROLE_DEATH";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE"] = 8] = "JUDGE_OPPORTUNITY_INIT_BATTLE_SCENE";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_ATTACK_ROUND_START"] = 9] = "JUDGE_OPPORTUNITY_ATTACK_ROUND_START";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_ATTACK_BEFORE"] = 10] = "JUDGE_OPPORTUNITY_ATTACK_BEFORE";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_OPPONENT_DEAD_GLOBAL"] = 11] = "JUDGE_OPPORTUNITY_OPPONENT_DEAD_GLOBAL";
    JUDGE_OPPORTUNITY[JUDGE_OPPORTUNITY["JUDGE_OPPORTUNITY_OPPONENT_FOR_ATTACK_BEFORE"] = 12] = "JUDGE_OPPORTUNITY_OPPONENT_FOR_ATTACK_BEFORE";
})(JUDGE_OPPORTUNITY || (JUDGE_OPPORTUNITY = {}));
//FightUtil 技能效用索引公式，技能效用表第8个字段，见表SkillInfluence
var FORMULA_INFO;
(function (FORMULA_INFO) {
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_COMMON_DAMAGE"] = 1] = "FORMULA_INFO_COMMON_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_SPECIAL_DAMAGE"] = 2] = "FORMULA_INFO_SPECIAL_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_CURE_HP"] = 3] = "FORMULA_INFO_CURE_HP";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_CURE_SP"] = 4] = "FORMULA_INFO_CURE_SP";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_DAMAGE_SP"] = 5] = "FORMULA_INFO_DAMAGE_SP";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_SP_DISUP"] = 6] = "FORMULA_INFO_SP_DISUP";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_DIZZY"] = 7] = "FORMULA_INFO_DIZZY";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_POSION"] = 8] = "FORMULA_INFO_POSION";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_Firing"] = 9] = "FORMULA_INFO_Firing";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_Explode"] = 10] = "FORMULA_INFO_Explode";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_PARALYSIS"] = 11] = "FORMULA_INFO_PARALYSIS";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_NO_SP"] = 12] = "FORMULA_INFO_NO_SP";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_RETAIN"] = 13] = "FORMULA_INFO_ADD_RETAIN";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_LESSEN_DAMAGE"] = 14] = "FORMULA_INFO_LESSEN_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_EVASION_SURELY"] = 15] = "FORMULA_INFO_EVASION_SURELY";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_DRAINS"] = 16] = "FORMULA_INFO_DRAINS";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_BEAR_HP"] = 17] = "FORMULA_INFO_BEAR_HP";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_BLIND"] = 18] = "FORMULA_INFO_BLIND";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_CRIPPLE"] = 19] = "FORMULA_INFO_CRIPPLE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_ATTACK"] = 21] = "FORMULA_INFO_ADD_ATTACK";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_SUB_ATTACK"] = 22] = "FORMULA_INFO_SUB_ATTACK";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_DEFENCE"] = 23] = "FORMULA_INFO_ADD_DEFENCE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_SUB_DEFENCE"] = 24] = "FORMULA_INFO_SUB_DEFENCE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_SELF_DAMAGE"] = 25] = "FORMULA_INFO_ADD_SELF_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_SUB_SELF_DAMAGE"] = 26] = "FORMULA_INFO_SUB_SELF_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_CRITICAL"] = 27] = "FORMULA_INFO_ADD_CRITICAL";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_SUB_CRITICAL"] = 28] = "FORMULA_INFO_SUB_CRITICAL";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_HIT"] = 29] = "FORMULA_INFO_ADD_HIT";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_DODGE"] = 30] = "FORMULA_INFO_ADD_DODGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_ENDURANCE"] = 31] = "FORMULA_INFO_ADD_ENDURANCE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_CLEAR_BUFF"] = 32] = "FORMULA_INFO_CLEAR_BUFF";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_DAMAGE"] = 33] = "FORMULA_INFO_ADD_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_KILL"] = 34] = "FORMULA_INFO_ADD_KILL";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_FIXED_DAMAGE"] = 35] = "FORMULA_INFO_FIXED_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_FORTHWITH"] = 36] = "FORMULA_INFO_FORTHWITH";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_REANA_ATTACK_DAMAGE"] = 37] = "FORMULA_INFO_REANA_ATTACK_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_RETAIN_INTENSION"] = 38] = "FORMULA_INFO_ADD_RETAIN_INTENSION";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_LESSEN_RETAIN_PERCENT"] = 39] = "FORMULA_INFO_LESSEN_RETAIN_PERCENT";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_NORMAL_SKILL_DAMAGE"] = 40] = "FORMULA_INFO_NORMAL_SKILL_DAMAGE";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_DAMAGE_REBOUND"] = 41] = "FORMULA_INFO_DAMAGE_REBOUND";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_NORMAL_SKILL_ODDS"] = 42] = "FORMULA_INFO_ADD_NORMAL_SKILL_ODDS";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_FIRING_DAMAGE_UPPER_LIMIT"] = 43] = "FORMULA_INFO_FIRING_DAMAGE_UPPER_LIMIT";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_ADD_RETAIN_BREAK_ODDS"] = 44] = "FORMULA_INFO_ADD_RETAIN_BREAK_ODDS";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_45"] = 45] = "FORMULA_INFO_TYPE_45";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_46"] = 46] = "FORMULA_INFO_TYPE_46";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_47"] = 47] = "FORMULA_INFO_TYPE_47";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_48"] = 48] = "FORMULA_INFO_TYPE_48";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_49"] = 49] = "FORMULA_INFO_TYPE_49";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_50"] = 50] = "FORMULA_INFO_TYPE_50";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_51"] = 51] = "FORMULA_INFO_TYPE_51";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_52"] = 52] = "FORMULA_INFO_TYPE_52";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_53"] = 53] = "FORMULA_INFO_TYPE_53";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_54"] = 54] = "FORMULA_INFO_TYPE_54";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_55"] = 55] = "FORMULA_INFO_TYPE_55";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_56"] = 56] = "FORMULA_INFO_TYPE_56";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_57"] = 57] = "FORMULA_INFO_TYPE_57";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_58"] = 58] = "FORMULA_INFO_TYPE_58";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_59"] = 59] = "FORMULA_INFO_TYPE_59";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_60"] = 60] = "FORMULA_INFO_TYPE_60";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_61"] = 61] = "FORMULA_INFO_TYPE_61";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_62"] = 62] = "FORMULA_INFO_TYPE_62";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_63"] = 63] = "FORMULA_INFO_TYPE_63";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_64"] = 64] = "FORMULA_INFO_TYPE_64";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_65"] = 65] = "FORMULA_INFO_TYPE_65";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_66"] = 66] = "FORMULA_INFO_TYPE_66";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_67"] = 67] = "FORMULA_INFO_TYPE_67";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_68"] = 68] = "FORMULA_INFO_TYPE_68";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_69"] = 69] = "FORMULA_INFO_TYPE_69";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_70"] = 70] = "FORMULA_INFO_TYPE_70";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_71"] = 71] = "FORMULA_INFO_TYPE_71";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_72"] = 72] = "FORMULA_INFO_TYPE_72";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_73"] = 73] = "FORMULA_INFO_TYPE_73";
    FORMULA_INFO[FORMULA_INFO["FORMULA_INFO_TYPE_74"] = 74] = "FORMULA_INFO_TYPE_74";
})(FORMULA_INFO || (FORMULA_INFO = {}));
//SkillInfluence 技能效用的作用阵营，见表SkillInfluence
var EFFECT_GROUP;
(function (EFFECT_GROUP) {
    EFFECT_GROUP[EFFECT_GROUP["EFFECT_GROUP_OPPOSITE"] = 0] = "EFFECT_GROUP_OPPOSITE";
    EFFECT_GROUP[EFFECT_GROUP["EFFECT_GROUP_OURSITE"] = 1] = "EFFECT_GROUP_OURSITE";
    EFFECT_GROUP[EFFECT_GROUP["EFFECT_GROUP_CURRENT"] = 2] = "EFFECT_GROUP_CURRENT";
})(EFFECT_GROUP || (EFFECT_GROUP = {}));
//SkillInfluence 技能效用的作用目标，见表SkillInfluence
var EFFECT_RANGE;
(function (EFFECT_RANGE) {
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_SINGLE"] = 0] = "EFFECT_RANGE_SINGLE";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_SELF"] = 1] = "EFFECT_RANGE_SELF";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_SINGLE_BACK"] = 2] = "EFFECT_RANGE_SINGLE_BACK";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_VERICAL"] = 3] = "EFFECT_RANGE_VERICAL";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_HORIZONAL"] = 4] = "EFFECT_RANGE_HORIZONAL";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_HORIZONAL_BACK"] = 5] = "EFFECT_RANGE_HORIZONAL_BACK";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_ALL"] = 6] = "EFFECT_RANGE_ALL";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_HEALTH_MOST"] = 7] = "EFFECT_RANGE_HEALTH_MOST";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_HEALTH_LEAST"] = 8] = "EFFECT_RANGE_HEALTH_LEAST";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_RANDOM_1"] = 9] = "EFFECT_RANGE_RANDOM_1";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_RANDOM_2"] = 10] = "EFFECT_RANGE_RANDOM_2";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_RANDOM_3"] = 11] = "EFFECT_RANGE_RANDOM_3";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_CROSS"] = 12] = "EFFECT_RANGE_CROSS";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_SP_MOST"] = 13] = "EFFECT_RANGE_SP_MOST";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_HP_lEST"] = 14] = "EFFECT_RANGE_HP_lEST";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANGE_HP_LESS_THEN"] = 15] = "EFFECT_RANGE_HP_LESS_THEN";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_DEFEND_PROPERTY_TARGET"] = 16] = "EFFECT_DEFEND_PROPERTY_TARGET";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_SKILL_PROPERTY_TARGET"] = 17] = "EFFECT_SKILL_PROPERTY_TARGET";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_ATTACK_PROPERTY_TARGET"] = 18] = "EFFECT_ATTACK_PROPERTY_TARGET";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_SKILL_PROPERTY_TARGET"] = 19] = "EFFECT_AFTER_SKILL_PROPERTY_TARGET";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_HP_LESS_THEN_TARGET"] = 20] = "EFFECT_AFTER_HP_LESS_THEN_TARGET";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_SELF_IN_COLUMN"] = 21] = "EFFECT_SELF_IN_COLUMN";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_HP_PERCENT_LEAST"] = 22] = "EFFECT_HP_PERCENT_LEAST";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_ATTACK_HIGHEST"] = 23] = "EFFECT_ATTACK_HIGHEST";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_RANDOM_LIMIT_3"] = 24] = "EFFECT_RANDOM_LIMIT_3";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_ROW_RANDOM_LIMIT_1"] = 25] = "EFFECT_AFTER_ROW_RANDOM_LIMIT_1";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_SELECT_TARGET_FOR_26"] = 26] = "EFFECT_AFTER_SELECT_TARGET_FOR_26";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_SELECT_TARGET_FOR_27"] = 27] = "EFFECT_AFTER_SELECT_TARGET_FOR_27";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_SELECT_TARGET_FOR_28"] = 28] = "EFFECT_AFTER_SELECT_TARGET_FOR_28";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_SELECT_TARGET_FOR_29"] = 29] = "EFFECT_AFTER_SELECT_TARGET_FOR_29";
    EFFECT_RANGE[EFFECT_RANGE["EFFECT_AFTER_SELECT_TARGET_FOR_30"] = 30] = "EFFECT_AFTER_SELECT_TARGET_FOR_30";
})(EFFECT_RANGE || (EFFECT_RANGE = {}));
//SkillInfluence 技能效用的种类，见表SkillInfluence
var SKILL_INFUENCE_RESULT;
(function (SKILL_INFUENCE_RESULT) {
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_DAMAGEHP"] = 0] = "SKILL_INFLUENCE_DAMAGEHP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADDHP"] = 1] = "SKILL_INFLUENCE_ADDHP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADDSP"] = 2] = "SKILL_INFLUENCE_ADDSP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_DAMAGESP"] = 3] = "SKILL_INFLUENCE_DAMAGESP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_NOSP"] = 4] = "SKILL_INFLUENCE_NOSP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_DIZZY"] = 5] = "SKILL_INFLUENCE_DIZZY";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_POISON"] = 6] = "SKILL_INFLUENCE_POISON";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_PARALYSIS"] = 7] = "SKILL_INFLUENCE_PARALYSIS";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_DISSP"] = 8] = "SKILL_INFLUENCE_DISSP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_FIRING"] = 9] = "SKILL_INFLUENCE_FIRING";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_EXPLODE"] = 10] = "SKILL_INFLUENCE_EXPLODE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADDRETAIN"] = 11] = "SKILL_INFLUENCE_ADDRETAIN";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADDDEFENCE"] = 12] = "SKILL_INFLUENCE_ADDDEFENCE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_DRAINS_HP"] = 14] = "SKILL_INFLUENCE_DRAINS_HP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_BEAR_HP"] = 15] = "SKILL_INFLUENCE_BEAR_HP";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_BLIND"] = 16] = "SKILL_INFLUENCE_BLIND";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_CRIPPLE"] = 17] = "SKILL_INFLUENCE_CRIPPLE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADD_ATTACK"] = 21] = "SKILL_INFLUENCE_ADD_ATTACK";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_SUB_ATTACK"] = 22] = "SKILL_INFLUENCE_SUB_ATTACK";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADD_DEFENSE"] = 23] = "SKILL_INFLUENCE_ADD_DEFENSE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_SUB_DEFENSE"] = 24] = "SKILL_INFLUENCE_SUB_DEFENSE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SILL_INFLUENCE_ADD_DAMAGE"] = 25] = "SILL_INFLUENCE_ADD_DAMAGE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SILL_INFLUENCE_ADD_BURISE"] = 26] = "SILL_INFLUENCE_ADD_BURISE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SILL_INFLUENCE_ADD_CRITICAL"] = 27] = "SILL_INFLUENCE_ADD_CRITICAL";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SILL_INFLUENCE_SUB_CRITICAL"] = 28] = "SILL_INFLUENCE_SUB_CRITICAL";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFLUENCE_ADD_HIT"] = 29] = "SKILL_INFLUENCE_ADD_HIT";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SILL_INFLUENCE_ADD_DODGE"] = 30] = "SILL_INFLUENCE_ADD_DODGE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_ENDURANCE"] = 31] = "SKILL_INFUENCE_ENDURANCE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_CLEAR_BUFF"] = 32] = "SKILL_INFUENCE_CLEAR_BUFF";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_ADD_FINNAL_DAMAGE"] = 33] = "SKILL_INFUENCE_ADD_FINNAL_DAMAGE";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_34"] = 34] = "SKILL_INFUENCE_RESULT_FOR_34";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_35"] = 35] = "SKILL_INFUENCE_RESULT_FOR_35";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_36"] = 36] = "SKILL_INFUENCE_RESULT_FOR_36";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_37"] = 37] = "SKILL_INFUENCE_RESULT_FOR_37";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_38"] = 38] = "SKILL_INFUENCE_RESULT_FOR_38";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_39"] = 39] = "SKILL_INFUENCE_RESULT_FOR_39";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_40"] = 40] = "SKILL_INFUENCE_RESULT_FOR_40";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_41"] = 41] = "SKILL_INFUENCE_RESULT_FOR_41";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_42"] = 42] = "SKILL_INFUENCE_RESULT_FOR_42";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_43"] = 43] = "SKILL_INFUENCE_RESULT_FOR_43";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_44"] = 44] = "SKILL_INFUENCE_RESULT_FOR_44";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_45"] = 45] = "SKILL_INFUENCE_RESULT_FOR_45";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_46"] = 46] = "SKILL_INFUENCE_RESULT_FOR_46";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_47"] = 47] = "SKILL_INFUENCE_RESULT_FOR_47";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_48"] = 48] = "SKILL_INFUENCE_RESULT_FOR_48";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_49"] = 49] = "SKILL_INFUENCE_RESULT_FOR_49";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_50"] = 50] = "SKILL_INFUENCE_RESULT_FOR_50";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_51"] = 51] = "SKILL_INFUENCE_RESULT_FOR_51";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_52"] = 52] = "SKILL_INFUENCE_RESULT_FOR_52";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_53"] = 53] = "SKILL_INFUENCE_RESULT_FOR_53";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_54"] = 54] = "SKILL_INFUENCE_RESULT_FOR_54";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_55"] = 55] = "SKILL_INFUENCE_RESULT_FOR_55";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_56"] = 56] = "SKILL_INFUENCE_RESULT_FOR_56";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_57"] = 57] = "SKILL_INFUENCE_RESULT_FOR_57";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_58"] = 58] = "SKILL_INFUENCE_RESULT_FOR_58";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_59"] = 59] = "SKILL_INFUENCE_RESULT_FOR_59";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_60"] = 60] = "SKILL_INFUENCE_RESULT_FOR_60";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_61"] = 61] = "SKILL_INFUENCE_RESULT_FOR_61";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_62"] = 62] = "SKILL_INFUENCE_RESULT_FOR_62";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_63"] = 63] = "SKILL_INFUENCE_RESULT_FOR_63";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_64"] = 64] = "SKILL_INFUENCE_RESULT_FOR_64";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_65"] = 65] = "SKILL_INFUENCE_RESULT_FOR_65";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_66"] = 66] = "SKILL_INFUENCE_RESULT_FOR_66";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_67"] = 67] = "SKILL_INFUENCE_RESULT_FOR_67";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_68"] = 68] = "SKILL_INFUENCE_RESULT_FOR_68";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_69"] = 69] = "SKILL_INFUENCE_RESULT_FOR_69";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_70"] = 70] = "SKILL_INFUENCE_RESULT_FOR_70";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_71"] = 71] = "SKILL_INFUENCE_RESULT_FOR_71";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_72"] = 72] = "SKILL_INFUENCE_RESULT_FOR_72";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_73"] = 73] = "SKILL_INFUENCE_RESULT_FOR_73";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_74"] = 74] = "SKILL_INFUENCE_RESULT_FOR_74";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_75"] = 75] = "SKILL_INFUENCE_RESULT_FOR_75";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_76"] = 76] = "SKILL_INFUENCE_RESULT_FOR_76";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_77"] = 77] = "SKILL_INFUENCE_RESULT_FOR_77";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_78"] = 78] = "SKILL_INFUENCE_RESULT_FOR_78";
    SKILL_INFUENCE_RESULT[SKILL_INFUENCE_RESULT["SKILL_INFUENCE_RESULT_FOR_79"] = 79] = "SKILL_INFUENCE_RESULT_FOR_79";
})(SKILL_INFUENCE_RESULT || (SKILL_INFUENCE_RESULT = {}));
//SkillMould 技能释放位置，见表SkillMould表
var SKILL_RELEASE_POSION;
(function (SKILL_RELEASE_POSION) {
    SKILL_RELEASE_POSION[SKILL_RELEASE_POSION["SKILL_RELEASE_POSION_SPOT"] = 0] = "SKILL_RELEASE_POSION_SPOT";
    SKILL_RELEASE_POSION[SKILL_RELEASE_POSION["SKILL_RELEASE_POSION_CENTRE_SCREEN"] = 1] = "SKILL_RELEASE_POSION_CENTRE_SCREEN";
    // SKILL_RELEASE_POSION_STRAIGHT = 2,
    SKILL_RELEASE_POSION[SKILL_RELEASE_POSION["SKILL_RELEASE_POSION_FRONT_FORWARD"] = 3] = "SKILL_RELEASE_POSION_FRONT_FORWARD";
    SKILL_RELEASE_POSION[SKILL_RELEASE_POSION["SKILL_RELEASE_POSION_FRONT_BACKWARD"] = 4] = "SKILL_RELEASE_POSION_FRONT_BACKWARD";
    // SKILL_RELEASE_POSION_ASSAULT = 5,
    // SKILL_RELEASE_ZOMURIA_TWO_SIDES = 9,
    SKILL_RELEASE_POSION[SKILL_RELEASE_POSION["SKILL_RELEASE_POSION_10"] = 10] = "SKILL_RELEASE_POSION_10";
    SKILL_RELEASE_POSION[SKILL_RELEASE_POSION["SKILL_RELEASE_POSION_11"] = 11] = "SKILL_RELEASE_POSION_11";
})(SKILL_RELEASE_POSION || (SKILL_RELEASE_POSION = {}));
var DRAGON_ANIMAE_INDEX;
(function (DRAGON_ANIMAE_INDEX) {
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_standby"] = 0] = "animation_standby";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_move"] = 1] = "animation_move";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_move_back"] = 2] = "animation_move_back";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_onrush"] = 3] = "animation_onrush";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_skill_began"] = 4] = "animation_skill_began";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_normal_be_attaked"] = 5] = "animation_normal_be_attaked";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_normal_conversely"] = 6] = "animation_normal_conversely";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_vertical_floated"] = 7] = "animation_vertical_floated";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_diagonal_floated"] = 8] = "animation_diagonal_floated";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_miss_action"] = 9] = "animation_miss_action";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_dizziness"] = 10] = "animation_dizziness";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_conversely"] = 11] = "animation_conversely";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_death"] = 12] = "animation_death";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_conversely_get_up"] = 13] = "animation_conversely_get_up";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_skill_attacking"] = 14] = "animation_skill_attacking";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_power_skill_attacking"] = 15] = "animation_power_skill_attacking";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_fit_skill_attacking"] = 16] = "animation_fit_skill_attacking";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_win_action"] = 17] = "animation_win_action";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_attack_jump"] = 18] = "animation_attack_jump";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_attack_jump_back"] = 19] = "animation_attack_jump_back";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_attack_jump_stay_in_the_sky"] = 20] = "animation_attack_jump_stay_in_the_sky";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_pursue"] = 21] = "animation_pursue";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_pursue_back"] = 22] = "animation_pursue_back";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_onrush_back"] = 23] = "animation_onrush_back";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_win_on_action"] = 24] = "animation_win_on_action";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_attack_normal_in_the_sky"] = 25] = "animation_attack_normal_in_the_sky";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_attack_skill_in_the_sky"] = 26] = "animation_attack_skill_in_the_sky";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_conversely_death"] = 27] = "animation_conversely_death";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_31_ji1"] = 28] = "animation_new_skill_31_ji1";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_32_ji2"] = 29] = "animation_new_skill_32_ji2";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_33_ji3"] = 30] = "animation_new_skill_33_ji3";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_34_ji4"] = 31] = "animation_new_skill_34_ji4";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_35_ji5"] = 32] = "animation_new_skill_35_ji5";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_36_ji1"] = 33] = "animation_new_skill_36_ji1";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_37_ji2"] = 34] = "animation_new_skill_37_ji2";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_38_ji3"] = 35] = "animation_new_skill_38_ji3";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_39_ji4"] = 36] = "animation_new_skill_39_ji4";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_40_ji5"] = 37] = "animation_new_skill_40_ji5";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_13_jueji"] = 38] = "animation_new_skill_13_jueji";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_29_daodi"] = 39] = "animation_new_skill_29_daodi";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_30_dingdian"] = 40] = "animation_new_skill_30_dingdian";
    DRAGON_ANIMAE_INDEX[DRAGON_ANIMAE_INDEX["animation_new_skill_31_xia"] = 41] = "animation_new_skill_31_xia";
})(DRAGON_ANIMAE_INDEX || (DRAGON_ANIMAE_INDEX = {}));
//# sourceMappingURL=EnumDef.js.map