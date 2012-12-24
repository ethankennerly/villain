package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Knight extends Peasant
    {
        public function Knight(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, KnightSpritesheet);
            health = 2;
        }

        override public function hurt(Damage:Number):void
        {   
            // trace("hurt", Damage);
            super.hurt(Damage);
            if (alive) {
                FlxG.play(Sounds.coinClass);
                var sheet:* = new PeasantSpritesheet();
                _pixels = sheet.bitmapData;
            }
        }
    }
}


import com.noorhakim.FlxMovieClip;
import com.finegamedesign.dragon.Swc;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class KnightSpritesheet extends FlxMovieClip
{
    public function KnightSpritesheet() 
    {
        super(Swc.KnightClip);
    }
}

class PeasantSpritesheet extends FlxMovieClip
{
    public function PeasantSpritesheet() 
    {
        super(Swc.PeasantClip);
    }
}
