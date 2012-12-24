package com.finegamedesign.dragon
{
    import org.flixel.*;

    public class Floor extends FlxSprite
    {
        public function Floor(X:int = 0, Y:int = 0, MovieClipClass:Class = null) 
        {
            super(X, Y);
            PlayState.constructSprite(this, FloorGraphic);
            immovable = true;
        }
    }
}


import com.noorhakim.FlxMovieClip;
import com.finegamedesign.dragon.Swc;
/**
 * Hold the pixels of a sprite sheet in this.bitmapData.
 */
class FloorGraphic extends FlxMovieClip
{
    public function FloorGraphic()
    {
        super(Swc.FloorClip);
    }
}
