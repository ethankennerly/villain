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

        /**
         * Parse animations from movie clip.
         * Flixel expects unique graphic class name.
         */
        public static function constructSprite(flxSprite:FlxSprite, SpritesheetClass:Class):void
        {
            var sheet:* = new SpritesheetClass();
            flxSprite.loadGraphic(SpritesheetClass, true, true, sheet.frameWidth, sheet.frameHeight);
        }

        public static function constructChild(FlxSpriteClass:Class, child:MovieClip):*
        {
            var flxSprite:FlxSprite = new FlxSpriteClass(child.x, child.y);
            addAnimation(flxSprite, child);
            return flxSprite;
        }

        private var instructionText:FlxText;
        private var waveText:FlxText;
        private var goldText:FlxText;
        private var waveCount:int;
        private var goldCount:int;
        private var head:Head;
        private var peasants:FlxGroup;
        private var golds:FlxGroup;

        private function addChildren(scene:MovieClip):void
        {
            peasants = new FlxGroup();
            golds = new FlxGroup();
            for (var c:int=0; c < scene.numChildren; c++) {
                var child:* = scene.getChildAt(c);
                if (child is HeadClip) {
                    head = constructChild(Head, child);
                    add(head);
                }
                else if (child is PeasantClip) {
                    peasants.add(constructChild(Peasant, child));
                    add(peasants);
                }
                else if (child is GoldClip) {
                    golds.add(constructChild(Gold, child));
                    add(golds);
                }
            }
        }

        override public function create():void
        {
            FlxG.score = 0;
            super.create();
            scene = new Scene();
            addChildren(scene);
            addHud();
        }

        private function addHud():void
        {
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
            updateRetreat();
            super.update();
        }

        private function updateInput():void
        {
            if (FlxG.keys.justReleased("SPACE") || FlxG.mouse.justReleased()) {
                trace("release");
				if (!FlxG.overlap(head, peasants, eat)) {
                    head.play("bite");
                }
            }
            else if (head.finished) {
                head.play("idling");
                if (peasants.countLiving() <= 0) {
                    FlxG.switchState(new MenuState());
                }
            }
            if (FlxG.keys.pressed("SHIFT") && FlxG.keys.justPressed("TWO")) {
                // FlxG.visualDebug = true;
                FlxG.timeScale = 8.0;
            }
            else if (FlxG.keys.pressed("SHIFT") && FlxG.keys.justPressed("ONE")) {
                // FlxG.visualDebug = false;
                FlxG.timeScale = 1.0;
            }
        }

        private function eat(head:FlxObject, peasant:FlxObject):void
        {
            Head(head).play("eat");
            peasant.kill();
            FlxG.score++;
        }

        /**
         * If peasant touches gold, carry.  Otherwise gold sits.
         * If peasants carry all gold away, lose.
         */
        private function updateGold():void
        {
            FlxG.overlap(golds, peasants, carry);
            if (golds.countLiving() <= 0) {
                FlxG.switchState(new MenuState());
            }
        }

        /**
         * If no gold idling on screen, then peasants on screen retreat.
         */
        private function updateRetreat():void
        {
            Gold.sum = 0;
            golds.callAll("count");
            if (Gold.sum <= 0) {
                peasants.callAll("retreat");
            }
        }

        /**
         * If gold being carried, do not transfer to another.
         */
        private function carry(me:FlxObject, you:FlxObject):void
        {
            var peasant:Peasant = Peasant(you);
            var gold:Gold = Gold(me);
            peasant.carry(gold);
        }
    }
}
