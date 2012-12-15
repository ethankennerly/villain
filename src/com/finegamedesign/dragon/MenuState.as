package com.finegamedesign.dragon
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        override public function create():void
        {
            if (null == FlxG.scores || FlxG.scores.length <= 0) {
                FlxG.scores = [0];
                FlxG.score = 0;
                trace("new game");
            }
            else {
                FlxG.scores.push(FlxG.score);
            }
            var t:FlxText;
            t = new FlxText(0,FlxG.height/4,FlxG.width,"Sleeping Dragon\nSneaking Treasure");
            t.size = 16;
            t.alignment = "center";
            add(t);
            t = new FlxText(FlxG.width/2-50,FlxG.height/2,100,
                "PRESS SPACE TO EAT THE PEASANT\n\nClick to play\n\nHigh Score " + Math.max.apply(null, FlxG.scores));
            
            t.alignment = "center";
            add(t);
            
            // FlxG.mouse.show();
        }

        override public function update():void
        {
            super.update();

            if(FlxG.mouse.justReleased() || FlxG.keys.justReleased("SPACE"))
            {
                // FlxG.mouse.hide();
                FlxG.switchState(new PlayState());
            }
        }
    }
}
