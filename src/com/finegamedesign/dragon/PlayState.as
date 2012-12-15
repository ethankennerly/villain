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
                trace("addAnimation", mc.currentLabels[i].name, frames, FlxG.stage.frameRate, looped);
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

        override public function create():void
        {
            scene = new Scene();
            FlxG.visualDebug = true;
            super.create();
            FlxG.bgColor = 0xFF222222;
            head = new Head();
            add(head);
            peasant = new Peasant();
            add(peasant);

            instructionText = new FlxText(FlxG.width/2 - 40, FlxG.height - 20, 200, 
                "RELEASE SPACEBAR TO FLASH PINK");
            add(instructionText);
            waveText = new FlxText(0, 0, 100, "WAVE " + waveCount.toString() + " OF 0");
            add(waveText);
            goldText = new FlxText(FlxG.width - 40, 0, 100, "GOLD " + goldCount.toString());
            add(goldText);
        }

		override public function update():void 
        {
            updateInput();
            super.update();
        }

        private function updateInput():void
        {
            if (FlxG.keys.justReleased("SPACE")) {
				if (FlxG.overlap(head, peasant, eat)) {
                    head.play("eat");
                }
                else {
                    head.play("bite");
                }
            }
            else if (head.finished) {
                head.play("idling");
            }
        }

        private function eat(head:FlxObject, other:FlxObject):void
        {
            other.kill();
        }
    }
}
