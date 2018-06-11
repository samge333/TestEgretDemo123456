
-- 战斗帮助类
-- @author xiaofeng
FightUtil = {}
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_COMMON_DAMAGE =  1
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_SPECIAL_DAMAGE =  2
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_CURE_HP =  3
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_CURE_SP =  4
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_DAMAGE_SP =  5
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_SP_DISUP =  6
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_DIZZY =  7
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_POSION =  8
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_Firing =  9
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_Explode =  10
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_PARALYSIS =  11
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_NO_SP =  12
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_RETAIN =  13
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_LESSEN_DAMAGE =  14
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_EVASION_SURELY =  15
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_DRAINS =  16
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_BEAR_HP =  17
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_BLIND =  18
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_CRIPPLE =  19
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_ATTACK =  21
-- 降低攻击
-- @author xiaofeng
FightUtil.FORMULA_INFO_SUB_ATTACK =  22
-- 增加防御
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_DEFENCE =  23
-- 降低防御
-- @author xiaofeng
FightUtil.FORMULA_INFO_SUB_DEFENCE =  24
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_SELF_DAMAGE =  25
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_SUB_SELF_DAMAGE =  26
-- 增加暴击
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_CRITICAL =  27
-- 增加抗暴
-- @author xiaofeng
FightUtil.FORMULA_INFO_SUB_CRITICAL =  28
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_HIT =  29
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_DODGE =  30
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_ENDURANCE =  31
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_CLEAR_BUFF =  32
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_DAMAGE =  33
-- 战斗帮助类
-- @author xiaofeng
FightUtil.FORMULA_INFO_ADD_KILL =  34
-- 固伤
-- @author xiaofeng
FightUtil.FORMULA_INFO_FIXED_DAMAGE =  35
-- 即时生效 去上一个作用目标
-- 降低治疗效果
-- @author xiaofeng
FightUtil.FORMULA_INFO_FORTHWITH = 36
-- 溅射
FightUtil.FORMULA_INFO_REANA_ATTACK_DAMAGE = 37
-- 增加格挡强度
FightUtil.FORMULA_INFO_ADD_RETAIN_INTENSION = 38
-- 降低格挡概率
FightUtil.FORMULA_INFO_LESSEN_RETAIN_PERCENT = 39
-- 小技能的伤害公式
FightUtil.FORMULA_INFO_NORMAL_SKILL_DAMAGE = 40
-- 反弹
FightUtil.FORMULA_INFO_DAMAGE_REBOUND = 41
-- 小技能触发概率
FightUtil.FORMULA_INFO_ADD_NORMAL_SKILL_ODDS = 42
-- 灼烧（目标生命值上限）
FightUtil.FORMULA_INFO_FIRING_DAMAGE_UPPER_LIMIT = 43
-- 44.增加破格挡率
FightUtil.FORMULA_INFO_ADD_RETAIN_BREAK_ODDS = 44
FightUtil.FORMULA_INFO_TYPE_45 = 45 -- 45	增加反弹率
FightUtil.FORMULA_INFO_TYPE_46 = 46 -- 46	加血（以自身最大生命值计算）
FightUtil.FORMULA_INFO_TYPE_47 = 47 -- 47	增加伤害减免
FightUtil.FORMULA_INFO_TYPE_48 = 48 -- 48	变形（变成玩偶）
FightUtil.FORMULA_INFO_TYPE_49 = 49 -- 49	降低小技能触发概率
FightUtil.FORMULA_INFO_TYPE_50 = 50 -- 50	降低暴击伤害
FightUtil.FORMULA_INFO_TYPE_51 = 51 -- 51	减少必杀伤害
FightUtil.FORMULA_INFO_TYPE_52 = 52 -- 52	嘲讽
FightUtil.FORMULA_INFO_TYPE_53 = 53 -- 53	加血（以自身已损失生命值计算）
FightUtil.FORMULA_INFO_TYPE_54 = 54 -- 54	加血（以目标生命值上限计算）
FightUtil.FORMULA_INFO_TYPE_55 = 55 -- 55	降低伤害加成
FightUtil.FORMULA_INFO_TYPE_56 = 56 -- 56	增加伤害加成
FightUtil.FORMULA_INFO_TYPE_57 = 57 -- 57	增加控制率
FightUtil.FORMULA_INFO_TYPE_58 = 58 -- 58	增加必杀伤害
FightUtil.FORMULA_INFO_TYPE_59 = 59 -- 59	减少必杀伤害率
FightUtil.FORMULA_INFO_TYPE_60 = 60 -- 60	降低怒气回复速度
FightUtil.FORMULA_INFO_TYPE_61 = 61 -- 61	提高怒气回复速度
FightUtil.FORMULA_INFO_TYPE_62 = 62 -- 62	增加暴击伤害
FightUtil.FORMULA_INFO_TYPE_63 = 63 -- 63	增加反伤率
FightUtil.FORMULA_INFO_TYPE_64 = 64 -- 64	增加暴击强度
FightUtil.FORMULA_INFO_TYPE_65 = 65 -- 65	降低伤害减免
FightUtil.FORMULA_INFO_TYPE_66 = 66 -- 66	增加必杀伤害率
FightUtil.FORMULA_INFO_TYPE_67 = 67 -- 67	增加格挡率
FightUtil.FORMULA_INFO_TYPE_68 = 68 -- 68	增加数码兽类型克制伤害加成
FightUtil.FORMULA_INFO_TYPE_69 = 69 -- 69	增增加数码兽类型克制伤害减免
FightUtil.FORMULA_INFO_TYPE_70 = 70 -- 70	降低暴击率
FightUtil.FORMULA_INFO_TYPE_71 = 71 -- 71	降低抗暴率
FightUtil.FORMULA_INFO_TYPE_72 = 72 -- 72	增加必杀抗性
FightUtil.FORMULA_INFO_TYPE_73 = 73 -- 73	减少必杀抗性
FightUtil.FORMULA_INFO_TYPE_74 = 74 -- 74	增加吸血率	总吸血率[40] = 原吸血率[40] + 百分比值

function FightUtil.computeMoveCoordinate(currentAttackerCoordinate, skillReleasePosion, byAttackObjects)
	if (skillReleasePosion == SkillMould.SKILL_RELEASE_POSION_SPOT ) then
		return SkillMould.SKILL_RELEASE_POSION_SPOT
	end
	if (skillReleasePosion == SkillMould.SKILL_RELEASE_POSION_CENTRE_SCREEN) then
		return SkillMould.SKILL_RELEASE_POSION_CENTRE_SCREEN
	end
	if (skillReleasePosion == SkillMould.SKILL_RELEASE_POSION_STRAIGHT) then
		if (1 == currentAttackerCoordinate or 4 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 2
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 3
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 4
			end
		end
		if (2 == currentAttackerCoordinate or 5 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 3
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 2
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 4
			end
		end
		if (3 == currentAttackerCoordinate or 6 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 4
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 3
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 2
			end
		end
	elseif (skillReleasePosion == SkillMould.SKILL_RELEASE_POSION_FRONT_FORWARD) then
		if (1 == currentAttackerCoordinate or 4 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 5
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 6
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 7
			end
		end
		if (2 == currentAttackerCoordinate or 5 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 6
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 5
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 7
			end
		end
		if (3 == currentAttackerCoordinate or 6 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 7
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 6
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 5
			end
		end
	elseif (skillReleasePosion == SkillMould.SKILL_RELEASE_POSION_FRONT_BACKWARD) then
		if (1 == currentAttackerCoordinate or 4 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 5
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 6
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 7
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			end
		end
		if(2 == currentAttackerCoordinate or 5 == currentAttackerCoordinate)then
			if (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 6
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 5
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 7
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			end
		elseif(3 == currentAttackerCoordinate or 6 == currentAttackerCoordinate)then
			if (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				return 7
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				return 6
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				return 5
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				return 4
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				return 3
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				return 2
			end
		end
	elseif (skillReleasePosion == SkillMould.SKILL_RELEASE_POSION_ASSAULT) then
		return 8
	elseif (skillReleasePosion == SkillMould.SKILL_RELEASE_ZOMURIA_TWO_SIDES) then
		return 9
	end
	return skillReleasePosion
end

function FightUtil.computeEndureDirection(currentAttackerCoordinate, skillInfluence, byAttackObjects)
	----_crint( "computeEndureDirection : " .. currentAttackerCoordinate)
	--_crint ("skillInfluence id: " .. skillInfluence.id  .. ", group : " .. skillInfluence.influenceGroup)
	--_crint ("SkillInfluence.influenceRange: ".. skillInfluence.influenceRange)

	if(skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OPPOSITE)then
		if(skillInfluence.influenceRange == SkillInfluence.EFFECT_RANGE_HORIZONAL)then
			if ((nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].revived) or (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].revived) or (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].revived))then
				return {"3", "1,2,3"}
			else
				return {"4", "4,5,6"}
			end
		elseif(skillInfluence.influenceRange == SkillInfluence.EFFECT_RANGE_HORIZONAL_BACK)then
			if ((nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].revived) or (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].revived) or (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].revived))then
				return {"4", "4,5,6"}
			else
				return {"3", "1,2,3"}
			end
		elseif(skillInfluence.influenceRange == SkillInfluence.EFFECT_RANGE_VERICAL)then
			if (1 == currentAttackerCoordinate or 4 == currentAttackerCoordinate) then
				if (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].revived) then
					return {"0", "1,4"}
				elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].revived) then
					return {"1", "2,5"}
				elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].revived) then
					return {"2", "3,6"}
				elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].revived) then
					return {"0", "1,4"}
				elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].revived) then
					return {"1", "2,5"}
				elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].revived) then
					return {"2", "3,6"}
				end
			elseif(2 == currentAttackerCoordinate or 5 == currentAttackerCoordinate)then
				if (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].revived) then
					return {"1", "2,5"}
				elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].revived) then
					return {"0", "1,4"}
				elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].revived) then
					return {"2", "3,6"}
				elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].revived) then
					return {"1", "2,5"}
				elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].revived) then
					return {"0", "1,4"}
				elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].revived) then
					return {"2", "3,6"}
				end
			elseif(3 == currentAttackerCoordinate or 6 == currentAttackerCoordinate)then
				if (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].revived) then
					return {"2", "3,6"}
				elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].revived) then
					return {"1", "2,5"}
				elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].revived) then
					return {"0", "1,4"}
				elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].revived) then
					return {"2", "3,6"}
				elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].revived) then
					return {"1", "2,5"}
				elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].revived) then
					return {"0", "1,4"}
				end
			end
		else
			--_crint ("Other case")
		end
	end
	--_crint ("Will return last way")
	return {"-1", "-1"}
end



