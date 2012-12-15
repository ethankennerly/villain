package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Body extends FlxSprite
    {
        public function Body(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, BodySpritesheet);
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class BodySpritesheet extends FlxMovieClip
{
    public function BodySpritesheet() 
    {
        super(BodyClip);
    }
    
}
