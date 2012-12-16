package com.finegamedesign.dragon
{
    import org.flixel.*;
    import org.flixel.system.FlxAnim;
    public class Gold extends FlxSprite
    {
        public static var sum:int;

        public function Gold(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, GoldSpritesheet);
        }

        public function count():void
        {
            if (onScreen() && null == curAnim || "idling" == curAnim.name) {
                sum++;
            }
        }

        override public function kill():void
        {
            FlxG.play(Sounds.coinClass);
            super.kill();
        }

        public function get curAnim():FlxAnim
        {
            return _curAnim;
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class GoldSpritesheet extends FlxMovieClip
{
    public function GoldSpritesheet() 
    {
        super(GoldClip);
    }
    
}
