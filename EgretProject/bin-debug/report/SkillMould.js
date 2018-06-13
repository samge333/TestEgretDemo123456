// skill_mould = {
// 	id = 1,						--	int(11)	Not null	主键，自增长
// 	skill_name = 2,				--	varchar(16)			技能名称
// 	skill_describe = 3,			--	varchar(255)		技能描述
// 	skill_quality = 4,			--	tinyint(4)			技能类型(0:普通 1:怒气 2:合击)
// 	skill_pic = 5,				--	int(11)				技能图标
// 	skill_property = 6,			--	tinyint(4)			技能属性(0:物理 1:法术)
// 	skill_release_position = 7, --	tinyint(4)			技能释放位置(0:原地 1:移动到承受者前方 2: 移动到承受者所在直线前方)
// 	after_remove = 8,   		--  int(11)				施放技能时的移动方式
// 	health_affect = 9,			--	varchar(255)		生命影响
// 	buff_affect = 10,			--	varchar(255)		buff影响
// 	base_mould = 11,			--	varchar(255)		基础模板
// 	next_level_skill = 12,		--	varchar(255)		下一级技能模板
// 	release_mould = 13,			--	varchar(255)		释放人员(a,b,c)
// 	releas_skill = 14,			--	varchar(255)		释放技能
// 	seriatim = 15,				--	int(2)				是否逐一(0否,1是)
// 	attack_move_mode = 16,      --	tinyint(4)			技能攻击移动方式(0跑过去，1跳过去，2待定，3.......)
// 	attack_scope = 17,			--	varchar(255)		攻击范围（最小距离,最大距离）
// 	is_jump = 18,				--	varchar(255)		是否起跳（0是，1否）
// 	zoom_ratio = 19,			--	int(11)				技能缩放比例(0:不缩放,>0缩放比例)
// 	launch_opportunity = 20,			--	int(11)		技能释放时机
// 	opportunity_param = 21,				--	int(11)		释放参数
// 	opportunity_count_limit = 22,		--	int(11)		释放次数限制
// 	skill_level = 23,			--	int(11)		技能级别
// }
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var EnumSkillMould;
(function (EnumSkillMould) {
    EnumSkillMould[EnumSkillMould["id"] = 1] = "id";
    EnumSkillMould[EnumSkillMould["skill_name"] = 2] = "skill_name";
    EnumSkillMould[EnumSkillMould["skill_describe"] = 3] = "skill_describe";
    EnumSkillMould[EnumSkillMould["skill_quality"] = 4] = "skill_quality";
    EnumSkillMould[EnumSkillMould["skill_pic"] = 5] = "skill_pic";
    EnumSkillMould[EnumSkillMould["skill_property"] = 6] = "skill_property";
    EnumSkillMould[EnumSkillMould["skill_release_position"] = 7] = "skill_release_position";
    EnumSkillMould[EnumSkillMould["after_remove"] = 8] = "after_remove";
    EnumSkillMould[EnumSkillMould["health_affect"] = 9] = "health_affect";
    EnumSkillMould[EnumSkillMould["buff_affect"] = 10] = "buff_affect";
    EnumSkillMould[EnumSkillMould["base_mould"] = 11] = "base_mould";
    EnumSkillMould[EnumSkillMould["next_level_skill"] = 12] = "next_level_skill";
    EnumSkillMould[EnumSkillMould["release_mould"] = 13] = "release_mould";
    EnumSkillMould[EnumSkillMould["releas_skill"] = 14] = "releas_skill";
    EnumSkillMould[EnumSkillMould["seriatim"] = 15] = "seriatim";
    EnumSkillMould[EnumSkillMould["attack_move_mode"] = 16] = "attack_move_mode";
    EnumSkillMould[EnumSkillMould["attack_scope"] = 17] = "attack_scope";
    EnumSkillMould[EnumSkillMould["is_jump"] = 18] = "is_jump";
    EnumSkillMould[EnumSkillMould["zoom_ratio"] = 19] = "zoom_ratio";
    EnumSkillMould[EnumSkillMould["launch_opportunity"] = 20] = "launch_opportunity";
    EnumSkillMould[EnumSkillMould["opportunity_param"] = 21] = "opportunity_param";
    EnumSkillMould[EnumSkillMould["opportunity_count_limit"] = 22] = "opportunity_count_limit";
    EnumSkillMould[EnumSkillMould["skill_level"] = 23] = "skill_level";
})(EnumSkillMould || (EnumSkillMould = {}));
var SkillMould = (function () {
    function SkillMould() {
        this.health_affect = "";
    }
    SkillMould.prototype.init = function (row) {
        this.id = row[0];
        this.skill_name = row[1];
        this.skill_describe = row[2];
        this.skill_quality = row[3];
        this.skill_pic = row[4];
        this.skill_property = row[5];
        this.skill_release_position = row[6];
        this.after_remove = row[7];
        this.health_affect = row[8];
        this.buff_affect = row[9];
        this.base_mould = row[10];
        this.next_level_skill = row[11];
        this.release_mould = row[12];
        this.releas_skill = row[13];
        this.seriatim = row[14];
        this.attack_move_mode = row[15];
    };
    return SkillMould;
}());
__reflect(SkillMould.prototype, "SkillMould");
//# sourceMappingURL=SkillMould.js.map