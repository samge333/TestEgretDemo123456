// skill_influence = {
// 	id = 1,							--	int(11)	Not null	主键，自增长
// 	skill_mould = 2,				--	int(11)		所属技能模版
// 	influenceDescribe = 3,			--	text		技能段描述
// 	skill_category = 4,				--	tinyint(4)	技能种类：0为攻击，1为加血，2为加怒，3为减怒，4为禁怒，5为眩晕，6为中毒，7为麻痹，8为封技，9为灼烧，10为爆裂，11为增加档格，12为增加防御
// 	skill_param = 5,				--	int(11)		技能参数，技能计算参数
// 	skill_effect_min_value = 6,		--	int(11)		技能影响最小值
// 	skill_effect_max_value = 7,		--	int(11)		技能影响最大值
// 	formula_info = 8,				--	int(11)		公式索引
// 	is_rate = 9,					--	tinyint(4)	是否为百分比作用，0为是，1为否
// 	addition_effect_probability = 10,	--	int(11)	附加效果命中率%
// 	influence_group = 11,			--	tinyint(4)	作用阵营：0为作用于敌方阵营、1为作用于本方阵营、2为作用于当前英雄
// 	influence_range = 12,			--	tinyint(4)	作用范围：0为单体、1为自己、2为后排单体、3为直线、4为横排、5为后排横排、6为全体、7为血最多的一个、8为血最少的1个、9为随机1个、10为随机2个、11为随机3个
// 	peak_limit = 13,				--	tinyint(4)	作用峰值，0为无限制，1为作用至满额
// 	influence_restrict = 14,		--	tinyint(4)	0:无 1:不含自己
// 	influence_duration = 15,		--	tinyint(4)	作用时长：0为即时作用、1为作用1回合、2为作用2回合、3为作用3回合
// 	before_action = 16,				-- 	int(11)		前段动作ID
// 	forepart_lighting_effect_id = 17,		--	int(11)		前段光效id
// 	forepart_lighting_sound_effect_id = 18,	--	int(11)		前段光效音效id
// 	after_action = 19,						-- 	int(11)		后段动作ID	
// 	posterior_lighting_effect_id = 20,		--	int(11)		后段光效id
// 	attack_section = 21,					--	int(11)		攻击段数
// 	posterior_lighting_sound_effect_id = 22,--	int(11)		后段光效音效id
// 	lighting_effect_draw_method = 23,		--	int(11)		光效绘制方式
// 	lighting_effect_count = 24,				-- 	int(11)		光效绘制次数
// 	army_bear_action = 25, 					-- 	int(11)		敌方承受动作ID
// 	bear_lighting_effect_id = 26,			--	int(11)		承受光效id
// 	bear_sound_effect_id = 27,				--	int(11)		承受音效id
// 	is_vibrate = 28,						-- 	tinyint(4)	是否抖动
// 	path_acrtoon = 29,						--int(11)		路径动画
// 	attack_over_action = 30,				--int(11)		攻击后段
// 	attack_move_action = 31,				--int(11)		进身攻击的移动帧组
// 	hit_down = 32,							--int(11)		击倒效果 帧组索引  参数修改成击退与击飞的距离  (x,y|x,y  |x,y  x,y| |)
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
// 	-- 东邪项目添加的参数
// 	scene_effect = 33, 						--INT(11) 	场景特效
// 	compute_mode = 34, 						--INT(11) 	效用计算类型
// 	buff_duration = 35, 					--INT(11) 	BUFF作用周期
// 	buff_additioal_count = 36, 				--INT(11) 	叠加次数
// 	trigger_timing = 37, 					--INT(11) 	本效用触发时机
// 	trigger_need_value = 38, 				--text		本效用触发值 格式为触发值1,触发值2…
// 	trigger_influence_id = 39, 				--INT(11) 	触发其他效用ID
// 	influence_over_condition = 40, 			--INT(11) 	BUFF结束条件（BUFF专用）
// 	influence_over_need_param = 41, 		--INT(11) 	BUFF结束条件值 当结束条件为1时生效，没有填-1
// 	influence_bullet_speed = 42, 			--INT(11) 	子弹移动速度
// 	-- 数码项目
// 	level_init_value = 33, -- 固定值
// 	level_grow_value = 34, -- 每级固定值成长
// 	level_percent_grow_value = 35, -- 每级百分比成长
// 	next_skill_influence = 36, -- 被执行的效用ID
// }
var EnumSkillInfluence;
(function (EnumSkillInfluence) {
    EnumSkillInfluence[EnumSkillInfluence["id"] = 1] = "id";
    EnumSkillInfluence[EnumSkillInfluence["skillMould"] = 2] = "skillMould";
    EnumSkillInfluence[EnumSkillInfluence["influenceDescribe"] = 3] = "influenceDescribe";
    EnumSkillInfluence[EnumSkillInfluence["skillCategory"] = 4] = "skillCategory";
    EnumSkillInfluence[EnumSkillInfluence["skillParam"] = 5] = "skillParam";
    EnumSkillInfluence[EnumSkillInfluence["skillEffectMinValue"] = 6] = "skillEffectMinValue";
    EnumSkillInfluence[EnumSkillInfluence["skillEffectMaxValue"] = 7] = "skillEffectMaxValue";
    EnumSkillInfluence[EnumSkillInfluence["formulaInfo"] = 8] = "formulaInfo";
    EnumSkillInfluence[EnumSkillInfluence["isRate"] = 9] = "isRate";
    EnumSkillInfluence[EnumSkillInfluence["additionEffectProbability"] = 10] = "additionEffectProbability";
    EnumSkillInfluence[EnumSkillInfluence["influenceGroup"] = 11] = "influenceGroup";
    EnumSkillInfluence[EnumSkillInfluence["influenceRange"] = 12] = "influenceRange";
    EnumSkillInfluence[EnumSkillInfluence["peakLimit"] = 13] = "peakLimit";
    EnumSkillInfluence[EnumSkillInfluence["influenceRestrict"] = 14] = "influenceRestrict";
    EnumSkillInfluence[EnumSkillInfluence["influenceDuration"] = 15] = "influenceDuration";
    EnumSkillInfluence[EnumSkillInfluence["beforeAction"] = 16] = "beforeAction";
    EnumSkillInfluence[EnumSkillInfluence["forepartLightingEffectId"] = 17] = "forepartLightingEffectId";
    EnumSkillInfluence[EnumSkillInfluence["forepartLightingSoundEffectId"] = 18] = "forepartLightingSoundEffectId";
    EnumSkillInfluence[EnumSkillInfluence["afterAction"] = 19] = "afterAction";
    EnumSkillInfluence[EnumSkillInfluence["posteriorLightingEffectId"] = 20] = "posteriorLightingEffectId";
    EnumSkillInfluence[EnumSkillInfluence["attackSection"] = 21] = "attackSection";
    EnumSkillInfluence[EnumSkillInfluence["posteriorLightingSoundEffectId"] = 22] = "posteriorLightingSoundEffectId";
    EnumSkillInfluence[EnumSkillInfluence["lightingEffectDrawMethod"] = 23] = "lightingEffectDrawMethod";
    EnumSkillInfluence[EnumSkillInfluence["lightingEffectCount"] = 24] = "lightingEffectCount";
    EnumSkillInfluence[EnumSkillInfluence["armyBearAction"] = 25] = "armyBearAction";
    EnumSkillInfluence[EnumSkillInfluence["bearLightingEffectId"] = 26] = "bearLightingEffectId";
    EnumSkillInfluence[EnumSkillInfluence["bearSoundEffectId"] = 27] = "bearSoundEffectId";
    EnumSkillInfluence[EnumSkillInfluence["isVibrate"] = 28] = "isVibrate";
    EnumSkillInfluence[EnumSkillInfluence["pathAcrtoon"] = 29] = "pathAcrtoon";
    EnumSkillInfluence[EnumSkillInfluence["rearEnd"] = 30] = "rearEnd";
    EnumSkillInfluence[EnumSkillInfluence["beforeAttackFrame"] = 31] = "beforeAttackFrame";
    EnumSkillInfluence[EnumSkillInfluence["hitDown"] = 32] = "hitDown";
    EnumSkillInfluence[EnumSkillInfluence["levelInitValue"] = 33] = "levelInitValue";
    EnumSkillInfluence[EnumSkillInfluence["levelGrowValue"] = 34] = "levelGrowValue";
    EnumSkillInfluence[EnumSkillInfluence["levelPercentGrowValue"] = 35] = "levelPercentGrowValue";
    EnumSkillInfluence[EnumSkillInfluence["nextSkillInfluence"] = 36] = "nextSkillInfluence";
})(EnumSkillInfluence || (EnumSkillInfluence = {}));
var SkillInfluence = (function () {
    function SkillInfluence() {
    }
    SkillInfluence.prototype.init = function (row) {
        this.id = Number(row[0]);
        this.skillMould = Number(row[1]);
        this.influenceDescribe = Number(row[2]);
        this.skillCategory = Number(row[3]);
        this.skillParam = Number(row[4]);
        this.skillEffectMinValue = Number(row[5]);
        this.skillEffectMaxValue = Number(row[6]);
        this.formulaInfo = Number(row[7]);
        this.isRate = Number(row[8]);
        this.additionEffectProbability = Number(row[9]);
        this.influenceGroup = Number(row[10]);
        var arrInfluenceRange = row[11].split(",");
        this.influenceRange = Number(arrInfluenceRange[0]);
        this.influenceRangeType = Number(arrInfluenceRange[1]);
        this.peakLimit = Number(row[12]);
        this.influenceRestrict = Number(row[13]);
        this.influenceDuration = Number(row[14]);
        this.beforeAction = Number(row[15]);
        this.forepartLightingEffectId = Number(row[16]);
        this.forepartLightingSoundEffectId = Number(row[17]);
        this.afterAction = Number(row[18]);
        this.posteriorLightingEffectId = Number(row[19]);
        this.attackSection = Number(row[20]);
        this.posteriorLightingSoundEffectId = Number(row[21]);
        this.lightingEffectDrawMethod = Number(row[22]);
        this.lightingEffectCount = Number(row[23]);
        this.armyBearAction = Number(row[24]);
        this.bearLightingEffectId = Number(row[25]);
        this.bearSoundEffectId = row[26];
        this.isVibrate = Number(row[27]);
        this.pathAcrtoon = Number(row[28]);
        this.rearEnd = Number(row[29]);
        this.beforeAttackFrame = Number(row[30]);
        this.hitDown = row[31];
        "";
        this.levelInitValue = Number(row[32]);
        this.levelGrowValue = Number(row[33]);
        this.levelPercentGrowValue = Number(row[34]);
        this.nextSkillInfluence = Number(row[35]);
    };
    return SkillInfluence;
}());
__reflect(SkillInfluence.prototype, "SkillInfluence");
//# sourceMappingURL=SkillInfluence.js.map