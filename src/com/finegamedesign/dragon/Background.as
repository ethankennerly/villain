package com.finegamedesign.dragon
{
    import org.flixel.*;
    public class Background extends FlxSprite
    {
        public function Background(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, BackgroundSpritesheet);
        }
    }
}


import com.noorhakim.FlxMovieClip;

/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class BackgroundSpritesheet extends FlxMovieClip
{
    public function BackgroundSpritesheet() 
    {
        super(BackgroundClip);
    }
    
}