function FightUtil.computeEffectCoordinate(currentAttackerCoordinate, skillInfluence, battleObject, byAttackObjects, byAttackTargetTag)
	if nil ~= skillInfluence.influenceRangeType and 1 == skillInfluence.influenceRangeType then
		if battleObject.byEffectCoordinateList then
			if skillInfluence.skillCategory == 37 then
				byAttackTargetTag = table.remove(battleObject.byEffectCoordinateList, "1")
			else
				local byEffectCoordinateList = {}
				table.add(byEffectCoordinateList, battleObject.byEffectCoordinateList)
				return byEffectCoordinateList
			end
		end
	end

	local influenceRange = skillInfluence.influenceRange
	local headCoordinate = -1
	local backCoordinate = -1
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		if (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
			headCoordinate = 1
		elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
			headCoordinate = 2
		elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
			headCoordinate = 3
		elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
			headCoordinate = 4
		elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
			headCoordinate = 5
		elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
			headCoordinate = 6
		end

		if nil ~= byAttackTargetTag and byAttackTargetTag > 0 then
			if (nil ~= byAttackObjects[byAttackTargetTag] and true ~= byAttackObjects[byAttackTargetTag].isDead and true ~= byAttackObjects[byAttackTargetTag].revived) then
				headCoordinate = byAttackTargetTag
			end
		end
		if (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
			backCoordinate = 4
		elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
			backCoordinate = 5
		elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
			backCoordinate = 6
		elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
			backCoordinate = 1
		elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
			backCoordinate = 2
		elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
			backCoordinate = 3
		end

		if influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_26 then
			if battleObject.byEffectCoordinateList and #battleObject.byEffectCoordinateList > 0 then
				headCoordinate = battleObject.byEffectCoordinateList[1]
			end
		end

		if (skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE) then
			if (influenceRange == SkillInfluence.EFFECT_RANGE_VERICAL 
				or influenceRange == SkillInfluence.EFFECT_RANGE_CROSS 
				or influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_26 
				) then -- 3 一列
				-- 3,12,26
				headCoordinate = battleObject.coordinate
				backCoordinate = battleObject.coordinate
			end
		end

		if nil ~= byAttackTargetTag and byAttackTargetTag > 0 then
			if (nil ~= byAttackObjects[byAttackTargetTag] and true ~= byAttackObjects[byAttackTargetTag].isDead and true ~= byAttackObjects[byAttackTargetTag].revived) then
				backCoordinate = byAttackTargetTag
			end
		end

		if (battleObject.lockAttackTargetPos > 0) then
			local lockAttackTargetPos = battleObject.lockAttackTargetPos
			if (nil ~= byAttackObjects[lockAttackTargetPos] and true ~= byAttackObjects[lockAttackTargetPos].isDead and true ~= byAttackObjects[lockAttackTargetPos].revived) then
				headCoordinate = lockAttackTargetPos
				backCoordinate = lockAttackTargetPos
			end
		end
	else
		if (1 == currentAttackerCoordinate or 4 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				headCoordinate = 1
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				headCoordinate = 2
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				headCoordinate = 3
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				headCoordinate = 4
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				headCoordinate = 5
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				headCoordinate = 6
			end
		elseif(2 == currentAttackerCoordinate or 5 == currentAttackerCoordinate)then
			if (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				headCoordinate = 2
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				headCoordinate = 1
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				headCoordinate = 3
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				headCoordinate = 5
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				headCoordinate = 4
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				headCoordinate = 6
			end
		elseif(3 == currentAttackerCoordinate or 6 == currentAttackerCoordinate)then
			if (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				headCoordinate = 3
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				headCoordinate = 2
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				headCoordinate = 1
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				headCoordinate = 6
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				headCoordinate = 5
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				headCoordinate = 4
			end
		end
		if (1 == currentAttackerCoordinate or 4 == currentAttackerCoordinate) then
			if (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				backCoordinate = 4
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				backCoordinate = 5
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				backCoordinate = 6
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				backCoordinate = 1
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				backCoordinate = 2
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				backCoordinate = 3
			end
		elseif(2 == currentAttackerCoordinate or 5 == currentAttackerCoordinate)then
			if (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				backCoordinate = 5
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				backCoordinate = 4
			elseif (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				backCoordinate = 6
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				backCoordinate = 2
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				backCoordinate = 1
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				backCoordinate = 3
			end
		elseif(3 == currentAttackerCoordinate or 6 == currentAttackerCoordinate)then
			if (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				backCoordinate = 6
			elseif (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				backCoordinate = 5
			elseif (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				backCoordinate = 4
			elseif (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) then
				backCoordinate = 3
			elseif (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) then
				backCoordinate = 2
			elseif (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) then
				backCoordinate = 1
			end
		end
	end
	
	local battleObjectList = {}
	--for (BattleObject tmpBattleObject : byAttackObjects) then
	for _, tmpBattleObject in pairs(byAttackObjects) do
		if(nil ~= tmpBattleObject and true ~= tmpBattleObject.isDead and true ~= tmpBattleObject.revived)then
			if(true ~= (skillInfluence.influenceGroup == SkillInfluence.EFFECT_GROUP_OURSITE and skillInfluence.influenceRestrict == 1 and tmpBattleObject.id == battleObject.id))then					
				table.insert(battleObjectList, tmpBattleObject)
			end
		end
	end
	local byEffectCoordinateList = {}
	battleObject.byEffectCoordinateList = byEffectCoordinateList
	if (influenceRange == SkillInfluence.EFFECT_RANGE_SINGLE ) then -- 0 单体	
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			if battleObject.lockAttackTargetPos > 0 and headCoordinate > 0 then
				
			else
				if 1 == battleObject.battleTag then
					local temp1 = {}
					for i = 1, 3 do
						if nil ~= byAttackObjects[i] and true ~= byAttackObjects[i].isDead and true ~= byAttackObjects[i].revived then
							table.insert(temp1, i)
						end
					end
					if 0 == #temp1 then
						local temp2 = {}
						for i = 4, 6 do
							if nil ~= byAttackObjects[i] and true ~= byAttackObjects[i].isDead and true ~= byAttackObjects[i].revived then
								table.insert(temp2, i)
							end
						end
						if 0 < #temp2 then
							headCoordinate = temp2[math.random(1, #temp2)]
						end
					else
						headCoordinate = temp1[math.random(1, #temp1)]
					end
				end
			end
		end
		table.insert(byEffectCoordinateList, headCoordinate)
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_SELF ) then -- 1 自己	
		table.insert(byEffectCoordinateList, battleObject.coordinate)
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_SINGLE_BACK ) then -- 2 后排单体	后排无数码兽时选前排单体
		table.insert(byEffectCoordinateList, backCoordinate)
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_VERICAL ) then -- 3 一列
		-- 如果敌方打我方一列时，随机选一列
		if 1 == battleObject.battleTag then
			-- 首先找到有几列可以打，比如第2列没有人的话，就只能从1、3列选
			local arr = {}
			if (nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived) or (nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived) then
				table.insert(arr, "line_1")
			end

			if (nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived) or (nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived) then
				table.insert(arr, "line_2")
			end

			if (nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived) or (nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived) then
				table.insert(arr, "line_3")
			end

			-- 随机选一列
			local strLine = arr[math.random(#arr)]
			if strLine == "line_1" then
				if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
					table.insert(byEffectCoordinateList, 1)
				end
				if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
					table.insert(byEffectCoordinateList, 4)
				end

			elseif strLine == "line_2" then
				if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
					table.insert(byEffectCoordinateList, 2)
				end
				if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
					table.insert(byEffectCoordinateList, 5)
				end

			elseif strLine == "line_3" then
				if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
					table.insert(byEffectCoordinateList, 3)
				end
				if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
					table.insert(byEffectCoordinateList, 6)
				end
			end
 
		else
			if(headCoordinate == 1 or headCoordinate == 4)then
				if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
					table.insert(byEffectCoordinateList, 1)
				end
				if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
					table.insert(byEffectCoordinateList, 4)
				end
			elseif(headCoordinate == 2 or headCoordinate == 5)then
				if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
					table.insert(byEffectCoordinateList, 2)
				end
				if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
					table.insert(byEffectCoordinateList, 5)
				end
			elseif(headCoordinate == 3 or headCoordinate == 6)then
				if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
					table.insert(byEffectCoordinateList, 3)
				end
				if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
					table.insert(byEffectCoordinateList, 6)
				end
			end
		end

	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_HORIZONAL) then -- 4 前排	前排无数码兽时选后排
		if(headCoordinate <= 3)then
			if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
				table.insert(byEffectCoordinateList,  3)
			end
		else
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
		end
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_HORIZONAL_BACK ) then -- 5 后排	后排无数码兽时选前排
		-- if(backCoordinate > 3)then
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
		-- else
			if #byEffectCoordinateList == 0 then
				if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
					table.insert(byEffectCoordinateList,  1)
				end
				if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
					table.insert(byEffectCoordinateList,  2)
				end
				if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
					table.insert(byEffectCoordinateList,  3)
				end
			end
		-- end
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_ALL) then -- 6 全体
		--for (BattleObject byAttackObject : byAttackObjects) then
		for _, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				if(skillInfluence.influenceRestrict == 1 and battleObject.battleTag == byAttackObject.battleTag 
					and battleObject.id == byAttackObject.id)then
					--continue
				else
					table.insert(byEffectCoordinateList, byAttackObject.coordinate)
				end
			end
		end
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_HEALTH_MOST) then -- 7 血最多的1个
		local temp = {}
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				table.insert(temp,byAttackObject)
			end
		end
		for i, byAttackObject in pairs(temp) do
			table.sort(temp,function(a,b) return a.healthPoint > b.healthPoint end)
		end
		table.insert(byEffectCoordinateList,temp[1].coordinate)
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_HEALTH_LEAST) then -- 8 血量百分比最少的1个
		local temp = {}
		for i, byAttackObject in pairs(battleObjectList) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				table.insert(temp,byAttackObject)
				-- _crint("血量信息：", byAttackObject.battleTag, byAttackObject.coordinate, byAttackObject.healthPoint, byAttackObject.healthMaxPoint)
			end
		end
		if(#temp > 0) then
			table.sort(temp,function(a,b) return a.healthPoint/a.healthMaxPoint < b.healthPoint/b.healthMaxPoint end)
			table.insert(byEffectCoordinateList,temp[1].coordinate)
			-- _crint("最终选取目标的血量信息：", temp[1].battleTag, temp[1].coordinate, temp[1].healthPoint, temp[1].healthMaxPoint)
		end
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_RANDOM_1) then -- 9 随机1个
		if battleObject.lockAttackTargetPos > 0 and headCoordinate > 0 then
			table.insert(byEffectCoordinateList, headCoordinate)
		else
			if(#battleObjectList > 0)then				
				battleObjectList = Unit.getRandomWithNoRepeat(battleObjectList, 1)
				if(true ~= battleObjectList[1].isDead and true ~= battleObjectList[1].revived)then						
					table.insert(byEffectCoordinateList, battleObjectList[1].coordinate)
				end
			end
		end
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_RANDOM_2) then -- 10 随机2个
		if(#battleObjectList > 0)then				
			battleObjectList = Unit.getRandomWithNoRepeat(battleObjectList, math.min(2, #battleObjectList))
			--for (BattleObject tmp : battleObjectList) then
			for _, tmp in pairs(battleObjectList)  do
				if(true ~= tmp.isDead and true ~= tmp.revived)then							
					table.insert(byEffectCoordinateList, tmp.coordinate)
				end
			end
		end
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_RANDOM_3) then -- 11 随机3个
		if(#battleObjectList > 0)then				
			battleObjectList = Unit.getRandomWithNoRepeat(battleObjectList, math.min(3, #battleObjectList))
			--for (BattleObject tmp : battleObjectList) then
			for _, tmp in pairs(battleObjectList) do
				if(true ~= tmp.isDead and true ~= tmp.revived)then						
					table.insert(byEffectCoordinateList, tmp.coordinate)
				end
			end
		end
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_CROSS) then -- 12 十字
		if(headCoordinate == 1)then
			if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
		elseif(headCoordinate == 2)then
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
				table.insert(byEffectCoordinateList,  3)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(headCoordinate == 3)then
			if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
				table.insert(byEffectCoordinateList,  3)
			end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
		elseif(headCoordinate == 4)then
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(headCoordinate == 5)then
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
		elseif(headCoordinate == 6)then
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
				table.insert(byEffectCoordinateList,  3)
			end
		end
		
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_SP_MOST) then -- 13 怒气最高的1个
		local temp = {}
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				table.insert(temp,byAttackObject)
			end
		end
		table.sort(temp,function(a,b) return a.skillPoint > b.skillPoint end)
		table.insert(byEffectCoordinateList,temp[1].coordinate)
	elseif(influenceRange == SkillInfluence.EFFECT_RANGE_HP_lEST) then -- 14 血量最少三的
		local temp = {}
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				table.insert(temp,byAttackObject)
			end
		end
		table.sort(temp,function(a,b) return a.healthPoint < b.healthPoint end)
		local count = 0
		for i, byAttackObject in pairs(temp) do
			table.insert(byEffectCoordinateList, byAttackObject.coordinate)
			count = count + 1
			if tonumber(count) == 3 then
				break
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_RANGE_HP_LESS_THEN) then -- 15 血量低于60%的全部
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				if(byAttackObject.healthPoint < byAttackObject.healthMaxPoint) and
					((byAttackObject.healthPoint / byAttackObject.healthMaxPoint) * 100 < 60)then
					table.insert(byEffectCoordinateList,byAttackObject.coordinate)
				end
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_DEFEND_PROPERTY_TARGET) then -- 16	防属性
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				if (byAttackObject.campPreference == 2)then
					table.insert(byEffectCoordinateList,byAttackObject.coordinate)
				end
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_SKILL_PROPERTY_TARGET) then -- 17	技属性
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				if (byAttackObject.campPreference == 3)then
					table.insert(byEffectCoordinateList,byAttackObject.coordinate)
				end
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_ATTACK_PROPERTY_TARGET) then -- 18	攻属性
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				if (byAttackObject.campPreference == 1)then
					table.insert(byEffectCoordinateList,byAttackObject.coordinate)
				end
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_AFTER_SKILL_PROPERTY_TARGET) then -- 19	后排技属性	后排无数码兽时选前排技属性
		local aliveCount = 0
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived and byAttackObject.coordinate > 3)then
				if (byAttackObject.campPreference == 3)then
					table.insert(byEffectCoordinateList,byAttackObject.coordinate)
				end
				aliveCount = aliveCount + 1
			end
		end
		if aliveCount == 0 then
			for i, byAttackObject in pairs(byAttackObjects) do
				if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
					if (byAttackObject.campPreference == 3)then
						table.insert(byEffectCoordinateList,byAttackObject.coordinate)
					end
				end
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_AFTER_HP_LESS_THEN_TARGET) then -- 20	后排血最少的1个	后排无数码兽时选前排血最少的1个
		local byAttackTarget = nil
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived and byAttackObject.coordinate > 3) then
				if nil == byAttackTarget or (byAttackObject.healthPoint < byAttackTarget.healthPoint) then
					byAttackTarget = byAttackObject
				end
			end
		end
		if nil == byAttackTarget then
			for i, byAttackObject in pairs(byAttackObjects) do
				if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived) then
					if nil == byAttackTarget or (byAttackObject.healthPoint < byAttackTarget.healthPoint) then
						byAttackTarget = byAttackObject
					end
				end
			end
		end
		if nil ~= byAttackTarget then
			table.insert(byEffectCoordinateList, byAttackTarget.coordinate)
		end
	elseif(influenceRange == SkillInfluence.EFFECT_SELF_IN_COLUMN) then -- 21 自身所在列

	elseif(influenceRange == SkillInfluence.EFFECT_HP_PERCENT_LEAST) then -- 22	血量最少的1个
		local temp = {}
		for i, byAttackObject in pairs(battleObjectList) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				table.insert(temp,byAttackObject)
				-- _crint("血量信息：", byAttackObject.battleTag, byAttackObject.coordinate, byAttackObject.healthPoint, byAttackObject.healthMaxPoint)
			end
		end
		if(#temp > 0) then
			table.sort(temp,function(a,b) return a.healthPoint < b.healthPoint end)
			table.insert(byEffectCoordinateList,temp[1].coordinate)
			-- _crint("最终选取目标的血量信息：", temp[1].battleTag, temp[1].coordinate, temp[1].healthPoint, temp[1].healthMaxPoint)
		end
	elseif(influenceRange == SkillInfluence.EFFECT_ATTACK_HIGHEST) then -- 23	攻击力最高的1个
		local temp = {}
		for i, byAttackObject in pairs(battleObjectList) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				table.insert(temp,byAttackObject)
				-- _crint("攻击力信息：", byAttackObject.battleTag, byAttackObject.coordinate, byAttackObject.attack)
			end
		end
		if(#temp > 0) then
			table.sort(temp,function(a,b) return a.attack > b.attack end)
			table.insert(byEffectCoordinateList,temp[1].coordinate)
			-- _crint("最终选取目标的攻击力信息：", temp[1].battleTag, temp[1].coordinate, temp[1].attack)
		end
	elseif(influenceRange == SkillInfluence.EFFECT_RANDOM_LIMIT_3) then -- 24  随机3个（随机选择不到人时，继续选择当前攻击目标）
		local temp = {}
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived) then
				table.insert(temp, byAttackObject)
			end
		end
		
		while #temp > 3 do
			local pos = math.random(1, #temp)
			table.remove(temp, pos, 1)
		end

		if #temp > 0 then
			for i, v in pairs(temp) do
				table.insert(byEffectCoordinateList, v.coordinate)
			end
			for i = #byEffectCoordinateList, 3 do
				table.insert(byEffectCoordinateList, temp[#temp].coordinate)
			end
		end
	elseif(influenceRange == SkillInfluence.EFFECT_AFTER_ROW_RANDOM_LIMIT_1) then -- 25	后排随机1个	后排无数码兽时选前排随机1个	
		local temp = {}
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived and byAttackObject.coordinate > 3) then
				table.insert(temp, byAttackObject)
			end
		end

		if #temp == 0 then
			for i, byAttackObject in pairs(byAttackObjects) do
				if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived) then
					table.insert(temp, byAttackObject)
				end
			end
		end
		local len = #temp
		if len > 0 then
			table.insert(byEffectCoordinateList,temp[math.random(1, len)].coordinate)
		end
	elseif (influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_26) then -- 26	中心点的十字范围（不包括中心）
		-- local pos = battleObject.lastByAttackTarget.coordinate
		-- if byAttackObjects[pos - 1] ~= nil then
		-- 	table.insert(byEffectCoordinateList, pos - 1)
		-- end
		-- if byAttackObjects[pos + 1] ~= nil then
		-- 	table.insert(byEffectCoordinateList, pos + 1)
		-- end
		-- if byAttackObjects[pos - 3] ~= nil then
		-- 	table.insert(byEffectCoordinateList, pos - 3)
		-- end
		-- if byAttackObjects[pos + 3] ~= nil then
		-- 	table.insert(byEffectCoordinateList, pos + 3)
		-- end
		if(headCoordinate == 1)then
			-- if(nil ~= byAttackObjects[1])then
			-- 	table.insert(byEffectCoordinateList,  1)
			-- end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
		elseif(headCoordinate == 2)then
			-- if(nil ~= byAttackObjects[2])then
			-- 	table.insert(byEffectCoordinateList,  2)
			-- end
			if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
				table.insert(byEffectCoordinateList,  3)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(headCoordinate == 3)then
			-- if(nil ~= byAttackObjects[3])then
			-- 	table.insert(byEffectCoordinateList,  3)
			-- end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
		elseif(headCoordinate == 4)then
			-- if(nil ~= byAttackObjects[4])then
			-- 	table.insert(byEffectCoordinateList,  4)
			-- end
			if(nil ~= byAttackObjects[1] and true ~= byAttackObjects[1].isDead and true ~= byAttackObjects[1].revived)then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(headCoordinate == 5)then
			-- if(nil ~= byAttackObjects[5])then
			-- 	table.insert(byEffectCoordinateList,  5)
			-- end
			if(nil ~= byAttackObjects[4] and true ~= byAttackObjects[4].isDead and true ~= byAttackObjects[4].revived)then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[6] and true ~= byAttackObjects[6].isDead and true ~= byAttackObjects[6].revived)then
				table.insert(byEffectCoordinateList,  6)
			end
			if(nil ~= byAttackObjects[2] and true ~= byAttackObjects[2].isDead and true ~= byAttackObjects[2].revived)then
				table.insert(byEffectCoordinateList,  2)
			end
		elseif(headCoordinate == 6)then
			-- if(nil ~= byAttackObjects[6])then
			-- 	table.insert(byEffectCoordinateList,  6)
			-- end
			if(nil ~= byAttackObjects[5] and true ~= byAttackObjects[5].isDead and true ~= byAttackObjects[5].revived)then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[3] and true ~= byAttackObjects[3].isDead and true ~= byAttackObjects[3].revived)then
				table.insert(byEffectCoordinateList,  3)
			end
		end
	elseif (influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_27) then -- 27	前排防属性	前排无数码兽时选后排防属性
		local temp = {}
		local aliveCount = 0
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived and byAttackObject.coordinate <= 3) then
				if byAttackObject.campPreference == 2 then
					table.insert(byEffectCoordinateList, byAttackObject.coordinate)
				end
				aliveCount = aliveCount + 1
			end
		end
		if aliveCount == 0 then
			for i, byAttackObject in pairs(byAttackObjects) do
				if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived) then
					if byAttackObject.campPreference == 2 then
						table.insert(byEffectCoordinateList, byAttackObject.coordinate)
					end
					aliveCount = aliveCount + 1
				end
			end
		end
	elseif (influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_28) then -- 28	剩余里随机1个，在同一回合攻击的时候，如果没有剩余可攻击的目标，清除记录状态，重新选
		if nil == battleObject.battleObjectList or #battleObject.battleObjectList == 0 then
			battleObject.battleObjectList = battleObjectList

		end
		local len = #battleObject.battleObjectList
		for i = 1, len do
			local byAttackTarget = battleObject.battleObjectList[i]
			if true == byAttackTarget.isDead and true ~= byAttackTarget.revived then
				table.remove(battleObject.battleObjectList, i, 1)
			end
		end
		len = #battleObject.battleObjectList
		if len > 0 then
			local randomPos = math.random(1, #battleObject.battleObjectList)
			local byAttackTarget = table.remove(battleObject.battleObjectList, randomPos, 1)
			table.insert(byEffectCoordinateList, byAttackTarget.coordinate)
		end
	elseif (influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_29) then -- 29	剩余里随机4个
		if(#battleObjectList > 0)then				
			battleObjectList = Unit.getRandomWithNoRepeat(battleObjectList, math.min(4, #battleObjectList))
			--for (BattleObject tmp : battleObjectList) then
			for _, tmp in pairs(battleObjectList) do
				if(true ~= tmp.isDead and true ~= tmp.revived)then						
					table.insert(byEffectCoordinateList, tmp.coordinate)
				end
			end
		end
	elseif (influenceRange == SkillInfluence.EFFECT_AFTER_SELECT_TARGET_FOR_30) then -- 30	自己所在的一排
		for i, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject and true ~= byAttackObject.isDead and true ~= byAttackObject.revived)then
				if ((battleObject.coordinate <= 3 and  byAttackObject.coordinate <= 3) or (battleObject.coordinate > 3 and  byAttackObject.coordinate > 3))then
					table.insert(byEffectCoordinateList,byAttackObject.coordinate)
				end
			end
		end
	end
	-- print("目标选择类型：", influenceRange)
	return byEffectCoordinateList
end

function FightUtil.computeCounterCoordinate(attackerCoordinate, skillInfluence, battleObject, byAttackObjects)
	local influenceRange = skillInfluence.influenceRange
	local battleObjectList = {}
	--for (BattleObject tmpBattleObject : byAttackObjects) then
	for _, tmpBattleObject in pairs(byAttackObjects) do
		table.insert(battleObjectList, tmpBattleObject)
	end
	local byEffectCoordinateList = {}
	--switch(influenceRange)then
	if  (influenceRange == SkillInfluence.EFFECT_RANGE_SINGLE ) then
		table.insert(byEffectCoordinateList, attackerCoordinate)
		--break
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_VERICAL ) then
		if(attackerCoordinate == 1 or attackerCoordinate == 4)then
			if(nil ~= byAttackObjects[1])then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[4])then
				table.insert(byEffectCoordinateList,  4)
			end
		elseif(attackerCoordinate == 2 or attackerCoordinate == 5)then
			if(nil ~= byAttackObjects[2])then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[5])then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(attackerCoordinate == 3 or attackerCoordinate == 6)then
			if(nil ~= byAttackObjects[3])then
				table.insert(byEffectCoordinateList,  3)
			end
			if(nil ~= byAttackObjects[6])then
				table.insert(byEffectCoordinateList,  6)
			end
		end
		--break
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_HORIZONAL ) then
		if(attackerCoordinate <= 3)then
			if(nil ~= byAttackObjects[1])then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[2])then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[3])then
				table.insert(byEffectCoordinateList,  3)
			end
		else
			if(nil ~= byAttackObjects[4])then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[5])then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[6])then
				table.insert(byEffectCoordinateList,  6)
			end
		end
		--break
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_ALL ) then
		--for (BattleObject byAttackObject : byAttackObjects) then
		for _, byAttackObject in pairs(byAttackObjects) do
			if(nil ~= byAttackObject)then
				if(skillInfluence.influenceRestrict == 1 and battleObject.battleTag == byAttackObject.battleTag and battleObject.id == byAttackObject.id)then
					--continue
				else
					table.insert(byEffectCoordinateList, byAttackObject.coordinate)
				end
			end
		end
		--break
	elseif (influenceRange == SkillInfluence.EFFECT_RANGE_CROSS ) then
		if(attackerCoordinate == 1)then
			if(nil ~= byAttackObjects[1])then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[2])then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[4])then
				table.insert(byEffectCoordinateList,  4)
			end
		elseif(attackerCoordinate == 2)then
			if(nil ~= byAttackObjects[2])then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[1])then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[3])then
				table.insert(byEffectCoordinateList,  3)
			end
			if(nil ~= byAttackObjects[5])then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(attackerCoordinate == 3)then
			if(nil ~= byAttackObjects[3])then
				table.insert(byEffectCoordinateList,  3)
			end
			if(nil ~= byAttackObjects[2])then
				table.insert(byEffectCoordinateList,  2)
			end
			if(nil ~= byAttackObjects[6])then
				table.insert(byEffectCoordinateList,  6)
			end
		elseif(attackerCoordinate == 4)then
			if(nil ~= byAttackObjects[4])then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[1])then
				table.insert(byEffectCoordinateList,  1)
			end
			if(nil ~= byAttackObjects[5])then
				table.insert(byEffectCoordinateList,  5)
			end
		elseif(attackerCoordinate == 5)then
			if(nil ~= byAttackObjects[5])then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[4])then
				table.insert(byEffectCoordinateList,  4)
			end
			if(nil ~= byAttackObjects[6])then
				table.insert(byEffectCoordinateList,  6)
			end
			if(nil ~= byAttackObjects[2])then
				table.insert(byEffectCoordinateList,  2)
			end
		elseif(attackerCoordinate == 6)then
			if(nil ~= byAttackObjects[6])then
				table.insert(byEffectCoordinateList,  6)
			end
			if(nil ~= byAttackObjects[5])then
				table.insert(byEffectCoordinateList,  5)
			end
			if(nil ~= byAttackObjects[3])then
				table.insert(byEffectCoordinateList,  3)
			end
		end
		--break
	end
	return byEffectCoordinateList
end

function FightUtil.checkNegativeBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	if byAttackObject.buffNegativeImmunityStatus == true then
		if nil ~= effectBuffer then
		    local bs = BattleSkill:new()
		    bs.byAttackerTag = byAttackObject.battleTag
		    bs.byAttackerCoordinate = byAttackObject.coordinate
		    bs.isDisplay = 1
		    bs.effectType = BattleSkill.SKILL_INFUENCE_RESULT_FOR_78
		    bs.effectValue = 0
		    bs:writeSkillAttack(userInfo, attackObject, byAttackObject, fightModule, effectBuffer)
		    battleSkill.effectAmount = battleSkill.effectAmount + 1	
	    end
		return false
	end
	return true
