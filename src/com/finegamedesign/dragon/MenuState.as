package com.finegamedesign.dragon
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        override public function create():void
        {
            FlxG.bgColor = 0xFF222222;
            if (null == FlxG.scores || FlxG.scores.length <= 0) {
                FlxG.scores = [0];
                FlxG.score = 0;
            }
            else {
                FlxG.scores.push(FlxG.score);
            }
            var t:FlxText;
            t = new FlxText(0,FlxG.height/5,FlxG.width,"Sleeping Dragon");
            t.size = 20;
            t.alignment = "center";
            add(t);
            t = new FlxText(0,FlxG.height/3, FlxG.width,
                "Release spacebar to bite"
                + "\nHold exactly until yellow eye to breathe fire"
                + "\nClick to play"
                + "\n\nScore " + FlxG.score
                + "\nHigh Score " + Math.max.apply(null, FlxG.scores)
                );
            
            t.size = 14;
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
