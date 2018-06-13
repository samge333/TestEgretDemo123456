//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2014-2015, Egret Technology Inc.
//  All rights reserved.
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the Egret nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY EGRET AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
//  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL EGRET AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;LOSS OF USE, DATA,
//  OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//////////////////////////////////////////////////////////////////////////////////////

class LoadingUI extends eui.Component {
    
    private mProgressBarSkin = `<?xml version='1.0' encoding='utf-8'?>
<e:Skin class="ProgressBarSkin" xmlns:e="http://ns.egret.com/eui" xmlns:w="http://ns.egret.com/wing">
	<e:Image source="resource/assets/game/progress_bg.png" x="0" y="0" width="324"/>
	<e:Image id="thumb" source="resource/assets/game/progress_bar.png" x="0" y="0" width="324"/>
</e:Skin>`;
    private progressbar:eui.ProgressBar;
    
    public constructor() {
        super();
        this.progressbar = new eui.ProgressBar();
        this.createView();
    }

    private createView():void {
        //添加背景图
        var loadingbk = new eui.Image();
        loadingbk.source = "resource/assets/game/loadingbk.png";
        this.addChild(loadingbk);
        loadingbk.x = 0;
        loadingbk.y = 0;
        
        //添加进度条
        this.progressbar.skinName = this.mProgressBarSkin;
        this.addChild(this.progressbar);
        this.progressbar.x = 78;
        this.progressbar.y = 395;
    }

    public setProgress(current, total):void {
        var i = Math.round((current / total) * 100);
        this.progressbar.value=i;
    }
}