end

function FightUtil.checkSkillInfluenceProbability(skillInfluence, attackObject, byAttackObject)
	--[[
		⑩免控率=	免控率[44] + 战外面板免控率/100
		⑪控制率=	控制率[47] + 战外面板控制率/100
			
		规则：	1.若效用的技能类型不在配置中，则触发概率为 skill_influence 第10字段
			2.若效用的技能类型在配置中，则触发概率 =  skill_influence 第10字段 + 攻方控制率*100 - 守方免控率*100
	--]]
	local probability = skillInfluence.additionEffectProbability
	-- if nil ~= FightModule.ifids then
		-- for i, v in pairs(FightModule.ifids) do
		-- 	if v == skillInfluence.skillCategory then
				local P10 = byAttackObject.avoidControlPercent * 100 + byAttackObject.fightObject.avoidControlPercent
				local P11 = attackObject.controlPercent * 100 + attackObject.fightObject.controlPercent
				probability = probability + P11 - P10
	-- 			break
	-- 		end
	-- 	end
	-- end
	-- print("免控率vs控制率:", probability, byAttackObject.avoidControlPercent, byAttackObject.fightObject.avoidControlPercent, P10, attackObject.controlPercent, attackObject.fightObject.controlPercent, P11)
	return probability
end

function FightUtil.computeRandomSkillEffectValue(skillInfluence)
	local skillEffectValue = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMaxValue)
	if(skillInfluence.isRate == 0)then
		skillEffectValue = skillEffectValue / 100
	end
	return skillEffectValue
end

function FightUtil.computeRandomValue()
	
	local val = (math.random(20) + 90) / 100
	--_crint ("Random value: " .. val)
	return val
end

