package com.finegamedesign.dragon
{
    import org.flixel.*;
   
    public class PlayState extends FlxState
    {
        private var instructionText:FlxText;
        private var waveText:FlxText;
        private var goldText:FlxText;
        private var waveCount:int;
        private var goldCount:int;

        override public function create():void
        {
            FlxG.visualDebug = true;
            super.create();
            FlxG.bgColor = 0xFF222222;
            instructionText = new FlxText(FlxG.width/2 - 40, FlxG.height - 20, 200, 
                "TAP SPACEBAR TO RETURN TO MENU");
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
            if (FlxG.keys.justPressed("SPACE")) {
                FlxG.switchState(new MenuState());
            }
        }
    }
}
