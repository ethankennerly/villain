package com.finegamedesign.dragon
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
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
                "RELEASE SPACEBAR TO RETURN TO MENU");
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
                FlxG.switchState(new MenuState());
            }
        }
    }
}