function FightUtil.computeCommonDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	print("计算普通攻击伤害")
	if(attackObject.isCripple)then
		effectArray[1] = 0
		attackObject.effectDamage=0
		return
	end
	local finalDamage = 0
	if(true ~= byAttackObject.isNoDamage)then
		local total = 0
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--[[
				公式1（普通攻击）	普攻伤害=	if( (攻方攻击力[1] * 破防系数A) > (攻方攻击力[1] - 防方防御力[2])，（攻方攻击力[1] * 破防系数A），（攻方攻击力[1] - 防方防御力[2]））
										*（1 + 攻方伤害加成[33] - 防方伤害减免[34]）
										*系数F之间纯随机（0.95-1.05）
										*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）

				
				①攻击力=	攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
				②防御力=	防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
					
				③暴伤强度=	暴伤强度[43]
				④格挡强度=	格挡强度[46]
				⑤伤害加成=	伤害加成[33] 
				⑥伤害减免=	伤害减免[34]
				⑦必杀伤害率=	必杀伤害率[55] + 战外面板必杀伤害率
				⑧增加必杀伤害=	增加必杀伤害[56] + 战外面板增加必杀伤害
				⑨增加必杀抗性=	增加必杀抗性[73] + 战外面板增加必杀抗性
				⑩免控率=	免控率[44] + 战外面板免控率
				⑪控制率=	控制率[47] + 战外面板控制率
				⑫治疗效果增加=	治疗效果增加[16] + 战外面板治疗效果增加
					
				⑮反弹率=	反弹率[42] + 战外面板反弹率
				⑯小技能触发概率=	小技能触发概率[45] + 战外面板小技能触发概率
				⑰怒气回复速度=	怒气回复速度[61] + 战外面板怒气回复速度
				⑱吸血率=	吸血率[40] + 战外面板吸血率
				⑲被治疗效果增加=	被治疗效果增加[17] + 战外面板被治疗效果增加
					
					
				⑬克制伤害加成=	若攻方克制守方，值 = (克制伤害加成[70] + 战外面板克制伤害加成) ；若不克制，则为0。（先判断攻方类型，再判断守方类型。 攻方类型[1]、守方类型[3] ; 攻方类型[2]、守方类型[1] ; 攻方类型[3]、守方类型[2] 时为克制关系 ）
				⑭克制伤害减免=	若守方克制攻方，值 = (克制伤害减免[71] + 战外面板克制伤害减免) ；若不克制，则为0。（先判断守方类型，再判断攻方类型。 守方类型[1]、攻方类型[3] ; 守方类型[2]、攻方类型[1] ; 守方类型[3]、攻方类型[2] 时为克制关系 ）

					（注：攻击、防御、克制伤害加成、克制伤害减免 取上方计算值）	
				公式1（普通攻击）	普攻伤害=	if( (攻方攻击力① * 破防系数A) > (攻方攻击力① - 防方防御力②)，（攻方攻击力① * 破防系数A），（攻方攻击力① * 技能百分比[说明1] / 100 - 防方防御力②））
						* max（下限值系数MIN ，（1 + 攻方伤害加成⑤  - 防方伤害减免⑥  - 防方受到直接伤害降低[62] ）)
					 	* max（下限值系数MIN ，（1 + 攻方克制伤害加成⑬ -  防方克制伤害减免⑭ + 攻方伤害提升[54] ）)
						* 系数F之间纯随机（0.95-1.05）
						*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）
			--]]

			-- @version 1.0
			-- local cia = attackObject.attack - byAttackObject.physicalDefence
			-- if (attackObject.attack * FightModule.frA) > cia then
			-- 	total = (attackObject.attack) * FightModule.frA
			-- else
			-- 	total = cia
			-- end
			-- local frF = math.random(FightModule.frF1, FightModule.frF2) / 100
			-- finalDamage = -- math.floor(
			-- 		total
			-- 		* (1 + attackObject.finalDamagePercent - byAttackObject.finalLessenDamagePercent)
			-- 		* frF
			-- 	-- )

			-- @version 1.1
			local P1 = attackObject.attack - byAttackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63) -- ①攻击力=	攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
			local P2 = byAttackObject.physicalDefence - byAttackObject.ptvf64 + byAttackObject.fightObject.physicalDefence * (byAttackObject.intellectAdditionalPercent - byAttackObject.ptvf68) -- ②防御力=	防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
			local P3 = attackObject.uniqueSkillDamagePercent
			local P4 = byAttackObject.uniqueSkillResistancePercent
			local P5 = attackObject.finalDamagePercent * (1 + attackObject.ptvf65)
				+ attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 33 )
			local P6 = byAttackObject.finalLessenDamagePercent

			local P13 = 0
			if (1 == attackObject.campPreference and 3 == byAttackObject.campPreference)
				or (2 == attackObject.campPreference and 1 == byAttackObject.campPreference)
				or (3 == attackObject.campPreference and 2 == byAttackObject.campPreference)
				then
				P13 = attackObject.ptvf70 + attackObject.fightObject.ptvf70
			end

			local P14 = 0
			if (1 == byAttackObject.campPreference and 3 == attackObject.campPreference)
				or (2 == byAttackObject.campPreference and 1 == attackObject.campPreference)
				or (3 == byAttackObject.campPreference and 2 == attackObject.campPreference)
				then
				P14 = byAttackObject.ptvf71 + byAttackObject.fightObject.ptvf71
			end

			local cia = P1 - P2
			local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
			if (P1 * FightModule.frA) > cia then
				total = P1 * FightModule.frA
			else
				total = P1 * ifvf - P2
			end

			local frF = math.random(FightModule.frF1, FightModule.frF2) / 100

			local ptvf54 = attackObject.ptvf54 + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 54 )

			finalDamage = total
				* math.max(FightModule.lvf, (1 + P5 - P6 - byAttackObject.ptvf62))
				* math.max(FightModule.lvf, (1 + P13 - P14 + ptvf54))
				* frF

			if attackObject.isCritical then
				-- -- 造成的最终伤害值 * （1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数C + 增加暴击伤害[58] - 减少暴击伤害[59]）
				-- finalDamage = finalDamage * (1 + FightModule.frB + attackObject.uniqueSkillDamagePercent * FightModule.frC + attackObject.ptvf58 - byAttackObject.ptvf59)

				-- 暴击伤害=	攻方造成的伤害值 * （1 + ( 暴击伤害系数B + 攻方暴击强度③ * 暴击强度系数C ）* （ 1 + 攻方增加暴击伤害[58] - 攻方减少暴击伤害[59]））
				finalDamage = finalDamage * (1 + (FightModule.frB + P3 * FightModule.frC) * (1 + attackObject.ptvf58 - attackObject.ptvf59))
			end

			if byAttackObject.isRetain then
				-- -- 格挡伤害=	造成的最终伤害值 * （1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）
				-- finalDamage = finalDamage * (1 - FightModule.frD - byAttackObject.uniqueSkillResistancePercent * FightModule.frE)

				-- 格挡伤害=	造成的伤害值 *  max（下限值系数MIN ，（1 - 格挡伤害系数D - 防方格挡强度④ * 格挡强度系数E））
				finalDamage = finalDamage * math.max(FightModule.lvf, (1 - FightModule.frD - P4 * FightModule.frE))
			end

			finalDamage = math.floor(finalDamage)

			-- print("--------------------------------------\r\n公式1（普通攻击）：\r\n",
			-- 		"攻方攻击力[1]：", attackObject.attack, "\r\n",
			-- 		"防方防御力[2]：", byAttackObject.physicalDefence, "\r\n",
			-- 		"破防系数A：", FightModule.frA, "\r\n",
			-- 		"攻方伤害加成[33]：", attackObject.finalDamagePercent, "\r\n",
			-- 		"防方伤害减免[34]：", byAttackObject.finalLessenDamagePercent, "\r\n",
			-- 		"系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
			-- 		"破防值：", cia, "\r\n",
			-- 		"基础伤害：", total, "\r\n",
			-- 		"最终的伤害：", finalDamage, "\r\n",
			-- 		"暴击：", attackObject.isCritical, "\r\n",
			-- 		"暴击伤害系数B：", FightModule.frB, "\r\n",
			-- 		"攻方暴击强度[43]：", attackObject.uniqueSkillDamagePercent, "\r\n",
			-- 		"暴击强度系数C：", FightModule.frC, "\r\n",
			-- 		"增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
			-- 		"减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
			-- 		"格挡：", byAttackObject.isRetain, "\r\n",
			-- 		"格挡伤害系数D：", FightModule.frD, "\r\n",
			-- 		"防方格挡强度[46]：", byAttackObject.uniqueSkillResistancePercent, "\r\n",
			-- 		"格挡强度系数E：", FightModule.frE, "\r\n",
			-- 		"连击加成：", attackObject.grade_attack, "\r\n",
			-- 		"--------------------------------------\r\n"
			-- 	)

			-- _crint("--------------------------------------\r\n公式1（普通攻击）：\r\n",
			-- 		"①攻击力：", P1, "\r\n",
			-- 			"\t攻击[1]：", attackObject.attack, "\r\n",
			-- 			"\t降低攻击[72]：", attackObject.ptvf72, "\r\n",
			-- 			"\t战外面板攻击：", attackObject.fightObject.attack, "\r\n",
			-- 			"\t攻击增加百分比[5]：", attackObject.courageAdditionalPercent, "\r\n",
			-- 			"\t攻击降低百分比[63]：", attackObject.ptvf63, "\r\n",
			-- 		"②防御力：", P2, "\r\n",
			-- 			"\t防御[2]：", byAttackObject.physicalDefence, "\r\n",
			-- 			"\t降低防御[64]：", byAttackObject.ptvf64, "\r\n",
			-- 			"\t战外面板防御：", byAttackObject.fightObject.physicalDefence, "\r\n",
			-- 			"\t防御增加百分比[6]：", byAttackObject.intellectAdditionalPercent, "\r\n",
			-- 			"\t防御降低百分比[68]：", byAttackObject.ptvf68, "\r\n",
			-- 		"最终的伤害：", finalDamage, "\r\n",
			-- 			"\t破防系数A：", FightModule.frA, "\r\n",
			-- 			"\t技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
			-- 			"\t下限值系数MIN：", FightModule.lvf, "\r\n",
			-- 			"\t攻方伤害加成⑤：", P5, "\r\n",
			-- 			"\t防方伤害减免⑥：", P6, "\r\n",
			-- 			"\t防方受到直接伤害降低[62]：", byAttackObject.ptvf62, "\r\n",
			-- 			"\t攻方克制伤害加成⑬：", P13, "\r\n",
			-- 			"\t防方克制伤害减免⑭：", P14, "\r\n",
			-- 			"\t攻方伤害提升[54]：", ptvf54, "\r\n",
			-- 			"\t系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
			-- 		"暴击伤害：", attackObject.isCritical, "\r\n",
			-- 			"\t暴击伤害系数B：", FightModule.frB, "\r\n",
			-- 			"\t攻方暴击强度③：", P3, "\r\n",
			-- 			"\t暴击强度系数C：", FightModule.frC, "\r\n",
			-- 			"\t攻方增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
			-- 			"\t攻方减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
			-- 		"格挡伤害：", byAttackObject.isRetain, "\r\n",
			-- 			"\t格挡伤害系数D：", FightModule.frD, "\r\n",
			-- 			"\t防方格挡强度④：", P4, "\r\n",
			-- 			"\t格挡强度系数E：", FightModule.frE, "\r\n",
			-- 		"--------------------------------------\r\n"
			-- 	)
		else
			if(skillMould.skillProperty==0)then
				total = math.floor ((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.skillAttackAdd + attackObject.physicalAttackAdd 
				+ attackObject.restrainObject.attackAdditional+ attackObject.restrainObject.physicAttackAdditional)
				--_crint ("Total 1 = " .. total)
				finalDamage =math.floor((total - byAttackObject.physicalDefence * (100 + byAttackObject.addPhysicalDefPercent - byAttackObject.decPhysicalDefPercent) / 100 
						- byAttackObject.restrainObject.physicDefenceAddtional)
							 * FightUtil.computeRandomSkillEffectValue(skillInfluence)
							 * FightUtil.computeRandomValue()
							 + attackObject.finalDamageAddition-byAttackObject.finalSubDamageAddition
							 + attackObject.restrainObject.finalAdditionalDamage - byAttackObject.restrainObject.finalLessenDamage)
			else
				total = math.floor ((attackObject.attack + attackObject.addAttack)  * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.skillAttackAdd
				+ attackObject.restrainObject.attackAdditional + attackObject.skillAttackAdd)
				--_crint ("Total 2 = " .. total)
				finalDamage =math.floor((total - byAttackObject.skillDefence * (100 + byAttackObject.addSkillDefPercent - byAttackObject.decSkillDefPercent) / 100
						- byAttackObject.restrainObject.skillDefenceAddtional)
						 * FightUtil.computeRandomSkillEffectValue(skillInfluence)
						 * FightUtil.computeRandomValue()
						 + attackObject.finalDamageAddition-byAttackObject.finalSubDamageAddition
						 + attackObject.restrainObject.finalAdditionalDamage - byAttackObject.restrainObject.finalLessenDamage)
			end
			finalDamage = math.floor (finalDamage * attackObject.critialMultiple)
		end
	end
	--_crint( "FightUtil " .. finalDamage)
	if (1 > finalDamage) then
		finalDamage = 1
	end
	local finalDamagePercent = attackObject.finalDamagePercent + attackObject.addFinalDamagePercent + byAttackObject.addBruiseDamagePercent
	+ attackObject.restrainObject.finalAdditionalDamagePercentage
	local finalLessenDamagePercent =  byAttackObject.finalLessenDamagePercent
	+ byAttackObject.restrainObject.finalAdditionalDamagePercentage
	if(byAttackObject.isEvasion)then
		finalDamage = 0
	else
		--for (Iterator<TalentJudgeResult> talentIter = attackObject.talentJudgeResultList.iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(attackObject.talentJudgeResultList) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
			for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			if (talentJudgeResult.resultType == TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT ) then
				finalDamagePercent = finalDamagePercent + talentJudgeResult.percentValue
				--break
			elseif (talentJudgeResult.resultType == TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT) then
				finalLessenDamagePercent = finalLessenDamagePercent + talentJudgeResult.percentValue
				--break
			elseif (talentJudgeResult.resultType == TalentConstant.JUDGE_RESULT_DAMAGE_HP_UPPER_LIMIT_PERCENT) then
				finalLessenDamagePercent = finalLessenDamagePercent + talentJudgeResult.percentValue
				--break
			end
		end
		--for (Iterator<TalentJudgeResult> talentIter = attackObject.getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
		for _, 	talentJudgeResult in pairs(attackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
			for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			finalDamagePercent = finalDamagePercent + talentJudgeResult.percentValue
		end
		--for (Iterator<TalentJudgeResult> talentIter = byAttackObject.getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : attackObject.talentImmunityList) then
			for _, talentImmunity in pairs(attackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			finalLessenDamagePercent = finalLessenDamagePercent + talentJudgeResult.percentValue
		end
		if(finalDamagePercent > 0)then
			finalDamage = finalDamage * (1 + finalDamagePercent / 100.0)
		end
		if(finalLessenDamagePercent > 0)then
			finalDamage = finalDamage * (1 - finalLessenDamagePercent / 100.0)
		end
		--for (Iterator<TalentJudgeResult> talentIter = byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_DAMAGE_HP_UPPER_LIMIT_PERCENT).iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_DAMAGE_HP_UPPER_LIMIT_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : attackObject.talentImmunityList) then
			for _, talentImmunity in pairs(attackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			local damagePercent = finalDamage / byAttackObject.healthMaxPoint
			if(damagePercent > talentJudgeResult.percentValue)then
				finalDamage = math.floor (byAttackObject.healthMaxPoint * talentJudgeResult.percentValue)
				break
			end
		end
	end
	
	print("普通攻击 attackObject.grade_attack: " .. attackObject.grade_attack)

	finalDamage = finalDamage * attackObject.grade_attack
	if(tonumber(finalDamage) < 1)then
		finalDamage = 1
	end

	if (true == byAttackObject.isNoDamage) then
		finalDamage = 0
	end
	
	if(attackObject.battleTag == 0)then
		if _ED.user_info.battleCache ~= nil then
			_ED.user_info.battleCache:addTotalDamage(finalDamage)
		end
	end
	-- --_crint ("Final damage is: " .. attackObject.grade_attack)
	byAttackObject:subHealthPoint(finalDamage)
	attackObject.effectDamage = finalDamage
	byAttackObject.reboundDamageValueResult = byAttackObject.reboundDamageValueResult + byAttackObject.reboundDamageValue * finalDamage
	effectArray[1] = finalDamage
end

function FightUtil.computeReAttackDamage(attackObject, byAttackObject)
	local finalDamage = 0
	local damageFormulaA = math.floor (((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 - byAttackObject.physicalDefence * (100 + byAttackObject.addPhysicalDefPercent - byAttackObject.decPhysicalDefPercent) / 100)
			* (1) 
			* FightUtil.computeRandomSkillEffectValue(attackObject.commonBattleSkill[1].skillInfluence) 
			+ attackObject.finalDamageAddition 
			- byAttackObject.finalSubDamageAddition)
	local damageFormulaB = math.floor (((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100
			* FightUtil.computeRandomSkillEffectValue(attackObject.commonBattleSkill[1].skillInfluence) 
			+ attackObject.finalDamageAddition 
			- byAttackObject.finalSubDamageAddition)
			* 0.23)
	--finalDamage = math.floor damageFormulaA >= damageFormulaB ? damageFormulaA : damageFormulaB
	finalDamage = damageFormulaB;
	if (damageFormulaA >= damageFormulaB) then
		finalDamage = damageFormulaA
	end
	if (1 > finalDamage) then
		finalDamage = 1
	end
	local finalDamagePercent = attackObject.finalDamagePercent + attackObject.addFinalDamagePercent
	local finalLessenDamagePercent =  byAttackObject.finalLessenDamagePercent + byAttackObject.addBruiseDamagePercent
	--for (Iterator<TalentJudgeResult> talentIter = attackObject.getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
	for _, talentJudgeResult in pairs(attackObject.getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT)) do
		--TalentJudgeResult talentJudgeResult = talentIter.next()
		local immunity = false
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
				immunity = true
				break
			end
		end
		if(immunity)then
			break
		end
		finalDamagePercent = finalDamagePercent + talentJudgeResult.percentValue
	end
	--for (Iterator<TalentJudgeResult> talentIter = byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
	for _,  talentJudgeResult in pairs(byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT)) do
		--TalentJudgeResult talentJudgeResult = talentIter.next()
		local immunity = false
		--for (TalentImmunity talentImmunity : attackObject.talentImmunityList) then
		for _, talentImmunity in pairs(attackObject.talentImmunityList) do
			if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
				immunity = true
				break
			end
		end
		if(immunity)then
			break
		end
		finalLessenDamagePercent = finalLessenDamagePercent + talentJudgeResult.percentValue
	end
	if(finalDamagePercent > 0)then
		finalDamage = finalDamage * (1 + finalDamagePercent / 100)
	end
	if(finalLessenDamagePercent > 0)then
		finalDamage = finalDamage * (1 - finalLessenDamagePercent / 100)
	end
	
	finalDamage = finalDamag * attackObject.grade_attack
	-- if(attackObject.battleTag == 0)then
		-- local userInfo = UserDB.getUserInfoWithUserInfoId(attackObject.userInfo + "", false)
		-- if(nil ~= userInfo and nil ~= userInfo.battleCache)then
			-- local templocal = userInfo.battleCache
			-- tempBattleCache.addTotalDamage(finalDamage)
		-- end
	-- end
	finalDamage = finalDamage * attackObject.grade_attack
	if(attackObject.battleTag == 0)then
		if _ED.user_info.battleCache ~= nil then
			_ED.user_info.battleCache:addTotalDamage(finalDamage)
		end
	end
	byAttackObject:subHealthPoint(finalDamage)
	attackObject.effectDamage=finalDamage
	return finalDamage
end

function FightUtil.computeSpecialDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	print("计算必杀技伤害")
	-- print(debug.traceback())
	local finalDamage = 0
	if(attackObject.isCripple)then	
		effectArray[1] = finalDamage
		attackObject.effectDamage=finalDamage
		return
	end
	if(true ~= byAttackObject.isNoDamage)then			
		local total = 0
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--[[
				公式2（怒气攻击）	必杀技伤害=	if( (攻方攻击力[1] * 破防系数A) > (攻方攻击力[1] - 防方防御力[2])，（攻方攻击力[1] * (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
											（攻方攻击力[1] - 防方防御力[2]）* (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
											*（1 + 攻方伤害加成[33] - 防方伤害减免[34] + 攻方必杀伤害率[55]）
											*（1 + 攻方伤害提升[54] + 增加必杀伤害[56] - 减少必杀伤害[57])
											* 系数F之间纯随机（0.95-1.05）
											*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）
					（注：攻击、防御、克制伤害加成、克制伤害减免 取上方计算值）	
				公式2（怒气攻击）	必杀技伤害=	if( (攻方攻击力① * 破防系数A) > (攻方攻击力① - 防方防御力②)，（攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
						（攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
						* max（下限值系数MIN ，（1 + 攻方伤害加成⑤ - 防方伤害减免⑥ + 攻方必杀伤害率⑦ - 攻方降低必杀伤害率[66] - 防方受到直接伤害降低[62] ）)
						* max（下限值系数MIN ，（1 + 攻方克制伤害加成⑬ -  防方克制伤害减免⑭ + 攻方伤害提升[54] + 攻方增加必杀伤害⑧ - 攻方减少必杀伤害[57] + 防方受到的必杀伤害增加[60] - 防方增加必杀抗性⑨ + 防方减少必杀抗性[74] ) )
						* 系数F之间纯随机（0.95-1.05）
			--]]
			-- @version 1.1
			local P1 = attackObject.attack - byAttackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63) -- ①攻击力=	攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
			local P2 = byAttackObject.physicalDefence - byAttackObject.ptvf64 + byAttackObject.fightObject.physicalDefence * (byAttackObject.intellectAdditionalPercent - byAttackObject.ptvf68) -- ②防御力=	防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
			local P3 = attackObject.uniqueSkillDamagePercent
			local P4 = byAttackObject.uniqueSkillResistancePercent
			local P5 = attackObject.finalDamagePercent * (1 + attackObject.ptvf65)
				+ attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 33 )
			local P6 = byAttackObject.finalLessenDamagePercent
			local P7 = attackObject.ptvf55 -- + attackObject.fightObject.ptvf55 / 100
			local P8 = attackObject.ptvf56 -- + attackObject.fightObject.ptvf56 / 100
			local P9 = byAttackObject.ptvf73 -- + attackObject.fightObject.ptvf73 / 100

			local P13 = 0
			if (1 == attackObject.campPreference and 3 == byAttackObject.campPreference)
				or (2 == attackObject.campPreference and 1 == byAttackObject.campPreference)
				or (3 == attackObject.campPreference and 2 == byAttackObject.campPreference)
				then
				P13 = attackObject.ptvf70 + attackObject.fightObject.ptvf70
			end

			local P14 = 0
			if (1 == byAttackObject.campPreference and 3 == attackObject.campPreference)
				or (2 == byAttackObject.campPreference and 1 == attackObject.campPreference)
				or (3 == byAttackObject.campPreference and 2 == attackObject.campPreference)
				then
				P14 = byAttackObject.ptvf71 + byAttackObject.fightObject.ptvf71
			end

			local cia = P1 - P2
			local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
			if (P1 * FightModule.frA) > cia then
				-- （攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
				total = ( P1 * ( ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100 ) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue ) * FightModule.frA
			else
				-- （攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
				total = cia * (ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
			end

			local frF = math.random(FightModule.frF1, FightModule.frF2) / 100

			local ptvf66 = attackObject.ptvf66 + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 66 )
			local ptvf54 = attackObject.ptvf54 + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 54 )

			finalDamage = total
				* math.max(FightModule.lvf, (1 + P5 - P6 + P7 - ptvf66 - byAttackObject.ptvf62))
				* math.max(FightModule.lvf, (1 + P13 - P14 + ptvf54 + P8 - attackObject.ptvf57 + byAttackObject.ptvf60 - P9 + byAttackObject.ptvf74))
				* frF

			if attackObject.isCritical then
				-- -- 造成的最终伤害值 * （1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数C + 增加暴击伤害[58] - 减少暴击伤害[59]）
				-- finalDamage = finalDamage * (1 + FightModule.frB + attackObject.uniqueSkillDamagePercent * FightModule.frC + attackObject.ptvf58 - byAttackObject.ptvf59)

				-- 暴击伤害=	攻方造成的伤害值 * （1 + ( 暴击伤害系数B + 攻方暴击强度③ * 暴击强度系数C ）* （ 1 + 攻方增加暴击伤害[58] - 攻方减少暴击伤害[59]））
				finalDamage = finalDamage * (1 + (FightModule.frB + P3 * FightModule.frC) * (1 + attackObject.ptvf58 - attackObject.ptvf59))
			end

			if byAttackObject.isRetain then
				-- -- 格挡伤害=	造成的最终伤害值 * （1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）
				-- finalDamage = finalDamage * (1 - FightModule.frD - byAttackObject.uniqueSkillResistancePercent * FightModule.frE)

				-- 格挡伤害=	造成的伤害值 *  max（下限值系数MIN ，（1 - 格挡伤害系数D - 防方格挡强度④ * 格挡强度系数E））
				finalDamage = finalDamage * math.max(FightModule.lvf, (1 - FightModule.frD - P4 * FightModule.frE))
			end

			finalDamage = math.floor(finalDamage)

			-- print("attackObject.ptvf65:" .. attackObject.ptvf65)
			-- print(attackObject.finalDamagePercent)
			-- print("--------------------------------------\r\n公式2（怒气攻击）：\r\n",
			-- 		"①攻击力：", P1, "\r\n",
			-- 			"\t攻击[1]：", attackObject.attack, "\r\n",
			-- 			"\t降低攻击[72]：", attackObject.ptvf72, "\r\n",
			-- 			"\t战外面板攻击：", attackObject.fightObject.attack, "\r\n",
			-- 			"\t攻击增加百分比[5]：", attackObject.courageAdditionalPercent, "\r\n",
			-- 			"\t攻击降低百分比[63]：", attackObject.ptvf63, "\r\n",
			-- 		"②防御力：", P2, "\r\n",
			-- 			"\t防御[2]：", byAttackObject.physicalDefence, "\r\n",
			-- 			"\t降低防御[64]：", byAttackObject.ptvf64, "\r\n",
			-- 			"\t战外面板防御：", byAttackObject.fightObject.physicalDefence, "\r\n",
			-- 			"\t防御增加百分比[6]：", byAttackObject.intellectAdditionalPercent, "\r\n",
			-- 			"\t防御降低百分比[68]：", byAttackObject.ptvf68, "\r\n",
			-- 		"最终的伤害：", finalDamage, "\r\n",
			-- 			"\t破防系数A：", FightModule.frA, "\r\n",
			-- 			"\t技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
			-- 			"\t下限值系数MIN：", FightModule.lvf, "\r\n",
			-- 			"\t攻方伤害加成⑤：", P5, "\r\n",
			-- 			"\t防方伤害减免⑥：", P6, "\r\n",
			-- 			"\t攻方必杀伤害率⑦：", P7, "\r\n",
			-- 			"\t攻方增加必杀伤害⑧：", P8, "\r\n",
			-- 			"\t防方增加必杀抗性⑨：", P9, "\r\n",
			-- 			"\t防方受到直接伤害降低[62]：", byAttackObject.ptvf62, "\r\n",
			-- 			"\t攻方降低必杀伤害率[66]：", ptvf66, "\r\n",
			-- 			"\t攻方减少必杀伤害[57]：", attackObject.ptvf57, "\r\n",
			-- 			"\t防方受到的必杀伤害增加[60]：", byAttackObject.ptvf60, "\r\n",
			-- 			"\t防方减少必杀抗性[74]：", byAttackObject.ptvf74, "\r\n",
			-- 			"\t攻方克制伤害加成⑬：", P13, "\r\n",
			-- 			"\t防方克制伤害减免⑭：", P14, "\r\n",
			-- 			"\t攻方伤害提升[54]：", ptvf54, "\r\n",
			-- 			"\t系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
			-- 		"暴击伤害：", attackObject.isCritical, "\r\n",
			-- 			"\t暴击伤害系数B：", FightModule.frB, "\r\n",
			-- 			"\t攻方暴击强度③：", P3, "\r\n",
			-- 			"\t暴击强度系数C：", FightModule.frC, "\r\n",
			-- 			"\t攻方增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
			-- 			"\t攻方减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
			-- 		"格挡伤害：", byAttackObject.isRetain, "\r\n",
			-- 			"\t格挡伤害系数D：", FightModule.frD, "\r\n",
			-- 			"\t防方格挡强度④：", P4, "\r\n",
			-- 			"\t格挡强度系数E：", FightModule.frE, "\r\n",
			-- 		"--------------------------------------\r\n"
			-- 	)

			-- local cia = attackObject.attack - byAttackObject.physicalDefence
			-- local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
			-- if (attackObject.attack * FightModule.frA) > cia then
			-- 	--（攻方攻击力[1] * (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A
			-- 	total = (attackObject.attack * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue) * FightModule.frA
			-- else
			-- 	--（攻方攻击力[1] - 防方防御力[2]）* (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4]）
			-- 	total = cia * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
			-- end
			-- local frF = math.random(FightModule.frF1, FightModule.frF2) / 100
			-- finalDamage = -- math.floor(
			-- 		total
			-- 		* (1 + attackObject.finalDamagePercent - byAttackObject.finalLessenDamagePercent + attackObject.ptvf55) -- *（1 + 攻方伤害加成[33] - 防方伤害减免[34] + 攻方必杀伤害率[55]）
			-- 		* (1 + attackObject.ptvf54 + attackObject.ptvf56 - byAttackObject.ptvf57) -- *（1 + 攻方伤害提升[54] + 增加必杀伤害[56] - 减少必杀伤害[57])
			-- 		* frF
			-- 	-- )

			-- if attackObject.isCritical then
			-- 	-- 造成的最终伤害值 * （1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数C + 增加暴击伤害[58] - 减少暴击伤害[59]）
			-- 	finalDamage = finalDamage * (1 + FightModule.frB + attackObject.uniqueSkillDamagePercent * FightModule.frC + attackObject.ptvf58 - byAttackObject.ptvf59)
			-- end

			-- if byAttackObject.isRetain then
			-- 	-- 格挡伤害=	造成的最终伤害值 * （1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）
			-- 	finalDamage = finalDamage * (1 - FightModule.frD - byAttackObject.uniqueSkillResistancePercent * FightModule.frE)
			-- end

			-- finalDamage = math.floor(finalDamage)

			-- -- _crint("--------------------------------------\r\n公式2（怒气攻击）：\r\n",
			-- -- 		"攻方攻击力[1]：", attackObject.attack, "\r\n",
			-- -- 		"防方防御力[2]：", byAttackObject.physicalDefence, "\r\n",
			-- -- 		"破防系数A：", FightModule.frA, "\r\n",
			-- -- 		"技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
			-- -- 		"天赋等级：", skillInfluence.level, "\r\n",
			-- -- 		"技能百分比成长值[说明2]：", skillInfluence.levelPercentGrowValue, "\r\n",
			-- -- 		"技能固定值[说明3]：", skillInfluence.levelInitValue, "\r\n",
			-- -- 		"技能固定值成长值[说明4]：", skillInfluence.levelGrowValue, "\r\n",
			-- -- 		"攻方伤害加成[33]：", attackObject.finalDamagePercent, "\r\n",
			-- -- 		"防方伤害减免[34]：", byAttackObject.finalLessenDamagePercent, "\r\n",
			-- -- 		"攻方必杀伤害率[55]：", attackObject.ptvf55, "\r\n",
			-- -- 		"攻方伤害提升[54]：", attackObject.ptvf54, "\r\n",
			-- -- 		"增加必杀伤害[56]：", attackObject.ptvf56, "\r\n",
			-- -- 		"减少必杀伤害[57]：", byAttackObject.ptvf57, "\r\n",
			-- -- 		"系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
			-- -- 		"破防值：", cia, "\r\n",
			-- -- 		"基础伤害：", total, "\r\n",
			-- -- 		"最终的伤害：", finalDamage, "\r\n",
			-- -- 		"暴击：", attackObject.isCritical, "\r\n",
			-- -- 		"暴击伤害系数B：", FightModule.frB, "\r\n",
			-- -- 		"攻方暴击强度[43]：", attackObject.uniqueSkillDamagePercent, "\r\n",
			-- -- 		"暴击强度系数C：", FightModule.frC, "\r\n",
			-- -- 		"增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
			-- -- 		"减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
			-- -- 		"连击加成：", attackObject.grade_attack, "\r\n",
			-- -- 		"格挡：", byAttackObject.isRetain, "\r\n",
			-- -- 		"格挡伤害系数D：", FightModule.frD, "\r\n",
			-- -- 		"防方格挡强度[46]：", byAttackObject.uniqueSkillResistancePercent, "\r\n",
			-- -- 		"格挡强度系数E：", FightModule.frE, "\r\n",
			-- -- 		"连击加成：", attackObject.grade_attack, "\r\n",
			-- -- 		"--------------------------------------\r\n"
			-- -- 	)
		else
			if(skillMould.skillProperty==0)then
				total = math.floor ((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.physicalAttackAdd
				+ attackObject.restrainObject.attackAdditional+ attackObject.restrainObject.physicAttackAdditional)
				finalDamage =math.floor((total - byAttackObject.physicalDefence * (100 + byAttackObject.addPhysicalDefPercent - byAttackObject.decPhysicalDefPercent) / 100)
							 * FightUtil.computeRandomSkillEffectValue(skillInfluence)
							 * FightUtil.computeRandomValue()
							 + attackObject.finalDamageAddition-byAttackObject.finalSubDamageAddition
							 + attackObject.restrainObject.finalAdditionalDamage - byAttackObject.restrainObject.finalLessenDamage)
			else
				total = math.floor ((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.skillAttackAdd
				+ attackObject.restrainObject.attackAdditional + attackObject.skillAttackAdd)
				finalDamage =math.floor((total - byAttackObject.skillDefence * (100 + byAttackObject.addSkillDefPercent - byAttackObject.decSkillDefPercent) / 100)
						 * FightUtil.computeRandomSkillEffectValue(skillInfluence)
						 * FightUtil.computeRandomValue()
						 + attackObject.finalDamageAddition-byAttackObject.finalSubDamageAddition
						 + attackObject.restrainObject.finalAdditionalDamage - byAttackObject.restrainObject.finalLessenDamage)
			end
			finalDamage = math.floor (finalDamage * attackObject.critialMultiple)
		end
	end
	if (1 > finalDamage) then
		finalDamage = 1
	end
	local finalDamagePercent = attackObject.finalDamagePercent + attackObject.addFinalDamagePercent
	+ attackObject.restrainObject.finalAdditionalDamagePercentage
	local finalLessenDamagePercent =  byAttackObject.finalLessenDamagePercent + byAttackObject.addBruiseDamagePercent
	+ byAttackObject.restrainObject.finalAdditionalDamagePercentage
	if(byAttackObject.isEvasion)then
		finalDamage = 0
	else
		--for (Iterator<TalentJudgeResult> talentIter = attackObject.getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(attackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
			for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			finalDamagePercent = finalDamagePercent + talentJudgeResult.percentValue
		end
		--for (Iterator<TalentJudgeResult> talentIter = byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : attackObject.talentImmunityList) then
			for _, talentImmunity in pairs(attackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			finalLessenDamagePercent = finalLessenDamagePercent + talentJudgeResult.percentValue
		end
		if(finalDamagePercent > 0.0)then
			finalDamage = finalDamage * (1 + finalDamagePercent / 100)
		end
		if(finalLessenDamagePercent > 0.0)then
			finalDamage = finalDamage * (1 - finalLessenDamagePercent / 100)
		end
	end
	-- if(attackObject.battleTag == 0)then
		-- local userInfo = UserDB.getUserInfoWithUserInfoId(attackObject.userInfo + "", false)
		-- if(nil ~= userInfo and nil ~= userInfo.battleCache)then
			-- local templocal = userInfo.battleCache
			-- tempBattleCache.addTotalDamage(finalDamage)
		-- end
	-- end
	finalDamage = finalDamage * attackObject.grade_attack
	if(tonumber(finalDamage) < 1)then
		finalDamage = 1
	end

	if (true == byAttackObject.isNoDamage) then
		finalDamage = 0
	end

	if(attackObject.battleTag == 0)then
		if _ED.user_info.battleCache ~= nil then
			_ED.user_info.battleCache:addTotalDamage(finalDamage)
		end
	end
	byAttackObject:subHealthPoint(finalDamage)
	print("必杀技伤害 " .. finalDamage)
	attackObject.effectDamage=finalDamage
	byAttackObject.reboundDamageValueResult = byAttackObject.reboundDamageValueResult + byAttackObject.reboundDamageValue * finalDamage
	effectArray[1] = finalDamage
end

function FightUtil.computeCureHealthPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	local finalCure = 0
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		--[[
			公式3（加血1）	加血1=	攻方攻击力[1] * （ (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 增加治疗效果百分比 [16] + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] )
		 						* (1 + 增加被治疗效果百分比[17] - 降低被治疗效果百分比[53]）

		 		（注：攻击、防御、克制伤害加成、克制伤害减免 取上方计算值）	
			公式3（加血1）	加血=	释放者攻击力① * （ (技能百分比[说明1] /100 +（天赋等级-1）* 技能百分比成长值[说明2] /100 )  + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] )
					 * (1 + 释放者治疗效果增加⑫ - 承受者被治疗率减少[53] + 承受者被治疗率增加[17]）
		--]]
		-- @version 1.1
		local P1 = attackObject.attack - byAttackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63) -- ①攻击力=	攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
		local P2 = byAttackObject.physicalDefence - byAttackObject.ptvf64 + byAttackObject.fightObject.physicalDefence * (byAttackObject.intellectAdditionalPercent - byAttackObject.ptvf68) -- ②防御力=	防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
		local P3 = attackObject.uniqueSkillDamagePercent
		local P4 = byAttackObject.uniqueSkillResistancePercent
		local P5 = attackObject.finalDamagePercent * (1 + attackObject.ptvf65)
				+ attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 33 )
		local P6 = byAttackObject.finalLessenDamagePercent

		local P12 = attackObject.curePercent + attackObject.fightObject.curePercent / 100

		local P13 = 0
		if (1 == attackObject.campPreference and 3 == byAttackObject.campPreference)
			or (2 == attackObject.campPreference and 1 == byAttackObject.campPreference)
			or (3 == attackObject.campPreference and 2 == byAttackObject.campPreference)
			then
			P13 = attackObject.ptvf70 + attackObject.fightObject.ptvf70
		end

		local P14 = 0
		if (1 == byAttackObject.campPreference and 3 == attackObject.campPreference)
			or (2 == byAttackObject.campPreference and 1 == attackObject.campPreference)
			or (3 == byAttackObject.campPreference and 2 == attackObject.campPreference)
			then
			P14 = byAttackObject.ptvf71 + byAttackObject.fightObject.ptvf71
		end

		local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
		finalCure = (P1 * (ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue)
			* (1 + P12 - byAttackObject.byCureLessenPercent + byAttackObject.byCurePercent)
		
		-- print("--------------------------------------\r\n公式3（加血）：\r\n",
		-- 		"①攻击力：", P1, "\r\n",
		-- 			"\t攻击[1]：", attackObject.attack, "\r\n",
		-- 			"\t降低攻击[72]：", attackObject.ptvf72, "\r\n",
		-- 			"\t战外面板攻击：", attackObject.fightObject.attack, "\r\n",
		-- 			"\t攻击增加百分比[5]：", attackObject.courageAdditionalPercent, "\r\n",
		-- 			"\t攻击降低百分比[63]：", attackObject.ptvf63, "\r\n",
		-- 		"②防御力：", P2, "\r\n",
		-- 			"\t防御[2]：", byAttackObject.physicalDefence, "\r\n",
		-- 			"\t降低防御[64]：", byAttackObject.ptvf64, "\r\n",
		-- 			"\t战外面板防御：", byAttackObject.fightObject.physicalDefence, "\r\n",
		-- 			"\t防御增加百分比[6]：", byAttackObject.intellectAdditionalPercent, "\r\n",
		-- 			"\t防御降低百分比[68]：", byAttackObject.ptvf68, "\r\n",
		-- 		"最终的加血值：", finalCure, "\r\n",
		-- 			"\t破防系数A：", FightModule.frA, "\r\n",
		-- 			"\t技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
		-- 			"\t下限值系数MIN：", FightModule.lvf, "\r\n",
		-- 			"\t攻方伤害加成⑤：", P5, "\r\n",
		-- 			"\t防方伤害减免⑥：", P6, "\r\n",
		-- 			"\t防方受到直接伤害降低[62]：", byAttackObject.ptvf62, "\r\n",
		-- 			"\t释放者治疗效果增加⑫：", P12, "\r\n",
		-- 			"\t攻方克制伤害加成⑬：", P13, "\r\n",
		-- 			"\t防方克制伤害减免⑭：", P14, "\r\n",
		-- 			"\t攻方伤害提升[54]：", attackObject.ptvf54, "\r\n",
		-- 			"\t承受者被治疗率减少[53]：", byAttackObject.byCureLessenPercent, "\r\n",
		-- 			"\t承受者被治疗率增加[17]：", byAttackObject.byCurePercent, "\r\n",
		-- 			"\t系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
		-- 		"暴击伤害：", attackObject.isCritical, "\r\n",
		-- 			"\t暴击伤害系数B：", FightModule.frB, "\r\n",
		-- 			"\t攻方暴击强度③：", P3, "\r\n",
		-- 			"\t暴击强度系数C：", FightModule.frC, "\r\n",
		-- 			"\t攻方增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
		-- 			"\t攻方减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
		-- 		"格挡伤害：", byAttackObject.isRetain, "\r\n",
		-- 			"\t格挡伤害系数D：", FightModule.frD, "\r\n",
		-- 			"\t防方格挡强度④：", P4, "\r\n",
		-- 			"\t格挡强度系数E：", FightModule.frE, "\r\n",
		-- 		"--------------------------------------\r\n"
		-- 	)

		-- local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
		-- finalCure = math.floor( (attackObject.attack * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + attackObject.curePercent +  skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue)
		-- 			* (1 + byAttackObject.byCurePercent - byAttackObject.byCureLessenPercent) )
	else
		finalCure = math.floor ((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.skillAttackAdd 
					+ attackObject.restrainObject.attackAdditional +attackObject.restrainObject.skillAttackAdditional 
					* (FightUtil.computeRandomSkillEffectValue(skillInfluence) + attackObject.cureAdditional / 100 + byAttackObject.byCurePercent / 100)
					*  FightUtil.computeRandomValue()
					+ attackObject.cureAdd
					+ byAttackObject.byCureAdd + byAttackObject.cureAdd)
	end
	local addHpPoint = byAttackObject.healthMaxPoint - byAttackObject.healthPoint
	if(addHpPoint < 0) then
		addHpPoint = 0
	end
	
	finalCure = finalCure * attackObject.grade_attack

	local healthPoint = math.floor(math.min(addHpPoint, finalCure))
	if(byAttackObject.isBearHP)then	
		effectArray[1] = 0
	else
		byAttackObject:addHealthPoint(healthPoint)
		effectArray[1] = finalCure
	end
end

function FightUtil.computeCureSkillPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		effectArray[1] = math.floor(FightUtil.computeRandomSkillEffectValue(skillInfluence))
		effectArray[1] = byAttackObject:addSkillPoint( effectArray[1], true)
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeDamageSkillPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then			
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_DAMAGE_SP)then
				effectArray[2] = 5
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then			
			effectArray[1] = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local damageSkillPoint =  byAttackObject.skillPoint - effectArray[1]
			byAttackObject:setSkillPoint(math.max(damageSkillPoint, 0))
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeSkillPointDisup(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_SP_DISUP)then
				effectArray[3] = 5
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then				
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
			byAttackObject.isSpDisable=true
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeDizzy(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	local probability = FightUtil.checkSkillInfluenceProbability(skillInfluence, attackObject, byAttackObject)
	local r = math.random(1, 100)
	-- print("随机值：", r)

	-- 如果这里设成true，被沉默或晕眩后，会一直挨打
	if(r <= probability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_DIZZY)then
				effectArray[3] = 1
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then
			if FightUtil.checkNegativeBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer) then
				local fightBuff = byAttackObject:getBuffEffect(skillInfluence.skillCategory)
				if nil == fightBuff then
					fightBuff = FightBuff:new()
					byAttackObject:pushBuffEffect(fightBuff)
				end
				fightBuff.skillInfluence=skillInfluence
				fightBuff.effectRound=skillInfluence.influenceDuration
				effectArray[2] = skillInfluence.influenceDuration
				byAttackObject.isDizzy=true
			else
				effectArray[3] = 1
			end
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computePosion(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_POSION)then
				effectArray[3] = 5
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then				
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			local skillEffect = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local effectValue = 0
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--[[
					公式说明8：
						治疗=	攻方攻击力[1] * （治疗百分比[48] + 增加治疗效果百分比 [16] + 治疗值[26]) * (1 + 增加被治疗效果百分比[17] - 降低被治疗效果百分比[53]）
				--]]
				local effectValue = attackObject.attack * (attackObject.cureEffectPercent + attackObject.curePercent + attackObject.cureAdd) * (1 + attackObject.byCurePercent - byAttackObject.byCureLessenPercent)
				byAttackObject.posionDamage=effectValue
			else
				if(skillInfluence.isRate == 0)then 
					effectValue = math.floor (skillEffect * attackObject.attack+attackObject.posionAdd-byAttackObject.byPosionLes
							+attackObject.restrainObject.posionAdditional - byAttackObject.restrainObject.posionLessen)
					if (effectValue < 5) then
						effectValue = 5
					end
					byAttackObject.posionDamage=effectValue
				else
					effectValue = math.floor(skillEffect)
				end
			end
			fightBuff.effectValue = effectValue
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeFiring(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then	
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_FIRING)then
				effectArray[3] = 5
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then				
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			local skillEffect = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local effectValue = 0
			local total = 0

			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--[[
					公式说明9：
						灼烧伤害 =	if( (攻方攻击力[1] * 破防系数A) > (攻方攻击力[1] - 防方防御力[2])，（攻方攻击力[1] * 灼烧百分比[39] + 灼烧伤害[28]）* 破防系数A，（攻方攻击力[1] - 防方防御力[2]）* 灼烧百分比[39] + 灼烧伤害[28]）
						*（1 + 攻方伤害加成[33] - 防方伤害减免[34]）

					公式9（灼烧1）	灼烧伤害1=	if( (攻方攻击力[1] * 破防系数A) > (攻方攻击力[1] - 防方防御力[2])，（攻方攻击力[1] * (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
											（攻方攻击力[1] - 防方防御力[2]）* (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
											*（1 + 攻方伤害加成[33] - 防方伤害减免[34]）

						（注：攻击、防御、克制伤害加成、克制伤害减免 取上方计算值）	
					公式9（灼烧1）	灼烧伤害=	if( (攻方攻击力① * 破防系数A) > (攻方攻击力① - 防方防御力②)，（攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
					行动方回合结束时计算灼烧伤害，连击加成取最终值，与出手顺序无关		（攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
							* max（下限值系数MIN ，（1 + 攻方伤害加成⑤  - 防方伤害减免⑥  - 防方受到直接伤害降低[62] ）)
							* max（下限值系数MIN ，（1 + 攻方克制伤害加成⑬ -  防方克制伤害减免⑭ + 攻方伤害提升[54] ）)
							* 系数F之间纯随机（0.95-1.05）
							*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）
				--]]
				-- @version 1.1
				local P1 = attackObject.attack - byAttackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63) -- ①攻击力=	攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
				local P2 = byAttackObject.physicalDefence - byAttackObject.ptvf64 + byAttackObject.fightObject.physicalDefence * (byAttackObject.intellectAdditionalPercent - byAttackObject.ptvf68) -- ②防御力=	防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
				local P3 = attackObject.uniqueSkillDamagePercent
				local P4 = byAttackObject.uniqueSkillResistancePercent
				local P5 = attackObject.finalDamagePercent * (1 + attackObject.ptvf65)
					+ attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 33 )
				local P6 = byAttackObject.finalLessenDamagePercent

				local P13 = 0
				if (1 == attackObject.campPreference and 3 == byAttackObject.campPreference)
					or (2 == attackObject.campPreference and 1 == byAttackObject.campPreference)
					or (3 == attackObject.campPreference and 2 == byAttackObject.campPreference)
					then
					P13 = attackObject.ptvf70 + attackObject.fightObject.ptvf70
				end

				local P14 = 0
				if (1 == byAttackObject.campPreference and 3 == attackObject.campPreference)
					or (2 == byAttackObject.campPreference and 1 == attackObject.campPreference)
					or (3 == byAttackObject.campPreference and 2 == attackObject.campPreference)
					then
					P14 = byAttackObject.ptvf71 + byAttackObject.fightObject.ptvf71
				end

				local cia = P1 - P2
				local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
				if (P1 * FightModule.frA) > cia then
					-- （攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
					total = ( P1 * ( ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100 ) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue ) * FightModule.frA
				else
					-- （攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
					total = cia * (ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
				end

				local frF = math.random(FightModule.frF1, FightModule.frF2) / 100

				local ptvf54 = attackObject.ptvf54 + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 54 )

				finalDamage = total
					* math.max(FightModule.lvf, (1 + P5 - P6 - byAttackObject.ptvf62))
					* math.max(FightModule.lvf, (1 + P13 - P14 + ptvf54))
					* frF

				finalDamage = finalDamage

				-- byAttackObject.posionDamage = finalDamage
				effectValue = finalDamage

				-- _crint("--------------------------------------\r\n公式9（灼烧）：\r\n",
				-- 	"①攻击力：", P1, "\r\n",
				-- 		"\t攻击[1]：", attackObject.attack, "\r\n",
				-- 		"\t降低攻击[72]：", attackObject.ptvf72, "\r\n",
				-- 		"\t战外面板攻击：", attackObject.fightObject.attack, "\r\n",
				-- 		"\t攻击增加百分比[5]：", attackObject.courageAdditionalPercent, "\r\n",
				-- 		"\t攻击降低百分比[63]：", attackObject.ptvf63, "\r\n",
				-- 	"②防御力：", P2, "\r\n",
				-- 		"\t防御[2]：", byAttackObject.physicalDefence, "\r\n",
				-- 		"\t降低防御[64]：", byAttackObject.ptvf64, "\r\n",
				-- 		"\t战外面板防御：", byAttackObject.fightObject.physicalDefence, "\r\n",
				-- 		"\t防御增加百分比[6]：", byAttackObject.intellectAdditionalPercent, "\r\n",
				-- 		"\t防御降低百分比[68]：", byAttackObject.ptvf68, "\r\n",
				-- 	"最终的伤害：", finalDamage, "\r\n",
				-- 		"\t破防系数A：", FightModule.frA, "\r\n",
				-- 		"\t技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
				-- 		"\t下限值系数MIN：", FightModule.lvf, "\r\n",
				-- 		"\t攻方伤害加成⑤：", P5, "\r\n",
				-- 		"\t防方伤害减免⑥：", P6, "\r\n",
				-- 		"\t防方受到直接伤害降低[62]：", byAttackObject.ptvf62, "\r\n",
				-- 		"\t攻方克制伤害加成⑬：", P13, "\r\n",
				-- 		"\t防方克制伤害减免⑭：", P14, "\r\n",
				-- 		"\t攻方伤害提升[54]：", ptvf54, "\r\n",
				-- 		"\t系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
				-- 	"暴击伤害：", attackObject.isCritical, "\r\n",
				-- 		"\t暴击伤害系数B：", FightModule.frB, "\r\n",
				-- 		"\t攻方暴击强度③：", P3, "\r\n",
				-- 		"\t暴击强度系数C：", FightModule.frC, "\r\n",
				-- 		"\t攻方增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
				-- 		"\t攻方减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
				-- 	"格挡伤害：", byAttackObject.isRetain, "\r\n",
				-- 		"\t格挡伤害系数D：", FightModule.frD, "\r\n",
				-- 		"\t防方格挡强度④：", P4, "\r\n",
				-- 		"\t格挡强度系数E：", FightModule.frE, "\r\n",
				-- 	"--------------------------------------\r\n"
				-- )

				-- local cia = attackObject.attack - byAttackObject.physicalDefence
				-- local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
				-- if (attackObject.attack * FightModule.frA) > cia then
				-- 	--（攻方攻击力[1] * (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A
				-- 	total = (attackObject.attack * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue) * FightModule.frA
				-- else
				-- 	--（攻方攻击力[1] - 防方防御力[2]）* (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4]）
				-- 	total = cia * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
				-- end
				-- local frF = math.random(FightModule.frF1, FightModule.frF2) / 100
				-- effectValue = -- math.floor(
				-- 		total
				-- 		* (1 + attackObject.finalDamagePercent - byAttackObject.finalLessenDamagePercent) -- *（1 + 攻方伤害加成[33] - 防方伤害减免[34]）
				-- 	-- )
				-- byAttackObject.posionDamage = effectValue
			else
				if(skillInfluence.isRate == 0)then 
					effectValue = math.floor (skillEffect * attackObject.attack+attackObject.posionAdd-byAttackObject.byPosionLes
							+attackObject.restrainObject.firingAdditional - byAttackObject.restrainObject.firingLessen)
					if (effectValue < 5) then
						effectValue = 5
					end
					byAttackObject.posionDamage=effectValue
				else
					effectValue = math.floor(skillEffect)
				end
			end

			fightBuff.effectValue = effectValue
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeExplode(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then			
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
		effectArray[2] = skillInfluence.influenceDuration
		attackObject.isExplode=true
		attackObject.explodeCount=skillInfluence.influenceDuration
	end
end

function FightUtil.computeParalysis(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	local probability = FightUtil.checkSkillInfluenceProbability(skillInfluence, attackObject, byAttackObject)
	if(math.random(1, 100) <= probability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_PARALYSIS)then
				effectArray[3] = 5
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then
			if FightUtil.checkNegativeBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer) then	
				local fightBuff = byAttackObject:getBuffEffect(skillInfluence.skillCategory)
				if nil == fightBuff then
					fightBuff = FightBuff:new()
					byAttackObject:pushBuffEffect(fightBuff)
				end
				fightBuff.skillInfluence=skillInfluence
				fightBuff.effectRound=skillInfluence.influenceDuration
				effectArray[2] = skillInfluence.influenceDuration
				byAttackObject.isParalysis=true
			else
				effectArray[3] = 1
			end
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeNoSkillPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	local probability = FightUtil.checkSkillInfluenceProbability(skillInfluence, attackObject, byAttackObject)
	if(math.random(1, 100) <= probability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_NO_SP)then
				effectArray[3] = 5
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then
			if FightUtil.checkNegativeBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer) then				
				local fightBuff = byAttackObject:getBuffEffect(skillInfluence.skillCategory)
				if nil == fightBuff then
					fightBuff = FightBuff:new()
					byAttackObject:pushBuffEffect(fightBuff)
				end
				fightBuff.skillInfluence=skillInfluence
				fightBuff.effectRound=skillInfluence.influenceDuration
				effectArray[2] = skillInfluence.influenceDuration
				byAttackObject.isDisSp=true
				--> __crint("被沉默", byAttackObject.buffNegativeImmunityStatus)
			else
				effectArray[3] = 1
			end
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeAddRetain(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	local fightBuff = FightBuff:new()
	fightBuff.skillInfluence=skillInfluence
	fightBuff.effectRound=skillInfluence.influenceDuration
	byAttackObject:pushBuffEffect(fightBuff)
	effectArray[2] = skillInfluence.influenceDuration
	byAttackObject.retainAdditional=byAttackObject.retainAdditional + skillInfluence.skillEffectMaxValue
end

function FightUtil.computeLessenDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then			
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
		effectArray[2] = skillInfluence.influenceDuration
		byAttackObject.isNoDamage=true
	end
end

function FightUtil.computeEvasionSurely(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	local fightBuff = FightBuff:new()
	fightBuff.skillInfluence=skillInfluence
	fightBuff.effectRound=skillInfluence.influenceDuration
	byAttackObject:pushBuffEffect(fightBuff)
	effectArray[2] = skillInfluence.influenceDuration
	byAttackObject.isEvasionSurely=true
end

--[[
16	吸血	16		吸血量 = 造成的伤害 *  吸血率[40] / 100
--]]
function FightUtil.computeDrains(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local drainHP = 0
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			drainHP = attackObject.totalEffectDamage * attackObject.inhaleHpDamagePercent
			-- _crint("吸血：", drainHP, attackObject.totalEffectDamage, attackObject.inhaleHpDamagePercent)
		else
			drainHP = math.floor (FightUtil.computeRandomSkillEffectValue(skillInfluence) * attackObject.totalEffectDamage
				* (1 + attackObject.cureAdditional / 100 + byAttackObject.byCurePercent / 100))
		end
		-- if(drainHP + byAttackObject.healthPoint >= byAttackObject.healthMaxPoint)then
		-- 	drainHP = math.floor (byAttackObject.healthMaxPoint - byAttackObject.healthPoint)
		-- end
		if(byAttackObject.isBearHP)then	
			effectArray[1] = 0
		else
			print("吸血量 FightUtil.computeDrains: " .. drainHP)
			byAttackObject:addHealthPoint(drainHP)
			effectArray[1] = drainHP
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeBearHP(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_BRAR_HP)then
				effectArray[3] = 7
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then				
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
			byAttackObject.isBearHP=true
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeEvasion(skillMould, skillInfluence, attackObject, byAttackObject)
	if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
		byAttackObject.isEvasion=false -- 取消闪避
		return
	end
	local isAccuracy = false
	local attackTalentMouldList = attackObject.talentMouldList
	--for (TalentMould talentMould : attackTalentMouldList) then
	for _, talentMould in pairs(attackTalentMouldList) do
		-- if(talentMould.influenceJudgeResult.equals(""..TalentConstant.JUDGE_RESULT_NO_EVASION .. ""))then
		if(talentMould.influenceJudgeResult == ""..TalentConstant.JUDGE_RESULT_NO_EVASION .. "")then
			isAccuracy = true
			break
		end
	end
	if(attackObject.isBlind)then	
		isAccuracy = true
		byAttackObject.isEvasion=true
		return
	else
		byAttackObject.isEvasion=false
	end
	if(true ~= isAccuracy)then
		if(math.random(1, 100) <= (95 + (attackObject.accuracy + attackObject.addAccuracy) - 
			(byAttackObject.evasion+ byAttackObject.addEvasion)
				+ attackObject.restrainObject.acciracuOdds - byAttackObject.restrainObject.evasionOdds))then			
			byAttackObject.isEvasion=false
		else
			byAttackObject.isEvasion=true
		end
	else
		byAttackObject.isEvasion=false
	end
end

function FightUtil.computeCritial(skillMould, skillInfluence, attackObject, byAttackObject)
	local criticalMultiple = 1.5
	--for (Iterator<TalentJudgeResult> talentIter = attackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_CRITICAL_MULTIPLE_ADDITIONAL_PERCENT).iterator(); talentIter.hasNext();) then
	for _, talentJudgeResult in pairs(attackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_CRITICAL_MULTIPLE_ADDITIONAL_PERCENT)) do
		--TalentJudgeResult talentJudgeResult = talentIter.next()
		local immunity = false
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
				immunity = true
				break
			end
		end
		if(immunity)then
			break
		end
		criticalMultiple = criticalMultiple * (1 + talentJudgeResult.percentValue / 100.0)
	end
	local talentJudgeResultList = byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_NO_CRITICAL)
	local canCritical = #talentJudgeResultList <= 0
	-- if((math.random(1, 100) <= (5 + (attackObject.critical + attackObject.addCritialMultiple) - (byAttackObject.criticalResist+byAttackObject.addCriticalResist)
	-- 		+ attackObject.restrainObject.criticalOdds - byAttackObject.restrainObject.criticalResistOdds) or attackObject.isExplode) and canCritical)then	
	local crlf = (attackObject.criticalAdditionalPercent - byAttackObject.criticalResistAdditionalPercent)
	local crlfr = math.random(1, 100) / 100
	if canCritical
		and crlf > 0
		and (attackObject.isExplode
			or 
			(crlfr <= crlf)
			)
		then		
		attackObject.isCritical=true
		attackObject.critialMultiple=criticalMultiple
		if(attackObject.isExplode)then
			attackObject:subExplodeCount(1)
			if(attackObject.explodeCount <= 0)then
				attackObject.isExplode=false
				attackObject.explodeCount=0
			end
		end
	end
	-- print(canCritical, attackObject.criticalAdditionalPercent, byAttackObject.criticalResistAdditionalPercent, attackObject.isExplode, crlf, crlfr, attackObject.isCritical)
end

function FightUtil.computeRetain(skillMould, skillInfluence, attackObject, byAttackObject)
	byAttackObject.isRetain = false
	-- if(math.random(1, 100) <= (5 + byAttackObject.retain - attackObject.retainBreak + byAttackObject.retainAdditional))then			
	if false == attackObject.isCritical 
		and (byAttackObject.retainAdditionalPercent - attackObject.retainBreakAdditionalPercent) > 0
		and (
				(math.random(1, 100) / 100 <= (byAttackObject.retainAdditionalPercent - attackObject.retainBreakAdditionalPercent))
			)
		then	
		byAttackObject.isRetain=true
	end
end

function FightUtil.computeBlind(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_BLIND)then
				effectArray[3] = 8
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then				
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
			byAttackObject.isBlind=true
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeCripple(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
		for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
			if(talentImmunity.immunityStatus == TalentConstant.IMMUNITY_STATUS_CRIPPLE)then
				effectArray[3] = 9
				return
			end
		end
		if(true ~= byAttackObject.isEvasion)then				
			-- local fightBuff = FightBuff:new()
			-- fightBuff.skillInfluence=skillInfluence
			-- fightBuff.effectRound=skillInfluence.influenceDuration
			-- byAttackObject:pushBuffEffect(fightBuff)
			-- effectArray[2] = skillInfluence.influenceDuration
			-- byAttackObject.isCripple=true

			if FightUtil.checkNegativeBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer) then	
				local fightBuff = byAttackObject:getBuffEffect(skillInfluence.skillCategory)
				if nil == fightBuff then
					fightBuff = FightBuff:new()
					byAttackObject:pushBuffEffect(fightBuff)
				end
				fightBuff.skillInfluence=skillInfluence
				fightBuff.effectRound=skillInfluence.influenceDuration
				effectArray[2] = skillInfluence.influenceDuration
				byAttackObject.isCripple=true
			else
				effectArray[3] = 1
			end
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end
--[[
21	增加攻击	21		总攻击[1] = 原攻击[1] + 百分比值/100 * 战外攻击
--]]
function FightUtil.computeAddAttack(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			-- _crint("增加攻击，随机值的结果：", finalAttack)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL
			local propertyValue = finalAttack * byAttackObject.fightObject.attack
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			effectArray[2] = skillInfluence.influenceDuration
			local effectValue = 0
			if(skillInfluence.isRate == 0)then
				effectValue = 100 * finalAttack
			else
				effectValue = finalAttack
			end
			fightBuff.effectValue=effectValue
			byAttackObject:pushBuffEffect(fightBuff)
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeSubAttack(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			-- _crint("减少攻击，随机值的结果：", skillInfluence.id, finalAttack, "攻击者：", attackObject.battleTag, attackObject.coordinate, "防御者：", byAttackObject.battleTag, byAttackObject.coordinate)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_ATTACK_ADDITIONAL
			local propertyValue = -1 * finalAttack * byAttackObject.fightObject.attack
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			effectArray[2] = skillInfluence.influenceDuration
			local finalValue = 0
			if(skillInfluence.isRate > 0)then
				finalValue = finalAttack
			else
				finalValue = 100 * finalAttack
			end
			fightBuff.effectValue=finalValue
			byAttackObject:pushBuffEffect(fightBuff)
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeAddPhysicalDefence(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			-- _crint("增加防御，随机值的结果：", finalAttack)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL
			local propertyValue = finalAttack * byAttackObject.fightObject.physicalDefence
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			local addPhyDefence = 0
			local addSkillDefence = 0
			if(skillInfluence.isRate > 0)then
				addPhyDefence = finalAttack
				addSkillDefence = finalAttack
			else
				addPhyDefence = 100*finalAttack
				addSkillDefence = 100*finalAttack
			end
			fightBuff.effectValue=addPhyDefence
			fightBuff.effectValue2=addSkillDefence
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeSubPhysicalDefence(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			-- _crint("减少防御，随机值的结果：", finalAttack)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_PHYSIC_DEFENCE_ADDITIONAL
			local propertyValue = -1 * finalAttack * byAttackObject.fightObject.physicalDefence
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local finalAttack = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			local addPhyDefence = 0
			local addSkillDefence = 0
			if(skillInfluence.isRate > 0)then
				addPhyDefence = finalAttack
				addSkillDefence = finalAttack
			else
				addPhyDefence = 100*finalAttack
				addSkillDefence = 100*finalAttack
			end
			fightBuff.effectValue=addPhyDefence
			fightBuff.effectValue2=addSkillDefence
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		end
	else
		effectArray[3] = 1
	end
end

--受到伤害降低
-- 技能百分比[说明1]：skill_influence第6、7字段的随机结果	
-- 技能百分比成长值[说明2]：skill_influence第35字段	
--总受到伤害降低[62] = 原受到伤害降低[62] + 百分比值 + 百分比成长 * （天赋等级-1）
function FightUtil.computeAddBurise(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_PERCENT_FOR_62
			local propertyValue = finalValue + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue
			-- _crint("伤害降低，随机值的结果：", finalValue, propertyValue)
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = skillInfluence
			fightBuff.effectRound = skillInfluence.influenceDuration
			local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			fightBuff.effectValue = effectValue * 100
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeSubBurise(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
		effectArray[2] = skillInfluence.influenceDuration
		local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		byAttackObject:subBruiseDamagePercent(effectValue)
	else
		effectArray[3] = 1
	end
end

--[[
总暴击[8] = 原暴击[8] + 百分比值
--]]
function FightUtil.computeAddCritical(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			-- _crint("增加暴击，随机值的结果：", finalValue)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS
			local propertyValue = finalValue
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			local effectRound = skillInfluence.influenceDuration - 1
			if effectRound == 0 then
				--当前回合生效
				byAttackObject.addCritialMultiple = effectValue * 100
			else
				if(effectValue > 0) then 
					fightBuff.effectValue = effectValue * 100
					byAttackObject:pushBuffEffect(fightBuff)
				end
				fightBuff.effectRound=effectRound
			end

			effectArray[2] = effectRound
		end
	else
		effectArray[3] = 1
	end
end

--[[
28	增加抗暴	28		总抗暴[9] = 原抗暴[9] + 百分比值
--]]
function FightUtil.computeAddResistCritical(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			-- _crint("增加抗暴，随机值的结果：", finalValue)
			local skillCategory = skillInfluence.skillCategory
			local propertyType = EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS
			local propertyValue = finalValue
			local influenceDuration = skillInfluence.influenceDuration
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)

	        effectArray[2] = influenceDuration
		else
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
			if(effectValue > 0)then
				fightBuff.effectValue=effectValue * 100
			end
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		end
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeAddHit(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		local effectRound = skillInfluence.influenceDuration
		effectRound = effectRound - 1;
		if(effectRound == 0) then
			--当前回合生效
			byAttackObject.addAccuracy = effectValue * 100
		else
			if(effectValue > 0)then
				fightBuff.effectRound=effectRound
				fightBuff.effectValue=effectValue * 100
				byAttackObject:pushBuffEffect(fightBuff)
			end
		end

		effectArray[2] = effectRound
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeAddEnvsion(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		fightBuff.fffectValue = effectValue * 100
		byAttackObject:pushBuffEffect(fightBuff)
		effectArray[2] = skillInfluence.influenceDuration
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeAddEndurance(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		if(skillInfluence.isRate == 0)then
			effectValue = attackObject.attack * effectValue
		end
		if(effectValue > 0)then
			fightBuff.effectValue = effectValue
			byAttackObject:pushBuffEffect(fightBuff)
		end
		effectArray[2] = skillInfluence.influenceDuration
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeClearBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local list = byAttackObject.buffEffect
		--for (Iterator iterator = list.iterator(); iterator.hasNext();) then
		-- 不管还有没有对应的技能队列，至少要把本回合已经加持在身上的buffer清除掉。
		-- FightBuff.clearBuff(skillInfluence.formulaInfo, byAttackObject);
		for i, fightBuff in pairs(byAttackObject.buffEffect) do
			--local fightBuff = (FightBuff) iterator.next()
			-- 清除buffer要清除的技能公式 == player技能队列里的技能类型就清除掉
			-- if(skillInfluence.formulaInfo == fightBuff.skillInfluence.skillCategory)then
			local skillCategory = fightBuff.skillInfluence.skillCategory
			if skillCategory == 5	
				or skillCategory == 7	
				or skillCategory == 8	
				or skillCategory == 9	
				or skillCategory == 17	
				or skillCategory == 22	
				or skillCategory == 24	
				or skillCategory == 36	
				or skillCategory == 39	
				or skillCategory == 47	
				or skillCategory == 48	
				or skillCategory == 50	
				or skillCategory == 51	
				or skillCategory == 55	
				or skillCategory == 56	
				or skillCategory == 61	
				or skillCategory == 66	
				or skillCategory == 67	
				or skillCategory == 69
				then
				-- iterator.remove()
				-- table.remove(byAttackObject.buffEffect, i, 1)
				FightBuff.clearBuff(fightBuff.skillInfluence.skillCategory, byAttackObject, fightBuff.skillInfluence)
				byAttackObject.buffEffect[i] = nil
				byAttackObject._isAction = nil
			end
		end
		effectArray[2] = skillInfluence.influenceDuration
		effectArray[4] = skillInfluence.formulaInfo
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeAddDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		fightBuff.effectValue=effectValue * 100
		byAttackObject:pushBuffEffect(fightBuff)
		effectArray[2] = skillInfluence.influenceDuration
	else
		effectArray[4] = 1
	end
end

function FightUtil.computeAllKill(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	local finalDamage = 9999999
	byAttackObject:subHealthPoint(math.floor(byAttackObject.healthPoint))
	attackObject.effectDamage=9999999
	effectArray[1] = finalDamage
	effectArray[3] = 0
end


function FightUtil.computeFixedKill(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
	local finalDamage = effectValue
	byAttackObject:subHealthPoint(finalDamage)
	attackObject.effectDamage = finalDamage
	effectArray[1] = finalDamage
	-- effectArray[3] = 0
end

--[[
36	降低治疗效果	36		总被治疗率减少[53] = 原被治疗率减少[53] + 百分比值
--]]
function FightUtil.computeForthwitch(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低治疗效果，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
37.溅射
公式说明：
	溅射伤害 = 造成的最终伤害值 * 防守方反弹率[42]
37	溅射	37		溅射伤害 = 造成的最终伤害值 * 百分比值/100
--]]
function FightUtil.computeReanaAttackDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local influenceDuration = skillInfluence.influenceDuration
		if attackObject.reanaAttackDamage <= 0 then
			attackObject.reanaAttackDamage = attackObject.effectDamage
		end
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		local finalDamage = attackObject.reanaAttackDamage * finalValue

		byAttackObject:subHealthPoint(finalDamage)
		attackObject.effectDamage=finalDamage

		effectArray[1] = finalDamage
		effectArray[2] = influenceDuration
		-- _crint("溅射：", finalValue, finalDamage, "承受者的信息：", byAttackObject.battleTag, byAttackObject.coordinate, byAttackObject.healthPoint, byAttackObject.isDead)
	else
		effectArray[3] = 1
	end
end

--[[
38.增加格挡强度
公式说明：
	总格挡强度[46] = 原格挡强度[46] + 百分比值
--]]
function FightUtil.computeAddRetainIntension(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	-- attackObject.uniqueSkillResistancePercent = attackObject.uniqueSkillResistancePercent + 1
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加格挡强度，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_RESISTANCE_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
39.降低格挡率
公式说明：
	总格挡率[10] = 原格挡率[10] - 百分比值
--]]
function FightUtil.computeLessenRetainIntension(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	-- attackObject.uniqueSkillResistancePercent = attackObject.uniqueSkillResistancePercent + 1
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加格挡率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS
		local propertyValue = -1 * finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
40.小技能
公式说明：
	...
--]]
function FightUtil.computeNormalSkillDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	local finalDamage = 0
	if(attackObject.isCripple)then	
		effectArray[1] = finalDamage
		attackObject.effectDamage=finalDamage
		return
	end
	if(true ~= byAttackObject.isNoDamage)then			
		local total = 0
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--[[
				公式说明40：
					最终伤害 =	if( (攻方攻击力[1] * 破防系数A) > (攻方攻击力[1] - 防方防御力[2])，（攻方攻击力[1] * 技能百分比[52] + 技能固定伤害[53]）* 破防系数A，（攻方攻击力[1] - 防方防御力[2]）* 技能百分比[52] + 技能固定伤害[53]）
					*（1 + 攻方伤害加成[33] - 防方伤害减免[34]）
					*（1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数B）[暂不处理]
					*（1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）[暂不处理]
					*系数F之间纯随机（0.95-1.05）
					*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）

					公式40（小技能）	小技能伤害=	if( (攻方攻击力[1] * 破防系数A) > (攻方攻击力[1] - 防方防御力[2])，（攻方攻击力[1] * (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
												（攻方攻击力[1] - 防方防御力[2]）* (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
												*（1 + 攻方伤害加成[33] - 防方伤害减免[34]）
												*（1 + 攻方伤害提升[54])
												*系数F之间纯随机（0.95-1.05）
												*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）

						（注：攻击、防御、克制伤害加成、克制伤害减免 取上方计算值）	
					公式40（小技能）	小技能伤害=	if( (攻方攻击力① * 破防系数A) > (攻方攻击力① - 防方防御力②)，（攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
							（攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
							* max（下限值系数MIN ，（1 + 攻方伤害加成⑤  - 防方伤害减免⑥  - 防方受到直接伤害降低[62] ）)
							* max（下限值系数MIN ，（1 + 攻方克制伤害加成⑬ -  防方克制伤害减免⑭ + 攻方伤害提升[54] ）)
							* 系数F之间纯随机（0.95-1.05）
							*（连击加成G1+连击加成G2+连击加成G3+连击加成G4+连击加成G5）   （说明：系数G：excellent *1.2，cool *1.15，nice *1.1，bad 无加成）
			--]]
			-- @version 1.1
			local P1 = attackObject.attack - byAttackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63) -- ①攻击力=	攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
			local P2 = byAttackObject.physicalDefence - byAttackObject.ptvf64 + byAttackObject.fightObject.physicalDefence * (byAttackObject.intellectAdditionalPercent - byAttackObject.ptvf68) -- ②防御力=	防御[2] - 降低防御[64] + 战外面板防御 * ( 防御增加百分比[6] - 防御降低百分比[68] ）
			local P3 = attackObject.uniqueSkillDamagePercent
			local P4 = byAttackObject.uniqueSkillResistancePercent
			local P5 = attackObject.finalDamagePercent * (1 + attackObject.ptvf65)
				+ attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 33 )
			local P6 = byAttackObject.finalLessenDamagePercent

			local P13 = 0
			if (1 == attackObject.campPreference and 3 == byAttackObject.campPreference)
				or (2 == attackObject.campPreference and 1 == byAttackObject.campPreference)
				or (3 == attackObject.campPreference and 2 == byAttackObject.campPreference)
				then
				P13 = attackObject.ptvf70 + attackObject.fightObject.ptvf70
			end

			local P14 = 0
			if (1 == byAttackObject.campPreference and 3 == attackObject.campPreference)
				or (2 == byAttackObject.campPreference and 1 == attackObject.campPreference)
				or (3 == byAttackObject.campPreference and 2 == attackObject.campPreference)
				then
				P14 = byAttackObject.ptvf71 + byAttackObject.fightObject.ptvf71
			end

			local cia = P1 - P2
			local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
			if (P1 * FightModule.frA) > cia then
				-- （攻方攻击力① * (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A，
				total = ( P1 * ( ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100 ) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue ) * FightModule.frA
			else
				-- （攻方攻击力① - 防方防御力②）* (技能百分比[说明1] / 100 +（天赋等级-1）* 技能百分比成长值[说明2] / 100 ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）
				total = cia * ( ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
			end
			-- _crint("小技能：", total, cia, (P1 * FightModule.frA), (( ifvf + ( skillInfluence.level - 1 ) * skillInfluence.levelPercentGrowValue / 100)), skillInfluence.levelInitValue, (skillInfluence.level - 1) * skillInfluence.levelGrowValue)

			local frF = math.random(FightModule.frF1, FightModule.frF2) / 100

			local ptvf54 = (attackObject.ptvf54 + attackObject:getInfluenceJudgeResultCheckConditionValue( fightModule, userInfo, attackObject, byAttackObject, byAttackCoordinates, attackObjects, byAttackObjects, battleSkill, effectBuffer, 54 )) * (1 + attackObject.ptvf84)

			finalDamage = total
				* math.max(FightModule.lvf, (1 + P5 - P6 - byAttackObject.ptvf62))
				* math.max(FightModule.lvf, (1 + P13 - P14 + ptvf54))
				* frF

			if attackObject.isCritical then
				-- -- 造成的最终伤害值 * （1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数C + 增加暴击伤害[58] - 减少暴击伤害[59]）
				-- finalDamage = finalDamage * (1 + FightModule.frB + attackObject.uniqueSkillDamagePercent * FightModule.frC + attackObject.ptvf58 - attackObject.ptvf59)

				-- 暴击伤害=	攻方造成的伤害值 * （1 + ( 暴击伤害系数B + 攻方暴击强度③ * 暴击强度系数C ）* （ 1 + 攻方增加暴击伤害[58] - 攻方减少暴击伤害[59]））
				finalDamage = finalDamage * (1 + (FightModule.frB + P3 * FightModule.frC) * (1 + attackObject.ptvf58 - attackObject.ptvf59))
			end

			if byAttackObject.isRetain then
				-- -- 格挡伤害=	造成的最终伤害值 * （1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）
				-- finalDamage = finalDamage * (1 - FightModule.frD - byAttackObject.uniqueSkillResistancePercent * FightModule.frE)

				-- 格挡伤害=	造成的伤害值 *  max（下限值系数MIN ，（1 - 格挡伤害系数D - 防方格挡强度④ * 格挡强度系数E））
				finalDamage = finalDamage * math.max(FightModule.lvf, (1 - FightModule.frD - P4 * FightModule.frE))
			end

			finalDamage = math.floor(finalDamage)

			-- print("--------------------------------------\r\n公式40（小技能）：\r\n",
			-- 		"①攻击力：", P1, "\r\n",
			-- 			"\t攻击[1]：", attackObject.attack, "\r\n",
			-- 			"\t降低攻击[72]：", attackObject.ptvf72, "\r\n",
			-- 			"\t战外面板攻击：", attackObject.fightObject.attack, "\r\n",
			-- 			"\t攻击增加百分比[5]：", attackObject.courageAdditionalPercent, "\r\n",
			-- 			"\t攻击降低百分比[63]：", attackObject.ptvf63, "\r\n",
			-- 		"②防御力：", P2, "\r\n",
			-- 			"\t防御[2]：", byAttackObject.physicalDefence, "\r\n",
			-- 			"\t降低防御[64]：", byAttackObject.ptvf64, "\r\n",
			-- 			"\t战外面板防御：", byAttackObject.fightObject.physicalDefence, "\r\n",
			-- 			"\t防御增加百分比[6]：", byAttackObject.intellectAdditionalPercent, "\r\n",
			-- 			"\t防御降低百分比[68]：", byAttackObject.ptvf68, "\r\n",
			-- 		"最终的伤害：", finalDamage, "\r\n",
			-- 			"\t破防系数A：", FightModule.frA, "\r\n",
			-- 			"\t技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
			-- 			"\t下限值系数MIN：", FightModule.lvf, "\r\n",
			-- 			"\t攻方伤害加成⑤：", P5, "\r\n",
			-- 			"\t防方伤害减免⑥：", P6, "\r\n",
			-- 			"\t技能百分比成长值[说明2]：", skillInfluence.levelPercentGrowValue, "\r\n",
			-- 			"\t防方受到直接伤害降低[62]：", byAttackObject.ptvf62, "\r\n",
			-- 			"\t攻方克制伤害加成⑬：", P13, "\r\n",
			-- 			"\t防方克制伤害减免⑭：", P14, "\r\n",
			-- 			"\t攻方伤害提升[54]：", ptvf54, "\r\n",
			-- 			"\t系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
			-- 		"暴击伤害：", attackObject.isCritical, "\r\n",
			-- 			"\t暴击伤害系数B：", FightModule.frB, "\r\n",
			-- 			"\t攻方暴击强度③：", P3, "\r\n",
			-- 			"\t暴击强度系数C：", FightModule.frC, "\r\n",
			-- 			"\t攻方增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
			-- 			"\t攻方减少暴击伤害[59]：", attackObject.ptvf59, "\r\n",
			-- 		"格挡伤害：", byAttackObject.isRetain, "\r\n",
			-- 			"\t格挡伤害系数D：", FightModule.frD, "\r\n",
			-- 			"\t防方格挡强度④：", P4, "\r\n",
			-- 			"\t格挡强度系数E：", FightModule.frE, "\r\n",
			-- 		"--------------------------------------\r\n"
			-- 	)

			-- -- 攻击力= 攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 1 + 攻击增加百分比[5] - 攻击降低百分比[63] ）
			-- -- 攻击力= 攻击[1] - 降低攻击[72] + 战外面板攻击 * ( 攻击增加百分比[5] - 攻击降低百分比[63] ）
			-- -- local attack = attackObject.attack - attackObject.ptvf72 + attackObject.attack * (1 + attackObject.courageAdditionalPercent - attackObject.ptvf63)
			-- local attack = attackObject.attack - attackObject.ptvf72 + attackObject.fightObject.attack * (attackObject.courageAdditionalPercent - attackObject.ptvf63)
			-- -- _crint("--------------------------------------\r\n攻击力：\r\n",
			-- -- 		"攻击力：", attack, "\r\n",
			-- -- 		"攻击[1]：", attackObject.attack, "\r\n",
			-- -- 		"降低攻击[72]：", attackObject.ptvf72, "\r\n",
			-- -- 		"战外面板攻击：", attackObject.fightObject.attack, "\r\n",
			-- -- 		"攻击增加百分比[5]：", attackObject.courageAdditionalPercent, "\r\n",
			-- -- 		"攻击降低百分比[63]：", attackObject.ptvf63, "\r\n",
			-- -- 		"--------------------------------------\r\n"
			-- -- 	)

			-- local cia = attackObject.attack - byAttackObject.physicalDefence
			-- local ifvf = math.random(skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue) / 100
			-- if (attackObject.attack * FightModule.frA) > cia then
			-- 	--（攻方攻击力[1] * (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4] ）* 破防系数A
			-- 	total = (attackObject.attack * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue) * FightModule.frA
			-- else
			-- 	--（攻方攻击力[1] - 防方防御力[2]）* (技能百分比[说明1] +（天赋等级-1）* 技能百分比成长值[说明2] ) + 技能固定值[说明3] +（天赋等级-1）* 技能固定值成长值[说明4]）
			-- 	total = cia * (ifvf + (skillInfluence.level - 1) * skillInfluence.levelPercentGrowValue / 100) + skillInfluence.levelInitValue + (skillInfluence.level - 1) * skillInfluence.levelGrowValue
			-- end
			-- local frF = math.random(FightModule.frF1, FightModule.frF2) / 100
			-- finalDamage = -- math.floor(
			-- 		total
			-- 		* (1 + attackObject.finalDamagePercent - byAttackObject.finalLessenDamagePercent) -- *（1 + 攻方伤害加成[33] - 防方伤害减免[34]）
			-- 		* (1 + attackObject.ptvf54) -- *（1 + 攻方伤害提升[54])
			-- 		* frF
			-- 	-- )

			-- if attackObject.isCritical then
			-- 	-- 造成的最终伤害值 * （1 + 暴击伤害系数B + 攻方暴击强度[43] * 暴击强度系数C + 增加暴击伤害[58] - 减少暴击伤害[59]）
			-- 	finalDamage = finalDamage * (1 + FightModule.frB + attackObject.uniqueSkillDamagePercent * FightModule.frC + attackObject.ptvf58 - byAttackObject.ptvf59)
			-- end

			-- if byAttackObject.isRetain then
			-- 	-- 格挡伤害=	造成的最终伤害值 * （1 - 格挡伤害系数D - 防方格挡强度[46] * 格挡强度系数E）
			-- 	finalDamage = finalDamage * (1 - FightModule.frD - byAttackObject.uniqueSkillResistancePercent * FightModule.frE)
			-- end

			-- finalDamage = math.floor(finalDamage)

			-- -- _crint("--------------------------------------\r\n公式40（小技能）：\r\n",
			-- -- 		"攻方攻击力[1]：", attackObject.attack, "\r\n",
			-- -- 		"防方防御力[2]：", byAttackObject.physicalDefence, "\r\n",
			-- -- 		"破防系数A：", FightModule.frA, "\r\n",
			-- -- 		"技能百分比[说明1]：", skillInfluence.skillEffectMinValue, skillInfluence.skillEffectMinValue, ifvf, "\r\n",
			-- -- 		"天赋等级：", skillInfluence.level, "\r\n",
			-- -- 		"技能百分比成长值[说明2]：", skillInfluence.levelPercentGrowValue, "\r\n",
			-- -- 		"技能固定值[说明3]：", skillInfluence.levelInitValue, "\r\n",
			-- -- 		"技能固定值成长值[说明4]：", skillInfluence.levelGrowValue, "\r\n",
			-- -- 		"攻方伤害加成[33]：", attackObject.finalDamagePercent, "\r\n",
			-- -- 		"防方伤害减免[34]：", byAttackObject.finalLessenDamagePercent, "\r\n",
			-- -- 		"攻方必杀伤害率[55]：", attackObject.ptvf55, "\r\n",
			-- -- 		"攻方伤害提升[54]：", attackObject.ptvf54, "\r\n",
			-- -- 		"增加必杀伤害[56]：", attackObject.ptvf56, "\r\n",
			-- -- 		"减少必杀伤害[57]：", byAttackObject.ptvf57, "\r\n",
			-- -- 		"系数F之间纯随机：", FightModule.frF1, FightModule.frF2, frF, "\r\n",
			-- -- 		"破防值：", cia, "\r\n",
			-- -- 		"基础伤害：", total, "\r\n",
			-- -- 		"最终的伤害：", finalDamage, "\r\n",
			-- -- 		"暴击：", attackObject.isCritical, "\r\n",
			-- -- 		"暴击伤害系数B：", FightModule.frB, "\r\n",
			-- -- 		"攻方暴击强度[43]：", attackObject.uniqueSkillDamagePercent, "\r\n",
			-- -- 		"暴击强度系数C：", FightModule.frC, "\r\n",
			-- -- 		"增加暴击伤害[58]：", attackObject.ptvf58, "\r\n",
			-- -- 		"减少暴击伤害[59]：", byAttackObject.ptvf59, "\r\n",
			-- -- 		"连击加成：", attackObject.grade_attack, "\r\n",
			-- -- 		"格挡：", byAttackObject.isRetain, "\r\n",
			-- -- 		"格挡伤害系数D：", FightModule.frD, "\r\n",
			-- -- 		"防方格挡强度[46]：", byAttackObject.uniqueSkillResistancePercent, "\r\n",
			-- -- 		"格挡强度系数E：", FightModule.frE, "\r\n",
			-- -- 		"连击加成：", attackObject.grade_attack, "\r\n",
			-- -- 		"--------------------------------------\r\n"
			-- -- 	)
		else
			if(skillMould.skillProperty==0)then
				total = math.floor ((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.physicalAttackAdd
				+ attackObject.restrainObject.attackAdditional+ attackObject.restrainObject.physicAttackAdditional)
				finalDamage =math.floor((total - byAttackObject.physicalDefence * (100 + byAttackObject.addPhysicalDefPercent - byAttackObject.decPhysicalDefPercent) / 100)
							 * FightUtil.computeRandomSkillEffectValue(skillInfluence)
							 * FightUtil.computeRandomValue()
							 + attackObject.finalDamageAddition-byAttackObject.finalSubDamageAddition
							 + attackObject.restrainObject.finalAdditionalDamage - byAttackObject.restrainObject.finalLessenDamage)
			else
				total = math.floor ((attackObject.attack + attackObject.addAttack) * (100 + attackObject.addAttackPercent - attackObject.decAttackPercent) / 100 + attackObject.skillAttackAdd
				+ attackObject.restrainObject.attackAdditional + attackObject.skillAttackAdd)
				finalDamage =math.floor((total - byAttackObject.skillDefence * (100 + byAttackObject.addSkillDefPercent - byAttackObject.decSkillDefPercent) / 100)
						 * FightUtil.computeRandomSkillEffectValue(skillInfluence)
						 * FightUtil.computeRandomValue()
						 + attackObject.finalDamageAddition-byAttackObject.finalSubDamageAddition
						 + attackObject.restrainObject.finalAdditionalDamage - byAttackObject.restrainObject.finalLessenDamage)
			end
			finalDamage = math.floor (finalDamage * attackObject.critialMultiple)
		end
	end
	if (1 > finalDamage) then
		finalDamage = 1
	end
	local finalDamagePercent = attackObject.finalDamagePercent + attackObject.addFinalDamagePercent
	+ attackObject.restrainObject.finalAdditionalDamagePercentage
	local finalLessenDamagePercent =  byAttackObject.finalLessenDamagePercent + byAttackObject.addBruiseDamagePercent
	+ byAttackObject.restrainObject.finalAdditionalDamagePercentage
	if(byAttackObject.isEvasion)then
		finalDamage = 0
	else
		--for (Iterator<TalentJudgeResult> talentIter = attackObject.getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(attackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_DAMAGE_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : byAttackObject.talentImmunityList) then
			for _, talentImmunity in pairs(byAttackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			finalDamagePercent = finalDamagePercent + talentJudgeResult.percentValue
		end
		--for (Iterator<TalentJudgeResult> talentIter = byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT).iterator(); talentIter.hasNext();) then
		for _, talentJudgeResult in pairs(byAttackObject:getTalentJudgeResultByResultType(TalentConstant.JUDGE_RESULT_FINAL_LESSEN_DAMAGE_PERCENT)) do
			--TalentJudgeResult talentJudgeResult = talentIter.next()
			local immunity = false
			--for (TalentImmunity talentImmunity : attackObject.talentImmunityList) then
			for _, talentImmunity in pairs(attackObject.talentImmunityList) do
				if(talentImmunity.immunityTalent == talentJudgeResult.talentMould.id)then
					immunity = true
					break
				end
			end
			if(immunity)then
				break
			end
			finalLessenDamagePercent = finalLessenDamagePercent + talentJudgeResult.percentValue
		end
		if(finalDamagePercent > 0.0)then
			print("伤害xx 1: " .. finalDamage)
			print("finalDamagePercent: " .. finalDamagePercent)
			finalDamage = finalDamage * (1 + finalDamagePercent / 100)
			print("伤害xx 2: " .. finalDamage)
		end
		if(finalLessenDamagePercent > 0.0)then
			print("伤害xx 3: " .. finalDamage)
			print("finalLessenDamagePercent: " .. finalLessenDamagePercent)
			finalDamage = finalDamage * (1 - finalLessenDamagePercent / 100)
			print("伤害xx 4: " .. finalDamage)
		end
	end
	-- if(attackObject.battleTag == 0)then
		-- local userInfo = UserDB.getUserInfoWithUserInfoId(attackObject.userInfo + "", false)
		-- if(nil ~= userInfo and nil ~= userInfo.battleCache)then
			-- local templocal = userInfo.battleCache
			-- tempBattleCache.addTotalDamage(finalDamage)
		-- end
	-- end

	print("伤害xx 5: " .. finalDamage)
	print("attackObject.grade_attack: " .. attackObject.grade_attack)
	finalDamage = finalDamage * attackObject.grade_attack
	if(tonumber(finalDamage) < 1)then
		finalDamage = 1
	end
	print("伤害xx 6: " .. finalDamage)

	if (true == byAttackObject.isNoDamage) then
		finalDamage = 0
	end
	
	if(attackObject.battleTag == 0)then
		if _ED.user_info.battleCache ~= nil then
			_ED.user_info.battleCache:addTotalDamage(finalDamage)
		end
	end

	print("打印伤害 " .. finalDamage)

	byAttackObject:subHealthPoint(finalDamage)
	attackObject.effectDamage=finalDamage
	byAttackObject.reboundDamageValueResult = byAttackObject.reboundDamageValueResult + byAttackObject.reboundDamageValue * finalDamage
	effectArray[1] = finalDamage
end

--[[
41	反弹	41		反弹伤害 = 造成的最终伤害值 * 承受方方反弹率[42]
--]]
function FightUtil.computeDamageRebound(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		-- local finalValue = byAttackObject.reboundDamageValue
		-- local finalDamage = attackObject.effectDamage * finalValue
		local finalDamage = byAttackObject.reboundDamageValueResult

		byAttackObject:subHealthPoint(finalDamage)
		attackObject.effectDamage=finalDamage

		effectArray[1] = finalDamage

		-- _crint("反弹：", finalValue, finalDamage, byAttackObject.reboundDamageValueResult, "承受者的信息：", byAttackObject.battleTag, byAttackObject.coordinate)
	else
		effectArray[3] = 1
	end
end

--[[
42.提高小技能触发概率
公式说明：
	小技能触发概率[45] = 原小技能触发概率[45] + 百分比值
	小技能触发概率[45] = 原小技能触发概率[45] + 百分比值*100
--]]
function FightUtil.computeAddNormalSkillOdds(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("提高小技能触发概率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT
		local propertyValue = finalValue * 100
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
43.灼烧（目标生命值上限）
公式说明：
	灼伤伤害 = 目标生命值上限 * 百分比/100  （灼伤伤害上限为释放者攻击力*40%）
--]]
function FightUtil.computeFiringDamageUpperLimit(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = skillInfluence
		fightBuff.effectRound = skillInfluence.influenceDuration
		local effectValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)

		local finalDamage = math.min(byAttackObject.healthMaxPoint * effectValue, attackObject.attack * 0.4)
		-- _crint("灼烧:", effectValue, finalDamage, byAttackObject.healthMaxPoint)

		fightBuff.effectValue = finalDamage
		byAttackObject:pushBuffEffect(fightBuff)
		effectArray[2] = skillInfluence.influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
44.增加破击率
公式说明：
	总破击[11] = 原破击[11] + 百分比值
--]]
function FightUtil.computeAddRetainBreakOdds(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加破击率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_RETAIN_BREAK_ODDS
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
45.增加反弹率
公式说明：
	总反弹率[42] = 原反弹率[42] + 百分比值
--]]
function FightUtil.computeFor45(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加反弹率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_REBOUND_DAMAGE_VALUE
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
46.回血（以自身最大生命值计算）
公式说明：
	回血值 = 自身生命值上限 * 百分比/100
--]]
function FightUtil.computeFor46(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("回血，随机值的结果：", finalValue)
		local finalDamage = byAttackObject.healthMaxPoint * finalValue

		attackObject:addHealthPoint(finalDamage)

		effectArray[1] = finalDamage
	else
		effectArray[3] = 1
	end
end

--[[
47.增加伤害减免
公式说明：
	总伤害减免[34] = 原伤害减免[34] + 百分比值
--]]
function FightUtil.computeFor47(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加伤害减免，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
48.变形（变成玩偶）
公式说明：
	...
--]]
function FightUtil.computeFor48(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	local probability = FightUtil.checkSkillInfluenceProbability(skillInfluence, attackObject, byAttackObject)
	if(math.random(1, 100) <= probability)then
		if FightUtil.checkNegativeBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer) then				
			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence=skillInfluence
			fightBuff.effectRound=skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
			effectArray[2] = skillInfluence.influenceDuration
		else
			effectArray[3] = 1
		end
	else
		effectArray[3] = 1
	end
end

--[[
49.降低小技能触发概率
公式说明：
	小技能触发概率[45] = 原概率[45] - 百分比值
--]]
function FightUtil.computeFor49(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低小技能触发概率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_NORMATIN_SKILL_TRIGGER_PERCENT
		local propertyValue = -1 * finalValue * 100
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
50.降低暴击伤害
公式说明：
	50	降低暴击伤害	50		总减少暴击伤害[59] = 原减少暴击伤害[59]  + 百分比值
--]]
function FightUtil.computeFor50(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低暴击伤害，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_59
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
51.减少必杀伤害
公式说明：
	51	减少必杀伤害	51		总减少必杀伤害[57] = 原减少必杀伤害[57]  + 百分比值
--]]
function FightUtil.computeFor51(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("减少必杀伤害，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_LESSEN_DAMAGE_PERCENT_FOR_57
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
52.嘲讽
公式说明：
	...
--]]
function FightUtil.computeFor52(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	local probability = FightUtil.checkSkillInfluenceProbability(skillInfluence, attackObject, byAttackObject)
	if(math.random(1, 100) <= probability)then
		local fightBuff = byAttackObject:getBuffEffect(skillInfluence.skillCategory)
		if nil == fightBuff then
			fightBuff = FightBuff:new()
			byAttackObject:pushBuffEffect(fightBuff)
		end
		fightBuff.skillInfluence=skillInfluence
		fightBuff.effectRound=skillInfluence.influenceDuration
		effectArray[2] = skillInfluence.influenceDuration

		byAttackObject.lockAttackTargetPos = attackObject.coordinate
	else
		effectArray[3] = 1
	end
end

--[[
53.加血（以自身已损失生命值计算）
公式说明：
	53	加血（以目标已损失生命值计算）	53		加血量 = 目标已损失生命值 * 百分比值/100
--]]
function FightUtil.computeFor53(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		local drainHP = (byAttackObject.healthMaxPoint - byAttackObject.healthPoint) * finalValue
		-- _crint("加血：", drainHP, (byAttackObject.healthMaxPoint - byAttackObject.healthPoint), finalValue)

		-- if(drainHP + byAttackObject.healthPoint >= byAttackObject.healthMaxPoint)then
		-- 	drainHP = math.floor (byAttackObject.healthMaxPoint - byAttackObject.healthPoint)
		-- end

		byAttackObject:addHealthPoint(drainHP)
		effectArray[1] = drainHP
	else
		effectArray[3] = 1
	end
end

--[[
54.加血（以目标生命值上限计算）
公式说明：
	54	加血（以目标生命值上限计算）	54		加血量 = 目标生命值上限 * 百分比值/100
--]]
function FightUtil.computeFor54(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		local drainHP = byAttackObject.healthMaxPoint * finalValue
		-- _crint("加血：", drainHP)

		-- if(drainHP + byAttackObject.healthPoint >= byAttackObject.healthMaxPoint)then
		-- 	drainHP = math.floor (byAttackObject.healthMaxPoint - byAttackObject.healthPoint)
		-- end

		byAttackObject:addHealthPoint(drainHP)
		effectArray[1] = drainHP
	else
		effectArray[3] = 1
	end
end

--[[
55.降低伤害加成
公式说明：
	总伤害加成[33] = 原伤害加成[33] - 百分比值
--]]
function FightUtil.computeFor55(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低伤害加成，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT
		local propertyValue = -1 * finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
56.增加伤害加成
公式说明：
	总伤害加成[33] = 原伤害加成[33] + 百分比值
--]]
function FightUtil.computeFor56(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加伤害加成，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_FINAL_ADDITIONAL_DAMAGE_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
57.增加控制率
公式说明：
	总控制率[47] = 原控制率[47] + 百分比值
--]]
function FightUtil.computeFor57(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加控制率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_CONTROL_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
58.增加必杀伤害
公式说明：
	58	增加必杀伤害	58		总增加必杀伤害[56] = 原增加必杀伤害[56] + 百分比值
--]]
function FightUtil.computeFor58(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加必杀伤害，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_56
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
59.减少必杀伤害率
公式说明：
	59	减少必杀伤害率	59		总减少必杀伤害率[66] = 原减少必杀伤害率[66] + 百分比值
--]]
function FightUtil.computeFor59(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加必杀伤害，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_66
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
60.降低怒气回复速度
公式说明：
	恢复怒气值 = 原怒气值 + 恢复的怒气 * （1 - 百分比/100）
60	降低怒气回复速度	60		总降低怒气回复速度[69] = 原降低怒气回复速度[69] + 百分比值
--]]
function FightUtil.computeFor60(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低怒气回复速度，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_69
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
61.提高怒气回复速度
公式说明：
	恢复怒气值 = 原怒气值 + 恢复的怒气 * （1 + 百分比/100）
61	提高怒气回复速度	61		总提高怒气回复速度[61] = 原提高怒气回复速度[61] + 百分比值
--]]
function FightUtil.computeFor61(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("提高怒气回复速度，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_ADDITIONAL_PWER_ADD_SPEED_FOR_61
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
62.增加暴击伤害
公式说明：
62	增加暴击伤害	62		增加暴击伤害[58] = 原增加暴击伤害[58] + 百分比值
--]]
function FightUtil.computeFor62(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加暴击伤害，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_ADDITIONAL_DAMAGE_PERCENT_FOR_58
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
63	降低治疗效果	63		总被治疗率减少[53] = 原被治疗率减少[53] + （1-原被治疗率减少[53]）*百分比值
--]]
function FightUtil.computeFor63(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		finalValue = (1 - byAttackObject.byCureLessenPercent) * finalValue
		-- _crint("降低治疗效果，随机值的结果：", finalValue)

		local fightBuff = byAttackObject:getBuffEffect(skillInfluence.skillCategory)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_BY_CURE_LESSEN_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		if nil == fightBuff then
			local _skillInfluence = {
				skillCategory = skillCategory, 
				influenceDuration = influenceDuration,
				propertyType = propertyType,
				propertyValue = propertyValue,
				percentValue = 0,
				resultType = -1,
	            buffRoundType = -1,
				judgeResultArray = nil,
			}

			local fightBuff = FightBuff:new()
			fightBuff.skillInfluence = _skillInfluence
			fightBuff.effectRound = _skillInfluence.influenceDuration
			byAttackObject:pushBuffEffect(fightBuff)
	        byAttackObject:addPropertyValue(propertyType, propertyValue)
		else
			if propertyValue > fightBuff.skillInfluence.propertyValue then
				fightBuff.skillInfluence.propertyValue = propertyValue
				fightBuff.effectRound = influenceDuration
				byAttackObject:addPropertyValue(propertyType, propertyValue - fightBuff.skillInfluence.propertyValue)
			end
		end

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
64.增加暴击强度
公式说明：
	总暴击强度[43] = 原暴击强度[43] + 百分比值
--]]
function FightUtil.computeFor64(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加暴击强度，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_UNIQUE_SKILL_DAMAGE_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
65.降低伤害减免
公式说明：
	总伤害减免[34] = 原伤害减免[34] - 百分比值 * 战外伤害减免[34]	总伤害减免[34] = 原伤害减免[34] - 固定值
--]]
function FightUtil.computeFor65(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低伤害减免，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_FINAL_LESSEN_DAMAGE_PERCENT
		local propertyValue = 0
		if skillInfluence.isRate == 0 then
			propertyValue = -1 * finalValue * byAttackObject.fightObject.finalLessenDamagePercent
		else
			propertyValue = -1 * finalValue
		end
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
66.增加必杀伤害率
公式说明：
	必杀伤害率[55] = 原必杀伤害率[55] + 百分比值
--]]
function FightUtil.computeFor66(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加必杀伤害率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_ODDS_FOR_55
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
67.增加格挡率
公式说明：
	总格挡率[10] = 原格挡率[10] + 百分比值
--]]
function FightUtil.computeFor67(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加格挡率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_RETAIN_ODDS
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
68.增加数码兽类型克制伤害加成
公式说明：
	总数码兽类型克制伤害加成[70] = 原数码兽类型克制伤害加成[70] + 百分比值
--]]
function FightUtil.computeFor68(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加数码兽类型克制伤害加成，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_70
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
69.增加数码兽类型克制伤害减免
公式说明：
	总数码兽类型克制伤害减免[71] = 原数码兽类型克制伤害减免[71] + 百分比值
--]]
function FightUtil.computeFor69(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加数码兽类型克制伤害减免，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_71
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
70.降低暴击率
公式说明：
	总暴击率[8] = 原暴击率[8] -  百分比值
--]]
function FightUtil.computeFor70(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低暴击率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_CRITICAL_ODDS
		local propertyValue = -1 * finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
71.降低抗暴率
公式说明：
	总抗暴率[9] = 原抗暴率[9] -  百分比值
--]]
function FightUtil.computeFor71(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("降低暴击率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_CRITICAL_RESIST_ODDS
		local propertyValue = -1 * finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
72.增加必杀抗性
公式说明：
	原增加必杀抗性[73] = 增加必杀抗性[73] + 百分比值
--]]
function FightUtil.computeFor72(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加必杀抗性，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_73
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
73.减少必杀抗性
公式说明：
	原减少必杀抗性[74] = 减少必杀抗性[74] + 百分比值
--]]
function FightUtil.computeFor73(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("减少必杀抗性，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_DAMAGE_LESSEN_DEFEND_FOR_74
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

--[[
74.增加吸血率
公式说明：
	总吸血率[40] = 原吸血率[40] + 百分比值
--]]
function FightUtil.computeFor74(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	if(math.random(1, 100) <= skillInfluence.additionEffectProbability)then
		print("增加吸血率 FightUtil.computeFor74")
		local finalValue = FightUtil.computeRandomSkillEffectValue(skillInfluence)
		-- _crint("增加吸血率，随机值的结果：", finalValue)
		local skillCategory = skillInfluence.skillCategory
		local propertyType = EquipmentMould.PROPERTY_TYPE_INHALE_HP_DAMAGE_PERCENT
		local propertyValue = finalValue
		local influenceDuration = skillInfluence.influenceDuration
		local _skillInfluence = {
			skillCategory = skillCategory, 
			influenceDuration = influenceDuration,
			propertyType = propertyType,
			propertyValue = propertyValue,
			percentValue = 0,
			resultType = -1,
            buffRoundType = -1,
			judgeResultArray = nil,
		}
		local fightBuff = FightBuff:new()
		fightBuff.skillInfluence = _skillInfluence
		fightBuff.effectRound = _skillInfluence.influenceDuration
		byAttackObject:pushBuffEffect(fightBuff)
        byAttackObject:addPropertyValue(propertyType, propertyValue)

        effectArray[2] = influenceDuration
	else
		effectArray[3] = 1
	end
end

function FightUtil.computeSkillEffect(battleSkill,skillMould, skillInfluence, attackObject, byAttackObject, userInfo, fightModule, effectBuffer)
	local effectArray = {} --new int[4]
	effectArray[1] = 0
	effectArray[3] = -1
	
	effectArray[2] = 0
	effectArray[4] = 0
	local formulaInfo = battleSkill.formulaInfo
	print("计算技能效用 " .. formulaInfo)

	if (formulaInfo == FightUtil.FORMULA_INFO_COMMON_DAMAGE ) then	
		FightUtil.computeCommonDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_SPECIAL_DAMAGE) then	
		FightUtil.computeSpecialDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_CURE_HP) then	
		FightUtil.computeCureHealthPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_CURE_SP) then	
		FightUtil.computeCureSkillPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_DAMAGE_SP) then	
		FightUtil.computeDamageSkillPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_SP_DISUP) then	
		FightUtil.computeSkillPointDisup(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_DIZZY) then	-- 7 眩晕
		FightUtil.computeDizzy(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_POSION) then	-- 8
		FightUtil.computePosion(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_Firing) then -- 9	灼烧
		FightUtil.computeFiring(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_Explode) then	-- 10
		FightUtil.computeExplode(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_PARALYSIS) then	-- 11
		FightUtil.computeParalysis(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_NO_SP) then	-- 12
		FightUtil.computeNoSkillPoint(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_RETAIN) then	
		FightUtil.computeAddRetain(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_LESSEN_DAMAGE) then	
		FightUtil.computeLessenDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_EVASION_SURELY) then	
		FightUtil.computeEvasionSurely(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_DRAINS) then	
		FightUtil.computeDrains(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_BEAR_HP) then	
		FightUtil.computeBearHP(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_BLIND) then	
		FightUtil.computeBlind(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_CRIPPLE) then	
		FightUtil.computeCripple(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_ATTACK) then -- 21	增加攻击
		FightUtil.computeAddAttack(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_SUB_ATTACK) then -- 22	降低攻击
		FightUtil.computeSubAttack(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_DEFENCE) then -- 23	增加防御
		FightUtil.computeAddPhysicalDefence(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_SUB_DEFENCE) then -- 24	降低防御
		FightUtil.computeSubPhysicalDefence(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_SELF_DAMAGE) then	
		FightUtil.computeAddDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_SUB_SELF_DAMAGE) then
		FightUtil.computeAddBurise(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_CRITICAL) then -- 27	增加暴击	
		FightUtil.computeAddCritical(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_SUB_CRITICAL) then -- 28	增加抗暴
		FightUtil.computeAddResistCritical(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_HIT) then
		FightUtil.computeAddHit(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_DODGE) then
		FightUtil.computeAddEnvsion(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_ENDURANCE) then
		FightUtil.computeAddEndurance(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_CLEAR_BUFF) then
		FightUtil.computeClearBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_DAMAGE) then
		FightUtil.computeAddDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_KILL) then
		FightUtil.computeAllKill(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif(formulaInfo == FightUtil.FORMULA_INFO_FIXED_DAMAGE) then
		FightUtil.computeFixedKill(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
		--break
	elseif (formulaInfo == FightUtil.FORMULA_INFO_FORTHWITH) then -- 36.降低治疗效果 
		FightUtil.computeForthwitch(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_REANA_ATTACK_DAMAGE) then -- 37.溅射
		FightUtil.computeReanaAttackDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_RETAIN_INTENSION) then -- 38.加格挡强度
		FightUtil.computeAddRetainIntension(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_LESSEN_RETAIN_PERCENT) then -- 39.降低格挡概率
		FightUtil.computeLessenRetainIntension(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_NORMAL_SKILL_DAMAGE) then -- 40.小技能的伤害公式
		FightUtil.computeNormalSkillDamage(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_DAMAGE_REBOUND) then -- 41.反弹伤害公式
		FightUtil.computeDamageRebound(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_NORMAL_SKILL_ODDS) then -- 42.提高小技能触发概率
		FightUtil.computeAddNormalSkillOdds(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_FIRING_DAMAGE_UPPER_LIMIT) then -- 43.灼烧（目标生命值上限）
		FightUtil.computeFiringDamageUpperLimit(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_ADD_RETAIN_BREAK_ODDS) then -- 44.增加破击率
		FightUtil.computeAddRetainBreakOdds(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_45) then -- 45	增加反弹率
		FightUtil.computeFor45(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_46) then -- 46	加血（以自身最大生命值计算）
		FightUtil.computeFor46(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_47) then -- 47	增加伤害减免
		FightUtil.computeFor47(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_48) then -- 48	变形（变成玩偶）
		FightUtil.computeFor48(skillMould, skillInfluence, attackObject, byAttackObject, effectArray, battleSkill, userInfo, fightModule, effectBuffer)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_49) then -- 49	降低小技能触发概率
		FightUtil.computeFor49(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_50) then -- 50	降低暴击伤害
		FightUtil.computeFor50(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_51) then -- 51	减少必杀伤害
		FightUtil.computeFor51(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_52) then -- 52	嘲讽
		FightUtil.computeFor52(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_53) then -- 53	加血（以自身已损失生命值计算）
		FightUtil.computeFor53(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_54) then -- 54	加血（以目标生命值上限计算）
		FightUtil.computeFor54(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_55) then -- 55	降低伤害加成
		FightUtil.computeFor55(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_56) then -- 56	增加伤害加成
		FightUtil.computeFor56(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_57) then -- 57	增加控制率
		FightUtil.computeFor57(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_58) then -- 58	增加必杀伤害
		FightUtil.computeFor58(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_59) then -- 59	减少必杀伤害率
		FightUtil.computeFor59(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_60) then -- 60	降低怒气回复速度
		FightUtil.computeFor60(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_61) then -- 61	提高怒气回复速度
		FightUtil.computeFor61(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_62) then -- 62	增加暴击伤害
		FightUtil.computeFor62(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_63) then -- 63	降低治疗效果
		FightUtil.computeFor63(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_64) then -- 64	增加暴击强度
		FightUtil.computeFor64(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_65) then -- 65	降低伤害减免
		FightUtil.computeFor65(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_66) then -- 66	增加必杀伤害率
		FightUtil.computeFor66(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_67) then -- 67	增加格挡率
		FightUtil.computeFor67(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_68) then -- 68	增加数码兽类型克制伤害加成
		FightUtil.computeFor68(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_69) then -- 69	增增加数码兽类型克制伤害减免
		FightUtil.computeFor69(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_70) then -- 70	降低暴击率
		FightUtil.computeFor70(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_71) then -- 71	降低抗暴率
		FightUtil.computeFor71(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_72) then -- 72	增加必杀抗性
		FightUtil.computeFor72(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_73) then -- 73	减少必杀抗性
		FightUtil.computeFor73(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	elseif (formulaInfo == FightUtil.FORMULA_INFO_TYPE_74) then -- 74	增加吸血率
		FightUtil.computeFor74(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	end
	return effectArray
end

function FightUtil.computeBuffEffect(skillMould, skillInfluence, attackObject, byAttackObject)
	local effectArray = {}
	effectArray[1] = 0
	effectArray[3] = -1
	
	effectArray[2] = 0
	effectArray[4] = 0
	FightUtil.computeClearBuff(skillMould, skillInfluence, attackObject, byAttackObject, effectArray)
	return effectArray
end

