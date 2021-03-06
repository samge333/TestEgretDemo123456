--[[ ----------------------------------------------------------------------------------------------------
-- 战斗中攻守双方的战队信息
天赋基本属性加成，战前赋予效果影响值  
0.生命          
1.攻击          
2.物防           
3.灵防   
4.生命（%）     
5.攻击（%）     
6.物防（%）      
7.灵防（%）  
8.暴击率（%）   
9.抗暴率（%）  
10.格挡率（%）   
11.破击率（%） 
12.命中率（%）  
13.闪避率（%）  
14.物理免伤（%） 
15.灵压免伤（%） 
16.治疗率（%）  
17.被治疗率（%）
18.最终伤害      
19.最终减伤   
20.初始怒气     
21.体质         
22.力量          
23.灵力  
24.物理攻击     
25.灵压攻击     
26.治疗值        
27.被治疗值   
28.灼烧伤害     
29.中毒伤害     
30.灼烧免伤      
31.中毒免伤    
32.经验         
33.最终伤害（%）
34.最终减伤（%） 
35.PVP终伤（%）
36.PVP免伤（%）
37.初始合击点数  
38.每次出手增加的怒气    
39.灼烧伤害%    
40.吸血率%  
41.怒气   
42.反弹%  
43.暴伤加成%	   
44.免控率%  
45.小技能触发概率%  
46.格挡强度% 
47.控制率%
48.治疗效果% 
49.暴击强化% 

目标限定    
1数码兽类型，0无，1攻，2防，3技，其他   
2作用于自身  
3被攻击的每个目标   
4死亡的队友  
5主目标    
6特定数码兽，ID，下一个   
7我方任意三人 
8敌方随机两个目标   
9己方数码兽类型，0无，1攻，2防，3技，其他 
10目标周围单位    
11己方后排  
12自己周围友军    
13敌方全体  


战内效果判断时机    
0被击时判断  
1攻击时判断  
2自身死亡时判断    
3对手死亡时判断    
4判断敌方行动后    
5判断我方行动后    
6入场时判定  

结果  
0反伤%，值  
1最终减伤%，值    
2最终伤害%，值    
3暴击伤害比例增加%，值    
4受到伤害最多为生命上限%，值 
5按目生命上限减少其%生命，值 
6按生命上限比例回复生命，值% 
7调用技能，技能ID  
8无法被暴击  
9对手无法反击 
10对手无法闪避    
11晕眩目标一回合
12降低和吸取 (eg:12，属性类型，值，返还百分比;目标限定)
13增加和消耗 (eg:13，属性类型，值，消耗百分比；目标限定)
14复活 (eg:14，血量%，死前怒气%；目标限定)

--]] ----------------------------------------------------------------------------------------------------
FormationInfo = class("FormationInfoClass")

function FormationInfo:ctor()
    self.super:ctor()

    -- 攻击伤害加成
    self.attackDamageAdditionalPercent = 0
    
    -- 战场全局天赋作用
    self.globalTalentInfo = {
        -- item: {type, value, param}
    }
end

function FormationInfo:init(param)

end

function FormationInfo:search(args1, args2, args3, ...)
    local result = {}
    for i, v in paris(self.globalTalentInfo) do
        if v.value == args1 then

        end
    end
    return result
end
-- ----------------------------------------------------------------------------------------------------