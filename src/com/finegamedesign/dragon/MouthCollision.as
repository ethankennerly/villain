package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class MouthCollision extends FlxSprite
    {
        public function MouthCollision(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, MouthCollisionSpritesheet);
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class MouthCollisionSpritesheet extends FlxMovieClip
{
    public function MouthCollisionSpritesheet() 
    {
        super(MouthCollisionClip);
    }
    
}
