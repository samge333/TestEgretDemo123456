var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var Npc = (function () {
    function Npc() {
    }
    Npc.prototype.init = function (row) {
        // this.id = 58;
        // this.npcName = "232";
        // this.headPic = "106601,106601";
        // this.basePic = 1;
        // this.attackLevelLimit = 1;
        // this.initShow = 0;
        // this.initLock = 0;
        // this.formationCount = 1;
        // this.isStatProgress = 0;
        // this.difficultyIncludeCount = 1;
        // this.difficultyReward = "99,99";
        // this.mapIndex = "1,3,5";
        // this.battleBackground = "1";
        // this.battleBackgroundMusic = "2";
        // this.dropLibrary = 699;
        // this.getStarCondition = 1;
        // this.getStarDescribe = "1";
        // this.dailyAttackCount = 9999;
        // this.attackNeedFood = 6;
        // this.unlockNpc = "59,518,519,520,521,522";
        // this.difficultyAdditional = "1,1,1,1|1,1,1,1|1,1,1,1";
        // this.towelReward = -1;
        // this.firstReward = 0;
        // this.npcType = -1;
        // this.soundIndex = -1;
        // this.signMsg = "20049";
        // this.byOpenNpc = "-1";
        this.id = Number(row[0]);
        this.npcName = Number(row[1]);
        this.headPic = row[2];
        this.basePic = Number(row[3]);
        this.attackLevelLimit = Number(row[4]);
        this.initShow = Number(row[5]);
        this.initLock = Number(row[6]);
        this.formationCount = Number(row[7]);
        this.environmentFormation1 = Number(row[8]);
        this.environmentFormation2 = Number(row[9]);
        this.environmentFormation3 = Number(row[10]);
        // this.isStatProgress = Number(row[10]);
        // this.difficultyIncludeCount = Number(row[10]);
        // this.difficultyReward = row[10];
        // this.mapIndex = row[10];
        // this.battleBackground = "1";
        // this.battleBackgroundMusic = "2";
        // this.dropLibrary = 699;
        // this.getStarCondition = 1;
        // this.getStarDescribe = "1";
        // this.dailyAttackCount = 9999;
        // this.attackNeedFood = 6;
        // this.unlockNpc = "59,518,519,520,521,522";
        // this.difficultyAdditional = "1,1,1,1|1,1,1,1|1,1,1,1";
        // this.towelReward = -1;
        // this.firstReward = 0;
        // this.npcType = -1;
        // this.soundIndex = -1;
        // this.signMsg = "20049";
        // this.byOpenNpc = "-1";
    };
    return Npc;
}());
__reflect(Npc.prototype, "Npc");
//# sourceMappingURL=Npc.js.map