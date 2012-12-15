package com.finegamedesign.dragon
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import org.flixel.*;
   
    public class PlayState extends FlxState
    {
        private static var scene:Scene;

        public static function getChildByClass(aClass:Class):*
        {
            for (var c:int=0; c < scene.numChildren; c++) {
                if (scene.getChildAt(c) is aClass) {
                    return scene.getChildAt(c);
                }
            }
            return null;
        }

        public static function endsWith(name:String, ending:String):Boolean
        {
            return name.indexOf(ending) == name.length - ending.length;
        }

        /**
         * Every labeled frame in the movie clip at Flixel frame index (frame - 1).
         * If label ends with "ing", then loop, otherwise stop.
         */
        public static function addAnimation(flxSprite:FlxSprite, mc:MovieClip):void
        {
            for (var i:int = 0; i < mc.currentLabels.length; i++) {
                var start:int = mc.currentLabels[i].frame - 1;
                var end:int;
                if (i < mc.currentLabels.length - 1) {
                    end = mc.currentLabels[i+1].frame - 2;
                }
                else {
                    end = mc.totalFrames - 1;
                }
                var frames:Array = [];
                for (var f:int = start; f <= end; f++) {
                    frames.push(f);
                }
                var looped:Boolean = endsWith(mc.currentLabels[i].name, "ing");
                trace(flxSprite, "addAnimation", mc.currentLabels[i].name, frames, FlxG.stage.frameRate, looped);
                flxSprite.addAnimation(mc.currentLabels[i].name, frames, FlxG.stage.frameRate, looped);
            }
        }

        private var instructionText:FlxText;
        private var waveText:FlxText;
        private var goldText:FlxText;
        private var waveCount:int;
        private var goldCount:int;
        private var head:Head;
        private var peasant:Peasant;
        private var gold:Gold;

        override public function create():void
        {
            FlxG.visualDebug = true;
            FlxG.timeScale = 8.0;
            FlxG.score = 0;
            super.create();
            scene = new Scene();
            FlxG.bgColor = 0xFF222222;
            head = new Head();
            add(head);
            peasant = new Peasant();
            add(peasant);
            gold = new Gold();
            add(gold);

            instructionText = new FlxText(FlxG.width/2 - 40, FlxG.height - 20, 200, 
                "RELEASE SPACEBAR TO EAT WHITE SQUARE");
            add(instructionText);
            waveText = new FlxText(0, 0, 100, "WAVE " + waveCount.toString() + " OF 0");
            add(waveText);
            goldText = new FlxText(FlxG.width - 40, 0, 100, "GOLD " + goldCount.toString());
            add(goldText);
        }

		override public function update():void 
        {
            updateInput();
            updateGold();
            super.update();
        }

        private function updateInput():void
        {
            if (FlxG.keys.justReleased("SPACE") || FlxG.mouse.justReleased()) {
                trace("release");
				if (FlxG.overlap(head, peasant)) {
                    head.play("eat");
                    peasant.kill();
                    FlxG.score++;
                }
                else {
                    head.play("bite");
                }
            }
            else if (head.finished) {
                head.play("idling");
                if (!peasant.alive) {
                    FlxG.switchState(new MenuState());
                }
            }
        }

        private function updateGold():void
        {
            if (FlxG.overlap(gold, peasant)) {
                peasant.play("carrying");
                peasant.velocity.x = Peasant.carryVelocity;
                gold.play("carrying");
                gold.velocity.x = peasant.velocity.x;
                gold.x = peasant.x;
            }
            else {
                gold.play("idling");
                gold.velocity.x = 0.0;
            }
            if (!gold.onScreen()) {
                FlxG.switchState(new MenuState());
            }
        }
    }
}
