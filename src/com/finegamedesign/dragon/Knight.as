package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Knight extends Peasant
    {
        public function Knight(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, KnightSpritesheet);
            sounds = {};
            health = 2;
            velocity.x = 128;
        }

        override public function hurt(Damage:Number):void
        {   
            trace("hurt", Damage);
            super.hurt(Damage);
            if (alive) {
                _pixels = new PeasantSpritesheet().bitmapData;
            }
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class KnightSpritesheet extends FlxMovieClip
{
    public function KnightSpritesheet() 
    {
        super(KnightClip);
    }
}

class PeasantSpritesheet extends FlxMovieClip
{
    public function PeasantSpritesheet() 
    {
        super(PeasantClip);
    }
}
