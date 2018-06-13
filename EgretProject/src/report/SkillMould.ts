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

enum EnumSkillMould {
	id = 1,						
	skill_name = 2,				
	skill_describe = 3,			
	skill_quality = 4,			
	skill_pic = 5,				
	skill_property = 6,			
	skill_release_position = 7, 
	after_remove = 8,   		
	health_affect = 9,			
	buff_affect = 10,			
	base_mould = 11,			
	next_level_skill = 12,		
	release_mould = 13,			
	releas_skill = 14,			
	seriatim = 15,				
	attack_move_mode = 16,      
	attack_scope = 17,			
	is_jump = 18,				
	zoom_ratio = 19,			
	launch_opportunity = 20,	
	opportunity_param = 21,		
	opportunity_count_limit = 22,	
	skill_level = 23,			
}

class SkillMould {
	public constructor() {
	}

	id: any;
	skill_name: any;
	skill_describe: any;
	skill_quality: any;
	skill_pic: any;
	skill_property: any;
	skill_release_position: any;
	after_remove: any;
	health_affect: string = "";
	buff_affect: any;
	base_mould: any;
	next_level_skill: any;
	release_mould: any;
	releas_skill: any;
	seriatim: any;
	attack_move_mode: any;

	public init(row: Array<any>) {
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
	}
}